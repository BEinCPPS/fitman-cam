camApp.controller('newChildClassController', [
		'$scope',
        'Scopes',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, Scopes, $http, $q, $ngDialog) {
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
            $http.post(BACK_END_URL_CONST + '/classes', $scope.newClass).success(function (data, status) {
                $ngDialog.close();
                //window.location.reload();
                Scopes.get('homeController').expandAncestors($scope.className);

            }).error(function (err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
        }
        }]);
