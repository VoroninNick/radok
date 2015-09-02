app = angular.module("radok", [])
app.controller "WizardController", [
  "$scope", ($scope)->
    $scope.wizard = {}
    $scope.master = {}
    $scope.user = {}
    $scope.title = "Hello world"
    $scope.update = (user)->
      $scope.master = angular.copy(user)

    #$scope.jQuery = jQuery
    $scope.configure = ()->
      $('.configuration-steps .wizard-step:first').go_to_this_step()
      $scope.wizard.configure_mode = true
      $scope.wizard.show_mini_summary = true

    $scope.next_question = ()->
      $('.next-question-button').removeClass("visible").addClass('hide')
      $question = $('.wizard-step').first().find(".question").eq(1)
      question_top = $question.offset().top
      top_to_animate = question_top - $('#header').height() - 48
      $('#body').animate({scrollTop: top_to_animate})


    $scope.reset = ()->
      $scope.user = angular.copy($scope.master)
]