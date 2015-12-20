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
    'ngTouch',
    'ui.map'
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
      .when '/create',
        template: '<create></create>'
      .when '/event/:id?',
        template: '<event-detail></event-detail>'
      .otherwise
        redirectTo: '/'

    return
