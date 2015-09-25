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

)(jQuery)