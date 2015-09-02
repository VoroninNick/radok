window.$app.controller "ForgotPasswordController", [
  "$scope", "$auth", "ngDialog", "$http", ($scope, Auth, ngDialog, $http)->
    $scope.credentials = {
      email: ""
    }


    $scope.sendPasswordReset = ()->
      $scope.submit
        method: 'POST',
        url: '/users/password.json',
        data: $scope.credentials
        #success_message: "Reset instructions have been sent to your e-mail address."
        #error_entity: $scope.login_error

    ###
    $scope.sendPasswordReset = ()->
      $scope.submit
        method: 'POST',
        url: '/users/password.json',
        data: $scope.credentials
        #success_message: "Reset instructions have been sent to your e-mail address."
        #error_entity: $scope.login_error




    $scope.login_user = {email: null, password: null}
    $scope.login_error = {message: null, errors: {}}



    $scope.submit = (parameters) ->
        $scope.reset_messages()
        $http(
          method: parameters.method
          url: parameters.url
          data: parameters.data).success((data, status)->
            if status == 201 or status == 204
              parameters.error_entity.message = parameters.success_message
              $scope.reset_users()
            else
              if data.error
                parameters.error_entity.message = data.error
              else
        # note that JSON.stringify is not supported in some older browsers, we're ignoring that
                parameters.error_entity.message = 'Success, but with an unexpected success code, potentially a server error, please report via support channels as this indicates a code defect.  Server response was: ' + JSON.stringify(data)

        ).error (data, status)->
          if status == 422
            parameters.error_entity.errors = data.errors
          else
            if data.error
              parameters.error_entity.message = data.error
            else
        # note that JSON.stringify is not supported in some older browsers, we're ignoring that
              parameters.error_entity.message = 'Unexplained error, potentially a server error, please report via support channels as this indicates a code defect.  Server response was: ' + JSON.stringify(data)

      $scope.reset_messages = ()->
        $scope.login_error.message = null;
        $scope.login_error.errors = {}
    ###

    $scope.openSignInDialog = ()->
      $scope.closeThisDialog()
      $scope.openForgotPasswordPopup = ()->
      ngDialog.open({
        template: '/assets/popups/sign_in.html'
        className: 'ngdialog-theme-default ngdialog-theme-rf-light-gray'
        controller: "SignInController"
      });
]