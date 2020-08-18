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



// Main Smooth Slider //
jQuery("html").addClass("smooth_slider_fouc");
jQuery(document).ready(function () {
    jQuery(".smooth_slider_fouc #smooth_slider_1").css({
        "display": "block"
    });
});
jQuery(document).ready(function () {
    jQuery("#smooth_slider_1").cycle({
        fx: "scrollHorz",
        speed: "500",
        timeout: "7000",
        next: "#smooth_slider_1_next",
        prev: "#smooth_slider_1_prev",
        pager: "#smooth_slider_1_nav",
        pagerAnchorBuilder: function (idx, slide) {
            return '<a class="sldr' + (idx + 1) + ' smooth_slider_nnav" href="#">' + (idx + 1) + '</a>';
        },
        pause: 1,
        slideExpr: "div.smooth_slideri"
    });
});

// Main Smooth Slider 2 //
jQuery("html").addClass("smooth_slider_fouc");
jQuery(document).ready(function () {
    jQuery(".smooth_slider_fouc #smooth_slider_2").css({
        "display": "block"
    });
});
jQuery(document).ready(function () {
    jQuery("#smooth_slider_2").cycle({
        fx: "turnUp",
        speed: "500",
        timeout: "7000",
        next: "#smooth_slider_2_next",
        prev: "#smooth_slider_2_prev",
        pager: "#smooth_slider_2_nav",
        pagerAnchorBuilder: function (idx, slide) {
            return '<a class="sldr' + (idx + 1) + ' smooth_slider_nnav" href="#">' + (idx + 1) + '</a>';
        },
        pause: 1,
        slideExpr: "div.smooth_slideri"
    });
});

// Main Smooth Slider 3 //
jQuery("html").addClass("smooth_slider_fouc");
jQuery(document).ready(function () {
    jQuery(".smooth_slider_fouc #smooth_slider_3").css({
        "display": "block"
    });
});
jQuery(document).ready(function () {
    jQuery("#smooth_slider_3").cycle({
        fx: "scrollHorz",
        speed: "500",
        timeout: "7000",
        next: "#smooth_slider_3_next",
        prev: "#smooth_slider_3_prev",
        pager: "#smooth_slider_3_nav",
        pagerAnchorBuilder: function (idx, slide) {
            return '<a class="sldr' + (idx + 1) + ' smooth_slider_nnav" href="#">' + (idx + 1) + '</a>';
        },
        pause: 1,
        slideExpr: "div.smooth_slideri"
    });
});

// Main Smooth Slider 4 //
jQuery("html").addClass("smooth_slider_fouc");
jQuery(document).ready(function () {
    jQuery(".smooth_slider_fouc #smooth_slider_4").css({
        "display": "block"
    });
});
jQuery(document).ready(function () {
    jQuery("#smooth_slider_4").cycle({
        fx: "scrollHorz",
        speed: "500",
        timeout: "7000",
        next: "#smooth_slider_4_next",
        prev: "#smooth_slider_4_prev",
        pager: "#smooth_slider_4_nav",
        pagerAnchorBuilder: function (idx, slide) {
            return '<a class="sldr' + (idx + 1) + ' smooth_slider_nnav" href="#">' + (idx + 1) + '</a>';
        },
        pause: 1,
        slideExpr: "div.smooth_slideri"
    });
});

// Main Smooth Slider 5 //
jQuery("html").addClass("smooth_slider_fouc");
jQuery(document).ready(function () {
    jQuery(".smooth_slider_fouc #smooth_slider_5").css({
        "display": "block"
    });
});
jQuery(document).ready(function () {
    jQuery("#smooth_slider_5").cycle({
        fx: "scrollHorz",
        speed: "500",
        timeout: "7000",
        next: "#smooth_slider_5_next",
        prev: "#smooth_slider_5_prev",
        pager: "#smooth_slider_5_nav",
        pagerAnchorBuilder: function (idx, slide) {
            return '<a class="sldr' + (idx + 1) + ' smooth_slider_nnav" href="#">' + (idx + 1) + '</a>';
        },
        pause: 1,
        slideExpr: "div.smooth_slideri"
    });
});

// Main Smooth Slider 6 //
jQuery("html").addClass("smooth_slider_fouc");
jQuery(document).ready(function () {
    jQuery(".smooth_slider_fouc #smooth_slider_6").css({
        "display": "block"
    });
});
jQuery(document).ready(function () {
    jQuery("#smooth_slider_6").cycle({
        fx: "scrollHorz",
        speed: "500",
        timeout: "7000",
        next: "#smooth_slider_6_next",
        prev: "#smooth_slider_6_prev",
        pager: "#smooth_slider_6_nav",
        pagerAnchorBuilder: function (idx, slide) {
            return '<a class="sldr' + (idx + 1) + ' smooth_slider_nnav" href="#">' + (idx + 1) + '</a>';
        },
        pause: 1,
        slideExpr: "div.smooth_slideri"
    });
});


// Main Nivo Slider //
jQuery("html").addClass("listic_slider_fouc");
jQuery(document).ready(function () {
    jQuery(".listic_slider_fouc .listic_slider_set").css({
        "display": "block"
    });
});

function listic_slider_2_pause() {
    jQuery("#listic_slider_1").cycle("pause");
};
jQuery(document).ready(function () {
    jQuery("#listic_slider_1").cycle({
        fx: "fade",
        easing: "swing",
        speed: "700",
        timeout: 3000,
        onPrevNextEvent: listic_slider_2_pause,
        onPagerEvent: listic_slider_2_pause,

        pager: "#listic_slider_1_nav",
        pagerAnchorBuilder: function (idx, slide) {
            return '<a href="#" style="background: transparent url(http://vryus.net:6313/vryus/eatsslim/project/images/nivonavi.png) no-repeat 0 0;width:13px;height:13px;"></a>';
        },
        updateActivePagerLink: function (pager, activeIndex) {
            jQuery(pager).find("a:eq(" + activeIndex + ")").addClass("activeSlide").siblings().removeClass("activeSlide");
            jQuery(pager).find("a:eq(" + activeIndex + ")").css("backgroundPosition", "-13px 0").siblings().css("backgroundPosition", "0 0");
        },
        pause: 1
    });
});