camApp.controller('newRelationshipController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialogManager',
    'ngNotifier',
    'entityManager',
    '$route',
    function ($scope, Scopes, $q, ngDialogManager, ngNotifier, entityManager, $route) {
        Scopes.store('newRelationshipController', $scope);
        $scope.relPanelTitle = "Add Relationship";
        $scope.valueIsMandatoryMsg = "Referred name is mandatory";
        $scope.invalidName = false;
        $scope.valueIsMandatory = false;
        $scope.isEditing = false;
        $scope.operationMessage = 'Are you sure you want to create a new ';
        $scope.titleOperationMessage = 'Create a new ';
        $scope.newRelationship = {name: ''};

        var urlFragment = '/assets/';
        if ($scope.attributeName) {
            $scope.relPanelTitle = "Edit Relationship";
            $scope.isEditing = true;
            // $http.get(BACK_END_URL_CONST + urlFragment + $scope.selectedAssetName + '/relationships/' + $scope.attributeName)
            entityManager.getRelationship($scope.selectedAssetName, $scope.attributeName)
                .success(function (data) {
                    $scope.newRelationship = {
                        name: data.normalizedName,
                        referredName: data.propertyValue
                    };
                }).error(function (err) {
                $scope.openErrorPanel(err);
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
            ngDialogManager.close();
        };

        $scope.select = {
            value: null,
            options: null
        };

        $scope.saveNewRelationship = function () {
            if ($scope.attributeName) {
                entityManager.updateRelationship($scope.selectedAssetName, $scope.attributeName, $scope.newRelationship)
                    .success(function (data, status) {
                        entityManager.getAssetDetail($scope.selectedAssetName);
                        ngDialogManager.close();
                        ngNotifier.success();
                        $route.reload();
                    }).error(function (err) {
                    ngDialogManager.close();
                    ngNotifier.error(err);
                });
            } else {
                entityManager.createRelationship($scope.selectedAssetName, $scope.newRelationship)
                    .success(function (data, status) {
                        entityManager.getAssetDetail($scope.selectedAssetName);
                        ngDialogManager.close();
                        ngNotifier.success();
                        $route.reload();
                    }).error(function (err) {
                    ngDialogManager.close();
                    ngNotifier.error(err);
                });
            }
        };
        /**
         * modified after Mauro mail 27-06-2017
         *
         * $scope.openConfirmOperationPanel();
         */
        /*$scope.openConfirmOperationPanel = function () {
         if ($scope.attributeName) {
         $scope.saveNewRelationship();
         return;
         }
         if (isEmpty($scope.newRelationship.name)) {
         $scope.invalidName = true;
         return;
         }
         if (isEmpty($scope.newRelationship.referredName)) {
         $scope.valueIsMandatory = true;
         return;
         }
         $scope.typeToAdd = 'relationship';
         $scope.operationName = "Save";
         ngDialogManager.open({
         template: 'pages/confirmNewOperation.htm',
         controller: 'confirmNewOperationController',
         scope: $scope
         });
         };*/


        $scope.manageEdit = function () {
            /**
             * modified after Mauro mail 27-06-2017
             *
             * $scope.openConfirmOperationPanel();
             */
            if ($scope.attributeName) {
                $scope.saveNewRelationship();
                return;
            }
            if (isEmpty($scope.newRelationship.name)) {
                $scope.invalidName = true;
                return;
            }
            if (isEmpty($scope.newRelationship.referredName)) {
                $scope.valueIsMandatory = true;
                return;
            }
            $scope.saveNewRelationship();
        }

    }]);
