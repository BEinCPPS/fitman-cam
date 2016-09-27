camApp.controller('homeController', [
    '$scope',
    'Scopes',
    '$http',
    '$routeParams',
    '$route',
    '$q',
    'ngDialog',
    '$timeout',
    'ngNotifier',
    function ($scope, Scopes, $http, $routeParams, $route, $q, $ngDialog, $timeout, ngNotifier ){
        Scopes.store('homeController', $scope);
        entityManager.init($scope, $http, $q);

        if (!isEmpty($routeParams.className)) {
            setTimeout(function () { //CHIAMATA ASINCRONA PER RICARICARE GLI ASSET DELLA CLASSE
                $scope.currentNode = {};
                $scope.currentNode.className = $routeParams.className;
                entityManager.getAssets($routeParams.className, true);
                $scope.expandAncestors($routeParams.className);
                $scope.newAssetVisible = true;
            }, 0);
            $scope.newAssetVisible = true;
        }

        $scope.regexPattern = REGEX_PATTERN;
        $scope.invalidNameMsg = INVALID_NAME_MSG;
        $scope.nameIsMandatory = NAME_IS_MANDATORY_MSG;


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
        entityManager.getClasses();
        $scope.newAssetVisible = false;


        //funzioni di utilità
        $scope.loadChildren = function () {
            entityManager.getChildrenForClass($scope.currentNode.className);
        }

        $scope.loadAsset = function () {
            //				alert($scope.currentNode); //per recuperare il nodo da passare in input a servizio rest
            if ($scope.currentNode.className) {
                entityManager.getAssets($scope.currentNode.className, true);

                $scope.newAssetVisible = true;
            } else {
                $scope.assetList = [];
                $scope.newAssetVisible = false;
            }
        }

        $scope.openNewAssetModelPanel = function () {
            $http.get(BACK_END_URL_CONST + '/owners')
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
                    openErrorPanel(error);
                });
        }

        $scope.openNewAssetPanel = function (selectedModel) {
            $scope.selectedModel = selectedModel;

            $http.get(BACK_END_URL_CONST + '/owners')
                .success(function (data) {
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
                    openErrorPanel(error);
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
            ngNotifier.notifyError($scope.errorMsg);

        }

        $scope.backToHomeWithExpandedTree = function (className) {
            $scope.ancestorClassName = className;
            var deferred = $q.defer();
            entityManager.getAncestorsList(className, deferred);
            var promise = deferred.promise;
            promise.then(function (data) {
                $route.reload();
                $scope.init();
            }, function (error) {
                console.log(error);
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

            var deferred = $q.defer();
            entityManager.getAncestorsList(elem, deferred);
            var promise = deferred.promise;
            var isLeaf = false
            promise.then(function (data) {
                var dataStr = data + '';
                var ancestors = dataStr.split(',');
                for (var i = 0; i < ancestors.length; i++) {
                    isLeaf = ancestors.length - 1 == i;
                    search($scope.classList, ancestors[i]);
                }
            }, function (error) {
                console.log(error);
            });

        }
    }])
;
