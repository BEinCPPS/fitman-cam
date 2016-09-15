camApp.controller('newAttributeController', [
		'$scope',
        'Scopes',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, Scopes, $http, $q, $ngDialog) {

        $scope.typeIsMandatoryMsg = "Type is mandatory";
        $scope.valueIsMandatoryMsg = "Value is mandatory";

        $scope.attrPanelTitle = "Add Attribute";
        $scope.invalidName = false;
        $scope.valueIsMandatory = false;
        $scope.typeIsMandatory = false;
        $scope.isEditing = false;
        $scope.newAttribute = {
            name: "",
            value: "",
            type: ""
        };

        $scope.updateValueType = function () {

            $scope.newAttribute.value = '';
        }

        $scope.closeNewAttributePanel = function () {
            $ngDialog.close();
        }
        var urlFragment = '/assets/';

        if (isEmpty($scope.selectedAsset.model)) {
            $scope.isModel = true;
        } else {
            $scope.isModel = false;
        }

        if ($scope.isModel)
            urlFragment = '/models/';

        $scope.$watch('newAttribute.name', function () {
            if (!isEmpty($scope.newAttribute.name)) {
                $scope.invalidName = false;
            }
        });

        $scope.$watch('newAttribute.type', function () {
            if (!isEmpty($scope.newAttribute.type)) {
                $scope.typeIsMandatory = false;
            }
        });

        $scope.$watch('newAttribute.value', function () {
            if (!isEmpty($scope.newAttribute.value)) {
                $scope.valueIsMandatory = false;
            }
        });

        $scope.saveNewAttribute = function () {
            if (isEmpty($scope.newAttribute.name)) {
                $scope.invalidName = true;
                return;
            }
            if (isEmpty($scope.newAttribute.type)) {
                $scope.typeIsMandatory = true;
                return;
            }
            if (isEmpty($scope.newAttribute.value)) {
                $scope.valueIsMandatory = true;
                return;
            }
            $http.post(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/attributes', $scope.newAttribute).success(function (data, status) {
                entityManager.getAssetDetail($scope.selectedAssetName);
                $ngDialog.close();
            }).error(function (err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
        }
        }]);
