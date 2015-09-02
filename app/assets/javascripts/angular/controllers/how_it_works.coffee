window.$app.controller "HowItWorksController", [
  "$scope", "$auth", "ngDialog", ($scope, Auth, ngDialog)->
    $scope.title = "How it works"

    $scope.page_banner = {
      title: "How it works page header"
      description: "Type few works about this page"
      image: '/assets/banners/contacts.jpg'
    }

#    curr_user = Auth.currentUser()
#    curr_user.then(
#      (user)->
#        console.log("user: ", user)
#
#      (error)->
#        console.log("error: ", error)
#
#
#    )

#    $scope.openSignInDialog = ()->
#      #alert("sign in")
#      ngDialog.open({
#        template: '/assets/popups/sign_in.html'
#        className: 'ngdialog-theme-default ngdialog-theme-rf-light-gray'
#        controller: "SignInController"
#        preCloseCallback: (result)->
#          alert("sign_in result: #{result}")
#          console.log("sign_in result:", result)
#      });

    #angular.element("header-user.unlogged").on "click", ()->
    #  alert("hello")


]