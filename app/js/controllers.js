// Generated by CoffeeScript 1.6.3
(function() {
  var app;

  app = angular.module('app.controllers', ['firebase']);

  app.controller('HomeController', function($scope) {
    var moreElement;
    $scope.piImage = "/app/img/rpi_logo.jpg";
    $scope.ircImage = "/app/img/robot_icon.png";
    $scope.siteImage = "/app/img/angularjs.png";
    moreElement = $(".more");
    moreElement.css({
      transformOrigin: 'center top',
      perspective: '300px',
      rotateX: '-90deg'
    });
    return $scope.openProject = function(e) {
      return console.log("clicked" + e);
    };
  });

  app.controller('RankController', function($scope, angularFire) {
    return $scope.init = function(value) {
      var ref;
      $scope.value = "";
      ref = new Firebase("https://steamduck.firebaseio.com/");
      return angularFire(ref, $scope, 'value');
    };
  });

}).call(this);
