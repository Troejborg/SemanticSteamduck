app = angular.module('app.controllers', ['firebase'])

app.controller 'HomeController', ($scope) ->
  $scope.piImage = "/app/img/rpi_logo.jpg"
  $scope.ircImage = "/app/img/robot_icon.png"
  $scope.siteImage = "/app/img/angularjs.png"
  moreElement = $(".more")
  moreElement.css(
    transformOrigin: 'center top',
    perspective: '300px',
    rotateX: '-90deg'
  )
  $scope.openProject = (e) ->
    console.log "clicked" + e

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