app = angular.module('app', [])

app.controller 'FrontController', ($scope) ->
  $scope.hidden = true;
  $scope.openProject = () ->
    $scope.hidden = !$scope.hidden
#    TODO: Do some proper handling of showing more project info.
