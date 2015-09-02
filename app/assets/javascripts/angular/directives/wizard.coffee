helper_path = "/assets/helpers/wizard/"
#$app



helper "optionImage",
  template_name: "option_image"
  require: "ngModel"
  scope:
    ng_model: "=ngModel"
  args:
    name: "@"
    label: "@"
    value: "@"
    description: "@"
    #ng_model: "=model"
    image_name: "@imagePath"
    columns_count: "@columnsCount"
  optional: ["ng_model"]
  linkFn: (scope, element, attrs, ctrl, transcludeFn)->
    scope.columns_count = "4" if !parseInt(scope.columns_count)
    scope.id = "#{scope.name}__#{attrs.id}"
    scope.image_path = "/assets/#{scope.image_name}.svg"
    #scope.ng_model = scope[attrs.ngModel]
    #element.on "click", ()->
    #  ctrl.$setViewValue(element.find("input").val())
#    scope.$watch 'ng_model', (newValue, oldValue)->
#      scope[attrs.ngModel] = newValue


###
helper "nextStepButton",
  template_name: "next_step_button"
  args:
    step_number: "@stepNumber"
    step_name: "@stepName"

###

$app.directive "nextStepButton", ()->
  templateUrl: "/assets/helpers/wizard/_next_step_button.html"
  #require: "disabled"
  scope:
    model_active_step: "=modelActiveStep"
    model_next_step: "=modelNextStep"
  link: (scope, element, attrs, ctrl, transcludeFn)->
#    scope.disabledClass = ()->
#      if scope.disabled
#        return "disabled"
#      else
#        return "enabled"
    scope.step_number = scope.model_next_step.number
    scope.step_name = scope.model_next_step.name


    scope.$watch("model_active_step", (newValue)->

      scope.disabled_class = if newValue && newValue.valid then "enabled" else "disabled"
    )

    scope.$watch("model_active_step.valid", (newValue)->
      scope.disabled_class = if newValue then "enabled" else "disabled"
    )

helper "goButton",
  template_name: "go_button"
  args:
    text: "@"
  linkFn: (scope, element, attrs, ctrl, transcludeFn)->
    scope.text ?= "Next"
    scope.image = '/assets/rf-icon-rocket.svg'
    scope.button_class = "go-button"

helper "configureButton",
  template_name: "go_button"
  args:
    text: "@"
  linkFn: (scope, element, attrs, ctrl, transcludeFn)->
    scope.text ?= "Configure"
    scope.image = '/assets/rf-icon-rocket.svg'
    scope.button_class = "configure-button"


helper "nextQuestionButton",
  template_name: "next_question_button"

helper "summaryButton",
  template_name: "summary_button"

#helper "configureButton",
#  template_name: "configure_button"

helper "prevStepButton",
  template_name: "prev_step_button"
  args:
    prev_step_number: "@prevStepNumber"

###
helper "wizardStep",
  template_name: "wizard_step",
  args:
    step_number: "@stepNumber"
    step_title: "@stepTitle"
    html_class: "@htmlClass"
    id: "@stepId"
    model: "=ngModel"
  linkFn: (scope, element, attrs, ctrl, transcludeFn)->
    scope.html_class ?= false
    scope.active = parseInt(scope.id) == parseInt(scope.model)
###

###
helper "introStep",
  template_name: "wizard_step"
#scope:
#  model: "=ngModel"
  args:
    step_title: "@stepTitle"
    html_class: "@htmlClass"
    id: "@stepId"

  linkFn: (scope, element, attrs, ctrl, transcludeFn)->
    scope.html_class ?= false
    scope.active = parseInt(scope.id) == parseInt(scope.model)
#scope.active = parseInt(scope.)
#alert("id: #{scope.id}\nmodel: #{scope.model}\nactive: #{scope.active}")
###

$app.directive "introStep", ()->
  transclude: true
  templateUrl: "/assets/helpers/wizard/_wizard_step.html"
  scope:
    step_number: "@stepNumber"
    step_title: "@stepTitle"
    html_class: "@htmlClass"
    step_id: "@stepId"
    model: "=activeStepId"
    wizard: "="
    child_scope_source: "@childScopeSource"
  link: (scope, element, attrs, ctrl, transcludeFn)->
    scope.html_class ?= false
    scope.active = parseInt(scope.id) == parseInt(scope.model)



    if scope.child_scope_source == "controller"
      scope.child_scope = angular.element("[ng-controller]").scope()
    else if scope.child_scope_source == null
      scope.child_scope = scope

    scope.$watch('model', (newValue, oldValue)->
      #alert("activeStepId changed:\noldValue: #{oldValue}\nnewValue: #{newValue}\nstep_id: #{scope.step_id}")
      scope.active = parseInt(scope.step_id) == parseInt(newValue)
      #scope.active = true
    )

    #scope.child_scope_source ?= element
#    transcludeFn scope.child_scope, (clone, childScope)->
#      element.find('.transcluded-content, .yield').append(clone)

$app.directive "wizardStep", ()->
  transclude: true
  templateUrl: "/assets/helpers/wizard/_wizard_step.html"
  scope:
    step_number: "@stepNumber"
    step_title: "@stepTitle"
    html_class: "@htmlClass"
    step_id: "@stepId"
    model: "=activeStepId"
    wizard: "="
    child_scope_source: "@childScopeSource"
  link: (scope, element, attrs, ctrl, transcludeFn)->
    scope.html_class ?= false
    scope.active = parseInt(scope.step_id) == parseInt(scope.model)
    #scope.active =true
    scope.$watch('model', (newValue, oldValue)->
      #alert("activeStepId changed:\noldValue: #{oldValue}\nnewValue: #{newValue}")
      scope.active = parseInt(scope.step_id) == parseInt(newValue)
      #scope.active = true

    )

    step_index = scope.step_id - 1
    scope.proceeded = false
    scope.$watch "wizard.steps[#{step_index}].proceeded", (newValue)->
      scope.proceeded = newValue


    if scope.child_scope_source == "controller"
      scope.child_scope = angular.element("[ng-controller]").scope()
    else if scope.child_scope_source == null
      scope.child_scope = scope.$new()

    transcludeFn scope.child_scope, (clone, childScope)->
      element.find('.transcluded-content, .yield').filter(':not(.transcluded)').each ()->
        angular.element(this).append(clone)
        angular.element(this).addClass('transcluded')





helper "blueHeader",
  template_name: "blue_header"
  args:
    text: "@"
    columns: "@"
  linkFn: (scope, element, attrs, ctrl, transcludeFn)->
    scope.columns ?= false


###
helper "platform",
  require: "ngModel"
  args:
    name: "@"
    image_path: "@imagePath"
    commentable: "@"
    model: "=ngModel"
  linkFn: (scope, element, attrs, ctrl, transcludeFn)->
    scope.commentable ?= true
    scope.name ?= scope.model.name
    scope.image_path ?= scope.model.image_path

###


$app.directive "platform", ()->
  restrict: "E"
  require: "ngModel"
  templateUrl: "/assets/helpers/wizard/_platform.html"
  #transclude: true
  scope:
    #name: "@"
    image_path: "@imagePath"
    model: "=ngModel"
  link: (scope, element, attrs, ctrl, transcludeFn)->
    scope.commentable = attrs.hasOwnProperty('commentable')
    scope.name = scope.model.name
    scope.image_path ?= "/assets/#{scope.model.svg}.svg"
    scope.show_full = attrs.hasOwnProperty("showFull")
    scope.platform_id = scope.model.id

    child_scope_source = attrs.childScopeSource || 'this'
    child_scope = null
    if child_scope_source == 'this'
      child_scope = scope.$new()
    else if child_scope_source == 'controller'
      child_scope = $("[ng-controller]").scope().$new()

    #transcludeFn child_scope, (clone, childScope)->
    #  element.find('.yield').append(clone)


###
helper "optionCount",
  template_name: "option_count"
  require: "ngModel"
  args:
    name: "@"
    ng_model: "=ngModel"
  #optional: ["ng_model"]
###

$app.directive "optionCount", ()->
  templateUrl: "/assets/helpers/wizard/_option_count.html"
  require: ["ngModel"]
  transclude: true
  replace: true
  scope:
    name: "@name"
    html_id: "@htmlId"

  link: (scope, element, attrs, ctrls, transcludeFn)->
    ngModelCtrl = ctrls[0]

    ngModelCtrl.$render = ()->
      scope.model = ngModelCtrl.$modelValue
      scope.name = scope.model.name
      scope.count = scope.model.count || 0
      scope.focused = false

    #console.log "optionCount->ngModelCtrl", ngModelCtrl


    ###
    scope.change_value = (e)->
      alert("handler")
      $label = $(this)
      $input_wrap = $label.closest(".input-wrap")
      $input = $input_wrap.find("input")
      $input.addClass("focus")
      increment = 1
      decrement = 1
      input_value = parseInt($input.val())
      if $label.hasClass("increment")
        #$input.val(input_value + increment)
        scope.model.count = scope.model.count + increment
      else if $label.hasClass("decrement")
        #$input.val(input_value - decrement)
        scope.model.count = scope.model.count + decrement
    ###

    scope.decrement = ()->
      console.log("count", scope.model.count)
      val = (parseInt(scope.model.count) || 0) - 1
      min = 0
      if val < min
        val = min
      if val != scope.model.count
        scope.model.count = val
        scope.onChange()

    scope.increment = ()->
      console.log("count", scope.model.count)
      scope.model.count = (parseInt(scope.model.count) || 0) + 1
      scope.onChange()

    scope.focus = ()->
      #element.find("input").addClass("focus")
      scope.focused = true
    element.find("input").bind("keypress", (e)->
      if e.charCode < 48 || e.charCode > 57
        e.preventDefault()
    )

    scope.onChange = ()->
      v = scope.model
      ngModelCtrl.$setViewValue(v)


    #element.find("div.option-count label, div.option-count input").bind "click",  scope.change_value


$app.directive "commentWithPrice", ()->
  templateUrl: "/assets/helpers/wizard/_comment_with_price.html"
  scope:
    model_comment: "=modelComment"
    model_price: "=modelPrice"
  link: (scope, element, attrs, ctrl, transcludeFn)->
    scope.in_edit = false
    scope.in_new = false
    scope.empty = false
    scope.focusin = false

    scope.$watch("model_comment", (newValue)->
      scope.empty = !newValue || !newValue.length
    )

    scope.$watch("focusin", (newValue)->
      if newValue
        element.find("textarea").focus()
    )

    scope.new = ()->
      scope.in_new = true
    scope.edit = ()->
      scope.in_edit = true

    scope.edit_or_create = ()->
      if scope.model_comment && scope.model_comment.length
        scope.edit()
        scope.focusin = true
      else
        scope.new()
        scope.focusin = true
        #element.find("textarea").focus()


    element.find("textarea").on "focusout", ()->
      scope.in_edit = false
      scope.in_new = false
      scope.focusin = false



$app.directive "rfButton", ['$state', "$location", ($state, $location)->
  template: ()->
    svg_str = "<div class='svg-wrap svg-size-{{rfButton.svgSize()}}' ng-include='svg()' ng-if='svg()'></div>"
    button_title_str = "<div class='button-title' ng-bind='title()' ng-if='title()'></div>"
    button_subtitle_str = "<div class='button-subtitle' ng-if='subtitle()' ng-bind='subtitle()'></div>"
    button_text_wrap_str = "<div class='button-text-wrap'><div class='inner'>#{button_title_str}#{button_subtitle_str}</div></div>"
    button_content_wrap = "<div class='rf-button-content-wrap'><div class='rf-button-content'>#{svg_str}#{button_text_wrap_str}</div></div>"
    button_wrap = "<button angular-ripple=''  ng-class='button_class()'>#{button_content_wrap}</button>"
    return button_wrap
  controllerAs: "rfButton"
  require: ["rfButton"]
  controller: ($scope, $element, $attrs)->
    this.svgSize = ()->
      $attrs.svgSize || 'medium'

    this.maxButtonWidth = ()->
      $attrs.maxButtonWidth

    return this

  replace: true
  scope: true
    #svg: "@"
    #title: "@"
    #subtitle: "@"
    #class: "@"
    #sref: "@"
    #scrollTo: "@"
  link: (scope, element, attrs, ctrls, transcludeFn)->
    rfButtonCtrl = ctrls[0]
    scope.scrollTo = scope.scrollTo || false
    scope.button_class = ()->
      custom_class = attrs.class || ''
      c = "rf-button "
      if scope.subtitle() && scope.subtitle().length
        c += " rf-button-with-subtitle"
      else
        c += " rf-button-without-subtitle"
      if scope.svg() && scope.svg().length
        c += " rf-button-with-svg"
      else
        c += " rf-button-without-svg"
      if scope.class && scope.class.length
        c += " #{scope.class}"
      raised = if eval(attrs.raised) == false then false else true
      if raised
        c += " rf-button-raised"
      else
        c += " rf-button-unraised"
      full_width = if attrs.hasOwnProperty('fullWidth') then true else false
      #console.log "full_width: ", full_width
      if full_width
        c += " rf-button-full-width"
      else
        c += " rf-button-auto-width"
      svg_size = rfButtonCtrl.svgSize()
      c += " rf-button-svg-size-#{svg_size}"
      align_content = attrs.alignContent || "center"
      c += " rf-button-align-content-#{align_content}"

      button_size = attrs.size
      if !button_size || !button_size.length
        button_size = 'medium'
      c += " rf-button-size-#{button_size}"


      c += " #{custom_class}"

      c
    scope.svg = ()->
      attrs.svg
    scope.title = ()->
      attrs.title
    scope.subtitle = ()->
      attrs.subtitle
    scope.href = ()->
      attrs.href || $state.href(attrs.sref)
    scope.sref = ()->
      attrs.sref
    scope.scrollTo = ()->
      attrs.scrollTo

    attrs_to_remove = ['svg', 'title', 'subtitle', 'class', 'sref']
    for k in attrs_to_remove
      a = k.toDash()
      element.removeAttr(a)

    ###
    if !scope.sref || !scope.sref.length
      scope.href = null
    else
      scope.href = $state.href(scope.sref)
    ###

    scope.goToLink = ()->
      sref = scope.sref()

      if sref && sref.length
        $state.go(sref)
      else if href && href.length
        href = alert scope.href()
        #$state.go(scope.sref)
        $location.path(href)

    element.on "click", scope.goToLink


    scope.getHref = ()->
      return scope.href
]

$app.directive "radioInput", ()->
  templateUrl: "/assets/helpers/wizard/_radio_input.html"
  require: "ngModel"
  transclude: true
  replace: true
  scope:
    model: "=ngModel"
    name: "@name"
    label: "@"
    value: "@"
    id: "@"
    methodology: "=methodologyData"
    with_description: "@withDescription"
  link: (scope, element, attrs, ctrl, transcludeFn)->
    transcluded = element.find('.yield').contents()
    scope.block_given = transcluded.length > 0
    #scope.name = scope.
    scope.full_id = "#{attrs.name}__#{attrs.id}"

    transcludeFn scope, (clone, childScope)->
      element.find('.transcluded-content, .yield').append(clone)
      #alert($('.selectize-tags-input input').length)
      #$('.selectize-tags-input > input:not(.tags-input-initialized)').addClass('tags-input-initialized').tagsInput()








###
helper "radioInput",
  template_name: "radio_input"
  args:
    name: "@"
    label: "@"
    value: "@"
    ng_model: "=model"
  optional: ["ng_model"]
  linkFn: (scope, element, attrs, ctrl, transcludeFn)->
    scope.id = "#{scope.name}__#{attrs.id}"
###

###
helper "checkboxInput",
  template_name: "checkbox_input"
  args:
    name: "@"
    label: "@"
    value: "@"
    ng_model: "=model"
  optional: ["ng_model"]
  linkFn: (scope, element, attrs, ctrl, transcludeFn)->
    scope.id = "#{scope.name}__#{attrs.id}"
###


$app.directive "checkboxInput", ()->
  templateUrl: "/assets/helpers/wizard/_checkbox_input.html"
  require: "ngModel"
  transclude: false
  replace: true
  scope:
    model: "=ngModel"
    name: "@name"
    label: "@"
    value: "@"
    id: "@"
    model_count: "=modelCount"
  link: (scope, element, attrs, ctrl, transcludeFn)->
#scope.name = scope.
    scope.full_id = "#{attrs.name}__#{attrs.id}"
    scope.label ?= scope.value
    element.find("input").on "change", ()->

      $input = $(this)
      checked = $input.filter(":checked").length > 0
      value = $input.val()
      #alert("checked: #{checked}\nvalue=#{value}")
      arr = scope.model
      if checked
        arr.push(value)
      else
        arr.splice(arr.indexOf(value), 1)
      arr_count = arr.length
      scope.model = arr
      scope.model_count = Math.random()
      #scope.model = scope.model + 1

      if scope.name == 'project_languages'
        cs = angular.element("[ng-controller]").scope()
        cs.project_languages_count = cs.project_languages_count + 1
        cs.$apply()
      if scope.name == 'report_languages'
        cs = angular.element("[ng-controller]").scope()
        cs.report_languages_count = cs.report_languages_count + 1
        cs.$apply()

$app.directive "checkboxInputCollection", ()->
  templateUrl: "/assets/helpers/wizard/_checkbox_input_collection.html"
  require: "ngModel"
  transclude: false
  replace: false
  scope:
    model: "=ngModel"
    name: "@name"
    #label: "@"
    #value: "@"
    #id: "@"
    model_count: "=modelCount"
    model_available: "=modelAvailable"
  link: (scope, element, attrs, ctrl, transcludeFn)->
#scope.name = scope.
    scope
    scope.full_id = "#{attrs.name}__#{attrs.id}"
    scope.label ?= scope.value
    element.find("input").on "change", ()->

      $input = $(this)
      checked = $input.filter(":checked").length > 0
      value = $input.val()
      #alert("checked: #{checked}\nvalue=#{value}")
      arr = scope.model
      if checked
        arr.push(value)
      else
        arr.splice(arr.indexOf(value), 1)
      arr_count = arr.length
      scope.model = arr
      scope.model_count = Math.random()
#scope.model = scope.model + 1


###
helper "question",
  args:
    text: "@"
    centered: "@"
    required: "@"
  linkFn: (scope, element, attrs, ctrl, transcludeFn)->
    scope.centered ?= false
    scope.required = attrs.required || false

###

$app.directive "question", ()->
  restrict: 'E'
  scope:
    text: "@"
    centered: "@"
    required: "@"
  templateUrl: "/assets/helpers/wizard/_question.html"
  transclude: true
  link: (scope, element, attrs, ctrl, transcludeFn)->
    scope.centered ?= false
    scope.required ?= false


$app.directive "topNav", ['$location', "$state", ($location, $state)->
  scope:
    menu: "="
    active: "="
    menu_item_class: "@itemClass"
  templateUrl: "/assets/helpers/wizard/_top_nav.html"
  link: (scope, element, attrs, ctrl, transcludeFn)->
    scope.menuItemClass = (menu_item)->
      drop_down_class = if menu_item.subitems && menu_item.subitems.length then "has-dropdown" else ""
      active_class = scope.menuItemActiveClass(menu_item)
      opened_class = if menu_item.opened then "opened" else ""
      return "#{drop_down_class} #{active_class} #{scope.menu_item_class} #{opened_class}"

    scope.menuItemActiveClass = (menu_item)->
      currentRoute = $location.path().substring(1) or 'home'
      #active = if scope.menuItemSref(menu_item) == currentRoute then true else false
      active = $state.is(scope.menuItemSref(menu_item))
      #console.log("menu_item<#{menu_item.title}>; active: #{active}; current_route: #{currentRoute};sref: #{scope.menuItemSref(menu_item)}")
      klass = if active then 'active' else ''
      return klass
    scope.closeDropdown = (menu_item, event)->
      console.log("closeDropdown")
      if menu_item.subitems && menu_item.subitems.length
        menu_item.opened = false

    scope.toggleDropdown = (menu_item, event)->
      if menu_item.subitems && menu_item.subitems.length
        menu_item.opened = !menu_item.opened || false
        event.preventDefault()
        #console.log("class: #{scope.menuItemClass(menu_item)}")
        #scope.$apply()

    scope.menuItemSref = (menu_item)->
      if menu_item.sref && menu_item.sref.length
        return menu_item.sref
      else
        return false
    scope.dropdowns = ()->
      dropdowns = []
      for menu_item in scope.menu
        if menu_item.subitems && menu_item.subitems.length
          dropdowns.push(menu_item.subitems)
      return dropdowns

    on_resize = ()->
      

    window.onresize = on_resize

]

$app.directive 'onFinishRender', ($timeout) ->
  restrict: 'A',
  link:  (scope, element, attr)->
    if scope.$last == true
      scope.$emit('ngRepeatFinished')
      #$timeout ()->
        #scope.$emit('ngRepeatFinished');

$app.directive 'afterRepeat', ($timeout) ->
  restrict: 'A',
  scope:
    afterRepeat: '&'
  link:  (scope, element, attr)->
    #alert("afterRepeat, #{scope.$last}")
    if scope.$last == true

      #scope.$emit('ngRepeatFinished')
      scope.afterRepeat()()


#$timeout ()->
#scope.$emit('ngRepeatFinished');



$app.directive 'scrollToItem', ->
  restrict: 'A'
  scope:
    scrollTo: '@'
  link: (scope, $elm, attr) ->
    $elm.on 'click', ->
      $('html,body').animate { scrollTop: $(scope.scrollTo).offset().top }, 'slow'


$app.directive "rfForm", ()->
  restrict: "E"
  require: ["?name"]
  replace: false
  transclude: true
  scope:
    class: "@"
  link: (scope, element, attrs, ctrl)->
    scope.formClass = ()->
      return "rf-form #{scope.class || "" }"
    scope.formName = ()->
      return attrs.name || ""

  template: "<form novalidate name='{{formName()}}' ng-class='formClass()'><div class='form-content' ng-transclude=''></div></form>"

###
$app.directive "rfInput", ()->
  restrict: 'E'
  require: ["^?rfForm", "ngModel"]
  replace: false
  scope:
    label: "@"
    type: "@"
    ngModel: "="
    name: "@"
    required: "@"

  template: "<div class='input-wrap' ng-class='inputClass()'><input ng-focus='hasFocus()' ng-blur='leaveFocus()' ng-required='isRequired()' ng-class='inputClass()' ng-model='ngModel' id='{{id()}}' type='{{type}}'/><div class='input-border-wrap'></div><label>{{label}}</label><div class='input-errors' ng-if='errors() && errors().length'><div class='error' ng-repeat='e in errors()' ng-class='e.error_key'>{{e.message}}</div></div></div>"
  link: (scope, element, attrs, ctrl)->
    closest_form = element.parent()

    _focused = false

    scope.build_error_message = (error_type, field_name, args)->
      args ?= {}
      error_messages =
        error_keys:
          required: "#{field_name} is required"
          min_length: "#{field_name} must be at least #{args.count} characters"
        #field_names:


      e = error_messages.error_keys[error_type]
      if error_messages.field_names && error_messages.field_names[field_name] && error_messages.field_names[error_type]
        e = error_messages.field_names[field_name][error_type]
      return e

    scope.errors = ()->
      errors = []
      field = scope.getFormScopeField()
      if field
        field_error = field.$error
        if field_error
          for error_name, error of field_error
            errors.push({error_key: error_name, message: scope.build_error_message(error_name, scope.name)})


    scope.getFormScopeField = ()->
      return scope.getFormScope()[scope.name]

    scope.getFormScope = ()->
      while closest_form[0].tagName.toLowerCase() != 'rf-form'
        closest_form = closest_form.parent()
      form = closest_form
      #form_scope = form.scope()
      form_name = form.attr('name')
      field_name = scope.name
      #form_scope_model = form_scope[]
      form_scope = scope
      while form_scope && form_scope[form_name] == undefined
        form_scope = form_scope.$parent
      if form_scope
        form_scope = form_scope[form_name]

    scope.isRequired = ()->
      return !!attrs.required
    scope.inputClass = ()->
      form = form_scope_field
      form_scope = scope.getFormScope()
      field_name = scope.name


      #console.log("form_scope", form_scope)
      type = scope.type || "string"
      if form_scope


        form_scope_field = form_scope[field_name]
        if form_scope_field
          console.log "form_scope_field", form_scope_field
          focus_class = if _focused then 'focus' else ''
          success_class = if form_scope_field.$valid then 'has-success' else ''
          error_class = if form_scope_field.$invalid && (form_scope.$submitted || form_scope_field.$touched) then 'has-error' else ''
      else
        focus_class = ""
        success_class = ""


      empty_class = if !scope.ngModel || !scope.ngModel.length then "is-empty" else "not-empty"
      return "#{type} #{empty_class} #{focus_class || ''} #{success_class || ''} #{success_class || ''} #{error_class || ''}"
    scope.hasFocus = ()->
      _focused = true
    scope.leaveFocus = ()->
      _focused = false

    scope.id = ()->
      while closest_form[0].tagName.toLowerCase() != 'rf-form'
        closest_form = closest_form.parent()
      form_name = closest_form.attr('name')
      return "#{form_name}__#{attrs.id || attrs.name || 'field-' + Math.random() * 10 | 0}"
    scope.fieldName = ()->
      while closest_form[0].tagName.toLowerCase() != 'rf-form'
        closest_form = closest_form.parent()
      form_name = closest_form.attr('name')
      return "#{form_name}[#{attrs.name || attrs.id || 'field-' + (Math.random() * 10 | 0 ) }]"

###

###
$app.directive 'outsideClick', ($document) ->
  {
  restrict: 'A'
  link: (scope, elem, attr, ctrl) ->
    elem.bind 'click', (e) ->
      e.stopPropagation()
      return
    $document.bind 'click', ->
      scope.$apply attr.outsideClick
      return
    return

  }
###

###
$app.directive "svgImage", ()->
  replace: false
  transclude: true
  scope:
    src: "@"
  templateUrl: "/assets/helpers/wizard/svg_image.html"
  #template: "<ng-include src='\'/assets/android.svg\''></ng-include>"
  #template: '<ng-include src="\'image_url\'"></ng-include>'
  #template: "<img src='{{image_url}}'/>"
  link: (scope, element, attrs, ctrl, transcludeFn)->
    scope.image_url = "/assets/#{attrs.src}.svg"
    #scope.image_url = "/assets/#{attrs.src}.svg"
    #scope.image_url = "/assets/android.svg"
###

###
$app.directive "svgImage", (compileFn)->
  replace: true
  scope: false
  restrict 'EA'
  link: (scope, element, attrs)->
    scope.image_url = attrs.src || null
    dom = angular.element "<div class='svg-image' ng-include='image_url'></div>"
    $e = compileFn(dom)(scope)
    element.replaceWith($e)
###


###
$app.directive "yield",
  replace: true
  scope: false
  template: "<div class='transcluded-content'></div>"
###


#$app.directive 'optionImage', ()->
#  #require: ['ngModel']
#  replace: true
#  scope:
#    ng_model: "=model"
#    image_path: "@imagePath"
#  transclude: true
#  templateUrl: "#{helper_path}_option_image.html"
#  link: (scope, element, attrs, ctrl, transclude)->
#    scope.name = attrs.name
#    scope.label = attrs.label
#    scope.value = attrs.value
#    scope.columns_count = attrs.columnsCount || 4
#    scope.description = attrs.description || null
#    scope.id = "#{scope.name}__#{attrs.id}"
#    scope.image_path = "/assets/android.svg"
#
#    transclude scope, (clone, childScope)->
      #if !scope.ng_model
        #element.find('input').removeAttr("ng-model")
###
  .directive 'introStep', ()->
    replace: true
    scope:
      step_title: "@stepTitle"
      html_class: "@htmlClass"
    transclude: true
    templateUrl: "#{helper_path}_wizard_step.html"
    link: (scope, element, attrs, ctrl, transclude)->
      scope.html_class ?= false
      transclude scope, (clone, childScope)->
        element.find('.transcluded-content').append(clone)


  .directive 'question', ()->
    replace: true
    scope:
      text: "@"
      centered: "@"
    transclude: true
    templateUrl: "#{helper_path}_question.html"
    link: (scope, element, attrs, ctrl, transclude)->
      scope.centered ?= false
      transclude scope, (clone, childScope)->
        element.find('.transcluded-content').append(clone)

  .directive 'blueHeader', ()->
    replace: true
    scope:
      text: "@"
      columns: "@"
    transclude: true
    templateUrl: "#{helper_path}_blue_header.html"
    link: (scope, element, attrs, ctrl, transclude)->
      scope.columns ?= false
      transclude scope, (clone, childScope)->
        element.find('.transcluded-content').append(clone)

  .directive 'blueHeader', ()->
    replace: true
    scope:
      text: "@"
      columns: "@"
    transclude: true
    templateUrl: "#{helper_path}_blue_header.html"
    link: (scope, element, attrs, ctrl, transclude)->
      scope.columns ?= false
      transclude scope, (clone, childScope)->
        element.find('.transcluded-content').append(clone)

.directive "container", ()->
    scope: {}
    transclude: true
    replace: true
    template: "<div class='my-container  columns-{{columns_count}}'><div class='container-header'></div><div class='container-content'><div>static label</div><div class='transcluded-content'  >{{transcluded_content}}</div></div><div class='container-footer'>name: {{name}}<br>title: {{title}}</div></div>"
    link: (scope, element, attrs, ctrl, transclude)->
      scope.name = "my name"
      scope.title = "my title"
      scope.columns_count = attrs['columnsCount'] || 4
      transclude scope, (clone, childScope)->
        element.find('.transcluded-content').append(clone)

###

