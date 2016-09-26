// MODULE
var camApp = angular.module('camApp', ['ngRoute', 'ngResource', 'angularTreeview', 'ngDialog', 'ngContextMenu',
    'toaster', 'ngAnimate','ui.bootstrap','ngScrollTo']);

camApp.config(['ngDialogProvider', function (ngDialogProvider) {
    ngDialogProvider.setDefaults({
        plain: false,
        showClose: false,
        closeByDocument: false,
        closeByEscape: true
    });
}]);

/** author @ascatox **/
//Timeout Management
// loading for each http request
camApp.config(function ($httpProvider) {
    $httpProvider.interceptors.push(function ($rootScope, $q) {
        return {
            request: function (config) {
                config.timeout = HTTP_TIMEOUT;
                return config;
            },
            responseError: function (rejection) {
                switch (rejection.status) {
                    case -1:
                        console.log('connection timed out');
                        rejection.data = HTTP_TIMEOUT_EXPIRED_MSG;
                        rejection.status = 408;
                        rejection.statusText = 'connection timed out';
                        break;
                }
                return $q.reject(rejection);
            }
        }
    })
});


camApp.factory('Scopes', function ($rootScope) {
    var mem = {};
    return {
        store: function (key, value) {
            mem[key] = value;
        },
        get: function (key) {
            return mem[key];
        },
        reset: function () {
            mem = {};
        }
    };
});


camApp.factory('ngNotifier', function (toaster) {
    return {
        notify: function (msg) {
            toaster.success(msg);
        },
        notifyError: function (msg) {
            toaster.error(msg);
        },
        notifyInfo: function (msg) {
            toaster.info(msg);
        }
    }
});

