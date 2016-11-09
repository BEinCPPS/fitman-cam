camApp.controller('detailController',
    ['$scope', '$routeParams', '$location', '$q', 'ngDialog', 'Scopes', 'ngNotifier', 'entityManager',
    function ($scope,  $routeParams, $location, $q, $ngDialog, Scopes, ngNotifier, entityManager) {
        Scopes.store('detailController', $scope);
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

        $scope.formatAssetDetailTableRow = function (data) {
            var attribute = {};
            attribute.name = data.normalizedName;
            attribute.value = data.propertyValue;
            var elementType = 'attribute';
            var individualName = data.propertyTarget;

            var btnDetailActionFunction = 'openAttributeDetailPanel';
            if (data.type == 'relationship')
                elementType = 'relationship';

            attribute.action = '<div class="inline-flex-item"><button class="cam-table-button" ng-click="openRemovePropertyPanel(\'' + attribute.name + '\', \'' + elementType + '\', \'' + individualName + '\')' + '"> <i data-toggle="tooltip" title="Delete ' + elementType + '" class="fa fa-trash cam-table-button"></i> </button>' + '<button class="cam-table-button" ng-click="openAttributeDetailPanel(\'' + data.normalizedName + '\', \'' + elementType + '\')' + '"> <i data-toggle="tooltip" title="Open detail" class="fa fa-pencil cam-table-button"></i> </button>';

            if (data.type == 'relationship')
                attribute.type = '<i data-toggle="tooltip" title="relationship" class="fa fa-link" ><i/>';
            else
                attribute.type = '<i data-toggle="tooltip" title="relationship" class="fa fa-font" ><i/>';

            return attribute;
        }

        $scope.getAssetDetail = function (name, type) {
            entityManager.getAssetDetail(name, type)
                .success(function (data) {
                    var owned;
                    var model;
                    var created;
                    var attrs = [];
                    var originalAttrs = data;
                    entityManager.getAssetDetail(name, RELATIONSHIPS)
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
                                domain: owned,
                                attributes: attrs,
                                isModel: isEmpty(model)
                            };
                        })
                })
                .error(function (error) {
                    ngNotifier.error(error);
                    return null;
                });
        }


        $scope.getAssetDetail($routeParams.selectedAssetName, ATTRIBUTES);

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
            "aTargets": [3],
            "bSortable": false
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
            "bDestroy": true,
            "oLanguage": {
                "sSearch": "Filter by "
            }

        };

        $scope.getAttributes = function () {
            entityManager.getAttributes().then(function (response) {
                $scope.attributes = response.data;
            }, function (error) {
                $scope.attributes = [];
               ngNotifier.error(error);
            });
        }
        $scope.getAttributes();

        // funzioni di utilità


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

        };

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
        };

    }]);
