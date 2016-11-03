// camApp.controller('newDomainController', [
//     '$scope',
//     'Scopes',
//     '$q',
//     'ngDialog',
//     '$route',
//     'entityManager',
//     'ngNotifier',
//     function ($scope, Scopes, $q, $ngDialog, $route, entityManager, ngNotifier) {
//         Scopes.store('newDomainController', $scope);
//         $scope.panelTitle = "Add Domain";
//
//         $scope.regexPattern = Scopes.get('homeController').regexPattern;
//         $scope.invalidNameMsg = Scopes.get('homeController').invalidNameMsg;
//         $scope.nameIsMandatory = Scopes.get('homeController').nameIsMandatory;
//
//         $scope.$watch('domain.name', function () {
//             if (!isEmpty($scope.domain.name)) {
//                 $scope.invalidName = false;
//             }
//         });
//
//         $scope.closePanel = function () {
//             $scope.attributeName = null;
//             $ngDialog.close();
//         };
//
//         $scope.domain = {
//             name: null,
//         };
//
//         $scope.saveNewDomain = function () {
//             entityManager.createOwner($scope.domain)
//                 .success(function (data, status) {
//                     $ngDialog.close();
//                     entityManager.getOwners()
//                         .then(function () {
//                             $route.reload();
//                         }, function (error) {
//                             console.log(error);
//                         });
//                 }).error(function (err) {
//                 $ngDialog.close();
//                 ngNotifier.error(err);
//             });
//         };
//
//         $scope.openConfirmPanel = function () {
//             if (isEmpty($scope.domain.name)) {
//                 $scope.invalidName = true;
//                 return;
//             }
//             $scope.typeToAdd = 'domain';
//             $ngDialog.open({
//                 template: 'pages/confirmNewDomain.htm',
//                 controller: 'confirmNewOperationController',
//                 scope: $scope
//             });
//         };
//         $scope.domainsList = Scopes.get('domainController').domainsList;
//
//     }]);
