app = angular.module('app.controllers', ['firebase'])

app.controller 'MenuController', ($scope, $rootScope) ->
  $scope.activeView = 'home'

app.controller 'HomeController', ($scope, $rootScope) ->
  $rootScope.activeView = "home"
  $scope.piImage = "/app/img/rpi_logo.jpg"
  $scope.ircImage = "/app/img/robot_icon.png"
  $scope.siteImage = "/app/img/angularjs.png"

app.controller 'RankController', ($scope, $rootScope, angularFire) ->
  $rootScope.activeView = "rank"
  $scope.players = new Array()
  ref = new Firebase("https://steamduck.firebaseio.com/players")
  angularFire(ref, $scope, 'players')

app.controller 'FifaController', ($scope, $rootScope, angularFire) ->
  $rootScope.activeView = "fifa"
  $scope.newMatch
  $scope.players = []
  $scope.matches = []
  ref = new Firebase("https://steamduck.firebaseio.com/fifa")
  angularFire(ref.child("players"),$scope,'players')
  angularFire(ref.child("matches"),$scope,'matches')

  $scope.openModal = () ->
    $(".modal").modal('show')
  $scope.submit = () ->
    goalStatus = $scope.home.goals - $scope.away.goals
    $scope.home.draw = 0
    $scope.away.draw = 0
    $scope.home.win = 0
    $scope.away.win = 0
    $scope.home.loss = 0
    $$scope.away.loss = 0
    $scope.away.goalsAgainst = parseInt($scope.home.goals)
    $scope.home.goalsAgainst = parseInt($scope.away.goals)
    if goalStatus == 0
      $scope.home.draw = $scope.away.draw = 1
    else if goalStatus > 0
      $scope.home.win = 1
    else if goalStatus < 0
      $scope.away.win = 1

    $scope.matches.push { "hometeam": $scope.home, "awayteam": $scope.away, "timestamp": new Date().getTime() }
    homePlayerFound  = false
    awayPlayerFound  = false
    $scope.players.forEach (player) ->
      if player.PlayerName == $scope.home.name
        homePlayerFound = true;
        addPlayerStats(player, $scope.home)
      else if player.PlayerName == $scope.away.name
        awayPlayerFound = true;
        addPlayerStats(player, $scope.away)

    unless homePlayerFound
      addNewPlayer($scope.home)
    unless awayPlayerFound
      addNewPlayer($scope.away)

    addPlayerStats = (player, playerStats) ->
      player.Draw += playerStats.draw
      player.Wins += playerStats.win
      player.Loss += playerStats.loss
      player.GoalsFor +=  playerStats.goals
      player.GoalsAgainst +=  playerStats.goalsAgainst

    addNewPlayer = (playerStats) ->
      player =
        "PlayerName": playerStats.name,
        "Draw": playerStats.draw,
        "Wins": playerStats.win,
        "Loss": playerStats.loss,
        "GoalsFor": playerStats.goals,
        "GoalsAgainst": playerStats.goalsAgainst

      $scope.players.push player

    $(".modal").modal('hide')
    $scope.home = {}
    $scope.away = {}