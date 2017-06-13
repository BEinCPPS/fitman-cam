camApp.controller('newAssetModelController', [
    '$scope',
    '$q',
    'ngDialogManager',
    'entityManager',
    'ngNotifier',
    '$route',
    'Scopes',
    function ($scope, $q, ngDialogManager, entityManager, ngNotifier, $route, Scopes) {
        $scope.invalidName = false;
        $scope.newAssetModel = {name:""};
        $scope.newAssetModel = {
            name: "",
            className: $scope.currentNode.className,
            domainName: ""
        };

        $scope.closeNewAssetModelPanel = function () {
            ngDialogManager.close();
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
            entityManager.createModel($scope.newAssetModel)
                .success(function (data, status) {
                    $scope.loadChildren();
                    ngDialogManager.close();
                    $route.reload();
                    ngNotifier.success();
                }).error(function (err) {
                ngDialogManager.close();
                ngNotifier.error(err);
            });
        }
    }]);
