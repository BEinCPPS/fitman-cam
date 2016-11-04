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

    entityManager.getAssetsInfo = function(assetList, completeCallback, result) {
        if (assetList.length == 0) {
            completeCallback(result);
        } else {
            var cur = assetList.shift();
            //$http.get(BACK_END_URL_CONST + '/assets/' + cur.individualName + '/attributes')
            entityManager.getAttributesForIndividual(cur.individualName)
                .success(function (data) {
                    var owned;
                    var model;
                    var created;
                    var originalDate;
                    var isModel = true;
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].normalizedName.indexOf('ownedBy') > 0)
                            owned = data[i].propertyValue.substring(data[i].propertyValue.lastIndexOf('#') + 1);
                        if (data[i].normalizedName.indexOf('instanceOf') > 0) {
                            model = data[i].propertyValue;
                            isModel = false;
                        }
                        if (data[i].normalizedName.indexOf('createdOn') > 0) {
                            var myDate = new Date(data[i].propertyValue);
                            var month = (myDate.getMonth() + 1).toString();
                            var day = new String(myDate.getDate());
                            while (month.length < 2)
                                month = '0' + month;
                            while (day.length < 2)
                                day = '0' + day;
                            created = day + "/" + month + "/" + myDate.getFullYear();
                            originalDate = myDate;

                        }
                    }
                    var asset = {
                        asset: cur.individualName,
                        created: created,
                        originalDate: myDate,
                        model: model || "",
                        domain: owned || "",
                        class: cur.className,
                        isModel: isModel,
                        index: i,
                    };
                    result.push(asset);
                })
                .error(function (error) {
                    ngNotifier.error(error);

                }).finally(function () {
                getAssetsInfo(assetList, completeCallback, result);
            });
        }
    }

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

    entityManager.getAssetsFromDomain = function (domainId) {
        return $http.get(BACK_END_URL_CONST + '/domains/' + domainId + '/assets');
    }

    // return our entire userFactory object
    return entityManager;

});