/**
 * Created by ascatolo on 24/10/2016.
 */
camApp.factory('templateManager', function ($http) {

    // create a new object
    var templateManager = {};

    templateManager.getDomainAction = function () {
        return $http.get('pages/templates/actionDomain.html');
    };
    templateManager.getAssetAction = function () {
        return $http.get('pages/templates/actionAsset.html');
    };
    templateManager.getTreeView = function () {
        return $http.get('pages/templates/treeview.html');
    };
    templateManager.getUserPopup = function () {
        return $http.get('pages/templates/userPopupTemplate.html');
    };
    return templateManager;
});
