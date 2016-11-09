camApp.controller('newChildClassController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialog',
    '$route',
    '$timeout',
    'entityManager',
    'ngNotifier',
    function ($scope, Scopes, $q, $ngDialog, $route, $timeout, entityManager, ngNotifier) {
        $scope.isNewClassReadonly = false;
        $scope.isParentNameReadonly = true;
        $scope.closeCreateClassPanel = function () {
            $scope.attributeName = null;
            $ngDialog.close();
        };
        $scope.newClass = {
            name: "",
            parentName: $scope.className
        }

        $scope.select = {
            value: null,
            options: null
        };
        $scope.invalidName = false;

        $scope.$watch('newClass.name', function () {
            if (!isEmpty($scope.newClass.name)) {
                $scope.invalidName = false;
            }
        });

        $scope.saveNewClass = function () {
            if (isEmpty($scope.newClass.name)) {
                $scope.invalidName = true;
                return;
            }
            entityManager.createClass($scope.newClass)
                .then(function (response) {
                    $ngDialog.close();
                    ngNotifier.success()
                    entityManager.getClasses(false).then(function () {
                        $route.reload();
                    }, function (error) {
                        ngNotifier.error(error);
                    })
                }, function (error) {
                    $ngDialog.close();
                    $scope.openErrorPanel(error);
                }).then(function (response) {
                Scopes.get('homeController').expandAncestors($scope.className);
            });
        }
    }]);
