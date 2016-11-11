camApp.controller('newAssetModelController', [
    '$scope',
    '$q',
    'ngDialog',
    'entityManager',
    'ngNotifier',
    '$route',
    'Scopes',
    function ($scope, $q, $ngDialog, entityManager, ngNotifier, $route, Scopes) {
        $scope.invalidName = false;
        $scope.newAssetModel = {
            name: "",
            className: $scope.currentNode.className,
            domainName: ""
        };

        $scope.closeNewAssetModelPanel = function () {
            $ngDialog.close();
        }

        $scope.$watch('newAssetModel.name', function () {
            if (!isEmpty($scope.newAssetModel.name)) {
                $scope.invalidName = false;
            }
        });

        $scope.saveNewAssetModel = function () {
            if (isEmpty($scope.newAssetModel.name)) {
                $scope.invalidName = true;
                return;
            }
            // $http.post(BACK_END_URL_CONST + '/models', $scope.newAssetModel)
            entityManager.createModel($scope.newAssetModel)
                .success(function (data, status) {
                    $scope.loadChildren();
                    $ngDialog.close();
                    ngNotifier.success();
                    $route.reload();
                }).error(function (err) {
                $ngDialog.close();
                ngNotifier.error(err);
            });
        }
    }]);
