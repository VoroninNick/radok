class Formify.TypeConverter
  @parse_boolean : (val)->
    if typeof val == 'string'
      if val.toLowerCase() == 't' || val.toLowerCase() == 'true' || val == '1'
        val = true
      else
        val = false

    val