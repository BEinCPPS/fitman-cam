/**
 * Created by ascatolo on 18/10/2016.
 */
camApp.factory('ngNotifier', ['toastr', '${authentication.service}', function (toastr, auth) {
    var notifierFactory = {};

    notifierFactory.success = function (msg) {
        if (!msg) msg = "Success!!!";
        toastr.success(msg);
    };
    notifierFactory.error = function (error) {

        if (typeof error === 'object' && error.error)
            error = error.error.message;
        else if (typeof error === 'object' && error.statusText) {
            error = error.data + ' <br/> ' + error.statusText;
        }

        if (typeof error === 'object' && error.message.indexOf('ERROR_NOT_LOGGED') === -1)
//        if (error.message != 'ERROR_NOT_LOGGED: You are not logged in. Please login!' &&
//            error.message != 'ERROR_NOT_LOGGED: User has no token.')
            toastr.error(error.message);
    };
    notifierFactory.info = function (msg) {
        toastr.info(msg);
    };
    return notifierFactory;
}]);
