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
    function ($scope, Scopes, $routeParams, $route, $q, ngDialogManager, $timeout, ngNotifier, entityManager, templateManager
        , currentNode, $window) {
        Scopes.store('homeController', $scope);
        $scope.assetList = [];

        $scope.getAssets = function (name, retrieveChildren) {
            entityManager.getAssets(name, retrieveChildren)
                .then(function (response) {
                    $scope.assetList = $scope.formatAssetListTable(response.data, name);
                }, function (error) {
                    ngNotifier.error(error);
                });
        }
        $scope.expandAncestors = function (elem) {
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
                             var event =  $window.event || eventFake;
                            $scope.selectNodeLabel(array[i], event);
                        }
                        return;
                    }
                    search(array[i].children, name);
                }
            }

            var promise = entityManager.getAncestors(elem);
            var isLeaf = false
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
        };

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
                if($scope.currentNode && $scope.currentNode.className)
                    $scope.expandAncestors($scope.currentNode.className);
                $scope.newAssetVisible = true;
                $scope.newAssetVisible = true;
            } else {
                if (currentNode.getClass().className) {
                    $scope.currentNode = currentNode.getClass();
                    $scope.expandAncestors($scope.currentNode.className);
                }
            }
        });

        $scope.regexPattern = REGEX_PATTERN;
        $scope.invalidNameMsg = INVALID_NAME_MSG;
        $scope.nameIsMandatory = NAME_IS_MANDATORY_MSG;
        $scope.keyrockSignupUrl = KEYROCK_SIGNUP_URL;

        $scope.columnDefs = [
            {
                "mDataProp": "individualName",
                "aTargets": [0],
                "bSearchable": true
            },
            {
                "mDataProp": "className",
                "aTargets": [1],
                "bSearchable": true
            }, {
                "mDataProp": "domain",
                "aTargets": [2],
                "bSearchable": true,
                "fnRender": function (data) {
                    var retVal = data.aData.domain;
//                    if (data.aData.domain && data.aData.lostDomain) {
//                        return '<span class="glyphicon glyphicon-remove" aria-hidden="true" data-lost-domain="true"></span>&nbsp;' + retVal;
//                    } else if (data.aData.domain && !data.aData.lostDomain) {
//                        return '<span class="glyphicon glyphicon-ok" aria-hidden="true" data-lost-domain="false"></span>&nbsp;' + retVal;
//                    } else
//                        return retVal;
                      return '<span aria-hidden="true" >'+retVal+'</span>&nbsp;';
                }
            }, {
                "mDataProp": "createdOn",
                "aTargets": [3],
                "bSortable": false
            }, {
                "mDataProp": "action",
                "aTargets": [4],
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
                $scope.addTooltipToAssetModel();
            }
        };
        $scope.newAssetVisible = false;

        //funzioni di utilità
        $scope.loadChildren = function () {
            var clsName = $scope.currentNode.className;
            if ($scope.currentNode.className.toUpperCase() == EVERYTHING) {
                clsName = '';
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
        }

        $scope.loadAsset = function () {
            if ($scope.currentNode.className) {
                var clsName = $scope.currentNode.className;
                if ($scope.currentNode.className.toUpperCase() == EVERYTHING) {
                    clsName = '';
                }
                $scope.getAssets(clsName, true);
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
                        if (isEmpty(value))
                            continue;
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

        $scope.openConfirmDeleteClass = function (node) {
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
            // ngDialogManager.open({
            //     template: 'pages/error.htm',
            //     controller: 'openErrorController',
            //     scope: $scope
            // });
            console.log($scope.errorMsg);
            if (typeof($scope.errorMsg) === 'object')
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

        $scope.addTooltipToAssetModel = function () {
            function addTooltip(htmlObj, maxLenght) {
                var valueOrig = htmlObj.text();
                var value = htmlObj.text();
                if(value && value.trim().length > 0 ) {
                    htmlObj.attr('data-toggle', 'tooltip');
                    htmlObj.attr('data-container', 'body');
                    htmlObj.attr('title', value);
                    if (value && value.length > maxLenght) {
                        value = value.substring(0, maxLenght).concat('...');
                        htmlObj.html().replace(valueOrig, value);
                    }
                }
            }

            var tableAssetElems = angular.element('tr.ng-scope');
            angular.forEach(tableAssetElems, function (value, key) {
                var children = angular.element(value).children();
                addTooltip(angular.element(children[0]), 25); //asset
                addTooltip(angular.element(children[1]), 25); //class
                addTooltip(angular.element(children[2]), 20); //owner group
            });
            $('[data-toggle="tooltip"]').tooltip();
        }

        templateManager.getAssetAction().then(function (response) {
            $scope.actionAssetTemplate = response.data;
        }, function (error) {
            $scope.actionAssetTemplate = '';
            ngNotifier.error(error);
        });
        templateManager.getAssetButtonAction().then(function (response) {
            $scope.actionAssetButtonTemplate = response.data;
        }, function (error) {
            $scope.actionAssetButtonTemplate = '';
            ngNotifier.error(error);
        });

        $scope.formatAssetListTable = function (data, clazzName) {
            if (!data)
                return [];
            for (var i = 0; i < data.length; i++) {
                if (isEmpty(data[i]))
                    continue;
                var elementType = 'asset';
                var individualName = '';
                if (!isEmpty(data[i].individualName))
                    individualName = data[i].individualName;

                data[i].action = (function () {
                    return $scope.actionAssetTemplate.replaceAll('$value$', individualName)
                        .replaceAll('$elementType$', elementType).replaceAll('$className$', data[i].className);

                })();
                data[i].action += (function () {
                    return $scope.actionAssetButtonTemplate.replaceAll('$value$', individualName);
                })();
            }

            data.sort(function (a, b) {
                if (isEmpty(a)||isEmpty(b))
                    return;
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

    }]);
