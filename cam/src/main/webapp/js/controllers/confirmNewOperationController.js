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
            ngDialogManager.close(ngDialogManager.getOpenDialogs()[1]);
        };

        $scope.confirmNewOperation = function () {
            if ($scope.typeToAdd == 'attribute') {
                Scopes.get('newAttributeController').saveNewAttribute();
            } else if($scope.typeToAdd == 'relationship'){
                Scopes.get('newRelationshipController').saveNewRelationship();
            } else if($scope.typeToAdd == 'domain'){
                Scopes.get('newDomainController').saveNewDomain();
            }
            ngDialogManager.closeAll();
        };
    }]);
