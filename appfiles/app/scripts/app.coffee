'use strict'

###*
 # @ngdoc overview
 # @name downespace
 # @description
 # # downespace
 #
 # Main module of the application.
###
angular
  .module 'downespace', [
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
      return
    return
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
      .when '/create',
        templateUrl: 'views/create.html'
        controller: 'createEventController'
        controllerAs: 'createEvent'
      .otherwise
        redirectTo: '/'

    return
