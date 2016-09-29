camApp.controller('confirmNewOperationController', [
    '$scope',
    'Scopes',
    '$http',
    '$q',
    'ngDialog',
    '$route',
    '$timeout',
    function ($scope, Scopes, $http, $q, $ngDialog, $route, $timeout) {
        $scope.closeConfirmNewOperationPanel = function () {
            $ngDialog.close($ngDialog.getOpenDialogs()[1]);
        };

        $scope.confirmNewOperation = function () {
            if ($scope.typeToAdd == 'attribute') {
                Scopes.get('newAttributeController').saveNewAttribute();
            } else if($scope.typeToAdd == 'relationship'){
                Scopes.get('newRelationshipController').saveNewRelationship();
            } else if($scope.typeToAdd == 'domain'){
                Scopes.get('newDomainController').saveNewDomain();
            }
            $ngDialog.closeAll();
        };
    }]);
