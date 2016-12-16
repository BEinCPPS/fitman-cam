/**
 * Created by ascatolo on 10/11/2016.
 */

camApp.factory('currentNode', function () {

    var currentNode = {};
    currentNode.domainNode = {};
    currentNode.classNode = {};
    currentNode.orionConfigNode = {};

    currentNode.setDomain = function (node) {
        currentNode.domainNode = node;
    }

    currentNode.getDomain = function () {
        return currentNode.domainNode;
    }

    currentNode.setClass = function (node) {
        currentNode.classNode = node;
    }

    currentNode.getClass = function () {
        return currentNode.classNode;
    }

    currentNode.setOrionConfig = function (node) {
        currentNode.orionConfigNode = node;
    }

    currentNode.getOrionConfig = function () {
        return currentNode.orionConfigNode;
    }

    return currentNode;

});
