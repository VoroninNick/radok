
window.$app.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state 'home',
        url: '/home'
        templateUrl: '/assets/home.html'
        controller: 'HomeController'

      .state "wizard",
        url: "/wizard",
        templateUrl: "/assets/wizard.html",
        controller: "WizardController"
      .state "about",
        url: '/about'
        templateUrl: "/assets/about.html"
        controller: "AboutController"
      .state "contact",
        url: '/contact-us'
        templateUrl: "/assets/contact.html"
        controller: "ContactController"
      .state "faq",
        url: "/faq"
        templateUrl: "/assets/faq.html"
        controller: "FaqController"
      .state "how_it_works",
        url: "/how-it-works"
        templateUrl: "/assets/how_it_works.html"
        controller: "HowItWorksController"
      .state "sign_up",
        url: "/sign-up"
        templateUrl: "/assets/sign_up.html"
        controller: "SignUpController"
      .state "dashboard",
        url: "/dashboard"
        templateUrl: "/assets/dashboard.html"
        controller: "DashboardController"
      .state "profile",
        url: "/profile"
        templateUrl: "/assets/profile.html"
        controller: "ProfileController"
      .state "pricing",
        url: "/pricing"
        templateUrl: "/assets/pricing.html"
        controller: "PricingController"
      .state "testing_services",
        url: "/testing-services"
        templateUrl: "/assets/testing_services.html"
        controller: "TestingServicesController"
      .state "terms_of_use",
        url: "/terms-of-use"
        templateUrl: "/assets/terms_of_use.html"

    $urlRouterProvider.otherwise '/home'
]


###
window.$app.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
    .when('/',
      templateUrl: "home.html"
      controller: 'HomeController'
    )
    .when('/wizard',
      templateUrl: "wizard.html"
      controller: 'WizardController'
    )
])
###