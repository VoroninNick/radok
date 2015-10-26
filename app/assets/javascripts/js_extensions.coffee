window.w = (str)->
  str.split(' ')
String.prototype.in = (args)->
  s = this.toString()
  args.indexOf(s) >= 0

