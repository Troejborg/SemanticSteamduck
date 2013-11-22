// Generated by CoffeeScript 1.6.3
(function() {
  var app;

  app = angular.module('app.controllers', ['firebase']);

  app.controller('MenuController', function($scope, $rootScope) {
    return $scope.activeView = 'home';
  });

  app.controller('HomeController', function($scope, $rootScope) {
    $rootScope.activeView = "home";
    $scope.piImage = "/app/img/rpi_logo.jpg";
    $scope.ircImage = "/app/img/robot_icon.png";
    return $scope.siteImage = "/app/img/angularjs.png";
  });

  app.controller('RankController', function($scope, $rootScope, angularFire) {
    var ref;
    $rootScope.activeView = "rank";
    $scope.players = new Array();
    ref = new Firebase("https://steamduck.firebaseio.com/players");
    return angularFire(ref, $scope, 'players');
  });

  app.controller('FifaController', function($scope, $rootScope, angularFire) {
    var ref;
    $rootScope.activeView = "fifa";
    $scope.newMatch;
    $scope.players = [];
    $scope.matches = [];
    ref = new Firebase("https://steamduck.firebaseio.com/fifa");
    angularFire(ref.child("players"), $scope, 'players');
    angularFire(ref.child("matches"), $scope, 'matches');
    $scope.openModal = function() {
      return $(".modal").modal('show');
    };
    return $scope.submit = function() {
      var addNewPlayer, addPlayerStats, awayPlayerFound, goalStatus, homePlayerFound;
      goalStatus = $scope.home.goals - $scope.away.goals;
      $scope.home.draw = 0;
      $scope.away.draw = 0;
      $scope.home.win = 0;
      $scope.away.win = 0;
      $scope.home.loss = 0;
      $$scope.away.loss = 0;
      $scope.away.goalsAgainst = parseInt($scope.home.goals);
      $scope.home.goalsAgainst = parseInt($scope.away.goals);
      if (goalStatus === 0) {
        $scope.home.draw = $scope.away.draw = 1;
      } else if (goalStatus > 0) {
        $scope.home.win = 1;
      } else if (goalStatus < 0) {
        $scope.away.win = 1;
      }
      $scope.matches.push({
        "hometeam": $scope.home,
        "awayteam": $scope.away,
        "timestamp": new Date().getTime()
      });
      homePlayerFound = false;
      awayPlayerFound = false;
      $scope.players.forEach(function(player) {
        if (player.PlayerName === $scope.home.name) {
          homePlayerFound = true;
          return addPlayerStats(player, $scope.home);
        } else if (player.PlayerName === $scope.away.name) {
          awayPlayerFound = true;
          return addPlayerStats(player, $scope.away);
        }
      });
      if (!homePlayerFound) {
        addNewPlayer($scope.home);
      }
      if (!awayPlayerFound) {
        addNewPlayer($scope.away);
      }
      addPlayerStats = function(player, playerStats) {
        player.Draw += playerStats.draw;
        player.Wins += playerStats.win;
        player.Loss += playerStats.loss;
        player.GoalsFor += playerStats.goals;
        return player.GoalsAgainst += playerStats.goalsAgainst;
      };
      addNewPlayer = function(playerStats) {
        var player;
        player = {
          "PlayerName": playerStats.name,
          "Draw": playerStats.draw,
          "Wins": playerStats.win,
          "Loss": playerStats.loss,
          "GoalsFor": playerStats.goals,
          "GoalsAgainst": playerStats.goalsAgainst
        };
        return $scope.players.push(player);
      };
      $(".modal").modal('hide');
      $scope.home = {};
      return $scope.away = {};
    };
  });

}).call(this);
