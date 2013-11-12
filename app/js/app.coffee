#Declare app level module which depends on filters, and services
angular.module('app', ['ngRoute', 'app.filters', 'app.controllers']).
config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/home', {templateUrl: 'app/partials/home.html', controller: 'HomeController'})
  $routeProvider.when('/ircranks', {templateUrl: 'app/partials/irc_rankings.html', controller: 'RankController'})
  $routeProvider.when('/anders', {templateUrl: 'app/partials/anders.html', controller: 'FifaController'})
  $routeProvider.otherwise({redirectTo: '/home'})
])