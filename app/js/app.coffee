#Declare app level module which depends on filters, and services
angular.module('app', ['ngRoute','app.controllers']).
config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/home', {templateUrl: 'app/partials/home.html', controller: 'HomeController'})
  $routeProvider.when('/twitter', {templateUrl: 'app/partials/irc_rankings.html', controller: 'TweetController'})
  $routeProvider.otherwise({redirectTo: '/view1'})
])