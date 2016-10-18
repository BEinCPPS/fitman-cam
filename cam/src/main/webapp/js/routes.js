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
    }).when('/login', {
        templateUrl: 'pages/login.html',
        controller: 'menuController'
    }). otherwise({
        redirectTo: '/'
    });
});