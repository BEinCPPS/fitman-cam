"use strict";
var EntityManager = (function () {
    var $http;
    var $scope;
    var $q;

    var getAssets = function (name) {
        $http.get($scope.BACK_END_URL + '/classes/' + name)
            .success(function (data) {
               $scope.assetList = formatAssetListTable(createAssets(data));
            })
            .error(function (error) {
                console.log("Error encountered :-(");
            });
    }

    var createAssets = function (data) {
        var assets = [];
        for (var i in data) {
            /*var asset = {
                asset: data[i].normalizedName,
                class: data[i].className,
                model: data[i].individualName,
                owner: '',
                created: '2016-06-01',
                isModel: true,
                action: 'x'
            }
      
            assets.push(asset);*/
        if(!isEmpty(data[i].normalizedName) && !isEmpty(data[i].className)){
         
            var promise = getAssetDetailForTable( data[i].normalizedName,  data[i].className);
            promise.then(function(asset){
                assets.push(asset);
                console.log(asset);
            });
        }
           
        }
        
      
        return assets;
    }

    
     var getAssetDetailForTable = function(name, clazz){
         var deferred = $q.defer();
         
          $http.get($scope.BACK_END_URL + '/assets/' + name)
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
              deferred.resolve(asset);
            })
            .error(function (error) {
                console.log("Error encountered :-(");
                deferred.reject(error);
            });
           return deferred.promise;
    }
    

    var formatAssetListTable = function (data) {
        if (!data)
            return [];
        for (var i = 0; i < data.length; i++) {
            data[i].action = '<div><i data-toggle="tooltip" title="Delete asset model" class="fa fa-remove cam-table-button"></i> <a class="cam-icon-a" href="#/detail/'
				+ data[i].asset
				+ '"> <i data-toggle="tooltip" title="Open detail" class="fa fa-search cam-table-button"></i> </a>';
            if (data[i].isModel == 'true')
                data[i].action += '<i data-toggle="tooltip" title="Create new asset from this model" class="fa fa-plus cam-table-button"></i></div>';
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
                console.log("Error encountered :-(");
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
          $http.get($scope.BACK_END_URL + '/assets/' + name)
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
                $scope.selectedAsset = {
                    name: name,
                    created : created,
                    model: model,
                    owner : owned
                };
            })
            .error(function (error) {
                console.log("Error encountered :-(");
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
                console.log("Error encountered :-(");
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
