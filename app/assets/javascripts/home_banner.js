var activate_slide = function(){
    var $slide = $(this)
    $slide.addClass("active")
    $header = $slide.find(".header")
    $text = $slide.find(".text")
    $header.textillate({in: { effect: 'fadeIn' }}).textillate("start")
    $text.css({opacity: 0})
    $header_span = $header.find("> span:first-child")
    header_text =	$.trim($header_span.text())
    console.log("slide: header:", header_text)
    setTimeout(
        function(){
            $text.css({opacity: 1})
            $text.textillate({in: { effect: 'fadeIn', delay: 75 }}).textillate("start")
        },
        50 * header_text.length * 0.75
    )

}

var deactivate_slide = function(){
    var $slide = $(this)
    $slide.removeClass("active")

}

var initialize_video = function(){
    //$("#home-banner-bg").tubular({videoId: "qCPARg-DaFM", parent: "#home-banner-bg"})

}


var next_slide = function(options){
    if(options == undefined){
        options = {}
    }

    var defaults = {
        loop: true
    }

    options = $.extend(defaults, options)

    $container = $("#home-banner-content")
    $active_slide = $container.find(".slide.active")
    if($active_slide.length == 0){
        activate_slide.apply($container.find(".slide").first())

        return
    }
    //return
    $next_slide = $active_slide.next().filter(".slide")
    if($next_slide.length == 0){
        $next_slide = $container.find(".slide").first()
    }

    //$active_slide.fadeOut(800)
    deactivate_slide.apply($active_slide)
    //$next_slide.fadeIn(800)
    activate_slide.apply($next_slide)
}


next_slide()
//setInterval(next_slide, 10000)
$active_slide = $("#home-banner-content .slide.active")
$small_text = $("#home-banner .small-text")
small_text = $.trim($small_text.text())
$small_text.text(small_text)

header_text = $.trim($active_slide.find(".header > span:first-child").text())
text_text = $.trim($active_slide.find(".text > span:first-child").text())

console.log("small_text: header: ", header_text, "text: ", text_text)
setTimeout(
    function(){
        $small_text.removeClass("transparent")
        $small_text.textillate({in: { effect: 'fadeIn' }, callback: function(){
            //$("<br/>").insertBefore($small_text.find(".word6"))
        }})

    },
    header_text.length * 50 * 0.75 + text_text.length * 75
)

