camApp.controller('newAssetController', [
    '$scope',
    '$http',
    '$q',
    'entityManager',
    'ngDialogManager',
    '$route',
    'ngNotifier',
    function ($scope, $http, $q, entityManager, ngDialogManager, $route, ngNotifier) {
        $scope.invalidName = false;
        $scope.newAsset = {name:""};
        $scope.closeNewAssetPanel = function () {
            ngDialogManager.close();
        }

        $scope.newAsset = {
            name: "",
            modelName: $scope.selectedModel,
            domainName: ""
        };
        var urlFragment = '/assets/';

        $scope.$watch('newAsset.name', function () {
            if (!isEmpty($scope.newAsset.name)) {
                $scope.invalidName = false;
            }
        });

        $scope.saveNewAsset = function () {
            if (isEmpty($scope.newAsset.name)) {
                $scope.invalidName = true;
                return;
            }
            entityManager.createAsset($scope.newAsset).success(function (data, status) {
                $scope.loadChildren();
                ngDialogManager.close();
                ngNotifier.success();
                $route.reload();
            }).error(function (err) {
                ngDialogManager.close();
                ngNotifier.error(err);
            });
        }
    }]);



