camApp.controller('moveClassController', [
		'$scope',
        'Scopes',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, Scopes, $http, $q, $ngDialog) {
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
                    Scopes.get('homeController').backToHomeWithAncestors($scope.newClass.parentName);
                }).error(function (err) {
                    $ngDialog.close();
                    $scope.openErrorPanel(err);
                });
        }
        }]);
