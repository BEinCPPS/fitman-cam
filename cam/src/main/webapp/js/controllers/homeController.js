camApp.controller('homeController', [
    '$scope',
    'Scopes',
    '$routeParams',
    '$route',
    '$q',
    'ngDialogManager',
    '$timeout',
    'ngNotifier',
    'entityManager',
    'templateManager',
    'currentNode',
    '$window',
    '$location',
    'tooltipTable',
    function ($scope, Scopes, $routeParams, $route, $q, ngDialogManager, $timeout, ngNotifier, entityManager, templateManager
        , currentNode, $window, $location, tooltipTable) {
        Scopes.store('homeController', $scope);
        $scope.assetList = [];
        $scope.regexPattern = REGEX_PATTERN;
        $scope.invalidNameMsg = INVALID_NAME_MSG;
        $scope.nameIsMandatory = NAME_IS_MANDATORY_MSG;
        $scope.keyrockSignupUrl = KEYROCK_SIGNUP_URL;
        $scope.enableContextMenuEntry = true;
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
                if (currentNode.getDomain() && currentNode.getDomain().name) {
                    $scope.currentNode = currentNode.getDomain();
                    $scope.expandAncestors($scope.currentNode.name, GROUPING_DOMAIN_TYPE);
                }
            }, function (error) {
                ngNotifier.error(error);
            });
        })()

        $scope.getAssets = function (name, retrieveChildren) {
            entityManager.getAssets(name, retrieveChildren)
                .then(function (response) {
                    $scope.assetList = $scope.formatAssetListTable(response.data, name);
                }, function (error) {
                    ngNotifier.error(error);
                });
        }

        $scope.expandAncestors = function (elem, grouping) {
            function expandClasses() {
                if (elem.toUpperCase() == EVERYTHING) return;
                function search(array, name) {
                    for (var i in array) {
                        if (array[i].className === name) {
                            array[i].collapsed = false;
                            if (isLeaf) {
                                array[i].selected = 'selected';
                                var eventFake = new MouseEvent('click', {
                                    'view': $window,
                                    'bubbles': true,
                                    'cancelable': true
                                });
                                var event = $window.event || eventFake;
                                $scope.selectNodeLabel(array[i], event);
                            }
                            return;
                        }
                        search(array[i].children, name);
                    }
                }

                var promise = entityManager.getAncestors(elem);
                var isLeaf = false;
                promise.then(function (response) {
                    var dataStr = response.data + '';
                    var ancestors = dataStr.split(',');
                    for (var i = 0; i < ancestors.length; i++) {
                        isLeaf = ancestors.length - 1 == i;
                        search($scope.classList, ancestors[i]);
                    }
                }, function (error) {
                    ngNotifier.error(error);
                });
            }

            function expandDomains() {
                for (var i in $scope.domainsList) {
                    if ($scope.domainsList[i].name === elem) {
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
            }

            if (grouping === GROUPING_CLASS_TYPE)
                expandClasses();
            else
                expandDomains();
        }

        entityManager.getClasses()
            .then(function (response) {
                $scope.classList = $scope.createClasses(response.data, false);
            }, function (error) {
                ngNotifier.error(error);
            }).then(function () {
            if (!isEmpty($routeParams.className)) {
                $scope.currentNode = {};
                $scope.currentNode.className = currentNode.getClass().className;
                // $routeParams.className;
                $scope.getAssets($routeParams.className, true);
                if ($scope.currentNode && $scope.currentNode.className)
                    $scope.expandAncestors($scope.currentNode.className, GROUPING_CLASS_TYPE);
                $scope.newAssetVisible = true;
            } else {
                if (currentNode.getClass() && currentNode.getClass().className) {
                    $scope.currentNode = currentNode.getClass();
                    $scope.expandAncestors($scope.currentNode.className, GROUPING_CLASS_TYPE);
                }
            }
        });
        $scope.columnDefs = [
            {
                "mDataProp": "connectedToOrion",
                "aTargets": [0],
                "bSortable": false,
                "fnRender": function (data) {
                    $scope.connectedTo = data.aData.connectedToOrion;
                    if (!isEmpty($scope.connectedTo))
                        return '<i class="fa fa-globe" aria-hidden="true" data-toggle="tooltip" data-original-title="Connected with ' + $scope.connectedTo + '"></i>';
                    else
                        return '';

                }
            },
            {
                "mDataProp": "individualName",
                "aTargets": [1],
                "bSearchable": true
            },
            {
                "mDataProp": "className",
                "aTargets": [2],
                "bSearchable": true
            }, {
                "mDataProp": "domain",
                "aTargets": [3],
                "bSearchable": true,
                "fnRender": function (data) {
                    var retVal = data.aData.domain;
                    return '<span aria-hidden="true" ></span>&nbsp;' + retVal;
                }
            }, {
                "mDataProp": "createdOn",
                "aTargets": [4],
                "bSortable": true
            }, {
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
                if (typeof Scopes.get('homeController') !== 'undefined')
                    tooltipTable.addTooltipToAssetModel();
            },
        };
        $scope.newAssetVisible = false;
        //funzioni di utilità
        $scope.loadChildren = function () {
            var clsName = $scope.currentNode.className;
            var domainName = $scope.currentNode.name;
            if (clsName) {
                if ($scope.currentNode.className.toUpperCase() == EVERYTHING) {
                    clsName = '';
                    $scope.newAssetVisible = false;
                }
                entityManager.getChildrenForClass(clsName)
                    .then(function (response) {
                        var dataNotMySelf = $scope.removeClassMySelf(response.data, $scope.currentNode.className);
                        if (!isEmpty(dataNotMySelf) && $scope.currentNode.className !== EVERYTHING) {
                            var classes = $scope.createClasses(dataNotMySelf, true);
                            $scope.currentNode.children = classes;
                        }
                        $scope.loadAsset();
                    }, function (error) {
                        ngNotifier.error(error);
                    });
                //$window.scroll(0, 0);
            } else if (domainName) {
                entityManager.getAssetsFromDomain($scope.currentNode.id)
                    .then(function (response) {
                        assetsCounter = 0;
                        $scope.assetList = $scope.formatAssetListTable(response.data);
                        //console.log("Assets List", $scope.assetList);
                        $scope.createOCBVisible = true;
                    }, function (error) {
                        ngNotifier.error(error);
                    });
            }
        }
        $scope.loadAsset = function () {
            assetsCounter = 0;
            if ($scope.currentNode.className) {
                var clsName = $scope.currentNode.className;
                if ($scope.currentNode.className.toUpperCase() == EVERYTHING) {
                    clsName = '';
                    $scope.newAssetVisible = false;
                }
                $scope.getAssets(clsName, true);
                if (clsName !== '')
                    $scope.newAssetVisible = true;
            } else {
                $scope.assetList = [];
                $scope.newAssetVisible = false;
            }
        }

        $scope.openNewAssetModelPanel = function () {
            entityManager.getDomains()
                .success(function (data) {
                    $scope.domainsList = [];
                    $scope.domainsList.push('');
                    for (var i = 0; i < data.length; i++) {
                        var value = data[i];
                        var domain = {
                            name: value.name,
                            id: value.id,
                            iri: value.links.self + '#' + value.name,
                            description: value.description,
                        };
                        if (domain.id.toUpperCase().indexOf(NO_DOMAIN) === -1) {
                            $scope.domainsList.push(domain);
                        }
                    }
                    ngDialogManager.open({
                        template: 'pages/newAssetModel.htm',
                        controller: 'newAssetModelController',
                        scope: $scope
                    });
                }).error(function (error) {
                $scope.domainsList = [];
                ngNotifier.error(error);
            });
        }

        $scope.openNewAssetPanel = function (selectedModel) {
            $scope.selectedModel = selectedModel;
            entityManager.getDomains().success(function (data) {
                $scope.domainsList = [];
                for (var i = 0; i < data.length; i++) {
                    var value = data[i];
                    var domain = {
                        name: value.name,
                        id: value.id,
                        iri: value.links.self + '#' + value.name,
                        description: value.description,
                    };
                    if (domain.id.toUpperCase().indexOf(NO_DOMAIN) === -1) {
                        $scope.domainsList.push(domain);
                    }
                }
                ngDialogManager.open({
                    template: 'pages/newAsset.htm',
                    controller: 'newAssetController',
                    scope: $scope
                });
            }).error(function (error) {
                $scope.domainsList = [];
                ngNotifier.error(error);
            });
        }

        $scope.changeBackground = function (ev) {
            $('.ownselector').each(
                function () {
                    $(this).removeClass('selected');
                    $(this).removeClass('ownselector');
                });
            ev.target.className += ' selected ownselector';
        }

        $scope.openRemoveAssetPanel = function (elementToDelete, typeToDelete) {
            $scope.elementToDelete = elementToDelete;
            $scope.typeToDelete = typeToDelete;
            ngDialogManager.open({
                template: 'pages/confirmDelete.htm',
                controller: 'confirmDeleteController',
                scope: $scope
            });
        }

        $scope.openConfirmDeleteElement = function (node) {
            $scope.elementToDelete = node.className;
            $scope.typeToDelete = 'class';
            ngDialogManager.open({
                template: 'pages/confirmDelete.htm',
                controller: 'confirmDeleteController',
                scope: $scope
            });
        }

        $scope.openAddChildPanel = function (node) {
            $scope.className = node.className;
            $scope.title = 'Add child class to ';
            ngDialogManager.open({
                template: 'pages/newClass.htm',
                controller: 'newChildClassController',
                scope: $scope
            });
        }

        $scope.openMoveClassPanel = function (node) {
            $scope.className = node.className;
            $scope.title = 'Move class';
            ngDialogManager.open({
                template: 'pages/newClass.htm',
                controller: 'moveClassController',
                scope: $scope
            });
        }

        $scope.openNewClassPanel = function () {
            $scope.title = 'Create class';
            ngDialogManager.open({
                template: 'pages/newClass.htm',
                controller: 'newClassController',
                scope: $scope
            });
        }

        $scope.openErrorPanel = function (err) {
            $scope.errorMsg = err;
            console.log($scope.errorMsg);
            if (typeof ($scope.errorMsg) === 'object')
                $scope.errorMsg = JSON.stringify($scope.errorMsg);
            ngNotifier.error($scope.errorMsg);
        }

        $scope.collapseAllTreeNodes = function () {
            $scope.classList.forEach(function (elem) {
                elem.collapsed = true;
            });
        }

        $scope.expandAllTreeNodes = function (classes) {
            if (!classes)
                classes = $scope.classList;
            for (var i in classes) {
                var elem = classes[i];
                elem.collapsed = false;
                if (elem.children && elem.children.length > 0)
                    $scope.expandAllTreeNodes(elem.children);
            }
        }

        templateManager.getAssetAction().then(function (response) {
            $scope.actionAssetTemplate = response.data;
        }, function (error) {
            $scope.actionAssetTemplate = '';
            ngNotifier.error(error);
        });


        $scope.formatAssetListTable = function (data, clazzName) {
            if (!data)
                return [];
            $scope.assetMap = {}
            for (var i = 0; i < data.length; i++) {
                var asset = angular.copy(data[i]);
                $scope.assetMap[asset.individualName] = asset;
                var elementType = 'asset';
                var groupingType = currentNode.getCurrentNodeType();
                var groupingName;
                if (groupingType === GROUPING_CLASS_TYPE)
                    groupingName = data[i].className;
                else if (groupingType === GROUPING_DOMAIN_TYPE)
                    groupingName = data[i].domain;
                data[i].action = (function () {
                    var visibility = isEmpty(data[i].connectedToOrion) ? 'style = "visibility:hidden;"' : '';
                    return $scope.actionAssetTemplate
                        .replaceAll('$value$', data[i].individualName)
                        .replaceAll('$elementType$', elementType)
                        .replaceAll('$groupingType$', groupingType)
                        .replaceAll('$groupingName$', groupingName)
                        .replaceAll('$visibility$', visibility)
                        .replaceAll('$isOCBEnabled$', !isEmpty(data[i].connectedToOrion));

                })();
            }
            data.sort(function (a, b) {
                return new Date(b.createdOn) - new Date(a.createdOn);
            });

            return data;
        }

        $scope.removeClassMySelf = function (data, className) {
            return entityManager.removeClassMySelf(data, className);
        }

        $scope.createClasses = function (data, isSubClass) {
            var classes = [];
            if (typeof isSubClass !== 'undefined' && !isSubClass) {
                var everythingClass = {
                    className: EVERYTHING,
                    classId: EVERYTHING.toLowerCase(),
                    children: [],
                    collapsed: true,
                };
                classes.push(everythingClass);
            }
            for (var i in data) {
                var classItem = {
                    className: data[i].normalizedName,
                    classId: data[i].normalizedName,
                    children: $scope.createClasses(data[i].subClasses, true),
                    collapsed: true,
                }
                classes.push(classItem);
            }
            return classes;
        }

        $scope.openDetail = function (value, groupingType, groupingName) {
            $location.path('/detail/' + value + '/' + groupingType + '/' + groupingName);
            $scope.selectedAsset = $scope.assetMap[value];
        }
    }]);
