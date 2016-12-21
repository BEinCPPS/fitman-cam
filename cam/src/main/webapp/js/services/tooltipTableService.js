/**
 * Created by ascatox on 21/12/16.
 */
camApp.factory('tooltipTable', function () {

    var tooltipTable = {};
    tooltipTable.addTooltipToAssetModel = function () {
        function addTooltip(htmlObj, maxLenght) {
            var valueOrig = htmlObj.text();
            var value = htmlObj.text();
            htmlObj.attr('data-toggle', 'tooltip');
            htmlObj.attr('data-container', 'body');
            htmlObj.attr('title', value);
            if (value && value.length > maxLenght) {
                value = value.substring(0, maxLenght).concat('...');
                htmlObj.text(value);
            }
        }

        var tableAssetElems = angular.element('tr.ng-scope');
        angular.forEach(tableAssetElems, function (value, key) {
            var children = angular.element(value).children();
            addTooltip(angular.element(children[1]), 25); //asset
            addTooltip(angular.element(children[2]), 25); //class
            //addTooltip(angular.element(children[3]), 20); //domain //TODO
        });
        $('[data-toggle="tooltip"]').tooltip();
    }

    return tooltipTable;

});
