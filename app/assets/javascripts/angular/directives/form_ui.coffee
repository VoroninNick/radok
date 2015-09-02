


wrapElement = (element, attrs)->




#$app.directive "rfSelect", [ ()->
#  template: (element, attrs)->
#    collection = attrs.collection
#  scope: false
#
#]


inputTemplate = (element, attrs)->
  #console.log "attrs", attrs
  tag = element[0].tagName.toLowerCase()
  if tag == "my-input"
    tag = 'input'
  else if tag == 'rf-textarea'
    tag = 'textarea'
  element.html_tag = tag
  input_str = "<#{tag} "
#  if attrs['ng-model']
#    attrs['ng-model'] = 'ngModel'
  excluded_attrs = ["label"]
  for k, v of attrs
    if k[0] != '$' && excluded_attrs.indexOf(k) == -1
      k = k.toDash()
      if k == 'model'
        k = 'ng-model'
        v = 'model'
        #console.log "k: ", k
        #console.log "v: ", v
      input_str += "#{k}='#{v}'"

  input_str += "/>"
  label_str = "<label>#{attrs.label}</label>"
  border_wrap_str = "<div class='input-border-wrap'></div>"

  error_messages_str = "<div class='error-messages' ng-show='form_field.$touched && keys_count(form_field.$error)'><div ng-repeat='(error_key, error_value) in form_field.$error' class='field-error-message {{error_key}}'>{{getErrorMessage(error_key)}}</div></div>"


  input_wrap = "<div ng-class='wrap_class()' class='rf-input-wrap'>#{border_wrap_str}#{label_str}#{input_str}#{error_messages_str}</div>"
  #return str
  str = input_wrap
  return str

inputLink = (scope, element, attrs, ngModel, transcludeFn)->
  element.on "focusin", ()->
    element.removeClass("focus-out")
    element.addClass("focus-in")
  element.on "focusout", ()->
    element.addClass("focus-out")
    element.removeClass("focus-in")

  #console.log "focusout"
  element_form = element
  while element_form[0].tagName != 'FORM'
    element_form = element_form.parent()
  form_name = element_form.attr("name")
  scope.form = scope.$parent[form_name]
  scope.form_field = scope.form[attrs.name]



  scope.wrap_class = ()->
    touched = if scope.form_field.$touched then 'ng-touched' else 'ng-untouched'
    is_empty = if !scope.form_field.$modelValue || !scope.form_field.$modelValue.length then 'is-empty' else 'not-empty'
    html_tag_class = if element.html_tag then "tag-" + element.html_tag else ""
    c = "#{html_tag_class} #{touched} #{is_empty}"

    return c

  scope.getErrorMessage = (error_key)->
    if !error_key || !error_key.length
      return ''
    error_key[0] = error_key[0].toUpperCase()
    msg = attrs["errorMessage" + error_key]
    if !msg
      msg = error_key
    return msg

  attrs_to_remove = ['model']
  for k in attrs_to_remove
    a = k.toDash()
    element.removeAttr(a)

inputDirective = ()->
  #restrict: "E"
  #require: "ngModel"
  template: inputTemplate
  replace: true
  scope:
    model: "="
  link: inputLink
checkboxTemplate = ()->

checkboxDirective = ()->
  template: checkboxTemplate
  replace: true
  restrict: "E"
  #scope: false
  link: ()->

inputTextTemplate = (element, attrs)->
  "<input ng-model='value' ng-change='onChange()'>"

#$app.directive "rfInput", ()->
#  restrict: ""
#  require: ["?ngModel", "rfInput"]
#  controllerAs: "rfInput"
#  controller: ()->
#
#  scope: {}
#  template: (element, attrs)->
#    type = attrs.type || 'text'
#    if type == 'text'
#      return inputTextTemplate()
#
#
#  link: (scope, element, attrs, ctrls)->
#    ngModelCtrl = ctrls[0]
#
#    scope.onChange = ()->
#      ngModelCtrl.$setViewValue(scope.value);
#
#    ngModelCtrl.$render = ()->
#      scope.value = ngModelCtrl.$modelValue;



$app.directive "pureCheckbox", ()->
  require: "ngModel"
  template: (element, attrs)->
    checkbox = "<label ></label>"
    input = "<input ng-model='value'/>"
  link: (scope, element, attrs, ctrl)->
    scope.changeValue = ()->


$app.directive "myInput", inputDirective
$app.directive "rfTextarea", inputDirective
$app.directive "myCheckbox", checkboxDirective

#$app.directive "customInput", ()->
#require: "ngModel"
#template: (element, attrs)->
#  "<input ng-model='model'  />"
#replace: true
#scope: {
#  model: "=model"
#}
#link: (scope, element, attrs, ngModel)->



$app.directive "equalTo", ()->
  restrict: "A"
  require: "ngModel"
  link: (scope, element, attrs, model, transcludeFn)->
    scope.$watch attrs.equalTo, (value)->
      # Only compare values if the second ctrl has a value.
      if typeof model.$viewValue != 'undefined' && model.$viewValue != ''
        valid = value == model.$viewValue
        model.$setValidity('equalTo', valid)
        console.log("model.setValidity", valid)



    model.$parsers.push (value)->
      # Mute the nxEqual error if the second ctrl is empty.
      if typeof value == 'undefined' || value == ''
        model.$setValidity('equalTo', true);
        return value;

      isValid = value == scope.$eval(attrs.equalTo)
      model.$setValidity('equalTo', isValid);
      value_to_return = if isValid then value else undefined

      return value_to_return

$app.directive "fullHeight", ["$window", ($window)->
  link: (element)->
    setHeight = ()->
      e = angular.element(".profile-tab-contents-row-wrap")
      e.css('minHeight', 'none')
      h = e.height()
      wrap_height = angular.element("#wrap").height()
      header_height = angular.element("#header").height()
      main_height = angular.element('main').height()
      height_increment = wrap_height - (header_height + main_height)
      if height_increment > 0
        h = h + height_increment
        e.css("minHeight", h)
    setHeight()
    $(window).on "resize", setHeight
]

