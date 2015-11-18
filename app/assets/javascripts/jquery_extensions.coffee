( ($)->
    original_functions = {}
    original_functions.val = $.fn.val

#    $.fn.val = (new_value)->
#      if new_value != undefined && new_value != null
#        old_val = original_functions.val.call(this)
#
#        original_functions.val.call(this, new_value)
#        new_val = original_functions.val.call(this)
#
#
#        if old_val != new_val
#          this.trigger("code-change")
#
#      return this

    $.fn.trigger_val = (value)->
      $this = $(this)

      if value != undefined && value != null && value != $this.val()
        $this.val(value)
        $this.trigger("code-change")

    $("body").on "change", "input:checkbox, input:radio", ->
      $this = $(this)
      if $this.filter(":checked").length > 0
        $this.trigger("check")
      else
        $this.trigger("uncheck")

      if $this.filter('[type=radio]').length > 0
        name = $this.attr('name')
        $(document.getElementsByName(name)).filter(":not(:checked)").trigger("uncheck")


    $.fn.val = (value)->
      getter = arguments[0] == undefined
      $this = $(this)
      if $this.filter(".rf-boolean-input").length
        return original_functions.val.apply($this) == 'true'
      if $this.filter("div.rf-input").length
        if $this.attr("type") == 'tags'
          res = $this.find("input").val().split(",")
          if res.length == 1 && res[0].length == 0
            return []
          else
            return res
        if $this.filter(".string").length

          return original_functions.val.apply($this.find("input"), arguments)
          #return $this.find("input").val(value)

        if  $this.filter(".text").length
          #return $this.find("textarea").val(value)
          return original_functions.val.apply($this.find("textarea"), arguments)
        if $this.filter(".checkbox-list").length
          if getter
            return $this.first().find("input").map( ()->
              if $(this).filter(":checked").length
                return $(this).val()
            )
      return original_functions.val.apply(this, arguments)


    $.fn.tagName = ()->
      if !$(this)
        return
      $(this).get(0).tagName.toLowerCase()


    $.fn.hasAttribute = (attr)->
      $(this).attr(attr) != undefined

)(jQuery)