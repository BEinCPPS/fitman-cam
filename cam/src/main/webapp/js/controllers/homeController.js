camApp.controller('homeController', [
    '$scope',
    'Scopes',
    '$routeParams',
    '$route',
    '$q',
    'ngDialog',
    '$timeout',
    'ngNotifier',
    'entityManager',
    'templateManager',
    function ($scope, Scopes, $routeParams, $route, $q, $ngDialog, $timeout, ngNotifier, entityManager, templateManager) {
        Scopes.store('homeController', $scope);
        $scope.getAssets = function (name, retrieveChildren) {
            entityManager.getAssets(name, retrieveChildren)
                .then(function (response) {
                    $scope.fetchAssetList(response.data, function (res) {
                        $scope.assetList = $scope.formatAssetListTable(res, name);
                    });
                }, function (error) {
                    ngNotifier.error(error);
                });
        }

        if (!isEmpty($routeParams.className)) {
            setTimeout(function () { //CHIAMATA ASINCRONA PER RICARICARE GLI ASSET DELLA CLASSE
                $scope.currentNode = {};
                $scope.currentNode.className = $routeParams.className;
                $scope.getAssets($routeParams.className, true);
                $scope.expandAncestors($routeParams.className);
                $scope.newAssetVisible = true;
            }, 0);
            $scope.newAssetVisible = true;
        }

        $scope.regexPattern = REGEX_PATTERN;
        $scope.invalidNameMsg = INVALID_NAME_MSG;
        $scope.nameIsMandatory = NAME_IS_MANDATORY_MSG;
        $scope.keyrockSignupUrl = KEYROCK_SIGNUP_URL;


        $scope.columnDefs = [
            {
                "mDataProp": "asset",
                "aTargets": [0],
            },
            {
                "mDataProp": "class",
                "aTargets": [1]
            }, {
                "mDataProp": "owner",
                "aTargets": [2]
            }, {
                "mDataProp": "created",
                "aTargets": [3]
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


        $scope.assetList = [];
        entityManager.getClasses().then(function (response) {
            $scope.classList = $scope.createClasses(response.data);
        }, function (error) {
            ngNotifier.error(error);
        })

        $scope.newAssetVisible = false;

        //funzioni di utilità
        $scope.loadChildren = function () {
            entityManager.getChildrenForClass($scope.currentNode.className)
                .then(function (response) {
                    var dataNotMySelf = $scope.removeClassMySelf(response.data, $scope.currentNode.className);
                    if (!isEmpty(dataNotMySelf)) {
                        var classes = $scope.createClasses(dataNotMySelf);
                        $scope.currentNode.children = classes;
                    }
                    $scope.loadAsset();
                }, function (error) {
                    ngNotifier.error(error);
                });
            //window.scroll(0, 0);
        }

        $scope.loadAsset = function () {
            if ($scope.currentNode.className) {
                $scope.getAssets($scope.currentNode.className, true);
                $scope.newAssetVisible = true;
            } else {
                $scope.assetList = [];
                $scope.newAssetVisible = false;
            }
        }

        $scope.openNewAssetModelPanel = function () {
            entityManager.getOwners()
                .success(function (data) {
                    $scope.ownersList = [];
                    $scope.ownersList.push('');
                    for (var i = 0; i < data.length; i++) {
                        $scope.ownersList.push(data[i].name);
                    }
                    $ngDialog.open({
                        template: 'pages/newAssetModel.htm',
                        controller: 'newAssetModelController',
                        scope: $scope
                    });
                })
                .error(function (error) {
                    $scope.ownersList = [];
                    ngNotifier.error(error);
                });
        }

        $scope.openNewAssetPanel = function (selectedModel) {
            $scope.selectedModel = selectedModel;
            entityManager.getOwners().success(function (data) {
                $scope.ownersList = [];
                for (var i = 0; i < data.length; i++) {
                    $scope.ownersList.push(data[i].name);
                }
                $ngDialog.open({
                    template: 'pages/newAsset.htm',
                    controller: 'newAssetController',
                    scope: $scope
                });
            })
                .error(function (error) {
                    $scope.ownersList = [];
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
            $ngDialog.open({
                template: 'pages/confirmDelete.htm',
                controller: 'confirmDeleteController',
                scope: $scope
            });
        }
        $scope.openConfirmDeleteClass = function (node) {
            $scope.elementToDelete = node.className;
            $scope.typeToDelete = 'class';
            $ngDialog.open({
                template: 'pages/confirmDelete.htm',
                controller: 'confirmDeleteController',
                scope: $scope
            });
        }

        $scope.openAddChildPanel = function (node) {
            $scope.className = node.className;
            $scope.title = 'Add child class to ';
            $ngDialog.open({
                template: 'pages/newClass.htm',
                controller: 'newChildClassController',
                scope: $scope
            });
        }

        $scope.openMoveClassPanel = function (node) {
            $scope.className = node.className;
            $scope.title = 'Move class';
            $ngDialog.open({
                template: 'pages/newClass.htm',
                controller: 'moveClassController',
                scope: $scope
            });
        }

        $scope.openNewClassPanel = function () {
            $scope.title = 'Create class';
            $ngDialog.open({
                template: 'pages/newClass.htm',
                controller: 'newClassController',
                scope: $scope
            });
        }

        $scope.openErrorPanel = function (err) {
            $scope.errorMsg = err;
            // $ngDialog.open({
            //     template: 'pages/error.htm',
            //     controller: 'openErrorController',
            //     scope: $scope
            // });
            console.log($scope.errorMsg);
            if (typeof($scope.errorMsg) === 'object')
                $scope.errorMsg = JSON.stringify($scope.errorMsg);
            ngNotifier.error($scope.errorMsg);
        }

        $scope.backToHomeWithExpandedTree = function (className) {
            $scope.ancestorClassName = className;
            entityManager.getAncestors(className).then(function (response) {
                $route.reload();
                $scope.init();
            }, function (error) {
                ngNotifier.error(error);
            });

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
                var value = htmlObj.text();
                htmlObj.attr('data-toggle', 'tooltip');
                htmlObj.attr('data-container', 'body');
                htmlObj.attr('title', value);
                if (value && value.length > maxLenght) {
                    value = value.substring(0, maxLenght).concat('...');
                    htmlObj.text(value);
                }
            }

            var tableAssetElems = angular.element('tr.ng-scope');
            angular.forEach(tableAssetElems, function (value, key) {
                var children = angular.element(value).children();
                addTooltip(angular.element(children[0]), 20); //asset
                addTooltip(angular.element(children[1]), 15); //class
                addTooltip(angular.element(children[2]), 20); //owner group
            });
            $('[data-toggle="tooltip"]').tooltip();
        }


        $scope.expandAncestors = function (elem) {
            function search(array, name) {
                for (var i in array) {
                    if (array[i].className === name) {
                        array[i].collapsed = false;
                        if (isLeaf)
                            array[i].selected = 'selected';
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
                var elementType = 'asset';

                data[i].action = (function () {
                    return $scope.actionAssetTemplate.replaceAll('$value$', data[i].asset).replaceAll('$element$', elementType).replaceAll('$className$', clazzName);

                })();
                data[i].action += (function () {
                    return $scope.actionAssetButtonTemplate.replaceAll('$value$', data[i].asset);
                })();
            }

            data.sort(function (a, b) {
                return new Date(b.originalDate) - new Date(a.originalDate);
            });

            return data;
        }


        $scope.fetchAssetList = function (assetList, completeCallback) {
            var result = [];

            function fetchData() {
                if (assetList.length == 0) {
                    completeCallback(result);
                } else {
                    var cur = assetList.shift();
                    //$http.get(BACK_END_URL_CONST + '/assets/' + cur.individualName + '/attributes')
                    entityManager.getAttributesForIndividual(cur.individualName)
                        .success(function (data) {
                            var owned;
                            var model;
                            var created;
                            var originalDate;
                            var isModel = true;
                            for (var i = 0; i < data.length; i++) {
                                if (data[i].normalizedName.indexOf('ownedBy') > 0)
                                    owned = data[i].propertyValue.substring(data[i].propertyValue.lastIndexOf('#') + 1);
                                if (data[i].normalizedName.indexOf('instanceOf') > 0) {
                                    model = data[i].propertyValue;
                                    isModel = false;
                                }
                                if (data[i].normalizedName.indexOf('createdOn') > 0) {
                                    var myDate = new Date(data[i].propertyValue);
                                    var month = (myDate.getMonth() + 1).toString();
                                    var day = new String(myDate.getDate());
                                    while (month.length < 2)
                                        month = '0' + month;
                                    while (day.length < 2)
                                        day = '0' + day;
                                    created = day + "/" + month + "/" + myDate.getFullYear();
                                    originalDate = myDate;

                                }
                            }

                            var asset = {
                                asset: cur.individualName,
                                created: created,
                                originalDate: myDate,
                                model: model || "",
                                owner: owned || "",
                                class: cur.className,
                                isModel: isModel,
                                index: i,
                            };
                            result.push(asset);
                        })
                        .error(function (error) {
                            ngNotifier.error(error);

                        }).finally(function () {
                        fetchData();
                    });
                }
            }

            fetchData();
        }


        $scope.removeClassMySelf = function (data, className) {
            return entityManager.removeClassMySelf(data, className);
        }

        $scope.createClasses = function (data) {
            var classes = [];
            for (var i in data) {
                var classItem = {
                    className: data[i].normalizedName,
                    classId: data[i].normalizedName,
                    children: $scope.createClasses(data[i].subClasses),
                    collapsed: true,
                }
                classes.push(classItem);
            }
            return classes;
        }

    }]);
