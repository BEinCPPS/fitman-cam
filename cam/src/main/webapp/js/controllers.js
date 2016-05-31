// CONTROLLERS
camApp.controller('homeController', [
		'$scope',
		'$http',
        '$q',
		function ($scope, $http,$q) {

        $scope.columnDefs = [{
            "mDataProp": "asset",
            "aTargets": [0]
			}, {
            "mDataProp": "class",
            "aTargets": [1]
			}, {
            "mDataProp": "model",
            "aTargets": [2]
			}, {
            "mDataProp": "owner",
            "aTargets": [3]
			}, {
            "mDataProp": "created",
            "aTargets": [4]
			}, {
            "mDataProp": "action",
            "aTargets": [5]
			}];

        $scope.overrideOptions = {
            "bStateSave": true,
            "iCookieDuration": 2419200,
            /* 1 month */
            "bJQueryUI": true,
            "bPaginate": true,
            "bLengthChange": false,
            "bFilter": true,
            "bInfo": true,
            "bDestroy": true
        };
            
        // $scope.BACK_END_URL = 'http://161.27.159.61:8080/CAMService'; //TODO Address config.JSON
        //$scope.BACK_END_URL = 'http://192.168.62.211:8080/CAMService';
        $scope.BACK_END_URL = 'http://localhost:8080/CAMService';
        entityManager.init($scope, $http, $q);
        $scope.assetList = [];
        entityManager.getClasses();

        //funzioni di utilità
        $scope.loadChildren = function () {
            entityManager.getChildrenForClass($scope.currentNode.className);
        }

        $scope.loadAsset = function () {
            //				alert($scope.currentNode); //per recuperare il nodo da passare in input a servizio rest
            if ($scope.currentNode.className) {
                entityManager.getAssets($scope.currentNode.className);
            } else {
                $scope.assetList = []
            }
        }

		}]);

camApp.controller('detailController', [ '$scope', '$http', '$routeParams', '$location', '$q',
        function($scope, $http, $routeParams, $location,$q) {
        if(isEmpty($routeParams.selectedAssetName)){
            $location.path('/');
        }   
            $scope.selectedAssetName = $routeParams.selectedAssetName;
            // $scope.selectedAsset =
            // $scope.retrieveSelectedAsset();
       // $scope.BACK_END_URL = 'http://161.27.159.61:8080/CAMService'; //TODO Address config.JSON
            $scope.BACK_END_URL = 'http://localhost:8080/CAMService';
        entityManager.init($scope, $http, $q);
            
             entityManager.getAssetDetail($routeParams.selectedAssetName);
            //$scope.assetDetailList = 
            /*$http.get('resources/asset.json').then(function(response) {
                $scope.assetList = response.data;
                for (var i = 0; i < $scope.assetList.length; i++) {
                    if ($scope.assetList[i].asset == $scope.selectedAssetName) {
                        $scope.selectedAsset = $scope.assetList[i];
                    }
                }
            });*/

            $scope.retrieveSelectedAsset = function() {
                for (var i = 0; i < $scope.assetList.length; i++) {
                    if ($scope.assetList[i].asset == $scope.selectedAssetName) {
                        alert();
                    }
                }
            }

            $scope.assetDetailColumnDefs = [ {
                "mDataProp" : "type",
                "aTargets" : [ 0 ]
            },{
                "mDataProp" : "name",
                "aTargets" : [ 1 ]
            }, {
                "mDataProp" : "value",
                "aTargets" : [ 2 ]
            }, {
                "mDataProp" : "action",
                "aTargets" : [ 3 ]
            } ];

            $scope.assetDetailOverrideOptions = {
                "bStateSave" : true,
                "iCookieDuration" : 2419200, /* 1 month */
                "bJQueryUI" : true,
                "bPaginate" : true,
                "bLengthChange" : false,
                "bFilter" : true,
                "bInfo" : true,
                "bDestroy" : true
            };

            // $scope.assetDetailList = loadAssetDetailTable($http, $scope); TODO qua

            // funzioni di utilità
            
            $scope.formatAssetDetailListTable = function(data) {
	           if (!data)
		          return [];
                for (var i = 0; i < data.length; i++) {
                    data[i].action = '<div><i data-toggle="tooltip" title="Delete property" class="fa fa-remove cam-table-button"></i> <a class="cam-icon-a" href="#/detail/'
                            + data[i].asset
                            + '"> <i data-toggle="tooltip" title="Open detail" class="fa fa-search cam-table-button"></i> </a>';
                    if(data[i].type == 'relationship')
                        data[i].type = '<i data-toggle="tooltip" title="relationship" class="fa fa-link" ><i/>'
                    else
                        data[i].type = '<i data-toggle="tooltip" title="relationship" class="fa fa-font" ><i/>'
                }
                return data;
            };

        } ]);