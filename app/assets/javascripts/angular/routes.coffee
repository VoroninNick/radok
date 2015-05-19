
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
        url: '/contact'
        templateUrl: "/assets/contact.html"
        controller: "ContactController"


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