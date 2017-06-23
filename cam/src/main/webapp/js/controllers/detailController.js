camApp.controller('detailController',
    ['$scope', '$routeParams', '$location', '$q', 'ngDialogManager', 'Scopes', 'ngNotifier', 'entityManager', '$route',
        function ($scope, $routeParams, $location, $q, ngDialogManager, Scopes, ngNotifier, entityManager, $route) {
            Scopes.store('detailController', $scope);
            if (isEmpty($routeParams.selectedAssetName)) {
                $location.path('/');
            }
            if (!isEmpty($routeParams.groupingType)) {
                $scope.groupingType = $routeParams.groupingType;
            }
            if (!isEmpty($routeParams.groupingName)) {
                $scope.groupingName = $routeParams.groupingName;
            }
            $scope.selectedAssetName = $routeParams.selectedAssetName;
            $scope.regexPattern = REGEX_PATTERN;
            $scope.invalidNameMsg = INVALID_NAME_MSG;
            $scope.nameIsMandatory = NAME_IS_MANDATORY_MSG;

            $scope.formatAssetDetailTableRow = function (data) {
                var attribute = {};
                attribute.name = data.normalizedName;
                attribute.value = data.propertyValue;
                var elementType = 'attribute';
                var individualName = data.propertyTarget;

                var btnDetailActionFunction = 'openAttributeDetailPanel';
                if (data.type == 'relationship')
                    elementType = 'relationship';

                attribute.action = '<div class="inline-flex-item"><button ng-disabled="isOCBEnabled" class="cam-table-button" ng-click="openRemovePropertyPanel(\'' + attribute.name + '\', \'' + elementType + '\', \'' + individualName + '\')' + '"> <i data-toggle="tooltip" title="Delete ' + elementType + '" class="fa fa-trash cam-table-button"></i> </button>' + '<button ng-disabled="isOCBEnabled" class="cam-table-button" ng-click="openAttributeDetailPanel(\'' + data.normalizedName + '\', \'' + elementType + '\')' + '"> <i data-toggle="tooltip" title="Open detail" class="fa fa-pencil cam-table-button"></i> </button>';

                if (data.type == 'relationship')
                    attribute.type = '<i data-toggle="tooltip" title="relationship" class="fa fa-link" ><i/>';
                else
                    attribute.type = '<i data-toggle="tooltip" title="relationship" class="fa fa-font" ><i/>';

                return attribute;
            }

            $scope.getAssetDetail = function (name, type) {
                entityManager.getAssetDetail(name, type)
                    .success(function (data) {
                        var owned;
                        var model;
                        var created;
                        var attrs = [];
                        var rels = [];
                        var originalAttrs = data;
                        entityManager.getAssetDetail(name, RELATIONSHIPS)
                            .success(function (data) {
                                for (var i = 0; i < data.length; i++) {
                                    data[i].type = 'relationship';
                                }
                                data = data.concat(originalAttrs);
                                for (var i = 0; i < data.length; i++) {
                                    if (data[i].normalizedName.indexOf('ownedBy') > 0)
                                        owned = data[i].propertyValue.substring(data[i].propertyValue.lastIndexOf('#') + 1);
                                    else if (data[i].normalizedName.indexOf('instanceOf') > 0)
                                        model = data[i].propertyValue;
                                    else if (data[i].normalizedName.indexOf('createdOn') > 0) {
                                        var myDate = new Date(data[i].propertyValue);
                                        var month = (myDate.getMonth() + 1).toString();
                                        var day = new String(myDate.getDate());
                                        while (month.length < 2)
                                            month = '0' + month;
                                        while (day.length < 2)
                                            day = '0' + day;
                                        created = myDate.getFullYear() + "-" + month + "-" + day;
                                    } else {
                                        if (data[i].type !== 'relationship')
                                            attrs.push($scope.formatAssetDetailTableRow(data[i]));
                                        else
                                            rels.push($scope.formatAssetDetailTableRow(data[i]));
                                    }
                                }
                                $scope.selectedAsset = Scopes.get('homeController').selectedAsset;
                                $scope.selectedAsset.attributes = attrs;
                                $scope.selectedAsset.relationships = rels;
                                $scope.selectedAsset.isModel = isEmpty(model);
                                $scope.isOCBEnabled = !isEmpty($scope.selectedAsset.connectedToOrion);
                                $scope.domainsListNoDomain = Scopes.get('homeController').domainsListNoDomain;
                                $scope.isDomainEnabled = $scope.domainsListNoDomain && $scope.domainsListNoDomain.length > 0;
                            })
                    })
                    .error(function (error) {
                        ngNotifier.error(error);
                        return null;
                    });
            }


            $scope.getAssetDetail($routeParams.selectedAssetName, ATTRIBUTES);
            $scope.retrieveSelectedAsset = function () {
                for (var i = 0; i < $scope.assetList.length; i++) {
                    if ($scope.assetList[i].asset == $scope.selectedAssetName) {
                        return $scope.assetList[i];
                    }
                }
            }

            $scope.assetDetailColumnDefs = [{
                "mDataProp": "type",
                "aTargets": [0]
            }, {
                "mDataProp": "name",
                "aTargets": [1]
            }, {
                "mDataProp": "value",
                "aTargets": [2]
            }, {
                "mDataProp": "action",
                "aTargets": [3],
                "bSortable": false
            }];

            $scope.assetDetailOverrideOptions = {
                "bStateSave": true,
                "iCookieDuration": 2419200,
                /* 1 month */
                "bJQueryUI": true,
                "bPaginate": true,
                "bLengthChange": false,
                "bFilter": true,
                "bInfo": true,
                "bDestroy": true,
                "oLanguage": {
                    "sSearch": "Filter by "
                }

            };

            $scope.getAttributes = function () {
                entityManager.getAttributes().then(function (response) {
                    $scope.attributes = response.data;
                }, function (error) {
                    $scope.attributes = [];
                    ngNotifier.error(error);
                });
            }
            $scope.getAttributes();

            // funzioni di utilità


            $scope.openNewAttributePanel = function () {
                ngDialogManager.open({
                    template: 'pages/newAttribute.htm',
                    controller: 'newAttributeController',
                    scope: $scope
                });
            };

            $scope.openAttributeDetailPanel = function (attributeName, elementType) {
                $scope.attributeName = attributeName;
                if ('relationship' == elementType) {
                    ngDialogManager.open({
                        template: 'pages/newRelationship.htm',
                        controller: 'newRelationshipController',
                        scope: $scope
                    });
                } else {
                    ngDialogManager.open({
                        template: 'pages/newAttribute.htm',
                        controller: 'attributeDetailController',
                        scope: $scope
                    });
                }
            };

            $scope.openNewRelationshipPanel = function () {
                $scope.attributeName = null;
                $scope.assetToFilter = $scope.selectedAsset.name;
                ngDialogManager.open({
                    template: 'pages/newRelationship.htm',
                    controller: 'newRelationshipController',
                    scope: $scope
                });

            };

            $scope.openRemovePropertyPanel = function (elementToDelete, typeToDelete, individualName) {
                $scope.elementToDelete = elementToDelete;
                $scope.typeToDelete = typeToDelete;
                $scope.individualName = individualName;
                $scope.detail = true;
                $scope.entityManager = entityManager;
                ngDialogManager.open({
                    template: 'pages/confirmDelete.htm',
                    controller: 'confirmDeleteController',
                    scope: $scope
                });
            };

            $scope.isAttributes = true;
            $scope.isTabAttrsActive = 'active';
            $scope.isTabRelsActive = 'not-active-tab';
            $scope.changeTab = function (type) {
                if (type === ATTRIBUTES) {
                    $scope.isAttributes = true;
                    $scope.isTabAttrsActive = 'active';
                    $scope.isTabRelsActive = 'not-active-tab';
                }
                else if (type === RELATIONSHIPS) {
                    $scope.isAttributes = false;
                    $scope.isTabAttrsActive = 'not-active-tab';
                    $scope.isTabRelsActive = 'active';
                }
            }

            $scope.openUpdateDomainPanel = function () {
                $scope.asset = $scope.selectedAsset;
                $scope.title = 'Update domain';
                ngDialogManager.open({
                    template: 'pages/updateDomain.htm',
                    controller: 'detailController',
                    scope: $scope
                });
            }

            $scope.panelTitle = 'Update Domain';
            $scope.updateAssetDomain = function () {
                var assetToSend = {
                    name: $scope.asset.individualName,
                    className: $scope.asset.className,
                    domainName: $scope.asset.domainName
                }
                var domain = $scope.asset.domainName.split('#')[1];
                entityManager.updateAsset($scope.asset.individualName, assetToSend)
                    .then(function () {
                        ngNotifier.success();
                        $scope.closePanelUpdateDomain();
                        $scope.selectedAsset.domain = domain;
                        if ($scope.groupingType === 'domains')
                            $scope.groupingName = domain;
                        $route.reload();
                    }, function (err) {
                        ngNotifier.error(err);
                    })
            }

            $scope.closePanelUpdateDomain = function () {
                $scope.asset = null;
                ngDialogManager.close();
            }

            //OCB Section
            $scope.selectedOcbAsset = [];
            $scope.openConfirmOperationPanel = function () {
                $scope.selectedOcbAsset = $scope.selectedAsset;
                if (isEmpty($scope.selectedOcbAsset)) {
                    ngNotifier.warn("Select assets please!");
                    return;
                }
                entityManager.getOrionConfigs().then(function (response) {
                    $scope.orionConfigsList = response.data;
                }, function (error) {
                    ngNotifier.error(error);
                });
                $scope.typeToAdd = 'Orion Context Broker';
                $scope.subTypeToAdd = 'createInOCB';
                $scope.titleOperationMessage = 'Create assets to the ';
                $scope.operationMessage = 'Are you sure you want to create this ' + $scope.selectedOcbAsset.individualName + ' asset into the ';
                ngDialogManager.open({
                    template: 'pages/createContexts.htm',
                    controller: 'confirmNewOperationController',
                    scope: $scope
                });
            }

            $scope.originalController = Scopes.get('detailController');
            $scope.createAssetsToOCB = function (selectedOrionConfigId) {
                var selectedAssetsJson = [];
                var selectedAssetJson = {
                    name: $scope.selectedOcbAsset.individualName,
                    className: $scope.selectedOcbAsset.className,
                    domainName: $scope.selectedOcbAsset.domain,
                    orionConfigId: selectedOrionConfigId
                };
                selectedAssetsJson.push(selectedAssetJson);
                entityManager.createAssetsToOCB(selectedAssetsJson)
                    .then(function (response) {
                        console.log(JSON.stringify(response.data));
                        ngNotifier.success("Asset correctly added to the Orion Context Broker.");
                        $scope.isOCBEnabled = true;
                        $scope.selectedAsset.connectedToOrion = selectedOrionConfigId;
                        $route.reload();
                    }, function (error) {
                        ngNotifier.error(error);
                    });
            }

            $scope.downloadAssetsForIDAS = function (selectedAsset) {
                var selectedAssetsJson = [];
                var selectedAssetJson = {
                    name: selectedAsset.individualName,
                    className: selectedAsset.className,
                    domainName: selectedAsset.domain
                };
                selectedAssetsJson.push(selectedAssetJson);
                entityManager.downloadAssetsForIDAS(selectedAssetsJson)
                    .then(function (response) {
                        var data = response.data;
                        console.log(JSON.stringify(data));
                        var url = URL.createObjectURL(new Blob([data]));
                        var a = document.createElement('a');
                        a.href = url;
                        // a.download = 'config_'+selectedAsset.individualName+'.json';
                        a.download = 'config-idas.json';
                        a.target = '_blank';
                        a.click();
                    }, function (error) {
                        ngNotifier.error(error);
                    });
            }

            $scope.selectedAssetNameToDisconnect = null;
            $scope.openDisconnectFromOCB = function (assetName) {
                $scope.selectedAssetNameToDisconnect = assetName;
                $scope.typeToAdd = 'Orion Context Broker';
                $scope.subTypeToAdd = 'disconnectFromOCB';
                $scope.titleOperationMessage = 'Disconnect asset from the ';
                $scope.operationMessage = 'Are you sure you want to disconnect this asset from the ';
                $scope.operationName = "Disconnect";
                ngDialogManager.open({
                    template: 'pages/confirmNewOperation.htm',
                    controller: 'confirmNewOperationController',
                    scope: $scope
                });
            }

            $scope.disconnectAssetFromOCB = function () {
                entityManager.disconnectAssetsFromOCB($scope.selectedAssetNameToDisconnect)
                    .then(function (response) {
                        ngNotifier.success('Asset correctly disconnected from the Orion Context Broker.');
                        $scope.isOCBEnabled = false;
                        $scope.selectedAsset.connectedToOrion = '';
                        $route.reload();
                    }, function (error) {
                        ngNotifier.error(error);
                    });
            }
            //TODO REMOVE
            $scope.refreshAssetFromOCBMock = function () {
                $scope.isRefreshig = true;
                setTimeout(function () {
                    $scope.isRefreshig = false;
                    $scope.$apply()
                }, 5000);
            }
            $scope.refreshAssetFromOCB = function () {
                $scope.isRefreshig = true;
                entityManager.refreshAssetFromOCB($scope.selectedAssetName)
                    .then(function (response) {
                        console.log(JSON.stringify(response.data));
                        ngNotifier.success("Asset correctly refreshed from the Orion Context Broker.");
                        $scope.isRefreshig = false;
                        $route.reload();
                    }, function (err) {
                        ngNotifier.error(err);
                        $scope.isRefreshig = false;
                        $scope.$apply()
                    })
            }
        }]);
