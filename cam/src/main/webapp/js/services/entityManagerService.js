/**
 * Created by ascatolo on 10/10/2016.
 */
camApp.factory('entityManager', ['$q', '$http', '${authentication.service}', function ($q, $http, auth) {

    // create a new object
    var entityManager = {};
    var ignoreLoadingBar = {
        ignoreLoadingBar: true
    };

    function rejectNotLoggedCall() {
        var defer = $q.defer();
        defer.reject({message: 'ERROR_NOT_LOGGED: You are not logged in. Please login!'});
        return defer.promise;
    }

    // get a single user
    entityManager.getAssets = function (name, retrieveForChildren) {
        if (auth.isLoggedIn()) {
            var assetsForChildren = '';
            if (retrieveForChildren)
                assetsForChildren = '&&retrieveForChildren=true';
            return $http.get(BACK_END_URL_CONST + '/assets?className=' + name + assetsForChildren);
        } else
            return rejectNotLoggedCall();
    };

    entityManager.getClasses = function () {
        if (auth.isLoggedIn())
            return $http.get(BACK_END_URL_CONST + '/classes', ignoreLoadingBar);
        else
            return rejectNotLoggedCall();
    }

    entityManager.getChildrenForClass = function (className) {
        if (auth.isLoggedIn())
            return $http.get(BACK_END_URL_CONST + '/classes/' + className);
        else
            return rejectNotLoggedCall();
    }

    entityManager.getAssetDetail = function (name, type) {
        if (auth.isLoggedIn()) {
            //type attributes or relationships empty for asset only
            if (type) type = '/' + type;
            return $http.get(BACK_END_URL_CONST + '/assets/' + name + type)
        } else
            return rejectNotLoggedCall();
    }

    entityManager.getDomains = function () {
        if (auth.isLoggedIn()) {
            var cache = {cache: true, ignoreLoadingBar: true};
            return $http.get(BACK_END_URL_CONST + '/domains', cache);
        } else
            return rejectNotLoggedCall();
    }

    entityManager.getAncestors = function (className) {
        if (auth.isLoggedIn())
            return $http.get(BACK_END_URL_CONST + '/classes/ancestors/' + className, ignoreLoadingBar);
        else
            return rejectNotLoggedCall();
    }

    entityManager.getAttributes = function () {
        if (auth.isLoggedIn())
            return $http.get(BACK_END_URL_CONST + '/attributes');
        else
            return rejectNotLoggedCall();
    }

    entityManager.getAttributesForIndividual = function (individualName) {
        if (auth.isLoggedIn())
            return $http.get(BACK_END_URL_CONST + '/assets/' + individualName + '/attributes')
        else
            return rejectNotLoggedCall();
    }

    entityManager.getAttribute = function (isModel, assetName, attributeName) {
        if (auth.isLoggedIn()) {
            var urlFragment = '/assets/';
            if (isModel)
                urlFragment = '/models/'
            return $http.get(BACK_END_URL_CONST + urlFragment + assetName + '/attributes/' + attributeName);
        } else
            return rejectNotLoggedCall();
    }

    entityManager.deleteIndividual = function (typeToDelete, elementToDelete, individualName) {
        if (auth.isLoggedIn()) {
            var urlFragment = '/assets/';
            if (typeToDelete == 'model')
                urlFragment = '/models/';
            else if (typeToDelete == 'attribute')
                urlFragment = '/assets/' + individualName + '/attributes/';
            else if (typeToDelete == 'relationship')
                urlFragment = '/assets/' + individualName + '/relationships/';
            else if (typeToDelete == 'class')
                urlFragment = '/classes/';
            else if (typeToDelete == 'domain')
                urlFragment = '/owners/';

            return $http.delete(BACK_END_URL_CONST + urlFragment + elementToDelete);
        } else
            return rejectNotLoggedCall();
    }

    entityManager.removeClassMySelf = function (data, className) {
        if (auth.isLoggedIn()) {
            var classes = [];
            if (!data) return classes;
            for (var i in data) {
                if (data[i].className != className)
                    classes.push(data[i]);
            }
            return classes;
        } else
            return rejectNotLoggedCall();
    }

    entityManager.updateClass = function (name, newClass) {
        if (auth.isLoggedIn())
            return $http.put(BACK_END_URL_CONST + '/classes/' + name, newClass);
        else
            return rejectNotLoggedCall();
    }

    entityManager.createAsset = function (newAsset) {
        if (auth.isLoggedIn())
            return $http.post(BACK_END_URL_CONST + '/assets', newAsset);
        else
            return rejectNotLoggedCall();
    }

    entityManager.createModel = function (newModel) {
        if (auth.isLoggedIn())
            return $http.post(BACK_END_URL_CONST + '/models', newModel);
        else
            return rejectNotLoggedCall();
    }

    entityManager.createClass = function (newClass) {
        if (auth.isLoggedIn())
            return $http.post(BACK_END_URL_CONST + '/classes', newClass);
        else
            return rejectNotLoggedCall();
    }

    entityManager.createAttribute = function (isModel, individualName, attribute) {
        if (auth.isLoggedIn()) {
            var urlFragment = '/assets/';
            if (isModel)
                urlFragment = '/models/';
            return $http.post(BACK_END_URL_CONST + urlFragment + individualName + '/attributes',
                attribute);
        } else
            return rejectNotLoggedCall();
    }

    entityManager.getRelationship = function (individualName, attributeName) {
        if (auth.isLoggedIn())
            return $http.get(BACK_END_URL_CONST + '/assets/' + individualName + '/relationships/' + attributeName);
        else
            return rejectNotLoggedCall();
    }

    entityManager.createRelationship = function (individualName, newRelationship) {
        if (auth.isLoggedIn())
            return $http.post(BACK_END_URL_CONST + '/assets/' + individualName + '/relationships', newRelationship);
        else
            return rejectNotLoggedCall();
    }

    entityManager.updateRelationship = function (individualName, attributeName, newRelationship) {
        if (auth.isLoggedIn())
            return $http.put(BACK_END_URL_CONST + '/assets/' + individualName + '/relationships/' + attributeName,
                newRelationship);
        else
            return rejectNotLoggedCall();
    }

    entityManager.updateAttribute = function (isModel, individualName, attributeName, attribute) {
        if (auth.isLoggedIn()) {
            var urlFragment = '/assets/';
            if (isModel)
                urlFragment = '/models/';
            return $http.put(BACK_END_URL_CONST + urlFragment + individualName + '/attributes/' + attributeName, attribute);
        } else
            return rejectNotLoggedCall();
    }

    entityManager.getAssetsFromDomain = function (domainId) {
        if (auth.isLoggedIn())
            return $http.get(BACK_END_URL_CONST + '/domains/' + domainId + '/assets');
        else
            return rejectNotLoggedCall();
    }

    entityManager.updateAsset = function (individualName, asset) {
        if (auth.isLoggedIn())
            return $http.put(BACK_END_URL_CONST + '/models/' + individualName,
                asset);
        else
            return rejectNotLoggedCall();
    }

    entityManager.createAssetsToOCB = function (selectedAssets) {
        if (auth.isLoggedIn())
            return $http.post(BACK_END_URL_CONST + '/orion/contexts', selectedAssets);
        else
            return rejectNotLoggedCall();
    }

    entityManager.updateAssetsToOCB = function (selectedAssets) {
        if (auth.isLoggedIn())
            return $http.put(BACK_END_URL_CONST + '/orion/contexts', selectedAssets);
        else
            return rejectNotLoggedCall();
    }

    entityManager.disconnectAssetsFromOCB = function (selectedAsset) {
        if (auth.isLoggedIn())
            return $http.delete(BACK_END_URL_CONST + '/orion/contexts/' + selectedAsset, ignoreLoadingBar);
        else
            return rejectNotLoggedCall();
    }

    entityManager.getOrionConfigs = function () {
        return $http.get(BACK_END_URL_CONST + '/orion/config', ignoreLoadingBar);
    }

    entityManager.editOrionConfigs = function (selectedOrionConfigs) {
        return $http.put(BACK_END_URL_CONST + '/orion/config', selectedOrionConfigs);
    }

    entityManager.createOrionConfigs = function (selectedOrionConfigs) {
        return $http.post(BACK_END_URL_CONST + '/orion/config', selectedOrionConfigs);
    }

    entityManager.deleteOrionConfig = function (configId) {
        return $http.delete(BACK_END_URL_CONST + '/orion/config/' + configId);
    }
    entityManager.getAssetsFromOrionConfig = function (orionConfigId) {
        if (auth.isLoggedIn())
            return $http.get(BACK_END_URL_CONST + '/orion/' + orionConfigId + '/assets');
        else
            return rejectNotLoggedCall();
    }
    entityManager.downloadAssetsForIDAS = function (selectedAssets) {
        var config = {
            responseType: 'arraybuffer',
            ignoreLoadingBar: true
        };
        if (auth.isLoggedIn())
            return $http.post(BACK_END_URL_CONST + '/idas/download', selectedAssets, config);
        else
            return rejectNotLoggedCall();
    }
    entityManager.refreshAssetFromOCB = function (individualName, selectedAsset) {
        if (auth.isLoggedIn())
            return $http.put(BACK_END_URL_CONST + '/assets/' + individualName + '/orion/refresh');
        else
            return rejectNotLoggedCall();
    }
    // return our entire userFactory object
    return entityManager;

}]);