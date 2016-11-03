/**
 * Created by ascatolo on 10/10/2016.
 */
camApp.factory('entityManager', function ($http) {

    // create a new object
    var entityManager = {};

    // get a single user
    entityManager.getAssets = function (name, retrieveForChildren) {
        var assetsForChildren = '';
        if (retrieveForChildren)
            assetsForChildren = '&&retrieveForChildren=true';
        return $http.get(BACK_END_URL_CONST + '/assets?className=' + name + assetsForChildren);
    };

    entityManager.getClasses = function () {
        return $http.get(BACK_END_URL_CONST + '/classes');
    }

    entityManager.getChildrenForClass = function (className) {
        return $http.get(BACK_END_URL_CONST + '/classes/' + className);
    }

    entityManager.getAssetDetail = function (name, type) {
        //type attributes or relationships
        return $http.get(BACK_END_URL_CONST + '/assets/' + name + '/' + type)
    }

    entityManager.getDomains = function () {
        return $http.get(BACK_END_URL_CONST + '/domains');
    }

    entityManager.getAncestors = function (className) {
        return $http.get(BACK_END_URL_CONST + '/classes/ancestors/' + className);
    }

    entityManager.getAttributes = function () {
        return $http.get(BACK_END_URL_CONST + '/attributes');
    }

    entityManager.getAttributesForIndividual = function (individualName) {
        return $http.get(BACK_END_URL_CONST + '/assets/' + individualName + '/attributes')
    }

    entityManager.getAttribute = function (isModel, assetName, attributeName) {
        var urlFragment = '/assets/';
        if (isModel)
            urlFragment = '/models/'
        return $http.get(BACK_END_URL_CONST + urlFragment + assetName + '/attributes/' + attributeName);
    }

    // entityManager.updateOwner = function (originalName, domain) {
    //     return $http.put(BACK_END_URL_CONST + '/owners/' + originalName, domain);
    // }

    entityManager.deleteIndividual = function (typeToDelete, elementToDelete, individualName) {
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
    }

    entityManager.removeClassMySelf = function (data, className) {
        var classes = [];
        if (!data) return classes;
        for (var i in data) {
            if (data[i].className != className)
                classes.push(data[i]);
        }
        return classes;
    }
    entityManager.updateClass = function (name, newClass) {
        return $http.put(BACK_END_URL_CONST + '/classes/' + name, newClass);
    }
    entityManager.createAsset = function (newAsset) {
        return $http.post(BACK_END_URL_CONST + '/assets', newAsset);
    }
    entityManager.createModel = function (newModel) {
        return $http.post(BACK_END_URL_CONST + '/models', newModel);
    }
    entityManager.createClass = function (newClass) {
        return $http.post(BACK_END_URL_CONST + '/classes', newClass);
    }
    // entityManager.createOwner = function (owner) {
    //     return $http.post(BACK_END_URL_CONST + '/owners', owner);
    // }
    entityManager.createAttribute = function (isModel, individualName, attribute) {
        var urlFragment = '/assets/';
        if (isModel)
            urlFragment = '/models/';
        return $http.post(BACK_END_URL_CONST + urlFragment + individualName + '/attributes',
            attribute);
    }

    entityManager.getRelationship = function (individualName, attributeName) {
        return $http.get(BACK_END_URL_CONST + '/assets/' + individualName + '/relationships/' + attributeName);
    }

    entityManager.createRelationship = function (individualName, newRelationship) {
        return $http.post(BACK_END_URL_CONST + '/assets/' + individualName + '/relationships', newRelationship);
    }

    entityManager.updateRelationship = function (individualName, attributeName, newRelationship) {
        return $http.put(BACK_END_URL_CONST + '/assets/' + individualName + '/relationships/' + attributeName,
            newRelationship);
    }

    entityManager.updateAttribute = function (isModel, individualName, attributeName, attribute) {
        var urlFragment = '/assets/';
        if (isModel)
            urlFragment = '/models/';
        return $http.put(BACK_END_URL_CONST + urlFragment + individualName + '/attributes/' + attributeName, attribute);
    }

    entityManager.getAssetsFromDomain = function(domainId){
        return $http.get(BACK_END_URL_CONST + '/domains/' + domainId + '/assets' );
    }

    // return our entire userFactory object
    return entityManager;

});