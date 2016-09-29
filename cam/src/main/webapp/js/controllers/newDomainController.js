camApp.controller('newDomainController', [
    '$scope',
    'Scopes',
    '$http',
    '$q',
    'ngDialog',
    '$route',
    function ($scope, Scopes, $http, $q, $ngDialog, $route) {
        Scopes.store('newDomainController', $scope);
        $scope.panelTitle = "Add Domain";

        $scope.regexPattern = Scopes.get('homeController').regexPattern;
        $scope.invalidNameMsg = Scopes.get('homeController').invalidNameMsg;
        $scope.nameIsMandatory = Scopes.get('homeController').nameIsMandatory;

        $scope.$watch('domain.name', function () {
            if (!isEmpty($scope.domain.name)) {
                $scope.invalidName = false;
            }
        });

        $scope.closePanel = function () {
            $scope.attributeName = null;
            $ngDialog.close();
        };

        $scope.domain = {
            name: null,
        };

        $scope.saveNewDomain = function () {
            $http.post(BACK_END_URL_CONST + '/owners', $scope.domain)
                .success(function (data, status) {
                    $ngDialog.close();
                    entityManager.getOwnersList();
                    setTimeout(function () {
                        $route.reload();
                    },1000);
                }).error(function (err) {
                $ngDialog.close();
                $scope.openErrorPanel(err);
            });
        };

        $scope.openConfirmPanel = function () {
            if (isEmpty($scope.domain.name)) {
                $scope.invalidName = true;
                return;
            }
            $scope.typeToAdd = 'domain';
            $ngDialog.open({
                template: 'pages/confirmNewDomain.htm',
                controller: 'confirmNewOperationController',
                scope: $scope
            });
        };
        $scope.ownersList = Scopes.get('domainController').ownersList;

    }]);
