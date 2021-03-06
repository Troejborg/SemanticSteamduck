// Generated by CoffeeScript 1.6.3
(function() {
  var app;

  app = angular.module('app.controllers', ['firebase']);

  app.controller('MenuController', function($scope) {
    return $scope.activeView = 'home';
  });

  app.controller('HomeController', function($scope) {
    $scope.piImage = "/app/img/rpi_logo.jpg";
    $scope.ircImage = "/app/img/robot_icon.png";
    return $scope.siteImage = "/app/img/angularjs.png";
  });

  app.controller('RankController', function($scope, angularFire) {
    var ref;
    $scope.players = new Array();
    ref = new Firebase("https://steamduck.firebaseio.com/players");
    return angularFire(ref, $scope, 'players');
  });

  app.controller('FifaController', function($scope, angularFire) {
    var addNewPlayer, addPlayerStats, ref;
    $scope.players = [];
    $scope.matches = [];
    ref = new Firebase("https://steamduck.firebaseio.com/fifa");
    angularFire(ref.child("players"), $scope, 'players');
    angularFire(ref.child("matches"), $scope, 'matches');
    $scope.$watch('matches', function(newVal, oldVal) {
      if (!Array.isArray(newVal)) {
        return $scope.matches([]);
      }
    });
    $scope.openModal = function() {
      return $(".modal").modal('show');
    };
    $scope.submit = function() {
      var awayPlayerFound, goalStatus, homePlayerFound;
      goalStatus = $scope.home.goals - $scope.away.goals;
      $scope.home.draw = $scope.away.draw = $scope.home.win = $scope.away.win = $scope.home.loss = $scope.away.loss = 0;
      $scope.home.goals = parseInt($scope.home.goals);
      $scope.away.goals = parseInt($scope.away.goals);
      $scope.away.goalsAgainst = $scope.home.goals;
      $scope.home.goalsAgainst = $scope.away.goals;
      if (goalStatus === 0) {
        $scope.home.draw = $scope.away.draw = 1;
      } else if (goalStatus > 0) {
        $scope.home.win = $scope.away.loss = 1;
      } else if (goalStatus < 0) {
        $scope.away.win = $scope.home.loss = 1;
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
      $(".modal").modal('hide');
      $scope.home = {};
      return $scope.away = {};
    };
    addPlayerStats = function(player, playerStats) {
      player.Draw += playerStats.draw;
      player.Wins += playerStats.win;
      player.Losses += playerStats.loss;
      player.GoalsFor += playerStats.goals;
      return player.GoalsAgainst += playerStats.goalsAgainst;
    };
    return addNewPlayer = function(playerStats) {
      var player;
      player = {
        "PlayerName": playerStats.name,
        "Draw": playerStats.draw,
        "Wins": playerStats.win,
        "Losses": playerStats.loss,
        "GoalsFor": playerStats.goals,
        "GoalsAgainst": playerStats.goalsAgainst
      };
      return $scope.players.push(player);
    };
  });

}).call(this);
