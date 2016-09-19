camApp.controller('moveClassController', [
    '$scope',
    'Scopes',
    '$http',
    '$q',
    'ngDialog',
    '$timeout',
    function ($scope, Scopes, $http, $q, $ngDialog, $timeout) {
        $scope.isNewClassNameReadonly = true;
        $scope.isParentNameReadonly = false;
        $scope.closeCreateClassPanel = function () {

            $ngDialog.close();
        };
        $scope.newClass = {
            name: $scope.className,
            parentName: ""
        }


        $scope.select = {
            value: null,
            options: null
        };

        $scope.saveNewClass = function () {
            $http.put(BACK_END_URL_CONST + '/classes/' + $scope.newClass.name, $scope.newClass)
                .success(function (data, status) {
                    $ngDialog.close();
                    $route.reload();
                    $timeout(function () {
                        Scopes.get('homeController').expandAncestors($scope.newClass.parentName);
                    }, 1000);
                }).error(function (err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
        }
    }]);
