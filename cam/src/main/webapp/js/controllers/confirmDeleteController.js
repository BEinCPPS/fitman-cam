camApp.controller('confirmDeleteController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialog',
    '$route',
    '$timeout',
    'entityManager',
    'ngNotifier',
    function ($scope, Scopes, $q, $ngDialog, $route, $timeout, entityManager, ngNotifier) {
        Scopes.store('confirmDeleteController', $scope);

        $scope.closeConfirmDeletePanel = function () {
            $ngDialog.close();
        }
        $scope.confirmDelete = function () {

            if ($scope.typeToDelete == 'class') {
                entityManager.getAncestors($scope.elementToDelete)
                    .then(function (response) {
                        var dataStr = response.data + "";
                        var ancestors = dataStr.split(',');
                        //$http.delete(BACK_END_URL_CONST + urlFragment + $scope.elementToDelete)
                        entityManager.deleteIndividual($scope.typeToDelete, $scope.elementToDelete, $scope.individualName)
                            .then(function (response) {
                                $ngDialog.close();
                                $route.reload();
                                $timeout(function () {
                                    Scopes.get('homeController').expandAncestors(ancestors[ancestors.length - 2]);
                                }, 1000);
                            }, function (error) {
                                $ngDialog.close();
                                ngNotifier.error(error);
                            });

                    }, function (error) {
                        console.log(error); //TODO ERROR
                    });
            } else
                entityManager.deleteIndividual($scope.typeToDelete, $scope.elementToDelete, $scope.individualName)
                    .success(function (data, status) {
                        if ($scope.detail) {
                            $route.reload();
                            $scope.entityManager.getAssetDetail($scope.individualName);
                        } else
                            $scope.loadChildren();
                        $ngDialog.closeAll();
                    }).error(function (err) {
                    $ngDialog.close();
                    ngNotifier.error(err);
                });

        }
    }]);
