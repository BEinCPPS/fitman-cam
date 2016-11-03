//TODO
camApp.controller('domainController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialog',
    'NgTableParams',
    'entityManager',
    'ngNotifier',
    'templateManager',
    function ($scope, Scopes, $q, $ngDialog, NgTableParams, entityManager, ngNotifier, templateManager) {
        Scopes.store('domainController', $scope);
        $scope.assetList = [];
        templateManager.getDomainAction().then(function (response) {
            $scope.actionTemplate = response.data;
        }, function (error) {
            $scope.actionTemplate = '';
            ngNotifier.error(error);
            return null;
        });

        (function getDomains() {
            entityManager.getDomains().then(function (response) {
                $scope.domainsList = [];
                var ownList = [];
                angular.copy(response.data, ownList);
                ownList.forEach(function (value) {
                    var domain = {
                        name: value.name,
                        id: value.id,
                        description: value.description,
                        action: function () {
                            return $scope.actionTemplate.replaceAll('$value$', value.name);
                        }
                    };
                    $scope.domainsList.push(domain);
                })
            }, function (error) {
                ngNotifier.error(error);
            });
        })();

        $scope.columnDefs = Scopes.get('homeController').columnDefs;
        $scope.overrideOptions = Scopes.get('homeController').overrideOptions;
        $scope.loadChildren = function () {
            entityManager.getAssetsFromDomain($scope.currentNode.id)
                .then(function (response) {
                  $scope.assetList = response.data;
                }, function (error) {
                    ngNotifier.error(error);
                });
        }

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
