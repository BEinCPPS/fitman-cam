/**
 * Created by ascatolo on 18/10/2016.
 */
camApp.factory('ngNotifier', ['toastr', '${authentication.service}', function (toastr, auth) {
    var notifierFactory = {};

    notifierFactory.success = function (msg) {
        if (!msg) msg = "Success!!!";
        toastr.success(msg, 'Success');
    };
    notifierFactory.error = function (error) {
        console.log(error);
        if (typeof error === 'object' && error.error)
            error = error.error.message;
        else if (typeof error === 'object' && typeof error.statusText !== 'undefined' &&  error.statusText !== null) {
            error = error.data + ' <br/> ' + error.statusText;
        }
        if (typeof error === 'object' && error.message &&  error.message.indexOf('ERROR_NOT_LOGGED') != -1)
            return;

        toastr.error(error, 'Error');
    };
    notifierFactory.info = function (msg) {
        toastr.info(msg, 'Information');
    };
    notifierFactory.warn = function (msg) {
        toastr.warning(msg, 'Warning');
    };
    return notifierFactory;
}]);
