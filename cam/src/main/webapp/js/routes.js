// ROUTES
camApp.config(function ($routeProvider) {
   
    $routeProvider
    
    .when('/', {
        templateUrl: 'pages/home.htm',
        controller: 'homeController'
    }).when('/:assetName', {
        templateUrl: 'pages/home.htm',
        controller: 'homeController'
    }).when('/detail/:selectedAssetName', {
        templateUrl: 'pages/assetDetail.htm',
        controller: 'detailController'
    })
    

});