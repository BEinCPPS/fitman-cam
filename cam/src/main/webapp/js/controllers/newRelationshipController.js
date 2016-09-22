camApp.controller('newRelationshipController', [
    '$scope',
    'Scopes',
    '$http',
    '$q',
    'ngDialog',
    function ($scope, Scopes, $http, $q, $ngDialog) {
        Scopes.store('newRelationshipController', $scope);
        $scope.relPanelTitle = "Add Relationship";
        $scope.valueIsMandatoryMsg = "Referred name is mandatory";
        $scope.invalidName = false;
        $scope.valueIsMandatory = false;
        $scope.isEditing = false;

        var urlFragment = '/assets/';
        if ($scope.attributeName) {
            $scope.relPanelTitle = "Edit Relationship";
            $scope.isEditing = true;
            $http.get(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/relationships/' + $scope.attributeName)
                .success(function (data) {
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

        $scope.saveNewRelationship = function () {
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
        };

        $scope.openConfirmOperationPanel = function () {
            if (isEmpty($scope.newRelationship.name)) {
                $scope.invalidName = true;
                return;
            }
            if (isEmpty($scope.newRelationship.referredName)) {
                $scope.valueIsMandatory = true;
                return;
            }
            $scope.typeToAdd = 'relationship';
            $ngDialog.open({
                template: 'pages/confirmNewOperation.htm',
                controller: 'confirmNewOperationController',
                scope: $scope
            });
        };

    }]);
