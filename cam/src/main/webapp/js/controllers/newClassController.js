camApp.controller('newClassController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http, $q, $ngDialog) {
        $scope.isNewClassReadonly = false;
        $scope.isParentNameReadonly = false;
        $scope.closeCreateClassPanel = function () {

            $ngDialog.close();
        };
        $scope.newClass = {
            name: "",
            parentName: ""
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
            if (isEmpty($scope.newClass.parentName)) {
                $scope.newClass.parentName = 'Thing';
            }

            $http.post(BACK_END_URL_CONST + '/classes', $scope.newClass).success(function (data, status) {
                $ngDialog.close();
                window.location.reload();
            }).error(function (err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
        }

        }]);
