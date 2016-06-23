"use strict";
var EntityManager = (function () {
    var $http;
    var $scope;
    var $q;

    var getAssets = function (name) {
        $http.get($scope.BACK_END_URL + '/assets?className=' + name)
            .success(function (data) {
                fetchAssetList(data, function(res) {
                    $scope.assetList = formatAssetListTable(res);
                })
                //var a = createAssets(data);
                //$scope.assetList = formatAssetListTable(a);
            })
            .error(function (error) {
                console.log("Error encountered :-( " + error);
            });
    }

//    var createAssets = function (data) {
//       
//         var promises = [];
//
//        var assets = [];
//       /* for (var i in data) {
//            
//        if(!isEmpty(data[i].normalizedName) && !isEmpty(data[i].className)){
//         
//            var promise = getAssetDetailForTable( data[i].normalizedName,  data[i].className);
//            promise.then(function(asset){
//                assets.push(asset);
//                console.log(asset);
//            });
//        }
//           
//        }*/
//        angular.forEach( data, function(value){
//            promises.push(getAssetDetailForTable(value.normalizedName,  value.className, assets));
//        });
//
//        $q.all(promises).then(function(){
//            $scope.assetList = formatAssetListTable(assets);
//            return assets;
//        });
//        
//    }
    
    
    function fetchAssetList(assetList, completeCallback) {
        var result = [];
        function fetchData() {
            if (assetList.length == 0) {
                completeCallback(result);
            } else {
              var cur= assetList.shift();    
              $http.get($scope.BACK_END_URL + '/assets/' + cur.individualName+'/attributes')
                .success(function (data) {
                  var owned;
                  var model;
                  var created;
                  var isModel = true;
                  for (var i =0; i< data.length; i++){
                      if(data[i].normalizedName.indexOf('ownedBy')> 0)
                          owned = data[i].propertyValue;
                      if(data[i].normalizedName.indexOf('instanceOf')> 0){
                          model = data[i].propertyValue;
                          isModel = false;
                        }
                      if(data[i].normalizedName.indexOf('createdOn')> 0)
                          created = data[i].propertyValue;
                  }
                   var asset = {
                        asset: cur.individualName,
                        created : created,
                        model: model || "",
                        owner : owned,
                        class: cur.className,
                        isModel: isModel
                    };
                   result.push(asset);
                })
                .error(function (error) {
                    console.log("Error encountered :-( " + error);
                  
                }).finally(function () {
                  fetchData();
              }); 
            }
        }
        fetchData();    
    }
    
    
    
    /* var getAssetDetailForTable = function(name, clazz, assets){
         var deferred = $q.defer();
         
          $http.get($scope.BACK_END_URL + '/assets/' + name+'/attributes')
            .success(function (data) {
              var owned;
              var model;
              var created;
              for (var i =0; i< data.length; i++){
                  if(data[i].normalizedName.indexOf('ownedBy')> 0)
                      owned = data[i].propertyValue;
                  if(data[i].normalizedName.indexOf('instanceOf')> 0)
                      model = data[i].propertyValue;
                  if(data[i].normalizedName.indexOf('createdOn')> 0)
                      created = data[i].propertyValue;
              }
               var asset = {
                    asset: name,
                    created : created,
                    model: model,
                    owner : owned,
                    class: clazz
                };
               assets.push(asset);
               deferred.resolve(assets);
            
            })
            .error(function (error) {
                console.log("Error encountered :-( " + error);
                //deferred.reject(error);
              deferred.resolve(assets);
               //return deferred.promise;
            });
             return deferred.promise;
    }
    */

    var formatAssetListTable = function (data) {
        if (!data)
            return [];
        for (var i = 0; i < data.length; i++) {
            var elementType = 'asset';
            if (data[i].isModel == true){
                elementType = 'model';
            }
            data[i].action = '<div> <button class="cam-table-button" ng-click="openRemoveAssetPanel(\''
                            + data[i].asset+'\', \''+elementType+'\')'
                            + '"> <i data-toggle="tooltip" title="Delete asset model" class="fa fa-remove cam-table-button"></i> </button>'
                
                +'<a class="cam-icon-a" href="#/detail/'
				+ data[i].asset
				+ '"> <i data-toggle="tooltip" title="Open detail" class="fa fa-search cam-table-button"></i> </a>';
            if (data[i].isModel == true){
                data[i].action += '<i data-toggle="tooltip" title="Create new asset from this model" class="fa fa-plus cam-table-button"></i></div>';
            }
        }
        
               return data;
    }


    var getClasses = function () {
        $http.get($scope.BACK_END_URL + '/classes') //http://localhost:8080/CAMService/assets
            //TODO Address
            .success(function (data) {
                $scope.classList = createClasses(data);
            })
            .error(function () {
                console.log("Error encountered :-( " + error);
            });

    }

    var createClasses = function (data) {
        var classes = [];
        for (var i in data) {
            var classItem = {
                className: data[i].normalizedName,
                classId: data[i].normalizedName
            }
            classes.push(classItem);
        }
        return classes;
    }
    
    var getAssetDetail = function(name){
          $http.get($scope.BACK_END_URL + '/assets/' + name+'/attributes')
            .success(function (data) {
              var owned;
              var model;
              var created;
              var attrs = [];
              for (var i =0; i< data.length; i++){
                  if(data[i].normalizedName.indexOf('ownedBy')> 0)
                      owned = data[i].propertyValue;
                  else if(data[i].normalizedName.indexOf('instanceOf')> 0)
                      model = data[i].propertyValue;
                  else if(data[i].normalizedName.indexOf('createdOn')> 0)
                      created = data[i].propertyValue;
                  else
                     attrs.push($scope.formatAssetDetailTableRow(data[i]));
                }
                $scope.selectedAsset = {
                    name: name,
                    created : created,
                    model: model,
                    owner : owned,
                    attributes : attrs
                };
            })
            .error(function (error) {
                console.log("Error encountered :-( " +error);
                return null;
            });
    }

    var getChildrenForClass = function (className) {
        $http.get($scope.BACK_END_URL + '/classes/' + className)
            .success(function (data) {
                var dataNotMySelf = removeClassMySelf(data, className);
                if (!isEmpty(dataNotMySelf)) {
                    var classes = createClasses(dataNotMySelf);
                    $scope.currentNode.children = classes;

                } else {
                    //alert("Assets for: " + className);
                    $scope.loadAsset();
                }

            })
            .error(function (error) {
                console.log("Error encountered :-( " + error);
                return null;
            });
    }

    var removeClassMySelf = function (data, className) {
        var classes = [];
        if (!data) return classes;
        for (var i in data) {
            if (data[i].className != className)
                classes.push(data[i]);
        }
        return classes;
    }


    var reset = function () {
        $scope = null;
        $http = null;
    }

    var init = function ($scopeExt, $httpExt, $qExt) {
            $scope = $scopeExt;
            $http = $httpExt;
            $q = $qExt;
        }
        //Costructor
    var EntityManager = function () {
        reset();
    }

    EntityManager.prototype = {
        //constructor
        constructor: EntityManager,
        reset: reset,
        init: init,
        getAssets: getAssets,
        getClasses: getClasses,
        getChildrenForClass: getChildrenForClass,
        getAssetDetail: getAssetDetail
    }
    return EntityManager;
})();

var entityManager = new EntityManager();
