'use strict'

###*
 # @ngdoc overview
 # @name appfilesApp
 # @description
 # # appfilesApp
 #
 # Main module of the application.
###
angular
  .module 'appfilesApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch'
  ]
  .run ($rootScope, Auth) ->
    Auth.getUser().then (data) ->
      $rootScope.currentUser = data
  .config ($routeProvider, $httpProvider) ->
    $httpProvider.defaults.xsrfHeaderName = 'X-CSRFToken'
    $httpProvider.defaults.xsrfCookieName = 'csrftoken'

    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'
      .otherwise
        redirectTo: '/'

