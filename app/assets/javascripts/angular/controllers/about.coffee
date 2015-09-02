window.$app.controller "AboutController", [
  "$scope", "Leader", ($scope, Leader)->
    $scope.title = "About us"
    $scope.leaders = Leader
    $scope.leaders.load_leaders()

    $scope.page_banner = {
      title: "2800+ testers from Ukraine"
      description: "Young team of professional testers"
      image: '/assets/banners/contacts.jpg'
    }

    # what we test
    $scope.application_types = [
      {img: '/assets/rf-mobile-apps.svg', title: "Mobile apps"}

      {img: '/assets/rf-responsive.svg', title: "Responsive websites"}

      {img: '/assets/rf-software.svg', title: "Software"}

      {img: '/assets/rf-games.svg', title: "Games"}
    ]

    $scope.clients = [
      {url: "http://apple.com", image: "/assets/clients/apple.svg", name: "Apple"}
      {url: "http://microsoft.com", image: "/assets/clients/microsoft.svg", name: "Microsoft"}
      {url: "http://ea.com", image: "/assets/clients/ea.svg", name: "Electronic Arts: EA Games"}
      {url: "http://adobe.com", image: "/assets/clients/adobe.svg", name: "Adobe"}
      {url: "http://intel.com", image: "/assets/clients/intel.svg", name: "Intel"}
      {url: "http://lenovo.com", image: "/assets/clients/lenovo.svg", name: "Lenovo"}
      {url: "http://logitech.com", image: "/assets/clients/logitech.svg", name: "Logitech"}
      {url: "http://nokia.com", image: "/assets/clients/nokia.svg", name: "Nokia"}
    ]

]