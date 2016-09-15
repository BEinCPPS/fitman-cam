camApp.controller('newRelationshipController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http, $q, $ngDialog) {
        $scope.relPanelTitle = "Add Relationship";
        $scope.invalidName = false;
        $scope.isEditing = false;
        if (isEmpty($scope.selectedAsset.model)) {
            $scope.isModel = true;
        } else {
            $scope.isModel = false;
        }

        var urlFragment = '/assets/';
        if ($scope.isModel)
            urlFragment = '/models/';
        if ($scope.attributeName) {
            $scope.relPanelTitle = "Edit Relationship";
            $scope.isEditing = true;
            $http.get(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/relationships/' + $scope.attributeName).success(function (data) {
                $scope.newRelationship = {
                    name: data.normalizedName,
                    referredName: data.propertyValue
                };
            });
        } else {
            $scope.newRelationship = {
                name: "",
                referredName: ""
            };
        }

        $scope.$watch('newRelationship.name', function () {
            if (!isEmpty($scope.newRelationship.name)) {
                $scope.invalidName = false;
            }
        });

        $scope.closeNewRelationshipPanel = function () {
            $scope.attributeName = null;
            $ngDialog.close();
        };

        $scope.select = {
            value: null,
            options: null
        };

        /*$scope.loadReferredAssets = function(){
             $http.get(BACK_END_URL_CONST + '/assets')
             .success(function (data) {
                return data;
                 })
                .error(function (error) {
                    console.log("Error encountered :-( " + error);
                    return [];
                });
             	
        };*/
        var urlFragment = '/assets/';

        if (isEmpty($scope.selectedAsset.model)) {
            $scope.isModel = true;
        } else {
            $scope.isModel = false;
        }

        if ($scope.isModel)
            urlFragment = '/models/';
        $scope.saveNewRelationship = function () {
            if (isEmpty($scope.newRelationship.name)) {
                $scope.invalidName = true;
                return;
            }
            if ($scope.attributeName) {
                $http.put(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/relationships/' + $scope.attributeName, $scope.newRelationship).success(function (data, status) {
                    entityManager.getAssetDetail($scope.selectedAssetName);
                    $ngDialog.close();

                }).error(function (err) {
                    $ngDialog.close();
                    $scope.openErrorPanel(err);
                });
            } else {
                $http.post(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/relationships', $scope.newRelationship).success(function (data, status) {
                    entityManager.getAssetDetail($scope.selectedAssetName);
                    $ngDialog.close();

                }).error(function (err) {
                    $ngDialog.close();
                    $scope.openErrorPanel(err);
                });
            }
        }
        }]);
