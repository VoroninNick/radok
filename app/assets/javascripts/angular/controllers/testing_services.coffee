window.$app.controller "TestingServicesController", [
  "$scope", "$auth", "ngDialog", ($scope, Auth, ngDialog)->
    $scope.title = "How it works"

    $scope.ctrl = 'testing_services'

    $scope.page_banner = {
      title: "Testing services page header"
      description: "Type few works about this page"
      image: '/assets/banners/contacts.jpg'
    }

    # test types
    $scope.three_images_in_row_model = [
      {img: "/assets/rf-icon-main-1.svg", title: "Functional testing", time: "apps | web | games", description: "Functional testing is performed in order to verify that a program functions correctly according to its specifications."}
      {img:"/assets/rf-icon-main-2.svg", title: "Localization testing", time: "apps | web | games", description: "A process to check the customization for a market, culture, or locale. It involves verifying translation of all native language strings to the target language, and tests GUI customizing, so that it is appropriate for the target market."}
      {img: "/assets/rf-icon-main-3.svg", title: "Usability testing", time: "apps | web | games", description: "A method of evaluating user-friendliness of a system or its components and getting insights on how users perceive and use it."}
    ]


    # what we test
    $scope.two_horizontal_items_per_row_model = [
      {img: '/assets/rf-mobile-apps.svg', title: "Mobile apps", description: 'Test your app or website for a mobile-friendly design.'}

      {img: '/assets/rf-responsive.svg', title: "Responsive websites", description: 'Make sure your users get optimal viewing experience on every device.'}

      {img: '/assets/rf-software.svg', title: "Software", description: 'Discover how your software performs under test to be certain its bug-free.'}

      {img: '/assets/rf-games.svg', title: "Games", description: 'Ensure your players have a complementary gaming experience.'}
    ]

    $scope.reasons = [
      {name: "Instantaneity", description: "1500+ certified on-demand testers"}
      {name: "Professional testers", description: "just 48 hours to deliver results"}
      {name: "Real-world testing", description: "each and every device available to test"}
    ]

]