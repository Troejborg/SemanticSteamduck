app = angular.module('app.controllers', ['firebase'])

app.controller 'MenuController', ($scope) ->
  $scope.activeView = 'home'


app.controller 'HomeController', ($scope) ->
  $scope.piImage = "/app/img/rpi_logo.jpg"
  $scope.ircImage = "/app/img/robot_icon.png"
  $scope.siteImage = "/app/img/angularjs.png"

app.controller 'RankController', ($scope, angularFire) ->
  $scope.players = new Array()
  ref = new Firebase("https://steamduck.firebaseio.com/players")
  angularFire(ref, $scope, 'players')

app.controller 'FifaController', ($scope, angularFire) ->
  $scope.players = new Array()
  $scope.matches = new Array()
  ref = new Firebase("https://steamduck.firebaseio.com/fifa")
  angularFire(ref.child("players"),$scope,'players')
  angularFire(ref.child("matches"),$scope,'matches')

  $scope.openModal = () ->
    $(".modal").modal('show')
  $scope.submit = () ->
    goalStatus = $scope.home.goals - $scope.away.goals
    # EVERYTHING IS ZERO
    $scope.home.draw = $scope.away.draw = $scope.home.win = $scope.away.win = $scope.home.loss = $scope.away.loss = 0
    $scope.home.goals = parseInt($scope.home.goals)
    $scope.away.goals = parseInt($scope.away.goals)
    $scope.away.goalsAgainst = $scope.home.goals
    $scope.home.goalsAgainst = $scope.away.goals
    if goalStatus == 0
      $scope.home.draw = $scope.away.draw = 1
    else if goalStatus > 0
      $scope.home.win =  $scope.away.loss = 1
    else if goalStatus < 0
      $scope.away.win = $scope.home.loss = 1

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