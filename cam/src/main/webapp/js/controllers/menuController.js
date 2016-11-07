/**
 * Created by ascatolo on 17/10/2016.
 */
camApp.controller('menuController', [
    '$scope',
    '$rootScope',
    '$location',
    'Auth', //option oAuth or auth for Keystone
    'Scopes',
    '$location',
    'ngNotifier',
    '$window',
    function ($scope, $rootScope, $location, Auth, Scopes, $location, ngNotifier, $window) {
        var auth = Auth;
        Scopes.store('menuController', $scope);
        // get info if a person is logged in
        $scope.loggedIn = auth.isLoggedIn();
        // check to see if a user is logged in on every request$scope
        auth.getUser()
            .then(function (data) {
                $scope.user = data.data;
                console.log($scope.user);
            }, function (error) {
                ngNotifier.error(error);
            });
        $rootScope.$on('$routeChangeStart', function () {
            $scope.loggedIn = auth.isLoggedIn();
            if (!$scope.loggedIn && !auth.isInLogout)
                auth.login();
        });

        $scope.isAdmin = function () {
            if ($scope.user) {
                var roles = $scope.user.roles;
                for (var i in roles) {
                    if (roles[i] == 'ADMIN')
                        return true;
                }
            }
            return false;
        }
        // function to handle logging out
        $scope.doLogout = function () {
            $scope.user = '';
            auth.logout();
        };

        //NOT USED with OAuth2
        $scope.doLogin = function () {
            $scope.processing = true;
            // clear the error
            $scope.error = '';
            auth.login($scope.loginData.username, $scope.loginData.password)
                .success(function (data) {
                    $scope.processing = false;
                    // if a user successfully logs in, redirect to users page
                    if (data.token) {
                        $scope.user = undefined;
                        $location.path('/');
                    }
                    else
                        ngNotifier.info(data);
                }).error(function (error) {
                if (error) {
                    ngNotifier.error("User and/or password are invalid!");
                }

            });
        };

        $scope.activeMenuClass = function () {
            if ($location.url().indexOf('domain') > -1)
                return '';
            else return 'active';
        }

        $scope.activeMenuDomain = function () {
            if ($location.url().indexOf('domain') > -1)
                return 'active';
            else return '';
        }

        $scope.dynamicPopover = {
            content: 'Hello, World!',
            templateUrl: 'myPopoverTemplate.html',
            title: 'Title'
        };

    }]);