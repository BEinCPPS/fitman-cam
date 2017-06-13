camApp.controller('confirmNewOperationController', [
    '$scope',
    'Scopes',
    '$http',
    '$q',
    'ngDialogManager',
    '$route',
    '$timeout',
    function ($scope, Scopes, $http, $q, ngDialogManager, $route, $timeout) {
        $scope.closeConfirmNewOperationPanel = function () {
            var ngDialog = ngDialogManager.getNgDialog();
            ngDialog.close(ngDialog.getOpenDialogs()[1]);
        };

        $scope.confirmNewOperation = function () {
            if ($scope.subTypeToAdd)
                $scope.typeToAdd = $scope.subTypeToAdd;
            if ($scope.typeToAdd == 'attribute') {
                Scopes.get('newAttributeController').saveNewAttribute();
            } else if ($scope.typeToAdd == 'relationship') {
                Scopes.get('newRelationshipController').saveNewRelationship();
            } else if ($scope.typeToAdd == 'domain') {
                Scopes.get('newDomainController').saveNewDomain();
            } else if ($scope.typeToAdd == 'createInOCB') {
                $scope.typeToAdd = "Orion Context Broker";
                $scope.originalController.createAssetsToOCB($scope.selectedOrionConfigId);
            } else if ($scope.typeToAdd == 'disconnectFromOCB') {
                $scope.typeToAdd = "Orion Context Broker";
                $scope.originalController.disconnectAssetFromOCB();
            }
            ngDialogManager.closeAll();
        };
    }]);
