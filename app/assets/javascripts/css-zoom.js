/*
 jquery polyfill for css zoom property for firefox
 https://gist.github.com/Nemo64/dce219b81695b177000c
*/

$.cssNumber.zoom = true;
if (!("zoom" in document.body.style)) {
    $.cssHooks.zoom = {
        get: function(elem, computed, extra) {
            var value = $(elem).data('zoom');
            return value != null ? value : 1;
        },
        set: function(elem, value) {
            var $elem = $(elem);
            var size = { // without margin
                width: $elem.outerWidth(),
                height: $elem.outerWidth()
            };
            $elem.data('zoom', value);
            if (value != 1) {
                $elem.css({
                    transform: 'scale(' + value + ')',
                    marginLeft: (size.width * value - size.width) / 2,
                    marginRight: (size.width * value - size.width) / 2,
                    marginTop: (size.height * value - size.height) / 2,
                    marginBottom: (size.height * value - size.height) / 2
                });
            } else {
                $elem.css({
                    transform: null,
                    margin: null
                });
            }
        }
    };
}