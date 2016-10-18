camApp.controller('newClassController', [
    '$scope',
    '$q',
    'ngDialog',
    'entityManager',
    'ngNotifier',
    function ($scope, $q, $ngDialog, entityManager, ngNotifier) {
        $scope.isNewClassReadonly = false;
        $scope.isParentNameReadonly = false;
        $scope.isNewRootClass = true;
        $scope.closeCreateClassPanel = function () {

            $ngDialog.close();
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
                    $ngDialog.close();
                    ngNotifier.success();
                    window.location.reload();
                }).error(function (err) {
                $ngDialog.close();
                ngNotifier.error(err);
            });
        }

    }]);
