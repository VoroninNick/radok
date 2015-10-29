class EventedClass

  bind: (event, callback) ->
    @eventHandlers ||= {}
    @eventHandlers[event] = [] unless @eventHandlers[event]?
    @eventHandlers[event].push(callback)
    return true

  unbind: (event, callback) ->
    @eventHandlers ||= {}
    if @eventHandlers[event]? && @eventHandlers[event].indexOf(callback) >= 0
      @eventHandlers[event].splice(@eventHandlers[event].indexOf(callback), 1)
      return true
    else
      return false

  unbindAll: ->
    @eventHandlers = {}
    return true

  trigger: (event, data={}, options = {}) ->
    options['break_on_false'] ?= true
    @eventHandlers ||= {}
    if @eventHandlers[event]? && @eventHandlers[event].length > 0
      for callback in @eventHandlers[event]
        res = null

        if typeof(callback) == 'function'
          res = callback(data)
          if options['break_on_false'] && res == false
            return false
      return true
    else
      #return false

    return true
window.EventedClass = EventedClass