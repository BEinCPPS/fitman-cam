camApp.controller('domainController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialogManager',
    'entityManager',
    'ngNotifier',
    'templateManager',
    '$route',
    'currentNode',
    '$window',
    function ($scope, Scopes, $q, ngDialogManager, entityManager, ngNotifier
        , templateManager, $route, currentNode, $window) {
        Scopes.store('domainController', $scope);
        //Load Domains
        var assetsCounter = 0;

        (function getDomains() {
            entityManager.getDomains().then(function (response) {
                $scope.domainsList = [];
                $scope.domainsListNoDomain = [];
                var ownList = [];
                angular.copy(response.data, ownList);
                ownList.forEach(function (value) {
                    var domain = {
                        name: value.name,
                        id: value.id,
                        iri: value.links.self + '#' + value.name,
                        description: value.description,
                    };
                    $scope.domainsList.push(domain);
                    if (domain.id.toUpperCase().indexOf(NO_DOMAIN) === -1) {
                        $scope.domainsListNoDomain.push(domain);
                    }
                });
            }, function (error) {
                ngNotifier.error(error);
            }).then(function () {
                if (currentNode.getDomain().name) {
                    $scope.currentNode = currentNode.getDomain();
                    $scope.expandAncestors($scope.currentNode.name);
                }
            }, function (error) {
                ngNotifier.error(error);
            });
        })();

        $scope.expandAncestors = function (domainName) {
            for (var i in $scope.domainsList) {
                if ($scope.domainsList[i].name === domainName) {
                    $scope.domainsList[i].selected = 'selected';
                    var eventFake = new MouseEvent('click', {
                        'view': $window,
                        'bubbles': true,
                        'cancelable': true
                    });
                    var event = $window.event || eventFake;
                    $scope.selectNodeLabel($scope.domainsList[i], event);
                    return;
                }
            }
        };
        $scope.assetList = [];
        templateManager.getDomainAction().then(function (response) {
            $scope.actionTemplate = response.data;
        }, function (error) {
            $scope.actionTemplate = '';
            ngNotifier.error(error);
            return null;
        });

        $scope.columnDefs = [
            {
                "mDataProp": "select",
                "aTargets": [0],
                "bSearchable": false,
                "bSortable": false,
                "fnRender": function (data) {
                    return '<input type="checkbox" ng-model="assetList[' + assetsCounter++ + '].selected"/>';
                }
            },
            {
                "mDataProp": "individualName",
                "aTargets": [1],
            },
            {
                "mDataProp": "className",
                "aTargets": [2]
            }, {
                "mDataProp": "domain",
                "aTargets": [3],
                "fnRender": function (data) {
                    var retVal = data.aData.domain;
                    if (data.aData.domain && data.aData.lostDomain) {
                        return '<span class="glyphicon glyphicon-remove" aria-hidden="true" data-lost-domain="true"></span>&nbsp;' + retVal;
                    } else if (data.aData.domain && !data.aData.lostDomain) {
                        return '<span class="glyphicon glyphicon-ok" aria-hidden="true" data-lost-domain="false"></span>&nbsp;' + retVal;
                    } else
                        return '<span aria-hidden="true" ></span>&nbsp;' + retVal;
                }
            }, {
                "mDataProp": "createdOn",
                "aTargets": [4]
            },
            {
                "mDataProp": "action",
                "aTargets": [5],
                "bSortable": false
            }];

        $scope.overrideOptions = {
            "bStateSave": true,
            "iCookieDuration": 2419200,
            /* 1 month */
            "bJQueryUI": true,
            "bPaginate": true,
            "bSort": true,
            "bLengthChange": false,
            "bFilter": true,
            "bInfo": true,
            "bDestroy": true,
            "oLanguage": {
                "sSearch": "Filter: "
            },
            "fnDrawCallback": function () {
                function colorToRed() {
                    var lostDomainArr = angular.element("[data-lost-domain='true']");
                    angular.forEach(lostDomainArr, function (value) {
                        var elem = angular.element(value);
                        var row = elem.parent().parent();
                        if (row.is('tr')) {
                            var css = row.prop('class');
                            css = 'danger ' + css;
                            row.prop('class', css);
                        }
                    });
                }

                colorToRed();
                if (typeof Scopes.get('homeController') !== 'undefined')
                    Scopes.get('homeController').addTooltipToAssetModel();
            },
        };

        $scope.loadChildren = function () {
            entityManager.getAssetsFromDomain($scope.currentNode.id)
                .then(function (response) {
                    assetsCounter = 0;
                    $scope.assetList = $scope.formatAssetListTable(response.data);
                    console.log("Assets List", $scope.assetList);
                    $scope.createOCBVisible = true;
                }, function (error) {
                    ngNotifier.error(error);
                });
        }

        $scope.formatAssetListTable = function (data) {
            if (!data)
                return [];
            $scope.assetMap = {};
            for (var i = 0; i < data.length; i++) {
                var asset;
                asset = angular.copy(data[i]);
                $scope.assetMap[asset.individualName] = asset;
                data[i].action =
                    $scope.actionTemplate.replaceAll("$value$", asset.individualName);
            }
            data.sort(function (a, b) {
                return new Date(b.createdOn) - new Date(a.createdOn);
            });

            return data;
        }
        $scope.panelTitle = 'Update Domain';

        $scope.updateAssetDomain = function () {
            var assetToSend = {
                name: $scope.asset.individualName,
                className: $scope.asset.className,
                domainName: $scope.asset.domainName
            }
            entityManager.updateAsset($scope.asset.individualName, assetToSend)
                .then(function () {
                    ngNotifier.success();
                    $route.reload();
                    $scope.closePanel();
                }, function (err) {
                    ngNotifier.error(err);
                })
        }

        $scope.openUpdateDomainPanel = function (assetName) {
            $scope.asset = $scope.assetMap[assetName];
            $scope.title = 'Update domain';
            ngDialogManager.open({
                template: 'pages/updateDomain.htm',
                controller: 'domainController',
                scope: $scope
            });
        }

        $scope.closePanel = function () {
            $scope.asset = null;
            ngDialogManager.close();
        }

        $scope.selectedOcbAssets = [];
        $scope.openConfirmOperationPanel = function () {
            $scope.selectedOcbAssets = $scope.assetList.filter(function (asset) {
                return asset.selected;
            });
            if (isEmpty($scope.selectedOcbAssets)) {
                ngNotifier.warn("Select assets please!");
                return;
            }
            $scope.typeToAdd = 'Orion Context Broker';
            $scope.titleOperationMessage = 'Create assets to the ';
            $scope.operationMessage = 'Are you sure you want to create these ' + $scope.selectedOcbAssets.length + ' assets into the ';
            ngDialogManager.open({
                template: 'pages/confirmNewOperation.htm',
                controller: 'confirmNewOperationController',
                scope: $scope
            });
        };

        $scope.createAssetsToOCB = function () {
            var selectedAssetsJson = [];
            angular.forEach($scope.selectedOcbAssets, function (asset) {
                var assetJSON = {
                    name: asset.individualName,
                    className: asset.className,
                    domainName: asset.domain
                };
                selectedAssetsJson.push(assetJSON);
            });
            entityManager.sendAssetsToOCB(selectedAssetsJson)
                .then(function (response) {
                    console.log(JSON.stringify(response.data));
                    ngNotifier.success("Assets correctly added to the Orion Context Broker");
                }, function (error) {
                    ngNotifier.error(error);
                });
        };

        $scope.selectAllAssetsForOCB = function () {
            for (var i in $scope.assetList)
                $scope.assetList[i].selected = $scope.flagSelectAll;
        };

    }]);
