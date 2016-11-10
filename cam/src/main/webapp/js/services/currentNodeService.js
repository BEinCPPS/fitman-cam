/**
 * Created by ascatolo on 10/11/2016.
 */

camApp.factory('currentNode', function () {

    var currentNode = {};
    currentNode.domainNode = {};
    currentNode.classNode = {};

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

    return currentNode;

});
