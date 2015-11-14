window.w = (str)->
  str.split(' ')
String.prototype.in = (args)->
  s = this.toString()
  args.indexOf(s) >= 0

window.diff = (obj1, obj2)->
  result = {}
  $.each obj2, (key, value) ->
    if !obj1.hasOwnProperty(key) or obj1[key] != obj2[key]
      result[key] = value

  result

String::camelize = () ->
  res = this
  .replace /[\s|_|-](.)/g, ($1) -> $1.toUpperCase()
  .replace /[\s|_|-]/g, ''
  .replace /^(.)/, ($1) -> $1.toLowerCase()

  res[0] = res[0].toUpperCase()

  res.replace(/^./, res[0].toUpperCase())


window.clone = (obj, options = {})->
  options.except_keys ?= []

  res = $.extend({}, obj)
  if options.except_keys.length
    for k in options.except_keys
      delete res[k]

  res

String::classify = ()->
  this.camelize()

Array::last = ()->
  this[this.length]


window.byString = (s, o = window) ->
  s = s.replace(/\[(\w+)\]/g, '.$1')
  # convert indexes to properties
  s = s.replace(/^\./, '')
  # strip a leading dot
  a = s.split('.')
  i = 0
  n = a.length
  while i < n
    k = a[i]
    if k of o
      o = o[k]
    else
      return
    ++i
  o



window.is_present = (val) ->
  if val == null || val == undefined
    return false
  if typeof val.length != 'undefined'
    return val.length > 0
  else if val == 0
    return true

  return true


window.is_blank = (val) ->
  !isPresent(val)

#Object::is_present = ()->
#  isPresent(this)
#
#
#Object::is_blank = ->
#  isBlank(this)
#
Array::has_any = ->
  this.length > 0

Array::is_empty = ->
  this.length == 0



window.virtual_class = (classes...)->
  classes.reduceRight (Parent, Child)->
    class Child_Projection extends Parent
      constructor: ->
# Temporary replace Child.__super__ and call original `constructor`
        child_super = Child.__super__
        Child.__super__ = Child_Projection.__super__
        Child.apply @, arguments
        Child.__super__ = child_super

        # If Child.__super__ not exists, manually call parent `constructor`
        unless child_super?
          super

    # Mixin prototype properties, except `constructor`
    for own key  of Child::
      if Child::[key] isnt Child
        Child_Projection::[key] = Child::[key]

    # Mixin static properties, except `__super__`
    for own key  of Child
      if Child[key] isnt Object.getPrototypeOf(Child::)
        Child_Projection[key] = Child[key]

    Child_Projection