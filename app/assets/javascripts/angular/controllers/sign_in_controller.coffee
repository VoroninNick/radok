window.$app.controller "SignInController", [
  "$scope", "$auth", "ngDialog", ($scope, Auth, ngDialog)->
    $scope.credentials = {
      email: ""
      password: ""
    }

    $scope._show_password = false

    $scope.showPassword = ()->
      $scope._show_password = true

    $scope.hidePassword = ()->
      $scope._show_password = false

    $scope.passwordShowed = ()->
      return $scope._show_password

    $scope.passwordInputType = ()->
      if $scope._show_password
        return "text"
      else
        return "password"

    $scope.openForgotPasswordPopup = ()->
      $scope.closeThisDialog()
      ngDialog.open({
        template: '/assets/popups/forgot_password.html'
        className: 'ngdialog-theme-default ngdialog-theme-rf-light-gray'
        controller: "ForgotPasswordController"
      });
    $scope.openSignUpPopup = ()->
      ngDialog.open({
        template: '/assets/popups/sign_up.html'
        className: 'ngdialog-theme-default ngdialog-theme-rf-light-gray'
        controller: "SignUpController"
      });

    $scope.authenticate_via_social = (provider)->
      Auth.authenticate(provider)

    $scope.doSignIn = ()->
#      Auth.login($scope.credentials).then(
#        (loggedUser)->
#          result = {signed_in: true}
#          $scope.closeThisDialog(result)
#      )

      Auth.submitLogin($scope.credentials).then(
        (response)->
          result = {signed_in: true}
          $scope.closeThisDialog(result)
      ).catch(
        (response)->

      )

    $scope.closeSelf = ()->
      $scope.closeThisDialog()
]