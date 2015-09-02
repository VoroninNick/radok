window.$app.controller "ProfileController", [
  "$rootScope", "$scope", "$http", "$auth", "$state", "Upload", ($rootScope, $scope, $http, $auth, $state, Upload)->

    $scope.active_tab_index = 0


    $scope.personal_data = {
      username: ""
      full_name: ""
      phone: ""
      email: ""
      country: ""
      city: ""
      zip_code: null
      billing_address: ""
    }

    $scope.password_change = {
      old_password: ""
      password: ""
      password_confirmation: ""
    }





    console.log "profile: ", $auth.data

    $scope.destroy_account = ()->
      promise = $auth.destroyAccount()
      promise.then ()->
        alert("destroyed account successfully")
        $state.go("home")

    $scope.confirm_destroy_account = ()->
      destroy = confirm("You're going to delete your account. This action never can be canceled. Destroy account and related data?")
      if destroy
        $scope.destroy_account()

    $scope.image_options = {
      selection: [0, 0, 120, 120, 120, 120]
    }

    $rootScope.$on "auth:validation-success auth:login-success", (e)->
      console.log "type: " + e.type



    $scope.user = $auth
    promise = $auth.validateUser()

    init_user = (user)->
      console.log("user")
      $scope.user = user
      #$scope.personal_data = user

      #$scope.personal_data.$setPristine()
      #$scope.$apply ()->
      angular.merge($scope.personal_data, user)

      ###
      for property_key, property_value of $scope.personal_data
        $scope.$watch property_key, (newValue, oldValue)->
          #$scope.pushPropertyToServer(property_key, newValue)
          if $scope.controller_initialized
            console.log "updateAccount"
            $auth.updateAccount($scope.personal_data)
      ###

      $scope.$watch "personal_data", update_account
      for property_key, property_value of $scope.personal_data
        $scope.$watch "personal_data.#{property_key}", update_account

    if $auth.user
      console.log "user", $auth.user
      init_user($auth.user)

    promise.then init_user

    last_update_account_time = null
    update_account_in_progress = false
    update_account = ()->
      current_time = Date.now()
      #if last_update_account_time == null || current_time - last_update_account_time >= 2000
      if !update_account_in_progress
        update_account_in_progress = true
        #last_update_account_time = current_time
        #update_account_in_progress = true
        console.log "updateAccount"
        c = $scope.personal_data
        $auth.updateAccount(c)
        setTimeout( ()->
          update_account_in_progress = false
        , 50)
      #else
      #  setTimeout( update_account , 1000)

    $scope.pushPropertyToServer = (key, value)->
      data = {}
      data[key] = value
      promise = $http.post "/update_profile", data

    $scope.controller_initialized = true

    $scope.change_password = ()->
      promise = $auth.updatePassword(
        password: $scope.password_change.password
        password_confirmation: $scope.password_change.password_confirmation
      )

      promise.then ()->
        alert("password updated successfully")
      promise.catch ()->
        alert("password update error")



]

# profile: name,