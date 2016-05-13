// CONTROLLERS
camApp.controller('homeController', [
		'$scope',
		'$http',
		function ($scope, $http) {

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
            
        $scope.BACK_END_URL = 'http://localhost:8080/CAMService'; //TODO Address config.JSON
        entityManager.init($scope, $http);
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
