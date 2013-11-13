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
    var ref;
    $scope.players;
    ref = new Firebase("https://steamduck.firebaseio.com/players");
    return angularFire(ref, $scope, 'players');
  });

  app.controller('FifaController', function($scope, angularFire) {
    var ref;
    $scope.newMatch;
    $scope.matches = new Array();
    ref = new Firebase("https://steamduck.firebaseio.com/fifamatches");
    angularFire(ref, $scope, 'matches');
    $scope.openModal = function() {
      return $('.modal').popup();
    };
    return $scope.submit = function() {
      return ref.push($scope.newMatch);
    };
  });

}).call(this);
