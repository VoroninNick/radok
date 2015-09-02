window.keys_count = (obj)->
  if typeof obj != 'object'
    return null
  keys = []
  for k,v of this
    keys.push k
  return keys.length

String.prototype.toDash = ()->
  return this.replace /([A-Z])/g, ($1)->
    return "-"+$1.toLowerCase()


String.prototype.humanize = ()->
  property = this
  property.replace(/_/g, ' ').replace /(\w+)/g, (match)->
    match.charAt(0).toUpperCase() + match.slice(1)
