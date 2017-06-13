camApp.controller('newAttributeController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialogManager',
    '$timeout',
    'entityManager',
    '$route',
    'ngNotifier',
    function ($scope, Scopes, $q, ngDialogManager, $timeout, entityManager, $route, ngNotifier) {
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
        $scope.operationMessage = 'Are you sure you want to create a new ';
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
            ngDialogManager.closeAll();
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
            entityManager.createAttribute($scope.isModel, $scope.selectedAssetName, $scope.newAttribute)
                .then(function (response) {
                    Scopes.get('detailController').getAssetDetail($scope.selectedAssetName, ATTRIBUTES);
                    Scopes.get('detailController').getAttributes();
                    ngDialogManager.close();
                    ngNotifier.success();
                    $route.reload();
                }, function (err) {
                    ngDialogManager.close();
                    ngNotifier.error(err);
                });
        }

        $scope.updateNewAttribute = function () {
             entityManager.updateAttribute($scope.isModel, $scope.selectedAssetName,
                    $scope.newAttribute.name, $scope.newAttribute)
                    .success(function (data, status) {
                        Scopes.get('detailController').getAssetDetail($scope.selectedAssetName, ATTRIBUTES);
                        ngDialogManager.close();
                        ngNotifier.success();
                        $route.reload();
                    }).error(function (err) {
                    ngDialogManager.close();
                    ngNotifier.error(err);
               });
        }

        var detailController = Scopes.get('detailController');
        $scope.attributes = detailController.attributes;

        $scope.openConfirmOperationPanel = function () {
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
            $scope.typeToAdd = 'attribute';
            $scope.operationName = "Save";
            $scope.titleOperationMessage = 'Create a new ';
            $scope.operationMessage = 'Are you sure you want to create a new ';
            if ($scope.isAutocomplete) {
                $scope.operationMessage = 'Are you sure you want to select this ';
                $scope.titleOperationMessage = 'Select this ';
            }
            ngDialogManager.open({
                template: 'pages/confirmNewOperation.htm',
                controller: 'confirmNewOperationController',
                scope: $scope
            });
        }

        $scope.manageEdit = function () {
            if ($scope.isAutocomplete) {
                $scope.updateNewAttribute();
            } else {
                $scope.openConfirmOperationPanel();
            }
        }

    }]);



