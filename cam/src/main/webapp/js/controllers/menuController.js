/**
 * Created by ascatolo on 17/10/2016.
 */
camApp.controller('menuController', [
    '$scope',
    '$rootScope',
    '$location',
    '${authentication.service}', //option oAuth or auth for Keystone
    'Scopes',
    'ngNotifier',
    '$window',
    function ($scope, $rootScope, $location, Auth, Scopes, ngNotifier, $window) {
        var auth = Auth;
        $scope.userDisplay = {};
        Scopes.store('menuController', $scope);
        // get info if a person is logged in
        $scope.loggedIn = auth.isLoggedIn();

        // check to see if a user is logged in on every request$scope
        auth.getUser()
            .then(function (data) {
                $scope.user = data.data;

                if (auth.mySelf() == OAUTH) {
                    $scope.userDisplay = {
                        name: $scope.user.username,
                        email: $scope.user.name,
                        roles: $scope.user.roles,
                        organizations: $scope.user.organizations
                    }
                } else if (auth.mySelf() == AUTH) {
                    $scope.userDisplay = {
                        name: $scope.user.id,
                        email: $scope.user.name,
                        roles: null,
                        organizations: $scope.user.organizations
                    }
                }
                $scope.dynamicPopover = {
                    title: $scope.userDisplay.name
                };

            }, function (error) {
                ngNotifier.error(error);
            });
        $rootScope.$on('$routeChangeStart', function (event, next, current) {
            $scope.loggedIn = auth.isLoggedIn();
            if (!$scope.loggedIn)
                $scope.login();
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
        //    if (!$scope.isOAuth)
                $scope.user = {};
            auth.logout();
        };

        $scope.login = function () {
            if (auth.mySelf() == OAUTH) {
                auth.login();
            } else if (auth.mySelf() == AUTH) {
                $location.path('/');
            }
        };

        $scope.isOAuth = auth.mySelf() == OAUTH;
        $scope.logoutLabel = 'Sign out';
        // $scope.isOAuth ? 'Change user' : 'Sign out';


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
                        $location.path('/classes');
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
            if ($location.url().indexOf('classes') > -1)
                return 'active';
            else return '';
        };

        $scope.activeMenuDomain = function () {
            if ($location.url().indexOf('domains') > -1)
                return 'active';
            else return '';
        };

        $scope.activeMenuOrionConfig = function () {
            if ($location.url().indexOf('orion') > -1)
                return 'active';
            else return '';
        };

        $scope.linkCamService = function () {
            return BACK_END_URL_CONST;
        };

        $scope.linkKeyrockSignup = function () {
            return KEYROCK_SIGNUP_URL;
        };
    }
]);