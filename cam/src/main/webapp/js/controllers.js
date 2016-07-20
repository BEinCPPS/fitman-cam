// CONTROLLERS
camApp.controller('homeController', [
		'$scope',
		'$http',
        '$q',
        'ngDialog',
         function ($scope, $http,$q, $ngDialog) {
             
             
        $scope.regexPattern = REGEX_PATTERN;
        $scope.invalidNameMsg = INVALID_NAME_MSG;
        $scope.nameIsMandatory = NAME_IS_MANDATORY_MSG;
        
        $scope.columnDefs = [{
            "mDataProp": "asset",
            "aTargets": [0]
			},
           /* {
            "mDataProp": "class",
            "aTargets": [1]
			}, */
            {
            "mDataProp": "model",
            "aTargets": [1]
			}, {
            "mDataProp": "owner",
            "aTargets": [2]
			}, {
            "mDataProp": "created",
            "aTargets": [3]
			}, {
            "mDataProp": "action",
            "aTargets": [4]
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
            
        entityManager.init($scope, $http, $q);
        $scope.assetList = [];
        entityManager.getClasses();
        $scope.newAssetVisible = false;

        //funzioni di utilità
        $scope.loadChildren = function () {
            entityManager.getChildrenForClass($scope.currentNode.className);
        }
        
        $scope.loadAsset = function () {
            //				alert($scope.currentNode); //per recuperare il nodo da passare in input a servizio rest
            if ($scope.currentNode.className) {
                entityManager.getAssets($scope.currentNode.className);
                $scope.newAssetVisible = true;
            } else {
                $scope.assetList = []
                $scope.newAssetVisible = false;
            }
        }
        
        $scope.openNewAssetModelPanel = function () {
             $http.get(BACK_END_URL_CONST + '/owners')
                 .success(function (data) {
                     $scope.ownersList = [];
                        for(var i =0; i<data.length; i++ ){
                            $scope.ownersList.push(data[i].name);
                        }
                          $ngDialog.open({
                                template: 'pages/newAssetModel.htm',
                                controller: 'newAssetModelController',
                                scope: $scope
                            });
                     })
                .error(function (error) {
                   $scope.ownersList= [];
                  openErrorPanel(error);
                });
        }
                
        $scope.openNewAssetPanel = function (selectedModel) {
             $scope.selectedModel = selectedModel;
            
            $http.get(BACK_END_URL_CONST + '/owners')
                 .success(function (data) {
                     $scope.ownersList = [];
                        for(var i =0; i<data.length; i++ ){
                            $scope.ownersList.push(data[i].name);
                        }
                       	$ngDialog.open({
						  template: 'pages/newAsset.htm',
                          controller: 'newAssetController',
                          scope: $scope
					   });
                })
                .error(function (error) {
                   $scope.ownersList= [];
                  openErrorPanel(error);
                });
            
		
            }
        
        $scope.changeBackground= function(ev){
            $('.ownselector').each(
                function(){
                    $(this).removeClass('selected');
                    $(this).removeClass('ownselector');
                });
            ev.target.className += ' selected ownselector';
        }
        
        $scope.openRemoveAssetPanel=function(elementToDelete, typeToDelete){
            $scope.elementToDelete = elementToDelete;
            $scope.typeToDelete = typeToDelete;
            $ngDialog.open({
						template: 'pages/confirmDelete.htm',
						controller: 'confirmDeleteController',
                        scope: $scope
					});
        }
        $scope.openConfirmDeleteClass = function(node){
            $scope.elementToDelete = node.className;
            $scope.typeToDelete = 'class';
            $ngDialog.open({
						template: 'pages/confirmDelete.htm',
						controller: 'confirmDeleteController',
                        scope: $scope
					});
        }
        
         $scope.openAddChildPanel = function(node){
            $scope.className = node.className;
            $scope.title = 'Add child class';
            $ngDialog.open({
						template: 'pages/newClass.htm',
						controller: 'newChildClassController',
                        scope: $scope
					});
        }
         
          $scope.openMoveClassPanel = function(node){
            $scope.className = node.className;
            $scope.title = 'Move class';
            $ngDialog.open({
						template: 'pages/newClass.htm',
						controller: 'moveClassController',
                        scope: $scope
					});
        }
        
           $scope.openNewClassPanel = function(){
            $scope.title = 'Create class';
            $ngDialog.open({
						template: 'pages/newClass.htm',
						controller: 'newClassController',
                        scope: $scope
					});
        }
        
        $scope.openErrorPanel=function(err){
            $scope.errorMsg = err;
            $ngDialog.open({
						template: 'pages/error.htm',
						controller: 'openErrorController',
                        scope: $scope
					});
        }
                
}]);


camApp.controller('detailController', [ '$scope', '$http', '$routeParams', '$location', '$q','ngDialog',
        function($scope, $http, $routeParams, $location,$q, $ngDialog) {
            if(isEmpty($routeParams.selectedAssetName)){
                $location.path('/');
            }   
            $scope.selectedAssetName = $routeParams.selectedAssetName;
            $scope.regexPattern = REGEX_PATTERN;
            $scope.invalidNameMsg = INVALID_NAME_MSG;
            $scope.nameIsMandatory = NAME_IS_MANDATORY_MSG;
        
           
            entityManager.init($scope, $http, $q);
            
            entityManager.getAssetDetail($routeParams.selectedAssetName);
            
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

             // funzioni di utilità
            
            $scope.formatAssetDetailTableRow = function(data) {
                var attribute = {};
                attribute.name = data.normalizedName;
                attribute.value = data.propertyValue;
                var elementType = 'attribute';
                var individualName = data.propertyTarget;
                
                var btnDetailActionFunction = 'openAttributeDetailPanel';
                
                
                 if(data.type == 'relationship')
                     elementType='relationship';
                     
	           attribute.action = '<div class="inline-flex-item"><button class="cam-table-button" ng-click="openRemovePropertyPanel(\''
                            + attribute.name+'\', \''+elementType+'\', \''+individualName+'\')'
                            + '"> <i data-toggle="tooltip" title="Delete '+elementType+'" class="fa fa-remove cam-table-button"></i> </button>'
                            +'<button class="cam-table-button" ng-click="openAttributeDetailPanel(\''
                            + data.normalizedName+'\', \''+elementType+'\')'
                            + '"> <i data-toggle="tooltip" title="Open detail" class="fa fa-pencil cam-table-button"></i> </button>';
                                
                    if(data.type == 'relationship')
                        attribute.type = '<i data-toggle="tooltip" title="relationship" class="fa fa-link" ><i/>';
                    else
                        attribute.type = '<i data-toggle="tooltip" title="relationship" class="fa fa-font" ><i/>';
                
                return attribute;
            };
            
              $scope.openNewAttributePanel = function () {
					$ngDialog.open({
						template: 'pages/newAttribute.htm',
						controller: 'newAttributeController',
                        scope: $scope
					});
				};
            
             $scope.openAttributeDetailPanel = function (attributeName, elementType) {
                 $scope.attributeName = attributeName;
                 if('relationship'==elementType){
                      $ngDialog.open({
						  template: 'pages/newRelationship.htm',
						  controller: 'newRelationshipController',
                         scope: $scope
					});
                 }else{
					$ngDialog.open({
						template: 'pages/newAttribute.htm',
						controller: 'attributeDetailController',
                        scope: $scope
					});
                 }
				};
            
           
             $scope.openNewRelationshipPanel = function () {
                 $scope.attributeName =null;
                      $ngDialog.open({
						  template: 'pages/newRelationship.htm',
						  controller: 'newRelationshipController',
                         scope: $scope
					});
                 
				}
        
		  $scope.openRemovePropertyPanel=function(elementToDelete, typeToDelete, individualName){
            $scope.elementToDelete = elementToDelete;
            $scope.typeToDelete = typeToDelete;
            $scope.individualName = individualName;
            $scope.detail = true;
            $scope.entityManager = entityManager;
            $ngDialog.open({
						template: 'pages/confirmDelete.htm',
						controller: 'confirmDeleteController',
                        scope: $scope
					});
        }
          
           $scope.openErrorPanel=function(err){
             $scope.errorMsg = err;
            $ngDialog.open({
						template: 'pages/error.htm',
						controller: 'openErrorController',
                        scope: $scope
					});
            
        }

        } ]);

camApp.controller('newAssetModelController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http,$q, $ngDialog) {
            $scope.invalidName = false;
                $scope.newAssetModel = {
                   name: "",
                   className: $scope.currentNode.className,
                   ownerName : ""
                };
            
            $scope.closeNewAssetModelPanel = function () {  
                $ngDialog.close();
            }
            
            $scope.$watch('newAssetModel.name', function(){
                if(!isEmpty($scope.newAssetModel.name)){
                     $scope.invalidName = false;
                }
            });
           
            $scope.saveNewAssetModel = function () { 
                if(isEmpty($scope.newAssetModel.name)){
                    $scope.invalidName = true;
                    return;
                }
                  $http.post(BACK_END_URL_CONST+'/models', $scope.newAssetModel).success(function(data, status) {
                      $scope.loadChildren();
                      $ngDialog.close();
                  }).error(function(err) {
                      $ngDialog.close();
                   $scope.openErrorPanel(err);
            });
            }
        } ]);

camApp.controller('newAttributeController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http,$q, $ngDialog) {
            $scope.attrPanelTitle="Add Attribute";
            $scope.invalidName = false;
              $scope.newAttribute = {
                   name: "",
                   value: "",
                   type : ""
                };
            
            $scope.closeNewAttributePanel = function () {  
                $ngDialog.close();
            }
            var urlFragment = '/assets/';
            
            if(isEmpty($scope.selectedAsset.model)){
              $scope.isModel = true;
            }else{
              $scope.isModel = false;
            }

            if($scope.isModel)
                 urlFragment = '/models/';
            
            $scope.$watch('newAttribute.name', function(){
                if(!isEmpty($scope.newAttribute.name)){
                     $scope.invalidName = false;
                }
            });
            
            $scope.saveNewAttribute = function () {  
                if(isEmpty($scope.newAttribute.name)){
                    $scope.invalidName = true;
                    return;
                }
                  $http.post(BACK_END_URL_CONST+urlFragment+$scope.selectedAssetName+'/attributes', $scope.newAttribute).success(function(data, status) {
                      entityManager.getAssetDetail($scope.selectedAssetName);
                     $ngDialog.close();
                  }).error(function(err) {
                    $ngDialog.close();
                   $scope.openErrorPanel(err);
                });
            }
        } ]);

camApp.controller('attributeDetailController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
       	function ($scope, $http,$q, $ngDialog) {
            $scope.attrPanelTitle="Edit Attribute";
           $scope.invalidName = false;
            if(isEmpty($scope.selectedAsset.model)){
              $scope.isModel = true;
            }else{
              $scope.isModel = false;
            }

           var urlFragment = '/assets/';
            if($scope.isModel)
                 urlFragment = '/models/';
              $http.get(BACK_END_URL_CONST+urlFragment+$scope.selectedAssetName+'/attributes/'+$scope.attributeName)
                 .success(function (data) {
                $scope.newAttribute={
                    name: data.normalizedName,
                    value: data.propertyValue,
                    type: data.propertyType
                }
               
                });
                      
             
            $scope.closeNewAttributePanel = function () {  
                $ngDialog.close();
            }
                
             $scope.$watch('newAttribute.name', function(){
                if(!isEmpty($scope.newAttribute.name)){
                     $scope.invalidName = false;
                }
            });
            
            $scope.saveNewAttribute = function () {  
                if(isEmpty($scope.newAttribute.name)){
                    $scope.invalidName = true;
                    return;
                }
                  $http.put(BACK_END_URL_CONST+urlFragment+$scope.selectedAssetName+'/attributes/'+$scope.newAttribute.name, $scope.newAttribute).success(function(data, status) {
                      entityManager.getAssetDetail($scope.selectedAssetName);
                     $ngDialog.close();
                  }).error(function(err) {
                      $ngDialog.close();
                   $scope.openErrorPanel(err);
                });
            }
        } ]);

camApp.controller('newRelationshipController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http,$q, $ngDialog) {
             $scope.relPanelTitle = "Add Relationship";
             $scope.invalidName =false;
            if(isEmpty($scope.selectedAsset.model)){
              $scope.isModel = true;
            }else{
              $scope.isModel = false;
            }

           var urlFragment = '/assets/';
            if($scope.isModel)
                 urlFragment = '/models/';
            if($scope.attributeName){
             $scope.relPanelTitle = "Edit Relationship"; $http.get(BACK_END_URL_CONST+urlFragment+$scope.selectedAssetName+'/relationships/'+$scope.attributeName).success(function (data) {
                                    $scope.newRelationship = {
                                    name: data.normalizedName,
                                    referredName: data.propertyValue
                                };
              });
            }else{
                  $scope.newRelationship = {
                   name: "",
                   referredName: ""
            };
            }
          
             $scope.$watch('newRelationship.name', function(){
                if(!isEmpty($scope.newRelationship.name)){
                     $scope.invalidName = false;
                }
            });
            
            $scope.closeNewRelationshipPanel = function () { 
                $scope.attributeName =null;
                $ngDialog.close();
            };
            
             $scope.select = {
                 value: null,
                 options: null
             };
            
            /*$scope.loadReferredAssets = function(){
                 $http.get(BACK_END_URL_CONST + '/assets')
                 .success(function (data) {
                    return data;
                     })
                    .error(function (error) {
                        console.log("Error encountered :-( " + error);
                        return [];
                    });
                 	
            };*/
            var urlFragment = '/assets/';
            
            if(isEmpty($scope.selectedAsset.model)){
              $scope.isModel = true;
            }else{
              $scope.isModel = false;
            }

            if($scope.isModel)
                 urlFragment = '/models/';
            $scope.saveNewRelationship = function () {  
                if(isEmpty($scope.newRelationship.name)){
                    $scope.invalidName = true;
                    return;
                    }
                if($scope.attributeName){
                    $http.put(BACK_END_URL_CONST+urlFragment+$scope.selectedAssetName+'/relationships/'
                      +$scope.attributeName, $scope.newRelationship).success(function(data, status) {
                      entityManager.getAssetDetail($scope.selectedAssetName);
                      $ngDialog.close();

                     }).error(function(err) {
                      $ngDialog.close();
                       $scope.openErrorPanel(err);
                    });
                }else{
                    $http.post(BACK_END_URL_CONST+urlFragment+$scope.selectedAssetName+'/relationships', $scope.newRelationship).success(function(data, status) {
                    entityManager.getAssetDetail($scope.selectedAssetName);
                    $ngDialog.close();

                  }).error(function(err) {
                      $ngDialog.close();
                       $scope.openErrorPanel(err);
                  });
                }
        } 
        }]);

camApp.controller('confirmDeleteController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http,$q, $ngDialog) {
            //$scope.elementToDelete;
            //$scope.typetoDelete;
             $scope.closeConfirmDeletePanel = function () {  
                $ngDialog.close();
            }
            var urlFragment = '/assets/';
            if($scope.typeToDelete=='model')
                urlFragment='/models/';
            else if($scope.typeToDelete=='attribute')
                urlFragment='/assets/'+$scope.individualName+'/attributes/';
            else if($scope.typeToDelete=='relationship')
                urlFragment='/assets/'+$scope.individualName+'/relationships/';
            else if($scope.typeToDelete=='class')
                urlFragment = '/classes/';
            $scope.confirmDelete = function(){
            $http.delete(BACK_END_URL_CONST+urlFragment+$scope.elementToDelete).success(function(data, status) {
                if($scope.typeToDelete=='class')
                     window.location.reload();
                if($scope.detail)
                    $scope.entityManager.getAssetDetail($scope.individualName);
                else
                    $scope.loadChildren();
                $ngDialog.close();
            }).error(function(err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
            }
        } ]);


camApp.controller('newAssetController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http,$q, $ngDialog) {
            //$scope.elementToDelete;
            //$scope.typetoDelete;
            $scope.invalidName = false;
             $scope.closeNewAssetPanel = function () {  
                $ngDialog.close();
            }
             
              $scope.newAsset = {
                   name: "",
                   modelName: $scope.selectedModel,
                   ownerName : ""
                };
            var urlFragment = '/assets/';
            
            $scope.$watch('newAsset.name', function(){
                if(!isEmpty($scope.newAsset.name)){
                     $scope.invalidName = false;
                }
            });
           
            $scope.saveNewAsset = function(){
                 if(isEmpty($scope.newAsset.name)){
                    $scope.invalidName = true;
                    return;
                }
                $http.post(BACK_END_URL_CONST+urlFragment,$scope.newAsset).success(function(data, status) {
                $scope.loadChildren();
                $ngDialog.close();
            }).error(function(err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
            }
        } ]);




camApp.controller('newChildClassController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http,$q, $ngDialog) {
              $scope.isNewClassReadonly = false;
            $scope.isParentNameReadonly = true;
            $scope.closeCreateClassPanel = function () { 
                $scope.attributeName =null;
                $ngDialog.close();
            };
            $scope.newClass = {
                name:"",
                parentName:$scope.className
            }
                
             $scope.select = {
                 value: null,
                 options: null
             };
            $scope.invalidName =false;
            
             $scope.$watch('newClass.name', function(){
                if(!isEmpty($scope.newClass.name)){
                     $scope.invalidName = false;
                }
            });
            
            $scope.saveNewClass = function () {  
                if(isEmpty($scope.newClass.name)){
                    $scope.invalidName = true;
                    return;
                }
                $http.post(BACK_END_URL_CONST+'/classes', $scope.newClass).success(function(data, status) {
                $ngDialog.close();
                window.location.reload();
              }).error(function(err) {
                  $ngDialog.close();
                  $scope.openErrorPanel(err);
                });
            }
        } ]);

camApp.controller('moveClassController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http,$q, $ngDialog) {
            $scope.isNewClassNameReadonly = true;
             $scope.isParentNameReadonly = false;
            $scope.closeCreateClassPanel = function () { 
               
                $ngDialog.close();
            };
            $scope.newClass = {
                name:$scope.className,
                parentName:""
            }
            
                       
             $scope.select = {
                 value: null,
                 options: null
             };
                      
            $scope.saveNewClass = function () {  
              $http.put(BACK_END_URL_CONST+'/classes/'+$scope.newClass.name, $scope.newClass).success(function(data, status) {
              $ngDialog.close();
                  window.location.reload();
              }).error(function(err) {
                  $ngDialog.close();
                   $scope.openErrorPanel(err);
                });
            }
        } ]);


camApp.controller('newClassController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http,$q, $ngDialog) {
              $scope.isNewClassReadonly = false;
            $scope.isParentNameReadonly = false;
            $scope.closeCreateClassPanel = function () { 
                
                $ngDialog.close();
            };
             $scope.newClass = {
                name:"",
                parentName:""
            }
                
             $scope.select = {
                 value: null,
                 options: null
             };
             $scope.invalidName = false;
            
             $scope.$watch('newClass.name', function(){
                if(!isEmpty($scope.newClass.name)){
                     $scope.invalidName = false;
                }
            });
            
            $scope.saveNewClass = function () {  
                if(isEmpty($scope.newClass.name)){
                    $scope.invalidName = true;
                    return;
                }
                if(isEmpty($scope.newClass.parentName)){
                    $scope.newClass.parentName='Thing';
                }
                
                $http.post(BACK_END_URL_CONST+'/classes', $scope.newClass).success(function(data, status) {
                $ngDialog.close();
                window.location.reload();
              }).error(function(err) {
                   $ngDialog.close();
                   $scope.openErrorPanel(err);
                });
            }
            
        } ]);

camApp.controller('openErrorController', [
		'$scope',
		'$http',
        '$q',
	    'ngDialog',
		function ($scope, $http,$q, $ngDialog) {
              $scope.isError = true;
              $scope.closeErrorPanel = function () { 
              
                $ngDialog.close();
            };
           
        } ]);