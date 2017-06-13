"use strict";
var TokenManager = (function () {

    var getToken = function () {
        return window.sessionStorage.getItem('token');
    }

    var setToken = function (token) {
        window.sessionStorage.setItem('token', token);
    }
    var removeToken = function () {
        window.sessionStorage.removeItem('token');
    }

    var getUserLoggedURL = function () {
        return OAUTH_USER_LOGGED_URL + getToken();
    }

    //Costructor
    var TokenManager = function () {
    }


    TokenManager.prototype = {
        //constructor
        constructor: TokenManager,
        setToken: setToken,
        getToken: getToken,
        removeToken: removeToken,
        getUserLoggedURL: getUserLoggedURL
    }
    return TokenManager;
})();

var TokenManager = new TokenManager();
