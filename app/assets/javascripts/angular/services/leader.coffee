$app.factory "Leader", ($http)->
  self =
    leaders: []
    load_leaders: ()->
      deferred = $http.get("/about/leaders")
      deferred.success (result)->
        self.leaders = result
      return deferred