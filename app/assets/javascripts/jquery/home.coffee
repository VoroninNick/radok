#
#$(document).on "appear", "#home-statistics", ()->
#  alert("appear")
#  $scope = angular.element("[ng-controller=HomeController]").scope()
#  if !$scope.statistics_counter_initialized
#    $scope.$apply( ()->
#      $scope.statistics_counter_initialized = true
#      $scope.statistics.tested_projects_count = 143
#      $scope.statistics.testers_count = 1981
#    )
#
#$(document.body).on "appear", "#home-statistics", ()->
#  alert("appear body")
#
#
#
##$(window).on "scroll", ()->
##  appeared = $("#home-statistics").is(":appeared")
##  alert("appeared: #{appeared}")