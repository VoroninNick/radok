window.$app.controller "DashboardController", [
  "$scope", "$auth", "ngDialog", "$timeout", "$state", "$http", "$rootScope", ($scope, Auth, ngDialog, $timeout, $state, $http, $rootScope)->
    $scope.title = "How it works"

    ctrl_name = "dashboard"

    $scope.range = (n)->
      arr = []
      i = 0
      while i < n
        arr[i] = i+1
        i++
      return arr

    $scope.page_banner = {
      title: "Dashboard page header"
      description: "Type few works about this page"
      image: '/assets/banners/contacts.jpg'
      button: {
        title: "Create test",
        click: ()->
          $state.go("wizard")
      }
    }
]