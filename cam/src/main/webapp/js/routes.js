// ROUTES
camApp.config(function ($routeProvider) {
   
    $routeProvider
    .when('/', {
        templateUrl: 'pages/home.htm',
        controller: 'homeController'
    }).when('/class/:className', {
        templateUrl: 'pages/home.htm',
        controller: 'homeController'
    }).when('/detail/:selectedAssetName/:className', {
        templateUrl: 'pages/assetDetail.htm',
        controller: 'detailController'
    }).when('/domain', {
        templateUrl: 'pages/domain.htm',
        controller: 'domainController'
    }). otherwise({
        redirectTo: '/'
    });

});