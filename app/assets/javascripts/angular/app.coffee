(()->
  orig = angular.module
  angular.modules = []
  angular.module = ()->
      args = Array.prototype.slice.call(arguments);
      if arguments.length > 1
        angular.modules.push(arguments[0])

      return orig.apply(null, args)

)();

window.$app = angular.module('app', [ 'ui.router', 'ngTagsInput', 'sparkscreative.attach-if', "angular.validators", "countTo", "angular-carousel", "ngResource", "ngSanitize", "ngMap", "offClick", "ngDialog", "ngCapsLock", "angular-svg-round-progress", 'ng-token-auth', "angularRipple", "angular-inview", "angular-loading-bar", "validation.match", "ngJcrop", "ngFileUpload", "ipCookie", "checklist-model", "ocNgRepeat"])
$app.config(
  [ '$authProvider'
    'cfpLoadingBarProvider'
    ($authProvider, cfpLoadingBarProvider)->
      $authProvider.configure(
        apiUrl: ''
        authProviderPaths:
          gplus: "/auth/gplus"
          facebook: "/auth/facebook"

      )


      cfpLoadingBarProvider.includeBar = false
      cfpLoadingBarProvider.latencyThreshold = 0;
  ]
)
#$app.helper_method = (options)->
#
#  # helper settings
#  helper_defaults =  {
#    helper_name: "wizard"
#    templates_folder_url: "/assets/helpers/"
#  }
#
#  helper_defaults.template_name = options.name
#
#  helper_defaults['this_helper_templates_folder_url'] = "#{helper_defaults['templates_folder_url']}#{helper_defaults['helper_name']}/"
#
#  helper_method_settings = helper_defaults
#
#  has_block = true
#
#
#  # directive settings
#  directive_name = options.name
#  directive_scope = {}
#  directive_replace = true
#  directive_transclude = true
#  directive_template_url = helper_defaults.template_name
#  disable_auto_link = false
#  link = options.link
#
#
#  $app.directive directive_name, ()->
#    replace: directive_replace
#    scope: directive_scope
#    transclude: directive_transclude
#    templateUrl: directive_template_url
#    link: (scope, element, attrs, ctrl, transcludeFn)->
#      if typeof link == 'function'
#        link_this = this
#        link_this.scope = scope
#        link_this.element = element
#        link_this.attrs = attrs
#        link_this.ctrl = ctrl
#        link_this.transcludeFn = transcludeFn
#        link_args = arguments
#
#        link.apply link_this, link_args
#      transcludeFn scope, (clone, childScope)->
#        element.find('.transcluded-content').append(clone)
#
#$app.helper = (fn)->
#  args = []
#  valueForThis = {}
#
#  valueForThis.selectColor = (color)->
#    console.log("selected color: #{color}")
#
#  fn.apply(valueForThis, args)

window.helper = (directive_name, options = {})->
  directive_name = directive_name
  scope_variables = options.args || {}
  linkFn =  if typeof options.linkFn == 'function' then options.linkFn else false

#  param_names = getFunctionParamNames(linkFn) || []
#  for p in param_names
#    scope_variables[p] = "@"
  options.template_name ?= directive_name
  underscored_template_name = "_#{options.template_name}"
  template_url = "/assets/helpers/wizard/#{underscored_template_name}.html"

  options_transcludeFn = if typeof options.transcludeFn == 'function' then options.transcludeFn else false

  optional_model_args = options.optional || []
  require = options.require || []

  $app.directive directive_name, ()->
    require: require
    replace: true
    scope: options.scope || true
    transclude: true
    templateUrl: template_url

    link: (scope, element, attrs, ctrl, transcludeFn)->
      for key, value of scope_variables
        if value[0] == '@'
          if value == '@'
            scope[key] = attrs[key]
          else
            scope[key] = attrs[value.substr(1)]
        else if value[0] == '='
          if value == '='
            scope[key] = attrs[key]
          else
            scope[key] = attrs[value.substr(1)]

      if linkFn
#        link_this = this
#        link_this.scope = scope
#        link_this.element = element
#        link_this.attrs = attrs
#        link_this.ctrl = ctrl
#        link_this.transcludeFn = transcludeFn
        linkFn.apply this, arguments


      transcluded = element.find('.yield').contents()
      scope.block_given = transcluded.length > 0

      child_scope_source = attrs.childScopeSource || 'this'
      child_scope = null
      if child_scope_source == 'this'
        child_scope = scope.$new()
      else if child_scope_source == 'controller'
        child_scope = $("[ng-controller]").scope().$new()

      transcludeFn child_scope, (clone, childScope)->
        element.find('.transcluded-content, .yield').append(clone)
        if options_transcludeFn
          options_transcludeFn.apply(this, arguments)
        if optional_model_args.length > 0
          for m in optional_model_args
            if !childScope[m]
              element.find("[ng-model='#{m}']").removeAttr("ng-model")





###

helper_method
  template_name: "custom_name"
  method: (name, text, age)->

###


window.getInfo = (a,b,c,d,e)->
  "a: #{a}\nb: #{b}"

window.getFunctionParamNames = (fn)->
  if typeof fn == 'function'
    str = fn.toString().replace(/\s/g, '')
    start_index = str.indexOf("(")
    end_index = str.indexOf(")")
    len = end_index - start_index + 1
    if start_index == -1 || end_index == -1
      return undefined

    start_index++
    end_index++
    len -= 2

    if len > 0
      names_str = str.substr(start_index, len)
      names = names_str.split(",")
      return names
    else
      return []
  else
    return undefined

#window.lowerCamelCase = (input) ->
#  occurence = 0
#  replace_func = (match, group1, group2) ->
#    occurence++
#    if group2 && group2.length
#
#      if occurence > 1
#        group2.toUpperCase()
#      else
#        group2
#
#
#
#  input.toLowerCase().replace /(.)-(.)/g, replace_func
#  occurence = 0
#  input.toLowerCase().replace /(.)_(.)/g, replace_func

#window.toLowerCamelCase =  ()->
#  expr = /-([a-z])/g
##  (prop) ->
##    if expr.test(prop) then prop.replace(expr, (->
##      arguments[1].toUpperCase()
##    )) else prop
#  return expr.test


