window.$app.controller "ScheduleCallController", [
  "$scope", "$auth", "ngDialog", ($scope, Auth, ngDialog)->
    $scope.credentials = {
      name: ""
      description: ""
      phone: ""
    }
]