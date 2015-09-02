$app.factory "FaqArticle", ($http)->
  self =
    articles: []
    load_articles: ()->
      deferred = $http.get("/faq_articles")
      deferred.success (result)->
        self.articles = result
      return deferred