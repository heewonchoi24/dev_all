// Main Index Slider //
jQuery("html").addClass("index_slider_fouc");
jQuery(document).ready(function () {
    jQuery(".index_slider_fouc .index_slider").css({
        "display": "block"
    });
});
jQuery(function () {
    var $index_wrapper = jQuery("#index_slider");
    var $index_item = jQuery("div.index-slider-nav");
    var $slider_control = jQuery("#index-slider-control");
    var $image_container = jQuery(".index_slideri");
    var ordernumber;
    var pause_scroll = false;
    $slider_control.find(".index-active-lt").addClass("index-active-lt-theme-yellow");
    $index_item.find("img").fadeTo("fast", 0.85);
    $slider_control.find(".index-active-lt img").fadeTo("fast", 1);
    $image_container.hover(function () {
        jQuery(this).find("img").stop(true, true).fadeTo("fast", 0.85);
        pause_scroll = true;
    }, function () {
        jQuery(this).find("img").stop(true, true).fadeTo("fast", 1);
        pause_scroll = false;
    });

    function index_gonext(this_element) {
        $slider_control.find(".index-active-lt img").stop(true, true).fadeTo("fast", 0.85);
        $slider_control.find(".index-active-lt").removeClass("index-active-lt");
        $slider_control.find(".index-active-lt-theme-yellow").removeClass("index-active-lt-theme-yellow");
        this_element.addClass("index-active-lt");
        this_element.addClass("index-active-lt-theme-yellow");
        $slider_control.find(".index-active-lt img").stop(true, true).fadeTo("fast", 1);
        ordernumber = this_element.find("span.index-order").html();
        jQuery("#index_slides").cycle(ordernumber - 1);
    }
    $index_item.click(function () {
        clearInterval(interval);
        index_gonext(jQuery(this));
        return false;
    });
    $index_item.hover(function () {
        pause_scroll = true;
    }, function () {
        pause_scroll = false;
    });
    var auto_number;
    var interval;
    $index_item.bind("index_autonext", function index_autonext() {
        if (!(pause_scroll)) index_gonext(jQuery(this));
        return false;
    });
    interval = setInterval(function () {
        var auto_number = $slider_control.find(".index-active-lt span.index-order").html();
        if (auto_number == $index_item.length) auto_number = 0;
        $index_item.eq(auto_number).trigger("index_autonext");
    }, 6000);
});
jQuery(function () {
    jQuery("#index_slides").cycle({
        timeout: 0,
        speed: 1000,
        fx: "fade"
    });
});
	