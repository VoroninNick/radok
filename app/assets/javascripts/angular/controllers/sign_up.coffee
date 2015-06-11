window.$app.controller "SignUpController", [
  "$scope", "$auth", "ngDialog", ($scope, Auth, ngDialog)->
    $scope.credentials = {
      username: ""
      email: ""
      password: ""
      password_confirmation: ""
      first_name: ""
      last_name: ""
      country: ""
      company_url: ""
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



    $scope.openSignInPopup = ()->
      ngDialog.open({
        template: '/assets/popups/sign_in.html'
        className: 'ngdialog-theme-default ngdialog-theme-rf-light-gray'
        controller: "SignInController"
      });

    $scope.createAccount = ()->
      ###
      Auth.register($scope.credentials).then(
        (registeredUser)->
          $scope.closeThisDialog()
          alert("successfully registered")
        (error)->
          alert("please resolve errors")
      )
      ###
      Auth.submitRegistration($scope.credentials).then(
        (response)->
          # handle success response
          $scope.closeThisDialog()
          alert("successfully registered")
      ).catch(
        (response)->
          # handle error response
          alert("please resolve errors")
      )

    $scope.show_more = false

    $scope.country_list = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua &amp; Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia &amp; Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia","Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe"];
]