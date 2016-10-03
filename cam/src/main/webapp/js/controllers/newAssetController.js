camApp.controller('newAssetController', [
    '$scope',
    '$http',
    '$q',
    'ngDialog',
    'ngNotifier',
    function ($scope, $http, $q, $ngDialog, ngNotifier) {
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
            $http.post(BACK_END_URL_CONST + urlFragment, $scope.newAsset).success(function (data, status) {
                $scope.loadChildren();
                $ngDialog.close();
                ngNotifier.notify('Success!!');
            }).error(function (err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
        }
    }]);



