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
  $scope.matches = new Array()
  ref = new Firebase("https://steamduck.firebaseio.com/fifamatches")
  angularFire(ref,$scope,'matches')

  $scope.openModal = () ->
    $(".modal").modal('show')
  $scope.submit = () ->
    ref.push($scope.newMatch)