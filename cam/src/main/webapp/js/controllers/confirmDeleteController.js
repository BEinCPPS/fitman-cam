camApp.controller('confirmDeleteController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialogManager',
    '$route',
    '$timeout',
    'entityManager',
    'ngNotifier',
    function ($scope, Scopes, $q, ngDialogManager, $route, $timeout, entityManager, ngNotifier) {
        Scopes.store('confirmDeleteController', $scope);

        $scope.closeConfirmDeletePanel = function () {
            ngDialogManager.close();
        }
        $scope.confirmDelete = function () {
            if ($scope.typeToDelete == 'class') {
                entityManager.getAncestors($scope.elementToDelete)
                    .then(function (response) {
                        var dataStr = response.data + "";
                        var ancestors = dataStr.split(',');
                        entityManager.deleteIndividual($scope.typeToDelete, $scope.elementToDelete, $scope.individualName)
                            .then(function (response) {
                                ngNotifier.success();
                                ngDialogManager.close();
                                $route.reload();
                                $timeout(function () {
                                    Scopes.get('homeController').expandAncestors(ancestors[ancestors.length - 2]);
                                }, 1000);
                            }, function (error) {
                                ngDialogManager.close();
                                ngNotifier.error(error);
                            });

                    }, function (error) {
                        ngNotifier.error(error);
                    });
            }
            else if ($scope.typeToDelete == 'orionConfig') {
                entityManager.deleteOrionConfig($scope.elementToDelete)
                    .then(function (response) {
                        ngNotifier.success();
                        ngDialogManager.close();
                        $route.reload();
                    }, function (error) {
                        ngDialogManager.close();
                        ngNotifier.error(error);
                    });
            }
            else {
                entityManager.deleteIndividual($scope.typeToDelete, $scope.elementToDelete, $scope.individualName)
                    .success(function (data, status) {
                        if ($scope.detail) {
                            ngNotifier.success();
                            $route.reload();
                            $scope.entityManager.getAssetDetail($scope.individualName);
                        } else {
                            ngNotifier.success();
                            $scope.loadChildren();
                        }
                        ngDialogManager.closeAll();
                    }).error(function (err) {
                    ngDialogManager.close();
                    ngNotifier.error(err);
                });
            }
        }
    }
])
;
