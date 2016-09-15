camApp.controller('newAssetModelController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http, $q, $ngDialog) {
        $scope.invalidName = false;
        $scope.newAssetModel = {
            name: "",
            className: $scope.currentNode.className,
            ownerName: ""
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
            $http.post(BACK_END_URL_CONST + '/models', $scope.newAssetModel).success(function (data, status) {
                $scope.loadChildren();
                $ngDialog.close();
            }).error(function (err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
        }
        }]);
