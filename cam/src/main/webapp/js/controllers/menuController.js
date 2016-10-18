/**
 * Created by ascatolo on 17/10/2016.
 */
camApp.controller('menuController', [
    '$scope',
    '$rootScope',
    '$location',
    'Auth',
    'Scopes',
    '$location',
    'ngNotifier',
    function ($scope, $rootScope, $location, Auth, Scopes, $location, ngNotifier) {
        Scopes.store('menuController', $scope);
        // get info if a person is logged in
        $scope.loggedIn = Auth.isLoggedIn();
        // check to see if a user is logged in on every request$scope
        Auth.getUser()
            .then(function (data) {
                $scope.user = data.data;
            });
        console.log('Logged User', $scope.user);
        $rootScope.$on('$routeChangeStart', function () {
            $scope.loggedIn = Auth.isLoggedIn();
            if (!$scope.loggedIn) $location.path('/login');
            // get user information on page load
            Auth.getUser()
                .then(function (data) {
                    $scope.user = data.data;
                });
        });
        // function to handle logging out
        $scope.doLogout = function () {
            Auth.logout();
            $scope.user = '';
            $location.path('/login');
        };

        $scope.doLogin = function () {
            $scope.processing = true;
            // clear the error
            $scope.error = '';
            Auth.login($scope.loginData.username, $scope.loginData.password)
                .success(function (data) {
                    $scope.processing = false;
                    // if a user successfully logs in, redirect to users page
                    if (data.token)
                        $location.path('/');
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


    }]);