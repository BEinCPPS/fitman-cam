(function (l) {
    l.module("angularTreeview", []).directive("treeModel", function ($compile) {
        return {
            restrict: "A",
            link: function (a, g, c) {
                var e = c.treeModel
                    , h = c.nodeLabel || "label"
                    , d = c.nodeChildren || "children"
                    , l = String(c.rightClickEnabled) == "true"? true :false
                    , m = l ? 'ng-right-click="classRightClicked($event)"':  ''
                    , n = l ? 'data-context-menu="pages/ctxtMenu.htm"' :''
                    , o = c.iconClassName || ''
                    , k = '<ul id="home-tree-nodes">' +
                    '<li data-ng-repeat="node in ' + e + '">' +
                    '<i class="collapsed '+o+'" data-ng-show="node.' + d + '.length && node.collapsed"' +
                         ' data-ng-click="selectNodeHead(node, $event)"></i>' +
                    '<i class="expanded '+o+'" data-ng-show="node.' + d + '.length && !node.collapsed" ' +
                        'data-ng-click="selectNodeHead(node, $event)">' +
                    '</i>' +
                    '<i class="normal '+o+'" data-ng-hide="node.' +
                    d + '.length"></i>' +
                    ' <span '+m+'" ' +
                    'data-ng-class="node.selected" data-ng-click="selectNodeLabel(node, $event)" ' +
                     n+' ng-model="node">{{node.' + h + '}}</span>' +
                    '<div data-ng-hide="node.collapsed" data-tree-model="node.' + d +
                    '" data-node-id=' + (c.nodeId || "id") + " " +
                    "data-node-label=" + h + " data-node-children=" + d + ">" +
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
    })
})(angular);



// camApp.directive('angularTreeview', ['$compile', 'templateManager', function ($compile, templateManager) {
//     return {
//         restrict: 'A',
//         link: function (scope, element, attrs) {
//             //tree id
//             var treeId = attrs.treeId;
//
//             //tree model
//             var treeModel = attrs.treeModel;
//
//             //node id
//             var nodeId = attrs.nodeId || 'id';
//
//             //node label
//             var nodeLabel = attrs.nodeLabel || 'label';
//
//             //children
//             var nodeChildren = attrs.nodeChildren || 'children';
//
//             //ascatox
//             var ngRightClickTemplate = attrs.ngRightClickTemplate || 'pages/ctxtMenu.htm';
//
//             //tree template
//             var template =
//                 '<ul>' +
//                 '<li data-ng-repeat="node in ' + treeModel + '">' +
//                 '<i class="collapsed" data-ng-show="node.' + nodeChildren + '.length && node.collapsed" data-ng-click="'
//                 + treeId + '.selectNodeHead(node)"></i>' +
//                 '<i class="expanded" data-ng-show="node.' + nodeChildren + '.length && !node.collapsed" data-ng-click="'
//                 + treeId + '.selectNodeHead(node)"></i>' +
//                 '<i class="normal" data-ng-hide="node.' + nodeChildren + '.length"></i> ' +
//                 '<span ng-right-click="classRightClicked($event)" data-context-menu="'
//                 + ngRightClickTemplate + '" data-ng-class="node.selected" data-ng-click="'
//                 + treeId + '.selectNodeLabel(node)">{{node.' + nodeLabel + '}}</span>' +
//                 '<div data-ng-hide="node.collapsed" data-tree-id="' + treeId
//                 + '" data-tree-model="node.' + nodeChildren + '" data-node-id='
//                 + nodeId + ' data-node-label=' + nodeLabel + ' data-node-children=' + nodeChildren + '></div>' +
//                 '</li>' +
//                 '</ul>';
//             //check tree id, tree model
//             if (treeId && treeModel) {
//
//                 //root node
//                 if (attrs.angularTreeview) {
//
//                     //create tree object if not exists
//                     scope[treeId] = scope[treeId] || {};
//
//                     //if node head clicks,
//                     scope[treeId].selectNodeHead = scope[treeId].selectNodeHead || function (selectedNode) {
//
//                             //Collapse or Expand
//                             selectedNode.collapsed = !selectedNode.collapsed;
//                         };
//
//                     //if node label clicks,
//                     scope[treeId].selectNodeLabel = scope[treeId].selectNodeLabel || function (selectedNode) {
//
//                             //remove highlight from previous node
//                             if (scope[treeId].currentNode && scope[treeId].currentNode.selected) {
//                                 scope[treeId].currentNode.selected = undefined;
//                             }
//
//                             //set highlight to selected node
//                             selectedNode.selected = 'selected';
//
//                             //set currentNode
//                             scope[treeId].currentNode = selectedNode;
//                             //ascatox
//                             scope.currentNode = selectedNode;
//                             scope.assetList = scope.loadChildren();
//                         };
//                 }
//                 //Rendering template.
//                 element.html('').append($compile(template)(scope));
//             }
//         }
//     };
//  }]);
