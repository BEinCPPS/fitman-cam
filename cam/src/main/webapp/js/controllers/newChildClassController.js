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
            entityManager.createClasses($scope.newClass)
                .then(function (response) {
                    $ngDialog.close();
                    ngNotifier.success()
                    $route.reload();
                    // $timeout(function () {
                    //     Scopes.get('homeController').expandAncestors($scope.className);
                    // }, 1000);

                }, function (error) {
                    $ngDialog.close();
                    $scope.openErrorPanel(error);
                }).then(function (response) {
                Scopes.get('homeController').expandAncestors($scope.className);
            });
        }
    }]);
