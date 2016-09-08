// DIRECTIVES
camApp.directive('assetTable',  ['$compile', function($compile){
    return function(scope, element, attrs) {

        // apply DataTable options, use defaults if none specified by user
        var options = {};
        if (attrs.assetTable.length > 0) {
            options = scope.$eval(attrs.assetTable);
        } else {
            options = {
                "bStateSave": true,
                "iCookieDuration": 2419200, /* 1 month */
                "bJQueryUI": true,
                "bPaginate": false,
                "bSort": false,
                "bLengthChange": false,
                "bFilter": false,
                "bInfo": false,
                "bDestroy": true
            };
        }

        // Tell the dataTables plugin what columns to use
        // We can either derive them from the dom, or use setup from the controller           
        var explicitColumns = [];
        element.find('th').each(function(index, elem) {
            explicitColumns.push($(elem).text());
        });
        if (explicitColumns.length > 0) {
            options["aoColumns"] = explicitColumns;
        } else if (attrs.aoColumns) {
            options["aoColumns"] = scope.$eval(attrs.aoColumns);
        }

        // aoColumnDefs is dataTables way of providing fine control over column config
        if (attrs.aoColumnDefs) {
            options["aoColumnDefs"] = scope.$eval(attrs.aoColumnDefs);
        }
               
//        if (attrs.fnRowCallback) {
//            options["fnRowCallback"] = scope.$eval(attrs.fnRowCallback);
//        }

        options["fnRowCallback"] = function(nRow){
            $compile(nRow)(scope);
            return nRow;
        };
        
        // apply the plugin
        var dataTable = element.dataTable(options);

        
        
        // watch for any changes to our data, rebuild the DataTable
        scope.$watch(attrs.aaData, function(value) {
            var val = value || null;
            if (val) {
                dataTable.fnClearTable();
                dataTable.fnAddData(scope.$eval(attrs.aaData));
            }
        });
    };
}]);

camApp.directive('lazyLoadOptions', ['$http', function($http) {
    return {
        restrict: 'EA',
        require: 'ngModel',
        scope: {
            options: '='
        },
        link: function($scope, $element, $attrs, $ngModel){
            // Ajax loading notification
            $scope.options = [
                {
                    normalizedName: "Loading..."
                }
            ];
            
            // Control var to prevent infinite loop
            $scope.loaded = false;
            
            $element.bind('mousedown', function() {
                             
                    if(!$scope.loaded) {
                        $http.get(BACK_END_URL_CONST+'/assets').success(function(data){
                            if(isEmpty(data)){
                                $scope.options = data;
                                return;
                            }
                            for(var i =0; i<data.length; i++){
                                if(data[i].individualName==$scope.$parent.assetToFilter){
                                    data.splice(i,1);
                                }
                            }
                            $scope.options = data;
                        }).error(function(error){
                            alert(error);
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

camApp.directive('lazyLoadClassesOptions', ['$http', function($http) {
    return {
        restrict: 'EA',
        require: 'ngModel',
        scope: {
            options: '='
        },
        link: function($scope, $element, $attrs, $ngModel){
            // Ajax loading notification
            $scope.options = [
                {
                    className: "Loading..."
                }
            ];
            
            // Control var to prevent infinite loop
            $scope.loaded = false;
            
            $element.bind('mousedown', function() {
                             
                    if(!$scope.loaded) {
                        $http.get(BACK_END_URL_CONST+'/classes').success(function(data){
                            $scope.options = data;
                        }).error(function(error){
                            alert(error);
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

camApp.directive('ngRightClick', function($parse) {
    return function(scope, element, attrs) {
        var fn = $parse(attrs.ngRightClick);
        element.bind('contextmenu', function(event) {
            scope.$apply(function() {
                event.preventDefault();
                fn(scope, {$event:event});
            });
        });
    };
});

camApp.directive("datepicker", function() {
  return {
    restrict: "A",
    require: "ngModel",
    link: function(scope, elem, attrs, ngModelCtrl) {
      var updateModel = function(dateText) {
        scope.$apply(function() {
          ngModelCtrl.$setViewValue(dateText);
        });
      };
      var options = {
        dateFormat: "yy-mm-dd",
        onSelect: function(dateText) {
          updateModel(dateText);
        }
      };
      elem.datepicker(options);
    }
  }
});

camApp.directive('input', [function() {
    return {
        restrict: 'E',
        require: '?ngModel',
        link: function(scope, element, attrs, ngModel) {
            if (
                   'undefined' !== typeof attrs.type
                && 'number' === attrs.type
                && ngModel
            ) {
                ngModel.$formatters.push(function(modelValue) {
                    return Number(modelValue);
                });

                ngModel.$parsers.push(function(viewValue) {
                    return Number(viewValue);
                });
            }
        }
    }
}]);