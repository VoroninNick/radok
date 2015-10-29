class Formify.Inputs.Platforms extends Formify.Inputs.CollectionInput
  dom_value : ()->
    @jquery_input.find(".option-count").map(
      (index, item)->
        count = parseInt($(item).find("input").val())
        id = parseInt($(item).attr('platform-subitem-id'))
        return {testers_count: count, id: id}
    )
    .filter(
      (index, option)->
        return option.testers_count > 0
    ).toArray()

  render : ()->
    input_id = @html_id_for()

    options_string = ""

    platforms_collection_string = ""

    for p in @options

      platform_options_collection_string = ""

      if p.children && p.children.length
        for child_platform in p.children
          platform_option_string = "
            <div class='option-count' platform-subitem-id='#{child_platform.id}'>
              <div class='platform-option-label'>#{child_platform.name}</div>
              <div class='input-wrap'>
                <input value='0' pattern='[0-9]*' type='text'/>
                <label class='decrement' for='platform-1-subitem-1'></label>
                <label class='increment' for='platform-1-subitem-1'></label>
              </div>
            </div>
            "

          platform_options_collection_string += platform_option_string


      platform_options_string = "
        <div class='platform-options'>
          #{platform_options_collection_string}
        </div>
      "

      platform_string = "
        <div class='platform'>
          <div class='name platform-label'>#{p.name}</div>
          <div class='human-svg-wrap platform-user-icon'>#{window.svg_images.user}</div>
          #{platform_options_string}
        </div>
        "

      platforms_collection_string += platform_string

    input_html = "
      <div class='clearfix'>
      #{platforms_collection_string}
      </div>
    "
