camApp.controller('attributeDetailController', [
    '$scope',
    'Scopes',
    '$http',
    '$q',
    'ngDialog',
    function ($scope, Scopes, $http, $q, $ngDialog) {
        Scopes.store('attributeDetailController', $scope);

        $scope.typeIsMandatoryMsg = "Type is mandatory";
        $scope.valueIsMandatoryMsg = "Value is mandatory";

        $scope.attrPanelTitle = "Edit Attribute";
        $scope.invalidName = false;
        $scope.isEditing = true;
        if (isEmpty($scope.selectedAsset.model)) {
            $scope.isModel = true;
        } else {
            $scope.isModel = false;
        }

        $scope.updateValueType = function () {

            $scope.newAttribute.value = '';
        }

        var urlFragment = '/assets/';
        if ($scope.isModel)
            urlFragment = '/models/';
        $http.get(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/attributes/' + $scope.attributeName)
            .success(function (data) {
                $scope.newAttribute = {
                    name: data.normalizedName,
                    value: data.propertyValue,
                    type: data.propertyType
                }

            });


        $scope.closeNewAttributePanel = function () {
            $ngDialog.close();
        }

        $scope.$watch('newAttribute.name', function () {
            if (!isEmpty($scope.newAttribute.name)) {
                $scope.invalidName = false;
            }
        })

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

        $scope.manageEdit = function () {
            $scope.saveNewAttribute();
        };

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
            $http.put(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/attributes/' + $scope.newAttribute.name, $scope.newAttribute).success(function (data, status) {
                entityManager.getAssetDetail($scope.selectedAssetName);
                $ngDialog.close();
            }).error(function (err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
        };


    }]);
