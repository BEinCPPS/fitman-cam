camApp.controller('newAttributeController', [
    '$scope',
    'Scopes',
    '$http',
    '$q',
    'ngDialog',
    '$timeout',
    function ($scope, Scopes, $http, $q, $ngDialog, $timeout) {
        Scopes.store('newAttributeController', $scope);
        $scope.typeIsMandatoryMsg = "Type is mandatory";
        $scope.valueIsMandatoryMsg = "Value is mandatory";

        $scope.attrPanelTitle = "Add Attribute";
        $scope.invalidName = false;
        $scope.valueIsMandatory = false;
        $scope.typeIsMandatory = false;
        $scope.isEditing = false;
        $scope.isAutocomplete = false;
        $scope.newAttribute = {
            name: "",
            value: "",
            type: ""
        };

        $scope.changeName = function () {
            $scope.isAutocomplete = false;
        }

        $scope.updateValueType = function ($item, $model, $label) {
            $scope.newAttribute.value = '';
            if ($item) {
                $scope.newAttribute.name = $item.normalizedName;
                $scope.newAttribute.type = $item.propertyType;
                $scope.isAutocomplete = true;
            } else
                $scope.isAutocomplete = false;
        }

        $scope.closeNewAttributePanel = function () {
            $ngDialog.closeAll();
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

        $scope.addNew = function () {
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
            $http.post(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/attributes',
                $scope.newAttribute).success(function (data, status) {
                entityManager.getAssetDetail($scope.selectedAssetName);
                entityManager.getAttributes();
                $ngDialog.close();
            }).error(function (err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
        };
        var detailController = Scopes.get('detailController');
        $scope.attributes = detailController.attributes;

        $scope.openConfirmOperationPanel = function () {
            $scope.typeToAdd = 'attribute';
            $ngDialog.open({
                template: 'pages/confirmNewOperation.htm',
                controller: 'confirmNewOperationController',
                scope: $scope
            });
        };

    }]);



