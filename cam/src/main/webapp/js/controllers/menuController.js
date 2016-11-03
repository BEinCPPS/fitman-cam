/**
 * Created by ascatolo on 17/10/2016.
 */
camApp.controller('menuController', [
    '$scope',
    '$rootScope',
    '$location',
    'oAuth',
    'Scopes',
    '$location',
    'ngNotifier',
    '$window',
    function ($scope, $rootScope, $location, oAuth, Scopes, $location, ngNotifier, $window) {
        Scopes.store('menuController', $scope);
        // get info if a person is logged in
        $scope.loggedIn = oAuth.isLoggedIn();
        // check to see if a user is logged in on every request$scope
        oAuth.getUser()
            .then(function (data) {
                $scope.user = data.data;
                console.log($scope.user);
            }, function (error) {
                ngNotifier.error(error);
            });
        $rootScope.$on('$routeChangeStart', function () {
            $scope.loggedIn = oAuth.isLoggedIn();
            if (!$scope.loggedIn && !oAuth.isInLogout)
                oAuth.login();
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
            oAuth.logout();
            $scope.user = '';
            //$location.path('/login');

            //$window.location.href = KEYROCK_LOGOUT_URL;
            $window.open(KEYROCK_LOGOUT_URL);
        };

        //NOT USED with OAuth2
        $scope.doLogin = function () {
            $scope.processing = true;
            // clear the error
            $scope.error = '';
            oAuth.login($scope.loginData.username, $scope.loginData.password)
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