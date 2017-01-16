camApp.controller('orionConfigController', [
    '$scope',
    'Scopes',
    '$q',
    'ngDialogManager',
    'entityManager',
    'ngNotifier',
    '$route',
    '$window',
    'currentNode',
    function ($scope, Scopes, $q, ngDialogManager, entityManager, ngNotifier, $route, $window, currentNode) {
        Scopes.store('orionConfigController', $scope);
        $scope.orionConfigsList = [];
        (function getOrionConfigs() {
            entityManager.getOrionConfigs().then(function (response) {
                $scope.orionConfigsList = response.data;
            }, function (error) {
                ngNotifier.error(error);
            }).then(function () {
                if (currentNode.getOrionConfig() && currentNode.getOrionConfig().id) {
                    $scope.currentNode = currentNode.getOrionConfig();
                    $scope.expandAncestors($scope.currentNode.id);
                } else {
                    if ($scope.orionConfigsList.length > 0)
                        $scope.expandAncestors($scope.orionConfigsList[0].id);
                }
            }, function (error) {
                ngNotifier.error(error);
            });
        })();

        $scope.selectedConfig = {};
        $scope.isEditing = false;
        $scope.isNew = false;
        $scope.enableContextMenuEntry = false;
        $scope.REGEX_URL_VALIDATOR = $scope.isEditing ? REGEX_URL_VALIDATOR : ''; //TODO
        $scope.REGEX_PATTERN = REGEX_PATTERN;
        $scope.placeholderService = $scope.isEditing ? "Enter Service" : '';
        $scope.placeholderServicePath = $scope.isEditing ? "Enter Service Path" : '';


        $scope.loadChildren = function () {
            angular.forEach($scope.orionConfigsList, function (value) {
                if (value && value.id == $scope.currentNode.id) {
                    $scope.selectedConfig = value;
                }
            });
        }
        $scope.enterEdit = function (isNew) {
            $scope.isEditing = true;
            $scope.isNew = false;
            if (isNew) {
                $scope.isNew = true;
                $scope.selectedConfig = {};
            }
        }

        $scope.save = function () {
            if ($scope.isNew)
                $scope.create();
            else
                $scope.update();
        }

        $scope.update = function () {
            var selectedConfigs = [];
            selectedConfigs.push(removeSelectedPropFromObj($scope.selectedConfig));
            entityManager.editOrionConfigs(selectedConfigs)
                .then(function () {
                    ngNotifier.success();
                    $route.reload();
                }, function (error) {
                    ngNotifier.error(error);
                });
        }
        $scope.create = function () {
            var selectedConfigs = [];
            selectedConfigs.push(removeSelectedPropFromObj($scope.selectedConfig));
            entityManager.createOrionConfigs(selectedConfigs)
                .then(function () {
                    ngNotifier.success();
                    $scope.isNew = false;
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

        $scope.expandAncestors = function (orionConfigId) {
            for (var i in $scope.orionConfigsList) {
                if ($scope.orionConfigsList[i].id === orionConfigId) {
                    $scope.orionConfigsList[i].selected = 'selected';
                    var eventFake = new MouseEvent('click', {
                        'view': $window,
                        'bubbles': true,
                        'cancelable': true
                    });
                    var event = $window.event || eventFake;
                    if ($scope.selectNodeLabel)
                        $scope.selectNodeLabel($scope.orionConfigsList[i], event);
                    return;
                }
            }
        }

        $scope.cancel = function () {
            $route.reload();
        }

        function removeSelectedPropFromObj(selectedOrionConfig) {
            if (selectedOrionConfig && selectedOrionConfig.hasOwnProperty("selected"))
                delete selectedOrionConfig.selected;
            return selectedOrionConfig;
        }

        $scope.$watch("isEditing", function (newValue, oldValue) {
            if (newValue) {
                $scope.placeholderService = 'Enter Service';
                $scope.placeholderServicePath = 'Enter Service Path';

            } else {
                $scope.placeholderService = '';
                $scope.placeholderServicePath = '';
            }


        });

    }]);
