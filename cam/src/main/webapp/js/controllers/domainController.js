//TODO
camApp.controller('domainController', [
    '$scope',
    'Scopes',
    '$http',
    '$q',
    'ngDialog',
    function ($scope, Scopes, $http, $q, $ngDialog) {
        Scopes.store('domainController', $scope);
        $scope.ownersList = Scopes.get('homeController').ownersList;

        $scope.domainColumnDefs = [{
            "mDataProp": "name",
            "aTargets": [0]
        }, {
            "mDataProp": "action",
            "aTargets": [1],
            "bSortable": false
        }];

        $scope.domainlOverrideOptions = {
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

        $scope.openConfirmDeleteDomain = function (elem) {
            $scope.elementToDelete =elem;
            $scope.typeToDelete = 'domain';
            $ngDialog.open({
                template: 'pages/confirmDelete.htm',
                controller: 'confirmDeleteController',
                scope: $scope
            });
        };

        $scope.openPanel = function () {
            $scope.title = 'Create domain';
            $ngDialog.open({
                template: 'pages/newDomain.htm',
                controller: 'newDomainController',
                scope: $scope
            });
        }
    }]);
