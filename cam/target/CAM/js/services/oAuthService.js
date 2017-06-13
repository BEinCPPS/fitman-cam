/**
 * Created by ascatolo on 26/10/2016.
 */
camApp.factory('oAuth', function ($http, $window, $q, $cacheFactory) {

    var oAuthFactory = {};
    var cache = $cacheFactory('camCache');
    oAuthFactory.mySelf = function () {
        return OAUTH;
    }
    // log a user in
    oAuthFactory.login = function () {
        // return the promise object and its data
        $window.location.href = OAUTH_LOGIN_URL;
        oAuthFactory.isInLogout = false;
    };

    // log a user out by clearing the token
    // Change the current user
    oAuthFactory.logout = function () {
         oAuthFactory.isInLogout = true;
        // clear the token
        TokenManager.removeToken();
        $window.open(KEYROCK_CHANGE_USER_URL);
    };

    // check if a user is logged in
    // checks if there is a local token
    oAuthFactory.isLoggedIn = function () {
        if (TokenManager.getToken())
            return true;
        else
            return false;
    };

    // get the logged in user
    oAuthFactory.getUser = function () {
        if (TokenManager.getToken()) {
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
    return oAuthFactory;
})

// ===================================================
// application configuration to integrate token into requests
// ===================================================
    .factory('oAuthInterceptor', function ($q, $location, $window) {

        var oInterceptorFactory = {};

        // this will happen on all HTTP requests
        oInterceptorFactory.request = function (config) {

            // grab the token
            var token = TokenManager.getToken();

            // if the token exists, add it to the header as x-access-token
            if (token)
                config.headers['X-Auth-Token'] = token;

            return config;
        };

        // happens on response errors
        oInterceptorFactory.responseError = function (response) {

            // if our server returns a 403 forbidden response
            if (response.status == 403 || response.status == 401) {
                TokenManager.removeToken();
                $window.location.href = OAUTH_LOGIN_URL;
            }

            // return the errors from the server as a promise
            return $q.reject(response);
        };

        return oInterceptorFactory;

    });