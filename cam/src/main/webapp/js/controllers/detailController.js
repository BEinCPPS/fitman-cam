camApp.controller('detailController', ['$scope', '$http', '$routeParams', '$location', '$q', 'ngDialog',
        function ($scope, $http, $routeParams, $location, $q, $ngDialog) {
        if (isEmpty($routeParams.selectedAssetName)) {
            $location.path('/');
        }

        if (!isEmpty($routeParams.className)) {
            $scope.className = $routeParams.className;
        }
        $scope.selectedAssetName = $routeParams.selectedAssetName;
        $scope.regexPattern = REGEX_PATTERN;
        $scope.invalidNameMsg = INVALID_NAME_MSG;
        $scope.nameIsMandatory = NAME_IS_MANDATORY_MSG;


        entityManager.init($scope, $http, $q);

        entityManager.getAssetDetail($routeParams.selectedAssetName);

        $scope.retrieveSelectedAsset = function () {
            for (var i = 0; i < $scope.assetList.length; i++) {
                if ($scope.assetList[i].asset == $scope.selectedAssetName) {
                    return $scope.assetList[i];
                }
            }
        }

        $scope.assetDetailColumnDefs = [{
            "mDataProp": "type",
            "aTargets": [0]
            }, {
            "mDataProp": "name",
            "aTargets": [1]
            }, {
            "mDataProp": "value",
            "aTargets": [2]
            }, {
            "mDataProp": "action",
            "aTargets": [3]
            }];

        $scope.assetDetailOverrideOptions = {
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

        // funzioni di utilità

        $scope.formatAssetDetailTableRow = function (data) {
            var attribute = {};
            attribute.name = data.normalizedName;
            attribute.value = data.propertyValue;
            var elementType = 'attribute';
            var individualName = data.propertyTarget;

            var btnDetailActionFunction = 'openAttributeDetailPanel';


            if (data.type == 'relationship')
                elementType = 'relationship';

            attribute.action = '<div class="inline-flex-item"><button class="cam-table-button" ng-click="openRemovePropertyPanel(\'' + attribute.name + '\', \'' + elementType + '\', \'' + individualName + '\')' + '"> <i data-toggle="tooltip" title="Delete ' + elementType + '" class="fa fa-remove cam-table-button"></i> </button>' + '<button class="cam-table-button" ng-click="openAttributeDetailPanel(\'' + data.normalizedName + '\', \'' + elementType + '\')' + '"> <i data-toggle="tooltip" title="Open detail" class="fa fa-pencil cam-table-button"></i> </button>';

            if (data.type == 'relationship')
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
            if ('relationship' == elementType) {
                $ngDialog.open({
                    template: 'pages/newRelationship.htm',
                    controller: 'newRelationshipController',
                    scope: $scope
                });
            } else {
                $ngDialog.open({
                    template: 'pages/newAttribute.htm',
                    controller: 'attributeDetailController',
                    scope: $scope
                });
            }
        };


        $scope.openNewRelationshipPanel = function () {
            $scope.attributeName = null;
            $scope.assetToFilter = $scope.selectedAsset.name;
            $ngDialog.open({
                template: 'pages/newRelationship.htm',
                controller: 'newRelationshipController',
                scope: $scope
            });

        }

        $scope.openRemovePropertyPanel = function (elementToDelete, typeToDelete, individualName) {
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

        $scope.openErrorPanel = function (err) {
            $scope.errorMsg = err;
            $ngDialog.open({
                template: 'pages/error.htm',
                controller: 'openErrorController',
                scope: $scope
            });

        }

        }]);
