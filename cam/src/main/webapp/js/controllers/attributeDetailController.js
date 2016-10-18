camApp.controller('attributeDetailController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialog',
    'entityManager',
    '$route',
    'ngNotifier',
    function ($scope, Scopes, $q, $ngDialog, entityManager, $route, ngNotifier) {
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

        //$http.get(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/attributes/' + $scope.attributeName)
        entityManager.getAttribute($scope.isModel, $scope.selectedAssetName, $scope.attributeName)
            .success(function (data) {
                $scope.newAttribute = {
                    name: data.normalizedName,
                    value: data.propertyValue,
                    type: data.propertyType
                }

            }).error(function (err) {
            console.log(err);
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
            //$http.put(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/attributes/' + $scope.newAttribute.name, $scope.newAttribute)
            entityManager.updateAttribute($scope.isModel, $scope.selectedAssetName, $scope.newAttribute.name, $scope.newAttribute)
                .success(function (data, status) {
                    Scopes.get('detailController').getAssetDetail($scope.selectedAssetName, ATTRIBUTES);
                    $ngDialog.close();
                    ngNotifier.notify('Success!!!');
                    $route.reload();
                }).error(function (err) {
                $ngDialog.close();
                ngNotifier.error(err);
            });
        };


    }]);
