#= require jquery/dist/jquery.min.js
#= require codemirror/lib/codemirror.js
#= require codemirror/addon/display/fullscreen.js
#= require codemirror/mode/xml/xml
#= require codemirror/mode/htmlembedded/htmlembedded
#= require codemirror/mode/htmlmixed/htmlmixed
#= require codemirror/mode/coffeescript/coffeescript
#= require codemirror/mode/javascript/javascript
#= require codemirror/mode/ruby/ruby
#= require codemirror/mode/markdown/markdown
#= require codemirror/mode/slim/slim

$(document).on "rails_admin.dom_ready rails_admin:dom_ready rails_admin_dom_ready pjax:end pjax.complete", (e)->
  $("textarea.my-codemirror:not(initialized)").each ()->
    $textarea = $(this)
    mode = $textarea.attr("mode") || "html"

    shortcuts = {
      html: "text/html"
      slim: "application/x-slim"
    }

    if shortcuts[mode]
      mode = shortcuts[mode]

    editor = CodeMirror.fromTextArea(this, {
      lineNumbers: true,
      theme: "ambiance",
      mode: mode,
      #mode: "text/html",
      extraKeys: {
        "F11": (cm)->
          cm.setOption("fullScreen", !cm.getOption("fullScreen"));

        "Esc": (cm)->
          if (cm.getOption("fullScreen"))
            cm.setOption("fullScreen", false)

    }
    });

    $textarea.data("editor", editor)


  $("button.convert").on "click", ()->
    data = { html: $(".editor.mode-html textarea").data("editor").getValue() }
    $.ajax({
      type: "post"
      url: "/html-to-slim"
      data: data
      dataType: "json"
      success: (res)->
        slim = res.slim
        $(".editor.mode-slim textarea").data("editor").setValue(slim)

    })

