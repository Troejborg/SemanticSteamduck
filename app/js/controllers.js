// Generated by CoffeeScript 1.6.3
(function() {
  var app;

  app = angular.module('app', []);

  app.controller('FrontController', function($scope) {
    $scope.hidden = true;
    return $scope.openProject = function() {
      return $scope.hidden = !$scope.hidden;
    };
  });

}).call(this);
