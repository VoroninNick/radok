#WizardTest = class WizardTest
#  @step: null
#  get_new: ()->
#    $http.get('/wizard/new_test_available_steps').success (data)->
#      angular.copy(data, @step)


#$app.factory "WizardTest", ()->


$app.controller "WizardController", [
   "$scope", "WizardTest", "ngDialog", "$auth", "$http", "$rootScope", ( $scope, WizardTest, ngDialog, $auth, $http, $rootScope)->

    $scope.page_banner = {
      title: "Wizard page header"
      description: "Type few works about this page"
      image: '/assets/banners/contacts.jpg'
    }

    $scope.wizard_test_data = WizardTest

    if window.reopen_test
      $scope.wizard_test = WizardTest.load()
    #$scope.ajax_steps = new WizardTest()
    #$scope.ajax_steps.get_new()


    $scope.wizard = WizardTest.new()
    $scope.master = {}
    $scope.user = {}

    $scope.wizard.tester_hour_price = 20
    $scope.wizard.hours = [1, 2, 3, 4, 5]
    $scope.wizard.selected_hour = $scope.wizard.hours[0] if !$scope.wizard.selected_hour
    $scope.wizard.show_help = true;
    $scope.wizard.type_of_test = false
    $scope.wizard.total_testers_count = 0
    $scope.wizard.ready_to_checkout = false

    $scope.wizard.item_price = 20

    $scope.wizard.total_price = 0

    $scope.wizard.active_step_id = 1
    #$scope.wizard
    $scope.next_step_id = 2

    $scope.wizard.active_step_valid = true

    $scope.wizard.configuration_steps = [
      #{id: 1, key: "intro", intro: true}
      {id: 2, key: "platforms", name: "Platforms", number: 1, valid: true}
      { id: 3, key: "project_info", name: "step B name", number: 2, valid: true }
      { id: 4, key: "testing_type", name: "Testing type", number: 3, valid: true }
      { id: 5, key: 'project_access', name: "Project access", numnber: 4, valid: true }
    ]

    $scope.$watch "wizard.steps"

#    $scope.wizard.steps_by_key = (key)->
#      $scope.wizard.steps.filter(
#        (s)->
#          s.key == key
#      )

    $scope.wizard.named_steps = {
      preconfiguration_steps: {
        type_of_test: {
          type_of_test: false
        }
        type_of_product: {
          type_of_product: false
        }
      }
      configuration_steps: {
        hours_per_tester: 1
        
      }
    }

    $scope.$watch("wizard.active_step_id", (newValue)->
      $scope.wizard.active_step = $scope.wizard.configuration_steps.filter( (s)->
        parseInt(s.id) == parseInt(newValue)
      )[0]


      #console.log "active_step_form_name = ", $scope.wizard.active_step

      $scope.wizard.active_step_form_key = if $scope.wizard.active_step then $scope.wizard.active_step.key else undefined

      if $scope.wizard.active_step_form_key
        $scope.wizard.active_step_form = $scope.wizard[$scope.wizard.active_step_form_key+"_form"]

      $scope.wizard.next_step_id = newValue + 1
      $scope.wizard.next_step = $scope.wizard.configuration_steps.filter( (s)->
        parseInt(s.id) == parseInt($scope.wizard.next_step_id)
      )[0]

      if parseInt(newValue) == 3
        $scope.wizard.active_step.valid = $scope.wizard.validate_step_3()
    )



    $scope.$watch("wizard.total_price", (newValue)->
      $scope.wizard.configuration_steps[1].valid = newValue > 0
    )

    $scope.wizard.validate_step_3 = ()->
      w = $scope.wizard
      if w.project_name.length > 0 && w.version_number && w.version_number.length > 0 && w.project_languages.length > 0 && w.report_languages.length > 0
        return true
      return false










    $scope.wizard.platforms = [
      {id: 1, name: "Browsers", svg: "ie", hours_count: 0, testers_count: 0, price: 0, comment: "", platform_subitems: [
        {name: "Internet Explorer 9", count: 0},
        { name: "Internet Explorer 10" },
        { name: "Internet Explorer 11" },
        { name: "Latest version of Firefox" },
        { name: "Latest version of Chrome" },
        { name: "Latest version of Safari" }
      ] },

      {id: 2, name: "IOS", svg: "apple", hours_count: 0, testers_count: 0, price: 0, comment: "", platform_subitems: [
        {name: "iPhone 4"},
        {name: "iPhone 5s"},
        {name: "iPad 2"},
        {name: "iPad Air"},
        {name: "iPad mini"},
        {name: "iPhone 6 Plus"}
      ]},
      {id: 3, name: "Android", hours_count: 0, testers_count: 0, price: 0, svg: "android", comment: "", platform_subitems: [
        {name: "Android phone (Samsung)"},
        {name: "Android phone (Non-Samsung)"},
        {name: "Android tablet (Samsung)"}
        {name: "Android tablet (Non-Samsung)"}
      ]}
    ]





    for p, i in $scope.wizard.platforms
      for ps, j in p.platform_subitems
        $scope.$watch("wizard.platforms[#{i}].platform_subitems[#{j}].count", (newValue, oldValue)->
          newValue = parseInt(newValue)
          oldValue = parseInt(oldValue)
          difference = newValue - oldValue
          $scope.wizard.total_testers_count = $scope.wizard.total_testers_count + difference

          for inner_p in $scope.wizard.platforms
            platform_price = 0
            platform_testers_count = 0
            for inner_ps in inner_p.platform_subitems
              platform_price += (parseInt(inner_ps.count) || 0) * $scope.wizard.item_price * $scope.wizard.data.ps__hours
              platform_testers_count += parseInt(inner_ps.count)
            inner_p.price = platform_price
            inner_p.testers_count = platform_testers_count
            inner_p.hours_count = platform_testers_count * $scope.wizard.data.ps__hours


          #difference = newValue - oldValue

          #p = $scope.wizard.platforms[i]
          #platform_price = p.price + $scope.wizard.item_price * difference * parseInt($scope.wizard.selected_hour)
          #p.price = platform_price
        )

      $scope.$watch("wizard.platforms[#{i}].price", (newValue, oldValue)->
        difference = newValue - oldValue
        #alert("change platform price:\nplatform_index: #{i}\nnewValue: #{newValue}\noldValue: #{oldValue}")
        price = 0
        for p in $scope.wizard.platforms
          #$scope.wizard.total_price = $scope.wizard.total_price + difference
          price += p.price
        $scope.wizard.total_price = price
        #alert($scope.wizard.platforms[0].price)
      )

    $scope.$watch("wizard.data.ps__hours", (newValue, oldValue)->
      for p, i in $scope.wizard.platforms
        #p.price = p.price / (oldValue) * newValue
        p.hours_count = p.testers_count * newValue
        p.price = p.hours_count * $scope.wizard.tester_hour_price
    )
    ###
    $scope.step_3_questions = [
      question: "Have you ever tested this project with us?"
      type: "radio"
      options: [
        {
          label: "Yes, we tested a previous version of this project"
          value: "yes"
        }
        {
          label: "No, this is a completely new project"
        }
      ]
    ]
    ###





    for p in $scope.wizard.platforms
      for item in p.platform_subitems
        if !item.count
          item.count = 0

    $scope.wizard.available_project_languages = ["English", "Ukrainian", "Russian", "Portuguese", "Polish"]
    $scope.wizard.available_report_languages = ["English", "Ukrainian", "Russian", "Portuguese", "Polish"]


    $scope.wizard.tested_before = 'no' #false
    $scope.wizard.project_name ?= "Project 1"
    $scope.wizard.version_number = null
    $scope.wizard.project_languages = ["English"]
    $scope.wizard.project_languages_count = 0
    $scope.wizard.report_languages = ["English"]
    $scope.wizard.report_languages_count = 0
    $scope.wizard.methodology_id = 1

    $scope.wizard.available_methodology_types = [
      {id: 1, type: "exploratory", description: "", description_placeholder: "Please provide testing instructions for the testers here..."}
      {id: 2, type: "Test-case driven", description: "", description_placeholder: "Please provide testing instructions for the testers here..."}
    ]



    $scope.wizard.product_main_components = []

    $scope.wizard.url = null
    $scope.wizard.auth_data = {
      username: ""
      password: ""
      require_auth: "false"
    }
    $scope.wizard.comment = ""




    for field_name in ["project_name", "version_number", "project_languages", "report_languages", "project_languages_count", "report_languages_count"]
      #console.log("bind watch on wizard.#{field_name}" )
      $scope.$watch("wizard.#{field_name}", (newValue, oldValue)->
        #console.log("triggered whatch on wizard.#{field_name}: old: #{oldValue}; new: #{newValue}")
        if $scope.wizard.active_step_id == 3
          $scope.active_step ?= $scope.wizard.configuration_steps.filter((s)-> s.id == $scope.wizard.active_step_id )

          if $scope.active_step
            $scope.wizard.active_step.valid = $scope.wizard.validate_step_3()
          $scope.wizard.configuration_steps[1].valid = $scope.wizard.validate_step_3()
      )


    for field_name in ["project_languages", "report_languages"]
      #console.log("bind watch on wizard.#{field_name}" )
      $scope.$watchCollection("wizard.#{field_name}", (newValue, oldValue)->
        #console.log("watchCollection")
        #console.log("triggered whatchCollection on wizard.#{field_name}: old: #{oldValue}; new: #{newValue}")
        if $scope.wizard.active_step_id == 3
          $scope.active_step ?= $scope.wizard.configuration_steps.filter((s)-> s.id == $scope.wizard.active_step_id )
          $scope.wizard.active_step.valid = $scope.wizard.validate_step_3()
          $scope.wizard.configuration_steps[1].valid = $scope.wizard.validate_step_3()
      )

    $scope.update = (user)->
      $scope.master = angular.copy(user)

    #$scope.jQuery = jQuery
    $scope.configure = ()->
      $('.configuration-steps').removeClass("hide").addClass("visible")
      $('.intro-step').addClass("proceeded")
      #$('.configuration-steps .wizard-step:first').go_to_this_step()
      $scope.wizard.configure_mode = true
      #$('.configuration-steps').removeClass()
      $scope.wizard.show_mini_summary = true
      $scope.wizard.show_help = false
      $scope.wizard.active_step_id = 2
      #$scope.wizard.configure_mode_class = ()->
      #$scope.wizard.available_platforms = WizardTest.load_platforms($scope.wizard.product_type).platforms

      #$scope.wizard_test_data.load_platforms($scope.wizard.product_type)





    $scope.$watch("wizard.active_step_id", (newValue, oldValue)->
      #$new_step = angular.element("[step-id=#{newValue}]")
      #console.log("active_step_id changed: new: #{newValue}; old: #{oldValue}")

      $new_step = jQuery("[step-id=#{newValue}]")
      #console.log("new_step: ", $new_step)
      scroll_to_top = $new_step.offset().top - 80
      #console.log("step: #{scroll_to_top}")
      jQuery("#body").animate(scrollTop: scroll_to_top)


      ###
      setTimeout( ()->

      , 1000)
      ###
    )


    $scope.wizard.ready_go_to_step = (step_id)->
      step_id = parseInt(step_id)
      if (parseInt($scope.wizard.active_step_id) > step_id) || ($scope.wizard.active_step &&  $scope.wizard.active_step.valid && parseInt($scope.wizard.active_step_id) < step_id)
        if $scope.wizard.active_step_id < step_id
          prev_step = $scope.wizard.configuration_steps.filter( (s)-> parseInt(s.id) == step_id   )[0]
          if prev_step && prev_step.valid
            return true
          else
            return false

        return true


    $scope.wizard.go_to_step = (step_id)->
      step_id = parseInt(step_id)
      if (parseInt($scope.wizard.active_step_id) > step_id) || ($scope.wizard.active_step &&  $scope.wizard.active_step.valid && parseInt($scope.wizard.active_step_id) < step_id)
        if $scope.wizard.active_step_id < step_id
          prev_step = $scope.wizard.configuration_steps.filter( (s)-> parseInt(s.id) == step_id   )[0]
          if prev_step && prev_step.valid
            $scope.wizard.active_step.proceeded = true
          else
            return false

        $scope.wizard.active_step_id = step_id

    $scope.go_back = ()->
      $scope.wizard.active_step_id = $scope.wizard.active_step_id - 1

    $scope.next_question = ()->
      $('.next-question-button').removeClass("visible").addClass('hide')
      $question = $('.wizard-step').first().find(".question").eq(1)
      question_top = $question.offset().top

      top_to_animate = question_top - $('#header').height() - 48
      $('#body').animate({scrollTop: top_to_animate})

    $scope.next_step = ()->
      if $scope.wizard.active_step_form.$valid
        $scope.wizard.active_step.proceeded = true
        $scope.wizard.active_step_id = $scope.wizard.active_step_id + 1


    $scope.openPaymentDialog = ()->
      ngDialog.open({
        template: '/assets/popups/payment.html'
        className: 'ngdialog-theme-default ngdialog-theme-rf-light-gray ngdialog-payment'
        controller: "PaymentController"
      });


    #$scope.openPaymentDialog()

    $scope.reset = ()->
      $scope.user = angular.copy($scope.master)


    $scope.validatePlatforms = ()->


    $scope.saveProject = ()->
      if $auth.user
        #alert("saveProject")
        #alert($auth.user.email)
        data = {
          data: $scope.wizard.data,
          state: {
            configure_mode: $scope.wizard.configure_mode
            configuration_steps: $scope.wizard.configuration_steps
            total_testers_count: $scope.wizard.total_testers_count
          }
        }


        promise = $http.post "/save_project", data
        promise.then (response)->
          response_data = response.data
          #alert "successfully saved"
          #console.log "response", response
          if response_data.action == 'create'
            #alert "create"
            console.log "create", response_data
            $scope.wizard.data.id = response_data.id
          else
            #alert "update"
        promise.error ()->
          #alert "error"
      else
        #alert "please login or register"
      #console.log "data", $scope.wizard.data

    $scope.initConfigurationSteps = ()->
      if $scope.wizard.configure_mode
        $(".configuration-steps").removeClass("hide")

    if $rootScope.draft
      project = $rootScope.draft
      angular.merge($scope.wizard.data, project)
      delete $scope.wizard.data.state
      if project.state
        project_state = project.state
        $scope.wizard.configure_mode = project_state.configure_mode
        $scope.wizard.total_testers_count = project_state.total_testers_count
      $scope.initConfigurationSteps()

    #$scope.$on "auth:login:success", $scope.saveProject


]