camApp.directive('input', [function () {
    return {
        restrict: 'E',
        require: '?ngModel',
        link: function (scope, element, attrs, ngModel) {
            if (
                'undefined' !== typeof attrs.type && 'number' === attrs.type && ngModel
            ) {
                ngModel.$formatters.push(function (modelValue) {
                    return Number(modelValue);
                });

                ngModel.$parsers.push(function (viewValue) {
                    return Number(viewValue);
                });
            }
        }
    }
}]);
