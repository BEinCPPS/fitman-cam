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
            } else {
                Scopes.get('newRelationshipController').saveNewRelationship();
            }
            $ngDialog.closeAll();
        };
    }]);
