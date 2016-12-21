camApp.controller('attributeDetailController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialogManager',
    'entityManager',
    '$route',
    'ngNotifier',
    function ($scope, Scopes, $q, ngDialogManager, entityManager, $route, ngNotifier) {
        Scopes.store('attributeDetailController', $scope);

        $scope.typeIsMandatoryMsg = "Type is mandatory";
        $scope.valueIsMandatoryMsg = "Value is mandatory";
         $scope.newAttribute = {
                    name: "",
                    value: "",
                    type: ""
                };
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
        entityManager.getAttribute($scope.isModel, $scope.selectedAssetName, $scope.attributeName)
            .success(function (data) {
                $scope.newAttribute = {
                    name: data.normalizedName,
                    value: data.propertyValue,
                    type: data.propertyType
                }

            }).error(function (err) {
            ngNotifier.error(err);
        });


        $scope.closeNewAttributePanel = function () {
            ngDialogManager.close();
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
            entityManager.updateAttribute($scope.isModel, $scope.selectedAssetName, $scope.newAttribute.name, $scope.newAttribute)
                .success(function (data, status) {
                    Scopes.get('detailController').getAssetDetail($scope.selectedAssetName, ATTRIBUTES);
                    ngDialogManager.close();
                    ngNotifier.success();
                    $route.reload();
                }).error(function (err) {
                ngDialogManager.close();
                ngNotifier.error(err);
            });
        };
    }]);
