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
         var ngDialog=ngDialogManager.getNgDialog();
           ngDialog.close(ngDialog.getOpenDialogs()[1]);
        };

        $scope.confirmNewOperation = function () {
            if ($scope.typeToAdd == 'attribute') {
                Scopes.get('newAttributeController').saveNewAttribute();
            } else if($scope.typeToAdd == 'relationship'){
                Scopes.get('newRelationshipController').saveNewRelationship();
            } else if($scope.typeToAdd == 'domain'){
                Scopes.get('newDomainController').saveNewDomain();
            } else if($scope.typeToAdd == 'Orion Context Broker'){
                Scopes.get('homeController').createAssetsToOCB();
            }
            ngDialogManager.closeAll();
        };
    }]);
