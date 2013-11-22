app = angular.module('app.controllers', ['firebase'])

app.controller 'HomeController', ($scope) ->
  $scope.piImage = "/app/img/rpi_logo.jpg"
  $scope.ircImage = "/app/img/robot_icon.png"
  $scope.siteImage = "/app/img/angularjs.png"

app.controller 'RankController', ($scope, angularFire) ->
  $scope.players = new Array()
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
    homePlayer = {}
    awayPlayer = {}
    newHomePlayer = {}
    newAwayPlayer = {}
    homePlayer.goalsFor = parseInt($scope.home.goals)
    homePlayer.goalsAgainst = parseInt($scope.away.goals)
    awayPlayer.goalsFor = parseInt($scope.away.goals)
    awayPlayer.goalsAgainst = parseInt($scope.home.goals)
    goalStatus = $scope.home.goals - $scope.away.goals
    homePlayerFound  = false
    awayPlayerFound  = false
    $scope.players.forEach (player) ->
      #find home player
      if player.PlayerName == $scope.home.name
        homePlayerFound  = true
        player.Draw += if goalStatus == 0 then 1 else 0
        player.Wins += if goalStatus > 0 then 1 else 0
        player.Loss += if goalStatus < 0 then 1 else 0
        player.goalsFor += homePlayer.goalsFor
        player.goalsAgainst += homePlayer.goalsAgainst
      else if player.PlayerName == $scope.away.name
        awayPlayerFound  = true
        player.Draw += if goalStatus == 0 then 1 else 0
        player.Wins += if goalStatus < 0 then 1 else 0
        player.Loss += if goalStatus > 0 then 1 else 0
        player.goalsFor += awayPlayer.goalsFor
        player.goalsAgainst += awayPlayer.goalsAgainst

    unless awayPlayerFound
      newAwayPlayer.PlayerName = $scope.away.name
      newAwayPlayer.Wins = if goalStatus < 0 then 1 else 0
      newAwayPlayer.Loss = if goalStatus > 0 then 1 else 0
      newAwayPlayer.Draw = if goalStatus == 0 then 1 else 0
      newAwayPlayer.goalsFor = awayPlayer.goalsFor
      newAwayPlayer.goalsAgainst = awayPlayer.goalsAgainst
      $scope.players.push(newAwayPlayer)
    unless homePlayerFound
      newHomePlayer.PlayerName = $scope.home.name
      newHomePlayer.Wins = if goalStatus > 0 then 1 else 0
      newHomePlayer.Loss = if goalStatus < 0 then 1 else 0
      newHomePlayer.Draw = if goalStatus == 0 then 1 else 0
      newHomePlayer.goalsFor += homePlayer.goalsFor
      newHomePlayer.goalsAgainst += homePlayer.goalsAgainst
      $scope.players.push(newHomePlayer)
#    $scope.home.goals = parseInt($scope.home.goals)
#    $scope.away.goals = parseInt($scope.away.goals)
#    goalStatus = $scope.home.goals - $scope.away.goals
#
#    $scope.home.goalsAgainst = $scope.away.goals
#    $scope.away.goalsAgainst = $scope.home.goals
#    newPlayer = {}
#
#    addPlayerStats = (player, newMatch, didWin) ->
#      if player.GoalsFor? then player.GoalsFor += newMatch.goals else player.GoalsFor = newMatch.goals
#      if player.GoalsAgainst? then player.GoalsAgainst += newMatch.goalsAgainst else player.GoalsAgainst = newMatch.goalsAgainst
#
#    playerFound = false
#    $scope.players.forEach (player) ->
#      if player.PlayerName == $scope.home.name
#        addPlayerStats(player, $scope.home, winner)
#        playerFound  = true
#    unless playerFound
#      newPlayer.PlayerName = $scope.home.name
#      addPlayerStats(newPlayer, $scope.home, winner)
#      $scope.players.push(newPlayer)
#
#    playerFound = false
#    $scope.players.forEach (player) ->
#      if player.PlayerName == $scope.away.name
#        addPlayerStats(player, $scope.away, winner)
#        playerFound = true
#    unless playerFound
#      newPlayer.PlayerName = $scope.away.name
#      addPlayerStats(newPlayer, $scope.away, !didHomeWin)
#      $scope.players.push(newPlayer)

    $(".modal").modal('hide')
    $scope.home = {}
    $scope.away = {}