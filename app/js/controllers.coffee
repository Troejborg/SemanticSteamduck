app = angular.module('app.controllers', ['firebase'])

app.controller 'HomeController', ($scope) ->
  $scope.piImage = "/app/img/rpi_logo.jpg"
  $scope.ircImage = "/app/img/robot_icon.png"
  $scope.siteImage = "/app/img/angularjs.png"

app.controller 'RankController', ($scope, angularFire) ->
  $scope.players
  ref = new Firebase("https://steamduck.firebaseio.com/players")
  angularFire(ref, $scope, 'players')

app.controller 'FifaController', ($scope, angularFire) ->
  $scope.newMatch
  $scope.players = new Array()
  ref = new Firebase("https://steamduck.firebaseio.com/fifa")
  angularFire(ref.child("players"),$scope,'players')

  $scope.openModal = () ->
    $(".modal").modal('show')
  $scope.submit = () ->
    $scope.home.goals = parseInt($scope.home.goals)
    $scope.away.goals = parseInt($scope.away.goals)
    didHomeWin = if $scope.home.goals - $scope.away.goals > 0 then true else false
    $scope.home.goalsAgainst = $scope.away.goals
    $scope.away.goalsAgainst = $scope.home.goals

    addPlayerStats = (player, newMatch, didWin) ->
      if player.GoalsFor? then player.GoalsFor += newMatch.goals else player.GoalsFor = newMatch.goals
      if player.GoalsAgainst? then player.GoalsAgainst += newMatch.goalsAgainst else player.GoalsAgainst = newMatch.goalsAgainst
      if didWin
        if player.Wins? then player.Wins += 1 else player.Wins = 1
        if player.Points? then player.Points += 3 else player.Points = 3
      else
        if player.Losses? then player.Losses +=1 else player.Losses = 1
    playerFound = false
    $scope.players.forEach (player) ->

      if player.PlayerName == $scope.home.name
        addPlayerStats(player, $scope.home, didHomeWin)
        playerFound  = true
    unless playerFound
      newPlayer = {}
      newPlayer.PlayerName = $scope.home.name
      addPlayerStats(newPlayer, $scope.home, didHomeWin)
      $scope.players.push(newPlayer)

    playerFound = false
    $scope.players.forEach (player) ->
      if player.PlayerName == $scope.away.name
        addPlayerStats(player, $scope.away, !didHomeWin)
        playerFound = true
    unless playerFound
      newPlayer = {}
      newPlayer.PlayerName = $scope.away.name
      addPlayerStats(newPlayer, $scope.away, !didHomeWin)
      $scope.players.push(newPlayer)
    $(".modal").modal('hide')
    $scope.newMatch = []
    playerFound = false