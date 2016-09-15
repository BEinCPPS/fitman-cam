"use strict";

function isEmpty(obj) {
    if (obj === null || obj === undefined || obj == 'undefined' || obj === '' || obj == 'null' || obj.length == 0) {
        return true;
    }
    return false;
}

function getCurrentDate() {
    var currentDate = new Date()
    var day = currentDate.getDate()
    if (day < 10)
        day = '0' + day;
    var month = currentDate.getMonth() + 1
    if (month < 10)
        month = '0' + month;
    var year = currentDate.getFullYear()
    return year + '-' + month + "-" + day;
}

var Routes = {
    HOME: "/",
    HOME_ASSET: "/:assetName",
    DETAIL: "/:selectedAssetName"
}
