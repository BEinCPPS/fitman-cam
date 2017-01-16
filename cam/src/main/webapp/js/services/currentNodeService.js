/**
 * Created by ascatolo on 10/11/2016.
 */

camApp.factory('currentNode', function () {

    var currentNode = {};
    currentNode.domainNode = {};
    currentNode.classNode = {};
    currentNode.orionConfigNode = {};


    currentNode.setDomain = function (node) {
        currentNode = {};
        currentNode.domainNode = node;
    }

    currentNode.getDomain = function () {
        return currentNode.domainNode;
    }

    currentNode.setClass = function (node) {
        currentNode = {};
        currentNode.classNode = node;
    }

    currentNode.getClass = function () {
        return currentNode.classNode;
    }

    currentNode.setOrionConfig = function (node) {
        currentNode = {};
        currentNode.orionConfigNode = node;
    }

    currentNode.getOrionConfig = function () {
        return currentNode.orionConfigNode;
    }

    currentNode.getCurrentNodeType = function() {
        if(currentNode.classNode && currentNode.classNode.hasOwnProperty("className"))
            return GROUPING_CLASS_TYPE
        else if(currentNode.domainNode && currentNode.domainNode.hasOwnProperty("name"))
            return GROUPING_DOMAIN_TYPE
         else
            return GROUPING_ORION_CONFIG_TYPE;
    }
    return currentNode;

});
