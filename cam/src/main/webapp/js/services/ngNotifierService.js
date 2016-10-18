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
        if(typeof error === 'object' && error.error)
            error = error.error.message;
        toaster.error(error);
    };
    notifierFactory.info = function (msg) {
        toaster.info(msg);
    };
    return notifierFactory;
});
