camApp.controller('newClassController', [
    '$scope',
    '$q',
    'ngDialogManager',
    'entityManager',
    'ngNotifier',
    '$route',
    function ($scope, $q, ngDialogManager, entityManager, ngNotifier, $route) {
        $scope.isNewClassReadonly = false;
        $scope.isParentNameReadonly = false;
        $scope.isNewRootClass = true;
        $scope.closeCreateClassPanel = function () {

            ngDialogManager.close();
        };
        $scope.newClass = {
            name: "",
            parentName: "Thing"
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
                .success(function (data, status) {
                    ngDialogManager.close();
                    ngNotifier.success();
                    entityManager.getClasses().then(function () {
                        $route.reload();
                    }, function (error) {
                        ngNotifier.error(error)
                    })
                }).error(function (err) {
                ngDialogManager.close();
                ngNotifier.error(err);
            });
        }

    }]);
