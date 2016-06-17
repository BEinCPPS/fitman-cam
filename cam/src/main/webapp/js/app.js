// MODULE
var camApp = angular.module('camApp', ['ngRoute', 'ngResource', 'angularTreeview','ngDialog']);

camApp.config(['ngDialogProvider', function (ngDialogProvider) {
    ngDialogProvider.setDefaults({
        plain: false,
        showClose: false,
        closeByDocument: true,
        closeByEscape: true
    });
 }]);