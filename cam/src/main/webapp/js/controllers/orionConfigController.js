camApp.controller('orionConfigController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialogManager',
    'entityManager',
    'ngNotifier',
    '$route',
    '$window',
    function ($scope, Scopes, $q, ngDialogManager, entityManager, ngNotifier
        , $route, $window) {
        Scopes.store('orionConfigController', $scope);
        $scope.orionConfigsList = [];
        (function getOrionConfigs() {
            entityManager.getOrionConfigs().then(function (response) {
                $scope.orionConfigsList = response.data;
            }, function (error) {
                ngNotifier.error(error);
            });
        })();

        $scope.selectedConfig = {};
        $scope.loadChildren = function(){
            angular.forEach($scope.orionConfigsList, function (value) {
                if(value && value.id == $scope.currentNode.id){
                    $scope.selectedConfig = value;
                }
            });
        }









}]);
