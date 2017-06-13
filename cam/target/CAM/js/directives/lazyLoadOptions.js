camApp.directive('lazyLoadOptions', ['$http', function ($http) {
    return {
        restrict: 'EA',
        require: 'ngModel',
        scope: {
            options: '=',
        },
        link: function ($scope, $element, $attrs, $ngModel) {
            // Ajax loading notification
            $scope.options = [
                {
                    normalizedName: "Loading..."
                }
            ];
            // Control var to prevent infinite loop
            $scope.loaded = false;

            $element.bind('mousedown', function () {

                if (!$scope.loaded) {
                    $http.get(BACK_END_URL_CONST + '/assets').success(function (data) {
                        if (isEmpty(data)) {
                            $scope.options = data;
                            return;
                        }
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].individualName == $scope.$parent.assetToFilter) {
                                data.splice(i, 1);
                            }
                        }
                        $scope.options = data;
                    }).error(function (error) {
                        $scope.$parent.closeNewRelationshipPanel();
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
