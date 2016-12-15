camApp.controller('orionConfigController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialogManager',
    'entityManager',
    'ngNotifier',
    '$route',
    '$window',
    function ($scope, Scopes, $q, ngDialogManager, entityManager, ngNotifier, $route, $window) {
        Scopes.store('orionConfigController', $scope);
        $scope.orionConfigsList = [];
        (function getOrionConfigs() {
            entityManager.getOrionConfigs().then(function (response) {
                $scope.orionConfigsList = response.data;
            }, function (error) {
                ngNotifier.error(error);
            });
        })();

        $scope.selectedConfig = {};
        $scope.isEditing = false;
        $scope.isNew = false;
        $scope.enableContextMenuEntry = false;
        $scope.regexUrlValidator = $scope.isEditing ? '/https?\:\/\/\w+((\:\d+)?\/\S*)?/' : '';
        $scope.loadChildren = function () {
            angular.forEach($scope.orionConfigsList, function (value) {
                if (value && value.id == $scope.currentNode.id) {
                    $scope.selectedConfig = value;
                }
            });
        }
        $scope.enterEdit = function (ev, isNew) {
            $scope.isEditing = !$scope.isEditing;
            if (isNew) {
                $scope.isNew = true;
                $scope.selectedConfig = {};
            }
            ev.preventDefault();

        }

        $scope.edit = function () {
            var selectedConfigs = [];
            selectedConfigs.push($scope.selectedConfig);
            entityManager.editOrionConfigs(selectedConfigs)
                .then(function () {
                    $route.reload();
                }, function (error) {
                    ngNotifier.error(error);
                });
        }

        $scope.create = function () {
            var selectedConfigs = [];
            selectedConfigs.push($scope.selectedConfig);
            entityManager.createOrio(selectedConfigs)
                .then(function () {
                    $route.reload();
                }, function (error) {
                    ngNotifier.error(error);
                });
        }

        $scope.openConfirmDeleteElement = function (node) {
            $scope.elementToDelete = node.id;
            $scope.typeToDelete = 'orionConfig';
            ngDialogManager.open({
                template: 'pages/confirmDelete.htm',
                controller: 'confirmDeleteController',
                scope: $scope
            });
        }

        $scope.changeBackground = function (ev) {
            $('.ownselector').each(
                function () {
                    $(this).removeClass('selected');
                    $(this).removeClass('ownselector');
                });
            ev.target.className += ' selected ownselector';
        }

        $scope.addOrionConfig = function () {

        }

    }]);
