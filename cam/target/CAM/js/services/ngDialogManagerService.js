/**
 * Created by ascatox on 23/11/16.
 */
camApp.factory('ngDialogManager', ['ngDialog', 'Auth', function ($ngDialog, auth) {

    var ngDialogManager = {};

    ngDialogManager.open = function (dialog) {
        if (auth.isLoggedIn())
            $ngDialog.open(dialog);
    };

    ngDialogManager.close = function () {
        $ngDialog.close();
    };

    ngDialogManager.closeAll = function () {
        $ngDialog.closeAll();
    };

    ngDialogManager.getNgDialog = function () {
        return $ngDialog;
    };
    return ngDialogManager;
}]);

