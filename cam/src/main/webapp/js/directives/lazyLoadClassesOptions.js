camApp.directive('lazyLoadClassesOptions', ['$http', function ($http) {
    return {
        restrict: 'EA',
        require: 'ngModel',
        scope: {
            options: '='
        },
        link: function ($scope, $element, $attrs, $ngModel) {
            // Ajax loading notification
            $scope.options = [
                {
                    className: "Loading..."
                }
            ];

            // Control var to prevent infinite loop
            $scope.loaded = false;
            $element.bind('mousedown', function () {

                if (!$scope.loaded) {
                    $http.get(BACK_END_URL_CONST + '/classes?flat=true').success(function (data) {
                        $scope.options = data;
                    }).error(function (error) {
                        $scope.$parent.closeCreateClassPanel();
                        $scope.$parent.openErrorPanel(error);
                    })

                    // Prevent the load from occurring again
                    $scope.loaded = true;

                    // Blur the element to collapse it
                    $element[0].blur();

                    // Click the element to re-open it
                    var e = document.createEvent("MouseEvents");
                    e.initMouseEvent("mousedown", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                    $element[0].dispatchEvent(e);
                }

            });
        }
    }
}]);
