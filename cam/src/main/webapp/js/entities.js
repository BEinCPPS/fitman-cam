"use strict";
var EntityManager = (function () {
    var $http;
    var $scope;
    var $q;

    var getAssets = function (name) {
        $http.get(BACK_END_URL_CONST + '/assets?className=' + name)
            .success(function (data) {
                $http.get(BACK_END_URL_CONST + '/models?className=' + name)
                    .success(function (modelData) {
                        data = data.concat(modelData);

                        fetchAssetList(data, function (res) {
                            $scope.assetList = formatAssetListTable(res, name);
                        });
                    }).error(function (error) {
                        $scope.openErrorPanel(error);
                    });
                //var a = createAssets(data);
                //$scope.assetList = formatAssetListTable(a);
            }).error(function (error) {
                $scope.openErrorPanel(error);
            });
    }


    function fetchAssetList(assetList, completeCallback) {
        var result = [];

        function fetchData() {
            if (assetList.length == 0) {
                completeCallback(result);
            } else {
                var cur = assetList.shift();
                $http.get(BACK_END_URL_CONST + '/assets/' + cur.individualName + '/attributes')
                    .success(function (data) {
                        var owned;
                        var model;
                        var created;
                        var originalDate;
                        var isModel = true;
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].normalizedName.indexOf('ownedBy') > 0)
                                owned = data[i].propertyValue.substring(data[i].propertyValue.lastIndexOf('#') + 1);
                            if (data[i].normalizedName.indexOf('instanceOf') > 0) {
                                model = data[i].propertyValue;
                                isModel = false;
                            }
                            if (data[i].normalizedName.indexOf('createdOn') > 0) {
                                var myDate = new Date(data[i].propertyValue);
                                var month = (myDate.getMonth() + 1).toString();
                                var day = new String(myDate.getDate());
                                while (month.length < 2)
                                    month = '0' + month;
                                while (day.length < 2)
                                    day = '0' + day;
                                created = day + "/" + month + "/" + myDate.getFullYear();
                                originalDate = myDate;


                            }
                        }
                        var asset = {
                            asset: cur.individualName,
                            created: created,
                            originalDate: myDate,
                            model: model || "",
                            owner: owned,
                            class: cur.className,
                            isModel: isModel
                        };
                        result.push(asset);
                    })
                    .error(function (error) {
                        $scope.openErrorPanel(error);

                    }).finally(function () {
                        fetchData();
                    });
            }
        }
        fetchData();
    }

    var formatAssetListTable = function (data, clazzName) {
        if (!data)
            return [];
        for (var i = 0; i < data.length; i++) {
            var elementType = 'asset';
            if (data[i].isModel == true) {
                elementType = 'model';
            }
            data[i].action = '<div class="inline-flex-item"> <button class="cam-table-button" ng-click="openRemoveAssetPanel(\'' + data[i].asset + '\', \'' + elementType + '\')' + '"> <i data-toggle="tooltip" title="Delete asset model" class="fa fa-remove cam-table-button"></i> </button>'

            + '<a class="cam-icon-a" href="#/detail/' + data[i].asset + '/' + clazzName + '"> <i data-toggle="tooltip" title="Open detail" class="fa fa-search cam-table-button"></i> </a>';
            if (data[i].isModel == true) {
                data[i].action += '<button class="cam-table-button" ng-click="openNewAssetPanel(\'' + data[i].asset + '\')' + '"> <i data-toggle="tooltip" title="Create new asset from this model" class="fa fa-plus cam-table-button"></i></div> </button>';

            }
        }

        data.sort(function (a, b) {
            return new Date(b.originalDate) - new Date(a.originalDate);
        });

        return data;
    }


    var getClasses = function () {
        $http.get(BACK_END_URL_CONST + '/classes') //http://localhost:8080/CAMService/assets
            //TODO Address
            .success(function (data) {
                $scope.classList = createClasses(data);
            })
            .error(function (error) {
                $scope.openErrorPanel(error);
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

    var getAssetDetail = function (name) {
        $http.get(BACK_END_URL_CONST + '/assets/' + name + '/attributes')
            .success(function (data) {
                var owned;
                var model;
                var created;
                var attrs = [];
                var originalAttrs = data;
                $http.get(BACK_END_URL_CONST + '/assets/' + name + '/relationships')
                    .success(function (data) {
                        for (var i = 0; i < data.length; i++) {
                            data[i].type = 'relationship';
                        }
                        data = data.concat(originalAttrs);
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].normalizedName.indexOf('ownedBy') > 0)
                                owned = data[i].propertyValue.substring(data[i].propertyValue.lastIndexOf('#') + 1);
                            else if (data[i].normalizedName.indexOf('instanceOf') > 0)
                                model = data[i].propertyValue;
                            else if (data[i].normalizedName.indexOf('createdOn') > 0) {
                                var myDate = new Date(data[i].propertyValue);
                                var month = (myDate.getMonth() + 1).toString();
                                var day = new String(myDate.getDate());
                                while (month.length < 2)
                                    month = '0' + month;
                                while (day.length < 2)
                                    day = '0' + day;
                                created = day + "/" + month + "/" + myDate.getFullYear();
                            } else
                                attrs.push($scope.formatAssetDetailTableRow(data[i]));
                        }
                        $scope.selectedAsset = {
                            name: name,
                            created: created,
                            model: model,
                            owner: owned,
                            attributes: attrs,
                            isModel: isEmpty(model)
                        };
                    })
            })
            .error(function (error) {
                $scope.openErrorPanel(error);
                return null;
            });
    }

    var getChildrenForClass = function (className) {
        $http.get(BACK_END_URL_CONST + '/classes/' + className)
            .success(function (data) {
                var dataNotMySelf = removeClassMySelf(data, className);
                if (!isEmpty(dataNotMySelf)) {
                    var classes = createClasses(dataNotMySelf);
                    $scope.currentNode.children = classes;

                }
                //else {
                //alert("Assets for: " + className);
                $scope.loadAsset();
                //}

            })
            .error(function (error) {
                $scope.openErrorPanel(error);
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

    var getOwnersList = function () {
        $http.get(BACK_END_URL_CONST + '/owners')
            .success(function (data) {
                $scope.ownersList = [];
                for (var i = 0; i < data.length; i++) {
                    $scope.ownersList.push(data[i].name);
                }
            })
            .error(function (error) {
                $scope.ownersList = [];
                $scope.openErrorPanel(error);
            });
    }

    var getAncestorsList = function (className) {
        if (!className) return;
        $http.get(BACK_END_URL_CONST + '/classes/ancestors/' + className)
            .success(function (data) {
                $scope.ancestorsList = data;
               

            })
            .error(function (error) {
                $scope.ancestorsList = [];
                $scope.openErrorPanel(error);
               
            });
        
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
        getAssetDetail: getAssetDetail,
        getOwnersList: getOwnersList,
        getAncestorsList: getAncestorsList
    }
    return EntityManager;
})();

var entityManager = new EntityManager();
