// MODULE
var camApp = angular.module('camApp', ['ngRoute', 'ngResource', 'angularTreeview', 'ngDialog', 'ngContextMenu',
    'toastr', 'ngAnimate','ui.bootstrap', 'angular-loading-bar']);

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
    });
    $httpProvider.interceptors.push('${authentication.service}Interceptor'); //option oAuthInterceptor
    $httpProvider.defaults.cache = false;
});

camApp.config(function(toastrConfig) {
    //Info on params and configuration here -> https://github.com/Foxandxss/angular-toastr
    angular.extend(toastrConfig, {
        allowHtml: true,
        autoDismiss: true,
        containerId: 'toast-container',
        maxOpened: 2,
        newestOnTop: true,
        positionClass: 'toast-top-right',
        preventDuplicates: false,
        preventOpenDuplicates: false,
        tapToDismiss: true,
        closeButton: true,
        timeOut: 3000,
        extendedTimeOut: 0,
        target: 'body',
    });
});

camApp.config(function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.latencyThreshold = 500;
});