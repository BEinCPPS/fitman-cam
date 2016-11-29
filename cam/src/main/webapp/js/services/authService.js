/**
 * Created by ascatolo on 17/10/2016.
 */
camApp

// ===================================================
// auth factory to login and get information
// inject $http for communicating with the API
// inject $q to return promise objects
// inject AuthToken to manage tokens
// ===================================================
    .factory('Auth', function ($http, $q, AuthToken, $cacheFactory, $location) {

        // create auth factory object
        var authFactory = {};
        var cache = $cacheFactory('camCache');
        // log a user in
        authFactory.mySelf = function () {
            return AUTH;
        }

        authFactory.login = function (username, password) {
            // return the promise object and its data
            return $http.post(BACK_END_URL_CONST + '/authenticate', {
                username: username,
                password: password
            }).success(function (data, status, headers) {
                AuthToken.setToken(headers('X-Subject-Token'));
                cache.remove('user');
                authFactory.isInLogout = false;
                return data;
            }).error(function (error) {
                return error;
            })
        };

        // log a user out by clearing the token
        authFactory.logout = function () {
            // clear the token
            AuthToken.setToken();
            authFactory.isInLogout = true;
            //$location.path('/login');
            authFactory.public();
        };

        authFactory.public = function () {
            // clear the token
            AuthToken.setToken();
            $location.path('/');
        };

        // check if a user is logged in
        // checks if there is a local token
        authFactory.isLoggedIn = function () {
            if (AuthToken.getToken())
                return true;
            else
                return false;
        };

        // get the logged in user
        authFactory.getUser = function () {
            if (AuthToken.getToken()) {
                if (!cache.get('user')) {
                    var promise = $http.get(BACK_END_URL_CONST + '/logged', {cache: false});
                    cache.put('user', promise);
                    return promise;
                }
                else
                    return cache.get('user');
            }
            return $q.reject({message: 'ERROR_NOT_LOGGED: User has no token.'});
        };


        // return auth factory object
        return authFactory;

    })

    // ===================================================
    // factory for handling tokens
    // inject $window to store token client-side
    // ===================================================
    .factory('AuthToken', function ($window) {

        var authTokenFactory = {};

        // get the token out of local storage
        authTokenFactory.getToken = function () {
            return $window.sessionStorage.getItem('token');
        };

        // function to set token or clear token
        // if a token is passed, set the token
        // if there is no token, clear it from local storage
        authTokenFactory.setToken = function (token) {
            if (token) {
                $window.sessionStorage.setItem('token', token);
            }
            else
                $window.sessionStorage.removeItem('token');
        };

        return authTokenFactory;

    })

    // ===================================================
    // application configuration to integrate token into requests
    // ===================================================
    .factory('AuthInterceptor', function ($q, $location, AuthToken) {

        var interceptorFactory = {};

        // this will happen on all HTTP requests
        interceptorFactory.request = function (config) {

            // grab the token
            var token = AuthToken.getToken();

            // if the token exists, add it to the header as x-access-token
            if (token)
                config.headers['X-Auth-Token'] = token;

            return config;
        };

        // happens on response errors
        interceptorFactory.responseError = function (response) {

            // if our server returns a 403 forbidden response
            if (response.status == 403 || response.status == 401) {
                AuthToken.setToken();
                //$location.path('/login');
//                if (response.config.url.indexOf('authenticate') > 0) {
                    $location.path('/');
//                }
            }
            // return the errors from the server as a promise
            return $q.reject(response);
        };

        return interceptorFactory;

    });