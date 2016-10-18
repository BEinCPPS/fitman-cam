/**
 * Created by ascatolo on 18/10/2016.
 */
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