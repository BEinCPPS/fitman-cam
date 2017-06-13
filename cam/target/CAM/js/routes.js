// ROUTES
camApp.config(function ($routeProvider) {
    $routeProvider
        .when('/', {
            templateUrl: 'pages/public.html',
            controller: 'homeController'
        }).when('/classes', {
        templateUrl: 'pages/home.htm',
        controller: 'homeController'
    }).when('/class/:className', {
        templateUrl: 'pages/home.htm',
        controller: 'homeController'
    }).when('/detail/:selectedAssetName/:groupingType/:groupingName', {
        templateUrl: 'pages/detail/assetDetail.htm',
        controller: 'detailController'
    }).when('/domain/:domainName', {
        templateUrl: 'pages/domain.htm',
        controller: 'homeController'
     }).when('/domains', {
        templateUrl: 'pages/domain.htm',
        controller: 'homeController'
    }).when('/orion', {
        templateUrl: 'pages/orionConfig.htm',
        controller: 'orionConfigController'
    }).otherwise({
        redirectTo: '/'
    });
});