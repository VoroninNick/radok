window.$app.controller "SheduleCallController", [
  "$scope", "$auth", "ngDialog", ($scope, Auth, ngDialog)->
    $scope.credentials = {
      name: ""
      description: ""
      phone: ""
    }
]