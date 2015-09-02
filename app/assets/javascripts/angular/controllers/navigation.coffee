$app.controller 'NavigationController', [
  '$scope'
  '$location'
  "$auth"
  "ngDialog"
  "$state"
  "$document"
  '$rootScope'
  'ipCookie'
  "$http"
  ($scope, $location, Auth, ngDialog, $state, $document, $rootScope, ipCookie, $http) ->

#    $scope.navClass = (page) ->
#      currentRoute = $location.path().substring(1) or 'home'
#      if page == currentRoute then 'active' else ''

    #$items_with_dropdown = angular.element(".header-menu-item.has-dropdown")
    #console.log("items.count: #{$items_with_dropdown.length}")
#    $items_with_dropdown.bind "click", (event)->
#      console.log("menu item with dropdown: click")
#      event.preventDefault()

#    $scope.openedDropdown = ()->
#      #$this = angular.element(this)
#      #return $this.data("opened") == true
#      return $scope.dropdown_opened

    #$scope.dropdown_opened = false

#    $scope.openedDropdownClass = ()->
#      opened = $scope.openedDropdown.apply(this)
#      if opened
#        return "opened"
#      else
#        return ""



#    $scope.openDropdown = ()->
#      #$this = angular.element(this)
#      #$this.data("opened", true)
#      $scope.dropdown_opened = true

#    $scope.toggleDropdown = ()->
#      $scope.dropdown_opened = !$scope.dropdown_opened



    unlogged_user_menu = [
      {title: "For clients", subitems: [
        {title: "Testing services", sref: "testing_services"}
        {title: "Pricing", sref: "pricing"}
        {title: "FAQ", sref: "faq"}
      ]}
      {title: "How it works", sref: "how_it_works"}
      {title: "About us", sref: "about"}
      {title: "Contact us", sref: "contact"}
    ]

    logged_user_menu = [
      {title: "My dashboard", sref: "dashboard"}
      {title: "For clients", subitems: [
        {title: "Testing services", sref: "testing_services"}
        {title: "How it works", sref: "how_it_works"}
        {title: "Pricing", sref: "pricing"}
        {title: "FAQ", sref: "faq"}
      ]}
      {title: "About us", sref: "about"}
      {title: "Contact us", sref: "contact"}
    ]

    $scope.menu_items = unlogged_user_menu

    $scope.$watch("logged_in", (newValue)->
      if newValue
        $scope.menu_items = logged_user_menu
      else
        $scope.menu_items = unlogged_user_menu
    )



    $scope.logged_in = false
    $scope.validation_invoked = false

    $scope.showUserConfirmationCongratulations = ()->
      alert("Congratulations! You've confirmed account successfully!")

    $scope.on_auth_validation_success = (event, user)->
      #alert("auth:validation-success")
      $scope.validation_invoked = true
      $scope.logged_in = true

    $scope.$on "auth:validation-success", $scope.on_auth_validation_success


    $scope.on_auth_validation_error = (event, user)->
      #alert("auth:validation-error")
      $scope.validation_invoked = true

    $scope.$on "auth:validation-error", $scope.on_auth_validation_error


    $scope.on_auth_login_success = (event, user)->
      #alert('auth:login-success')
      $scope.logged_in = true

    $rootScope.$on 'auth:login-success', $scope.on_auth_login_success

    $scope.$on "auth:email-confirmation-success", (event, user)->
      $scope.showUserConfirmationCongratulations()

    $scope.$on 'auth:logout-success', (event, user)->
      console.log('auth:logout-success', arguments)
      #alert('auth:logout-success')
    #$scope.showUserConfirmationCongratulations()



#    Auth.currentUser().then(
#      (user)->
#        $scope.logged_in = true
#    )

    $scope.headerUserClass = ()->

      if $scope.logged_in
        logged_in_class = "logged-in"
      else
        logged_in_class = "unlogged"

      no_avatar_class = "no-avatar"

      return "#{logged_in_class} #{no_avatar_class}"

    $scope.show_user_dropdown = false

    $scope.showUserDropdown = ()->
      $scope.show_user_dropdown = true
    $scope.closeUserDropdown = ()->
      $scope.show_user_dropdown = false
    $scope.toggleUserDropdown = ()->
      $scope.show_user_dropdown = !$scope.show_user_dropdown



    $scope.logoutUser = ()->
      ###
      Auth.logout(
        (oldUser)->
          console.log("logged_out, user: ", oldUser)
          $scope.logged_in = false
          $scope.$update()
        (error)->
      )
      ###
      Auth.signOut()
      $scope.logged_in = false


    $scope.$on('devise:logout', (event, oldCurrentUser)->
      $scope.logged_in = false
    )



    $scope.openSignInDialog = ()->
      ngDialog.open({
        template: '/assets/popups/sign_in.html'
        className: 'ngdialog-theme-default ngdialog-theme-rf-light-gray'
        controller: "SignInController"
        preCloseCallback: (result)->
          ###
          Auth.currentUser().then(
            (user)->
              #alert("success")
              $scope.logged_in = true
            (error)->
              #alert("error")
          )
          ###
          #Auth.signOut()

      });
    $scope.goToDashboard = ()->
      $state.go("dashboard")

    $scope.mobile_menu_opened = false
    $scope.$watch("mobile_menu_opened", (newValue)->
      mobile_menu_opened_class = 'mobile-menu-opened'
      body = angular.element("#body")
      if newValue
        body.addClass(mobile_menu_opened_class)
      else
        body.removeClass(mobile_menu_opened_class)
    )



    $scope.openMobileMenu = ()->
      $scope.mobile_menu_opened = true
    $scope.closeMobileMenu = ()->
      $scope.mobile_menu_opened = false
    $scope.toggleMobileMenu = ()->
      $scope.mobile_menu_opened = !$scope.mobile_menu_opened

    $scope.mobileMenuButtonClass = ()->
      mobile_menu_opened_class = if $scope.mobile_menu_opened then 'mobile-menu-opened' else ''

    $scope.headerClass = ()->
      mobile_menu_opened_class = if $scope.mobile_menu_opened then 'mobile-menu-opened' else ''
      return "#{mobile_menu_opened_class}"


    $document.bind "keyup", (e)->

      # if Esc key
      if e.which == 27
        #console.log("keydown", e)
        #alert($scope.closeMobileMenu)
        $scope.closeMobileMenu()
        $scope.closeUserDropdown()
        $scope.$apply()

    ###
    Auth.validateUser()
      .then(
        ()->
          #alert('valid')
      ).catch(
        ()->
          #alert("invalid")
      )
    ###


    if !$scope.validation_invoked
      Auth.validateUser().then(
        ()->
          #alert("Auth.validateUser() success")
          $scope.on_auth_validation_success.apply(this, arguments)
          return true
      )
      .catch(
        ()->
          #alert("Auth.validateUser() error")
          $scope.on_auth_validation_error.apply(this, arguments)
          return true
      )


    $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams)->
      #event.preventDefault()
      #transitionTo() promise will be rejected with
      #a 'transition prevented' error
      $scope.closeMobileMenu()

    $rootScope.$on "cfpLoadingBar:completed", ()->
      #alert("hello")

    $rootScope.geo = ipCookie('geo')
    if !$rootScope.geo
      promise = $http.get("/geo")
      promise.success (data)->
        $rootScope.geo = data
        ipCookie('geo', data)

]
