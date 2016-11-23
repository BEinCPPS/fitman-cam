camApp.controller('moveClassController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialogManager',
    '$timeout',
    '$route',
    'entityManager',
    'ngNotifier',
    function ($scope, Scopes, $q, ngDialogManager, $timeout, $route, entityManager, ngNotifier) {
        $scope.isNewClassNameReadonly = true;
        $scope.isParentNameReadonly = false;
        $scope.isNewRootClass = false;
        $scope.closeCreateClassPanel = function () {

            ngDialogManager.close();
        };
        $scope.newClass = {
            name: $scope.className,
            parentName: ""
        }


        $scope.select = {
            value: null,
            options: null
        };

        $scope.$watch('select.options', function () {
            if ($scope.select.options && $scope.select.options.length > 1) { //TODO
                var excludeMe = entityManager.removeClassMySelf($scope.select.options, $scope.className);
                $scope.select.options = excludeMe;
            }
        });

        $scope.saveNewClass = function () {
            //$http.put(BACK_END_URL_CONST + '/classes/' + $scope.newClass.name, $scope.newClass)
            entityManager.updateClass($scope.newClass.name, $scope.newClass)
                .then(function (data) {
                    ngDialogManager.close();
                    ngNotifier.success();
                    $route.reload();
                }, function (error) {
                    ngDialogManager.close();
                    ngNotifier.error(error);
                }).then(function (data) {
                ngDialogManager.close();
                $route.reload();
                $timeout(function () {
                    Scopes.get('homeController').expandAncestors($scope.newClass.parentName);
                }, 1000);
            })
        }
    }]);
