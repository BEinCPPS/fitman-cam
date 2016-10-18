camApp.controller('newAssetController', [
    '$scope',
    '$q',
    'ngDialog',
    'entityManager',
    'ngNotifier',
    function ($scope, $q, $ngDialog, entityManager, ngNotifier) {
        //$scope.elementToDelete;
        //$scope.typetoDelete;
        $scope.invalidName = false;
        $scope.closeNewAssetPanel = function () {
            $ngDialog.close();
        }

        $scope.newAsset = {
            name: "",
            modelName: $scope.selectedModel,
            ownerName: ""
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
                ngNotifier.success("Success");
            }).error(function (err) {
                $ngDialog.close();
                ngNotifier.error(err);
            });
        }
    }]);



