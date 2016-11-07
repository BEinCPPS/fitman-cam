camApp.controller('newAssetController', [
    '$scope',
    '$http',
    '$q',
    'entityManager',
    'ngDialog',
    function ($scope, $http, $q, entityManager, $ngDialog) {
        //$scope.elementToDelete;
        //$scope.typetoDelete;
        $scope.invalidName = false;
        $scope.closeNewAssetPanel = function () {
            $ngDialog.close();
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
                $ngDialog.close();
            }).error(function (err) {
                $ngDialog.close();
                ngNotifier.error(err);
            });
        }
    }]);



