//TODO
camApp.controller('domainController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialog',
    'NgTableParams',
    'entityManager',
    'ngNotifier',
    function ($scope, Scopes, $q, $ngDialog, NgTableParams, entityManager, ngNotifier) {
        Scopes.store('domainController', $scope);

        (function getOwners() {
            entityManager.getOwners().then(function (response) {
                $scope.ownersList = [];
                var ownList = [];
                angular.copy(response.data, ownList);
                ownList.forEach(function (value) {
                    var domain = {
                        name: value.name,
                        //TODO
                        action: '<div class="inline-flex-item"><button class="cam-table-button" ng-click="openConfirmDeleteDomain(\'' + value.name + '\')"> <i data-toggle="tooltip" title="Delete ' + value.name + '" class="fa fa-trash cam-table-button"></i> </button>'
                    };
                    $scope.ownersList.push(domain);
                })
            }, function (error) {
                ngNotifier.error(error);
            });
        })();

        $scope.ownerColumnDefs = [{
            "mDataProp": "name",
            "aTargets": [0]
        }, {
            "mDataProp": "action",
            "aTargets": [1],
            "bSortable": false
        }];

        $scope.ownerOverrideOptions = {
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

        // $scope.save = function (row, rowForm) {
        //     if (isEmpty(row.name)) return;
        //     //TODO REGEXP
        //     var originalName = '';
        //     for (var i in originalData) {
        //         if (originalData[i].id === row.id) {
        //             originalName = originalData[i].name;
        //         }
        //     }
        //     var domain = {
        //         name: row.name
        //     };
        //     var promise = entityManager.updateOwner(originalName, domain);
        //     promise.success(function (data) {
        //         var originalRow = $scope.resetRow(row, rowForm);
        //         angular.extend(originalRow, row);
        //     });
        //     promise.error(function (err) {
        //         Scopes.get('homeController').openErrorPanel(err);
        //     })
        // }

        $scope.openConfirmDeleteDomain = function (elem) {
            $scope.elementToDelete = elem;
            $scope.typeToDelete = 'domain';
            $ngDialog.open({
                template: 'pages/confirmDelete.htm',
                controller: 'confirmDeleteController',
                scope: $scope
            });
        }

        $scope.openPanel = function () {
            $scope.title = 'Create domain';
            $ngDialog.open({
                template: 'pages/newDomain.htm',
                controller: 'newDomainController',
                scope: $scope
            });
        }

    }]);
