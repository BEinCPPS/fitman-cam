(function (l) {
    l.module("angularTreeview", []).directive("treeModel", ['currentNode', '$compile', function (currentNode, $compile) {
        return {
            restrict: "A",
            link: function (a, g, c) {
                var e = c.treeModel
                    , h = c.nodeLabel || "label"
                    , d = c.nodeChildren || "children"
                    , l = String(c.rightClickEnabled) == "true" ? true : false
                    , m = l ? 'ng-right-click="classRightClicked($event)"' : ''
                    , n = l ? 'data-context-menu="pages/ctxtMenu.htm"' : ''
                    , o = c.iconClassName
                    , k = '<ul id="home-tree-nodes">' +
                    '<li data-ng-repeat="node in ' + e + '">' +
                    '<i class="collapsed ' + o + '" data-ng-show="node.' + d + '.length && node.collapsed"' +
                    ' data-ng-click="selectNodeHead(node, $event)"></i>' +
                    '<i class="expanded ' + o + '" data-ng-show="node.' + d + '.length && !node.collapsed" ' +
                    'data-ng-click="selectNodeHead(node, $event)">' +
                    '</i>' +
                    '<i class="normal ' + o + '" data-ng-hide="node.' +
                    d + '.length"></i>' +
                    ' <span ' + m + '" ' +
                    'data-ng-class="node.selected" data-ng-click="selectNodeLabel(node, $event)" ' +
                    n + ' ng-model="node">{{node.' + h + '}}</span>' +
                    '<div data-ng-hide="node.collapsed" data-tree-model="node.' + d +
                    '" data-node-id=' + (c.nodeId || "id") + " " +
                    "data-node-label=" + h + " data-node-children=" + d + " data-icon-class-name=\"" + o + "\" " +
                    "data-right-click-enabled=\"" + l + "\" >" +
                    "</div>" +
                    "</li></ul>";
                e && e.length && (c.angularTreeview ? (a.$watch(e, function (m, b) {
                        g.empty().html($compile(k)(a))
                    }, !1),
                        a.selectNodeHead = a.selectNodeHead || function (a, b) {
                                b.stopPropagation && b.stopPropagation();
                                b.preventDefault && b.preventDefault();
                                b.cancelBubble = !0;
                                b.returnValue = !1;
                                a.collapsed = !a.collapsed
                            }
                        ,
                        a.selectNodeLabel = a.selectNodeLabel || function (c, b) {
                                b.stopPropagation && b.stopPropagation();
                                b.preventDefault && b.preventDefault();
                                b.cancelBubble = !0;
                                b.returnValue = !1;
                                a.currentNode && a.currentNode.selected && (a.currentNode.selected = void 0);
                                c.selected = "selected";
                                a.currentNode = c;
                                if (a.currentNode.className)
                                    currentNode.setClass(a.currentNode);
                                else if (a.currentNode.name)
                                    currentNode.setDomain(a.currentNode);
                                else if (a.currentNode.id) {
                                    currentNode.setOrionConfig(a.currentNode);
                                    a.isEditing = false;
                                    a.isNew = false;
                                }
                                a.flagSelectAll = false;
                                a.assetList = a.loadChildren(); //TODO
                            },
                        a.classRightClicked = function (event) {
                            a.changeBackground(event);
                        },

                        a.collapseAll = function () {
                            console.log(e);
                        },
                        a.expandAll = function () {

                        }
                ) : g.html($compile(k)(a)))
            }
        }
    }])
})(angular);
