window.$app.controller "FaqController", [
  "$scope", "$sce", "$http", "FaqArticle", ($scope, $sce, $http, FaqArticle)->
    $scope.faq_articles = FaqArticle
    $scope.faq_articles.load_articles().then ()->
      $scope.active_article_index = 0
      $scope.active_article = $scope.faq_articles.articles[0]
      $scope.title = "About us"
      $scope.$watch("active_article_index", (newValue)->
        newValue = parseInt(newValue) || 0
        if newValue
          $scope.active_article = $scope.faq_articles.articles[newValue]
      )

    $scope.page_banner = {
      title: "FAQ page header"
      description: "Type few works about this page"
      image: '/assets/banners/contacts.jpg'
    }


    $scope.item = 'What&nbsp;Is&nbsp;Your&nbsp;Name?'

    $scope.question_request = {
      name: ""
      email: ""
      question_title: ""
      question_description: ""
    }

    $scope.submitQuestion = ()->
      deffered = $http.post("/faq_request", $scope.question_request)
      deffered.success (data)->
        if data.code == 200
          alert("success")
        else
          alert("error")
      deffered.error ()->
        alert("deffered error")


    $scope.faqMenuClass = (index)->
      if index == $scope.active_article_index
        return "active"
      else
        return ""

    $scope.openArticle = (index)->
      $scope.active_article_index = index
      $scope.scrollToArticle()

    $scope.scrollToArticle = ()->
      target_offset = $("#article").offset()
      if target_offset
        top_to_scroll = target_offset.top - $("#header-row").height()
        if window.innerWidth > 768
          top_to_scroll -= 24
        $("html, body").animate(scrollTop: top_to_scroll)

    $scope.scrollToForm = ()->
      target_offset = $("#faq-form").offset()
      if target_offset
        $("html, body").animate(scrollTop: target_offset.top - $("#header-row").height())
]