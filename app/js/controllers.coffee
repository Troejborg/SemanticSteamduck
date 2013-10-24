app = angular.module('app.controllers', [])

app.controller 'HomeController', ($scope) ->
  hidden = true;
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
    target = e.currentTarget
    animate()
    if $(target).hasClass "rpi"
      $scope.moretext = "Node.js? Check. Pre-loaded with ssh, Git and java? Check. Low consumption? Double check!"
      $scope.moreimage = $scope.piImage
    else if $(target).hasClass "irc"
      $scope.moretext = "Just a hastily thrown together irc bot that responds to very basic commands. It does have an (almost) functional rpg brawl game though so there's that..."
      $scope.moreimage = $scope.ircImage
    else if $(target).hasClass "mysite"
      $scope.moretext = "My own private workbench where I can rejoice in the wonders of AngularJS and Semantic UI."
      $scope.moreimage = $scope.siteImage

  animate = () ->
    if !hidden
      moreElement
      .css({ transformOrigin: 'center top' })
      .transition(
          perspective: '300px',
          rotateX: '-90deg',
        )
    else
      moreElement.transition(
        perspective: '300px',
        rotateX: '0deg',
      )
    hidden = !hidden

app.controller 'TweetController', ($scope) ->
  $scope.twitter = "TWEET FEED"