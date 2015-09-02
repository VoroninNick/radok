#window.Wizard ?= {}
#Wizard.Steps ?= {}
#Wizard.Test = class Test
#  constructor: ()->
#  @new: ()->
#    steps = jQuery.getJSON("/wizard/new_test_available_steps")
#    return steps
#
#Wizard.Step = class Step
#  constructor: ()->
#
#Wizard.Steps.Intro = class Intro extends Wizard.Step


#$app.config [
#  "valdrProvider"
#  (valdrProvider)->
#    valdrProvider.addConstraints(
#      WizardTest:
#        project_name:
#          required: {}
#        version_number:
#          required: {}
#    )
#]

random_name = ()->
  "Project-#{Math.ceil(Math.random() * 1000)  } "

$app.factory "WizardTest", ($http)->
  obj =
    name: null
    data: null
    platforms: null
    load: ()->
      if obj.data == null
        $http.get("/wizard/new_test_available_steps").success (response)->
          obj.data = response
      return obj
    load_platforms: (type_of_product)->
      $http.get("/wizard/available_platforms_by_product_type/#{type_of_product}").success (response)->
        obj.platforms = response
    new: ()->
      obj.data = 
        tot__type_of_test: ""
        top__type_of_product: ""
        ps__platforms: ""
        ps__hours: 1
        pi__project_name: random_name()
        pi__project_version: ""
        pi__project_languages: ["English"]
        pi__report_languages: ["English"]
        tp__type_of_testing: "exploratory"
        tp__exploratory_instructions: ""
        #t.has_attached_file :tp__test_case_attachment
        pa__access_instructions_url: ""
        #pa__access_instructions_attachment
        pa__access_user_name: ""
        pa__access_password: ""
        pa__need_authorization: false
        pa__comment: ""

      return obj
  return obj

#o.getAll = function() {
#return $http.get('/posts.json').success(function(data){
#angular.copy(data, o.posts);
#});
#};