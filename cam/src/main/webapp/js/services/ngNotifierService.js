/**
 * Created by ascatolo on 18/10/2016.
 */
camApp.factory('ngNotifier', function (toaster) {
    var notifierFactory = {};

    notifierFactory.success = function (msg) {
        if (!msg) msg = "Success!!!";
        toaster.success(msg);
    };
    notifierFactory.error = function (error) {
        console.log(error);
        if (typeof error === 'object' && error.error)
            error = error.error.message;
        else if (typeof error === 'object' && error.statusText) {
            error = error.data + ' <br/> ' + error.statusText;
        }
        toaster.error(error);
    };
    notifierFactory.info = function (msg) {
        toaster.info(msg);
    };
    return notifierFactory;
});
