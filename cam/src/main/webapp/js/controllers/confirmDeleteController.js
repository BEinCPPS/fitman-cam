camApp.controller('confirmDeleteController', [
    '$scope',
    'Scopes',
    '$http',
    '$q',
    'ngDialog',
    '$route',
    '$timeout',
    function ($scope, Scopes, $http, $q, $ngDialog, $route, $timeout) {
        Scopes.store('confirmDeleteController', $scope);

        $scope.closeConfirmDeletePanel = function () {
            $ngDialog.close();
        }
        var urlFragment = '/assets/';
        if ($scope.typeToDelete == 'model')
            urlFragment = '/models/';
        else if ($scope.typeToDelete == 'attribute')
            urlFragment = '/assets/' + $scope.individualName + '/attributes/';
        else if ($scope.typeToDelete == 'relationship')
            urlFragment = '/assets/' + $scope.individualName + '/relationships/';
        else if ($scope.typeToDelete == 'class')
            urlFragment = '/classes/';
        else if ($scope.typeToDelete == 'domain')
            urlFragment = '/owners/';

        $scope.confirmDelete = function () {

            if ($scope.typeToDelete == 'class') {
                var deferred = $q.defer();
                entityManager.getAncestorsList($scope.elementToDelete, deferred);
                var promise = deferred.promise;
                promise.then(function (datas) {
                    var dataStr = datas + "";
                    var ancestors = dataStr.split(',');
                    $http.delete(BACK_END_URL_CONST + urlFragment + $scope.elementToDelete).success(function (data, status) {
                        $ngDialog.close();
                        $route.reload();
                        $timeout(function () {
                            Scopes.get('homeController').expandAncestors(ancestors[ancestors.length - 2]);
                        }, 1000);
                    }).error(function (err) {
                        $ngDialog.close();
                        $scope.openErrorPanel(err);
                    });

                }, function (error) {
                    console.log(error); //TODO ERROR
                });
            } else
                $http.delete(BACK_END_URL_CONST + urlFragment + $scope.elementToDelete)
                    .success(function (data, status) {
                    if ($scope.detail) {
                        $route.reload();
                        $scope.entityManager.getAssetDetail($scope.individualName);
                    } else if ($scope.typeToDelete == 'domain') {
                        entityManager.getOwnersList();
                        setTimeout(function () {
                            $route.reload();
                        },1000);
                    }
                    else
                        $scope.loadChildren();
                    $ngDialog.closeAll();
                }).error(function (err) {
                    $ngDialog.close();
                    Scopes.get('homeController').openErrorPanel(err);
                });

        }
    }]);
