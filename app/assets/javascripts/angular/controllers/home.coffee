window.$app.controller "HomeController", [
  "$scope", "ngDialog", "$rootScope", ($scope, ngDialog, $rootScope)->
    $scope.title = "Home"

    $scope.home_slides = [
      {title: "We test mobile, web apps, and games.", description: "1500+ certified testers ready to start testing your product immediately.", button: { title: "Start now", subtitle: "no registration required", svg: "/assets/rf-rocket-up-right.svg", class: "start-now-button", sref: "wizard"  } }
      #{title: "We are experienced testers", description: "1500+ certified testers ready to start testing your product immediately.", button: { title: "Read more", subtitle: "about us", svg: "/assets/rf-rocket-up-right.svg", class: "start-now-button", sref: "about"  } }
      #{title: "Google like us", description: "We working on cool projects for customers from whole world", button: { title: "Find out", subtitle: "about our testing services", svg: "/assets/rf-rocket-up-right.svg", class: "start-now-button", sref: "testing_services"  } }
    ]

    # how it works
    $scope.three_images_in_row_model = [
      {img: "/assets/rf-icon-main-1.svg", title: "Tell us that you need to test", time: "Takes less than 10 minutes!", description: "Choose the type of testing you need, amount of hours spent, number of people involved, and platforms you want your product be tested on. No sign-up or credit card needed."}
      {img:"/assets/rf-icon-main-2.svg", title: "Submit your request", time: "2-3 minutes", description: "Submit your request and sit back enjoying our engineers do everything else! Our team of 1500+ testing professionals are ready to start immediately."}
      {img: "/assets/rf-icon-main-3.svg", title: "Get rapid results", time: "48 hours", description: "In up to 48 hours, you will receive a detailed bug report with test cases carefully documented. In some cases, we would even get the work done overnight."}
    ]

    $scope.what_for_you = {
      title: "What’s in it for you?", items: [
        "Get results fast - in 48 hours!"
        "No time wasted on a bunch of freelancers, each able to test only on a couple of platforms;"
        "Have your product tested on all the needed platforms, don’t miss anything;"
        "You get a service only by certified professionals."
      ]
    }

    $scope.statistics = {
      title: "Need some statistic?"
      tested_projects_count: 0
      testers_count: 0
    }

    #window.onscroll = ()->



    $scope.feedbacks = [
#      {text: "Being in the software industry requires constant functional and usability testing. I have to say Radok Force time/quality ratio of reports are a must have.", name: "Victor Shevchenko", position: "Company CEO"}
#      {text: "Being in the software industry requires constant functional and usability testing. I have to say Radok Force time/quality ratio of reports are a must have.", name: "Victor Shevchenko", position: "Company CEO"}
#      {text: "Being in the software industry requires constant functional and usability testing. I have to say Radok Force time/quality ratio of reports are a must have.", name: "Victor Shevchenko", position: "Company CEO"}
#      {text: "Being in the software industry requires constant functional and usability testing. I have to say Radok Force time/quality ratio of reports are a must have.", name: "Victor Shevchenko", position: "Company CEO"}
#      {text: "Being in the software industry requires constant functional and usability testing. I have to say Radok Force time/quality ratio of reports are a must have.", name: "Victor Shevchenko", position: "Company CEO"}
      {text: "I am greatly pleased with the experience with Radok Force. I have contacted them to get a functional and usability testing before a release of our peace of software. The reports guys created were very professional and did exceed my expectations, and also they caught a number of bugs we missed internally. Our release was so much smoother thanks to Radok Force.", name: "Victor Shevchenko", position: "Company CEO"}
      {text: "We have involved Radok in testing our mobile app for localisation. We all at [company name] were impressed with the testing team’s in-depth knowledge and system approach. Besides, we got results in less than 2 days! Without any hesitation, we are going to use Radok’s services in the future."}
      {text: "I have engaged with Radok Force after a few failed attempts to work with cheap freelancers on oDesk. I was disappointed no one could test my app on all the devices I needed, both desktop and mobile, so didn’t even expect they could do this in such a short period. Not only my app was tested on all the platforms and devices I asked, but also I got a profound report with the recommendations for bug fixing to make my app truly responsive. I’m planning to use Radok Force in all further iterations and product pivots as it is worry-free for me. "}
    ]

    $scope.feedbacks_carousel_index = 0

    $scope.who_we_are_best_for = {
      title: "Who we are best for:", items: [
        "Startups that need to test their products before a release;"
        "Product companies that don’t have QA engineers in-house;"
        "Product owners or individual freelancers to test their product."
      ]
    }

    $scope.ctrl = "home"

    $scope.benefits = {
      title: "Benefits:", items: [
        "We deliver results in 48 hours!"
        "1500+ professional certified QA engineers;"
        "we test on all platforms, we mean it, all (we have access to every hardware device manufactured in the last 5 years);"
        "our customers support works 24/7."
      ]
    }

    #ctrl = this;
    $scope.members = []

    $scope.init_carousel_bullets = ()->
      #alert "init_carousel_bullets"
      current_index = $scope.owl.currentItem
      $bullets = $scope.$wrap.find(".rn-carousel-indicator.custom-indicator span")
      $bullets.removeClass("active")
      $bullets.eq(current_index).addClass("active")

    $scope.carouselInitializer = ()->
      $scope.$wrap = $(".carousel-wrapper")
      $scope.$owl = $(".owl-carousel")
      $scope.$owl.owlCarousel({
        autoPlay : 30 * 1000,
        stopOnHover : true,
        items: 1,
        navigation: false,
        pagination: false,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"]
        singleItem : true,
        autoHeight : true,
        transitionStyle:"fade"
      });

      $scope.owl = $scope.$owl.data("owlCarousel")

      $('.rn-carousel-control').on "click", "div", ()->
        $arrow = $(this)
        if $arrow.hasClass("rn-carousel-control-prev")
          $scope.$owl.trigger("owl.prev");
          #owl.prev()
        else
          $scope.$owl.trigger("owl.next");
      $(".carousel-wrapper").on "click", ".rn-carousel-indicator.custom-indicator span", ()->
        $bullet = $(this)
        if !$bullet.hasClass("active")
          bullet_index = $bullet.index()
          #alert "$bullet->#{bullet_index}"
          #$owl.find("> li").eq(bullet_index).trigger("owl.goTo")
          #$owl.goTo(bullet_index)
          #owl.goTo(bullet_index)
          $scope.$owl.trigger "owl.goTo", bullet_index

      $scope.$owl.on "owl.goTo owl.next owl.prev owl.jumpTo owl.play", $scope.init_carousel_bullets










    scene = angular.element('.home-parallax-banner').each ()->
      parallax = new Parallax(this)

    $scope.show_plans_section_header = true

    $scope.ngRepeatFinished_count = 0
    $scope.$on 'ngRepeatFinished', (ngRepeatFinishedEvent)->
      ###
      if $scope.ngRepeatFinished_count == 0
        $scope.ngRepeatFinished_count = 1
        console.log("ngRepeatFinishedEvent", ngRepeatFinishedEvent)
        alert($('.scene').length)
        alert($scope.ngRepeatFinished_count)


      else
        $scope.ngRepeatFinished_count = 0

      ###

      $scope.homeBannerCarouselIndex = 0
      scene = angular.element('.home-parallax-banner').each ()->
        parallax = new Parallax(this)

    $scope.sheduleCall = ()->
      ngDialog.open({
        template: '/assets/popups/shedule_call.html'
        className: 'ngdialog-theme-default ngdialog-theme-rf-light-gray'
        controller: "SheduleCallController"
      });




    $scope.openSignInDialog = ()->
      ngDialog.open({
        template: '/assets/popups/sign_in.html'
        className: 'ngdialog-theme-default ngdialog-theme-rf-light-gray'
        controller: "SignInController"
        preCloseCallback: (result)->

      })

#    $scope.initialize_statistics_counter = ()->
#      $elem = $("#home-statistics")
#      #alert("initialize_statistics_counter: #{$elem.length}")
#      $elem.appear ()->
#        #alert("appear")
#        $scope = angular.element("[ng-controller=HomeController]").scope()
#        if $scope.controller_initialized && !$scope.statistics_counter_initialized
#          $scope.$apply ()->
#            $scope.statistics_counter_initialized = true
#            $scope.statistics.tested_projects_count = 143
#            $scope.statistics.testers_count = 1981

    initialize_statistics_after_ready = false
    $scope.initialize_statistics = ()->
      setTimeout( ()->
        if initialize_statistics_after_ready
          #alert("initialize_statistics")
          $scope.statistics_counter_initialized = true
          $scope.statistics.tested_projects_count = 143
          $scope.statistics.testers_count = 1981
        else
          initialize_statistics_after_ready = true
      , 300)

    #$scope.initialize_statistics_counter()

    $scope.controller_initialized = true


]


###
$(window).on "scroll", (event)->
  appElement = $('[ng-app=myApp]');
  $scope = angular.element("[ng-controller=HomeController]").scope();
  if !$scope.statistics_counter_initialized

    $scope.$apply( ()->
      $scope.statistics_counter_initialized = true
      $scope.statistics.tested_projects_count = 143
      $scope.statistics.testers_count = 1981
    )

###



