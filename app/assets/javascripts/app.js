window.$app = window.$app = angular.module('app', [ 'ui.router', 'ngAnimate' ])


$app.config([
    '$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('home', {
                url: '/home',
                templateUrl: '/assets/home.html',
                controller: 'HomeController'
            })
            .state("wizard", {
                url: "/wizard",
                templateUrl: "/assets/wizard.html",
                controller: "WizardController"
            })
            .state("about", {
                url: "/about",
                templateUrl: "/assets/about.html",
                controller: "AboutController"
            })
            .state("contact", {
                url: "/contact",
                templateUrl: "/assets/contact.html",
                controller: "ContactController"
            })

        return $urlRouterProvider.otherwise('home');
    }
]);


$app.controller("HomeController", [
    "$scope", function($scope) {
        $scope.title = "home page"
        $scope.article = {name: "Test article"}
    }
])

$app.controller("WizardController", [
    "$scope", function($scope) {
        $scope.title = "wizard"
        $scope.test = {name: "Functional"}
    }
])

$app.controller("AboutController", [
    "$scope", function($scope) {
        $scope.title = "about us"
        $scope.test = {name: "Functional"}
    }
])

$app.controller("ContactController", [
    "$scope", function($scope) {
        $scope.title = "contact us"
        $scope.test = {name: "Functional"}
    }
])