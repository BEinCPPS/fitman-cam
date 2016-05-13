"use strict";
function isEmpty(obj) {
    if (obj === null || obj === undefined || obj == 'undefined' || obj === '' || obj == 'null' || obj.length == 0) {
        return true;
    }
    return false;
}
