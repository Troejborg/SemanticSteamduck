#Declare app level module which depends on filters, and services
angular.module('app', ['ngRoute', 'app.controllers']).
config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/home', {templateUrl: 'app/partials/home.html', controller: 'HomeController'})
  $routeProvider.when('/ircranks', {templateUrl: 'app/partials/irc_rankings.html', controller: 'RankController'})
  $routeProvider.otherwise({redirectTo: '/home'})
])