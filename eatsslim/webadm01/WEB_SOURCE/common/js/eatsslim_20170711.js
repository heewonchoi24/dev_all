$(document).ready(function() {
	// Select Box //
	$("SELECT").selectBox();

	// GNB MENU //
	$("#dropline li.current").children("ul").css("left", "0px").show();
	$("#dropline li.current").children(":first-child");

	$("#dropline li").hover(function(){
		if (this.className.indexOf("current") == -1) {
			getCurrent = $(this).parent().children("li.current:eq(0)");
			if (this.className.indexOf("top") != -1) {
				$(this).children("a:eq(0)");
			} else {
				$(this).children("a:eq(0)");
			}
			if (getCurrent = 1) {
				$(this).parent().children("li.current:eq(0)").children("ul").hide();;
			}
			$(this).children("ul:eq(0)").css("left", "0px").show();
			}
		},function() {
		if (this.className.indexOf("current") == -1) {
			getCurrent = $(this).parent().children("li.current:eq(0)");
			if (this.className.indexOf("top") != -1) {
				$(this).children("a:eq(0)");
			} else {
				$(this).children("a:eq(0)");
			}
			if (getCurrent = 1 ) {
				$(this).parent().children("li.current:eq(0)").children("ul").show();;
			}
			$(this).children("ul:eq(0)").css("left", "-99999px").hide();
		}
	});
});

// Floating Menu //
$(function () {

  /*var msie6 = $.browser == 'msie' && $.browser.version < 7;

  if (!msie6) {
    var top = $('#floatMenu').offset().top - parseFloat($('#floatMenu').css('margin-top').replace(/auto/, 0));
    $(window).scroll(function (event) {
      // what the y position of the scroll is
      var y = $(this).scrollTop();
      var yplus = y + $("#floatMenu").outerHeight();

      // whether that's below the form

		if(( $("#container").outerHeight() + $(".container").outerHeight() )- $(".shop_visual").outerHeight() <= $("#floatMenu").outerHeight()){
			setTimeout(function(){
				$('#floatMenu').removeClass('fixed').removeClass('fixed2');
				return false;
			},50);

		}else{
			if(yplus > $(document).innerHeight() - $("#footer").outerHeight() - 250){
				setTimeout(function(){
					$('#floatMenu').removeClass('fixed').addClass("fixed2");
			    	return false;
				},50);

		      } else if (y >= $("#header").outerHeight() + $(".visual_area").outerHeight() + $(".main_title_area").outerHeight() + $(".shop_visual").outerHeight()) {
		        // if so, ad the fixed class
		    	  setTimeout(function(){
		    		  $('#floatMenu').removeClass("fixed2").addClass('fixed');
				        return false;
		    	  },50);
		      } else {
		        // otherwise remove it
		    	  setTimeout(function(){
		    		  $('#floatMenu').removeClass('fixed');
				        return false;
		    	  },50);
		      }
		}

    });
  }*/

	var quick_menu = $('#floatMenu');
//	var quick_top = ( $("#container").outerHeight() + $(".container").outerHeight() )- $(".shop_visual").outerHeight() <= $("#floatMenu").outerHeight();
	var quick_top = 222;

	/* quick menu initialization */
//	quick_menu.css('top', $(window).height() );
	$(document).ready(function(){
        var offsetTop = $(".container").length > 0 ? $(".container").offset().top : $("#container").offset().top;
		if ($("#wrap").hasClass("ol")) {
			offsetTop = $(".goods_list").offset().top;
            quick_menu.animate( { "top": offsetTop }, 500 );
		}else {
			quick_menu.animate( { "top": offsetTop + 50 }, 500 );
		}

	$(window).scroll(function(){
        var offsetTop = $(".container").length > 0 ? $(".container").offset().top : $("#container").offset().top;
		if ($("#wrap").hasClass("ol")){
			offsetTop = $(".goods_list").offset().top;
            if($(document).scrollTop() <= offsetTop){
				quick_menu.stop();
				quick_menu.animate( { "top": offsetTop }, 500 );
			}else{
				quick_menu.stop();
				quick_menu.animate( { "top": $(document).scrollTop() + 50 }, 500 );
			}
		}else {
			if($(document).scrollTop() <= offsetTop){
				quick_menu.stop();
				quick_menu.animate( { "top": offsetTop + 50 }, 500 );
			}else{
				quick_menu.stop();
				quick_menu.animate( { "top": $(document).scrollTop() + 50 }, 500 );
			}
		}
	});
	});
});


// QUANTITY //
jQuery("div.quantity").append('<input type="button" value="+" id="add1" class="plus" />').prepend('<input type="button" value="-" id="minus1" class="minus" />');
        jQuery(".plus").click(function()
        {
            var currentVal = parseInt(jQuery(this).prev(".qty").val());

            if (!currentVal || currentVal=="" || currentVal == "NaN") currentVal = 0;

            jQuery(this).prev(".qty").val(currentVal + 1);
        });

        jQuery(".minus").click(function()
        {
            var currentVal = parseInt(jQuery(this).next(".qty").val());
            if (currentVal == "NaN") currentVal = 0;
            if (currentVal > 0)
            {
                jQuery(this).next(".qty").val(currentVal - 1);
            }
        });

// Lightbox //
    jQuery(document).ready(function($){
      $('.lightbox').lightbox();
      $('.custombox').lightbox([{

      }]);
    });

// Sliding Drawer //
$(function(){
	$('.drawer').slideDrawer({
		showDrawer: true,
		slideTimeout: true,
		slideSpeed: 600,
		slideTimeoutCount: 3000,
	});


	$.mCustomScrollbar.defaults.scrollButtons.enable=true; //enable scrolling buttons by default
    $.mCustomScrollbar.defaults.axis="xy"; //enable 2 axis scrollbars by default
    $.mCustomScrollbar.defaults.setTop="-100px";

    // main_visual settings
    var time = 4;
    var $bar,
    $slickWrap,
    $slick,
    $slick2,
    $slickCtrl,
    isPause,
    tick,
    percentTime;

    $slickWrap = $('.visual_area');
    $slick = $('.main_visual');
    $slick2 = $('.visual_nav');
    $slickCtrl = $('.visual_navigation .visual_nav_options .slick-ctrl');
    $slick.slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        draggable: false,
        centerMode: false,
        centerPadding: 0,
        fade: true,
        arrows: true,
        prevArrow : '<button type="button" class="slick-prev"><img src="/dist/images/ico/ico_slider_left.png" alt=""></button>',
        nextArrow : '<button type="button" class="slick-next"><img src="/dist/images/ico/ico_slider_right.png" alt=""></button>',
        asNavFor: '.visual_nav'
    });

    $slick2.slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        autoplay: true,
        //rows:1,
        //slidesPerRow:5,
        //vertical: true,
        //centerMode:true,
        arrows: false,
        asNavFor: '.main_visual',
        draggable: false,
        focusOnSelect: true
    });

    $slickCtrl.on("click",function(){
        if($(this).hasClass("slick-pause")){
            isPause = true;
            $(this).removeClass("slick-pause").addClass("slick-play").find("img").attr("src","/dist/images/ico/ico_slider_play.png");
            $slick.slick('slickPause');
        }else{
            isPause = false;
            $(this).removeClass("slick-play").addClass("slick-pause").find("img").attr("src","/dist/images/ico/ico_slider_pause.png");
            $slick.slick('slickPlay');
        }
    });

//    $bar = $('.visual_progress .progress');
//
//    function startProgressbar() {
//        resetProgressbar();
//        percentTime = 0;
//        isPause = false;
//        tick = setInterval(interval, 10);
//    }
//
//    function interval() {
//        if(isPause === false) {
//                percentTime += 1 / (time+0.1);
//                $bar.css({
//                width: percentTime+"%"
//            });
//            if(percentTime >= 100){
//              $slick.slick('slickNext');
//              startProgressbar();
//            }
//        }
//    }
//
//    function resetProgressbar() {
//        $bar.css({
//            width: 0+'%'
//        });
//        clearTimeout(tick);
//    }
//
//    startProgressbar();



    // $slickWrap.on({
    //     mouseenter: function() {
    //         isPause = true;
    //     },
    //     mouseleave: function() {
    //         isPause = false;
    //     }
    // });

	$("#footer .fs_selector").on("click",function(){
        if($("#footer .familysite").hasClass("selected")){
            $("#footer .familysite").removeClass("selected");
            $("#footer .familysite.selected .site_list").mCustomScrollbar("destroy");
        }else{
            $("#footer .familysite").addClass("selected");
            $("#footer .familysite.selected .site_list").mCustomScrollbar({theme:"minimal"});
        }
    });

    $("#footer .site_list").mouseleave(function(){
    	 $("#footer .familysite").removeClass("selected");
         $("#footer .familysite.selected .site_list").mCustomScrollbar("destroy");
    });

    $('button.go_top').click(function() {
        $('html, body').animate({
            scrollTop: 0
        }, 900);
        return false;
    });

    $("#floatMenu .qm_recent").slick({
        slidesToShow: 2,
        slidesToScroll: 2,
        vertical: true,
        prevArrow: '<button type="button" data-role="none" class="slick-prev" aria-label="Previous" tabindex="0" role="button"><img src="/dist/images/ico/btn_quickmenu_prev.png"></button>',
        nextArrow: '<button type="button" data-role="none" class="slick-next" aria-label="Next" tabindex="0" role="button"><img src="/dist/images/ico/btn_quickmenu_next.png"></button>',
    });

    $(".set_list ul").slick({
    	infinite: false,
    	slidesToShow: 5,
    	slidesToScroll: 5,
    	arrows: true,
    	dots:false,
    	prevArrow: '<button type="button" class="slick-prev"><img src="/dist/images/ico/ico_slider_left.png" width="15" height="25" alt="" /></button>',
    	nextArrow: '<button type="button" class="slick-next"><img src="/dist/images/ico/ico_slider_right.png" width="15" height="25" alt="" /></button>'
    	});

    var $md2 = $(".main_content_area.goods_best .md2 .item");
    var slideCount = null;

    $( document ).ready(function() {
    	$md2.slick({
        	autoplay: true,
        	infinite: true,
        	fade: true,
            prevArrow: '<button type="button" data-role="none" class="slick-prev" aria-label="Previous" tabindex="0" role="button"><img src="/dist/images/ico/ico_slider_left2.png"></button>',
            nextArrow: '<button type="button" data-role="none" class="slick-next" aria-label="Next" tabindex="0" role="button"><img src="/dist/images/ico/ico_slider_right2.png"></button>',
        });
    });

    $md2.on('init', function(event, slick){
      slideCount = slick.slideCount;
      setSlideCount();
      setCurrentSlideNumber(slick.currentSlide);
    });

    $md2.on('beforeChange', function(event, slick, currentSlide, nextSlide){
      setCurrentSlideNumber(nextSlide);
    });

    function setSlideCount() {
      var $el = $('.slide-count-wrap').find('.total');
      $el.empty().text(slideCount);
    }

    function setCurrentSlideNumber(currentSlide) {
      var $el = $('.slide-count-wrap').find('.current');
      $el.empty().text(currentSlide + 1);
    }


});


    var categoryFn = {
        onInit : function(frame){
            var _frame = $('.'+frame);
            var _nav = _frame.find(".bx_nav");
            var d1Anchor = $(".sub_anchor");

            _frame.find(".on").removeClass("on");
            _nav.find(">ul>li:first-child").children(".sub_anchor").addClass("on");
            _nav.find(">ul>li>ul>li:first-child").children("a").addClass("on");
        },
        onToggle : function(target, element){
            var _target = $('.'+target);
            // if (_target.hasClass("hasActived")) ? element.removeClass("hasActived") :  element.addClass("hasActived");
            if(element) {
    	        if(_target.hasClass("hasActived")){
    	            _target.removeClass("hasActived");
    	            element.removeClass("on");
    	         }else{
    	             $(".lnb_sub").removeClass("hasActived");
    	            _target.addClass("hasActived");
    	            element.addClass("on");

    	            categoryFn.onInit(target);
    	            categoryFn.onExecution(target);
    	        }
            }else{
            	if(_target.hasClass("hasActived")){
    	            _target.removeClass("hasActived");
    	         }else{
    	             $(".lnb_sub").removeClass("hasActived");
    	            _target.addClass("hasActived");

    	            categoryFn.onInit(target);
    	            categoryFn.onExecution(target);
    	        }
            }
        },
        onExecution : function(frame){

            if(frame == "close"){
                $(".cat_sub").removeClass("hasActived");
            }
            else{
                var _frame = $('.'+frame);
                var d1Anchor = $(".sub_anchor");

                d1Anchor.on("mouseover",function(){
                    $(".sub_anchor").removeClass("on");
                    $(this).addClass("on");

                    var d2Ul = $(this).siblings("ul");
                    var d2UlH = d2Ul.outerHeight();
                    var d2Anchor = d2Ul.find("> li > a");
//
//                    _frame.css({"height":d2UlH+68});

                    d2Anchor.on("mouseover",function(){
                        d2Anchor.removeClass("on");
                        $(this).addClass("on");
                    });
                });
            }
        }
    }



    var cartFn = {
        onInit : function(){
            var cFrame = $("#floating_cart"), cSection = cFrame.find("section"), cHeader = cFrame.find("header");
            var cSectionH = cSection.outerHeight();
            var cHeaderH = cHeader.outerHeight();
            var footerH = $("#footer").outerHeight();
            var itemLength = Number($("#cartCount").val());

            /*cFrame.find(".goods_count dd span").empty().text(itemLength);*/



            (itemLength != 0) ? $("#floating_cart .showOrder").addClass("on") : $("#floating_cart").removeClass("on").find(".showOrder").removeClass("on");
        },
        onFold : function(c){
            var customClass = c || "on";
            var cFrame = $("#floating_cart"), cSection = cFrame.find("section"), cHeader = cFrame.find("header");
            var cSectionH = cSection.outerHeight();
            var cHeaderH = cHeader.outerHeight();
            var footerH = $("#footer").outerHeight();

            if(cFrame.hasClass(customClass)){
                cFrame.find(".showCart").text("");
                cFrame.removeClass(customClass);//.stop().animate({'bottom':-cSectionH},150);
            }else{
                cFrame.find(".showCart").text("");
                cFrame.addClass(customClass);//.stop().animate({'bottom':cHeaderH},300);
            }

            cartFn.onInit();
        },
        onAdd : function(devlWeek,devlDay,buyQty,type,cartId,devlType,buyBagYn,day,sumPriceWeek,groupName){
        	var cFrame = $("#floating_cart"), cSection = cFrame.find("section"), cHeader = cFrame.find("header"), cInner = cSection.find(".fc_inner");
            var t = $('.goods_thumbnail');
            var itemLength = cFrame.find(".bx_item").length;
            var str = Number($("#cartCount").val());
            var img = t.find(">img");
            var appendBx = "";

            img.clone().addClass("img_clone").css({'position':'absolute', 'z-index':110, top : img.offset().top, left : img.offset().left, 'opacity' : 0.7}).prependTo($('body'));

            var clone = $(".img_clone");
            var cartIcon = $("#floating_cart .goods_count dt img");
            var duration = 1;

            TweenMax.to( clone, duration / 2, {css:{scale:.04, opacity:.8}, ease:Power1.easeInOut});
            TweenMax.to( clone, duration / 2, {css:{top:cartIcon.offset().top-273, left:cartIcon.offset().left-258}, ease:Quad.easeInOut});
            TweenMax.to( clone, .1, {
                css:{opacity:0},
                ease:Power1.easeInOut,
                delay : .8,
                onComplete : function(){
                    TweenMax.to(cartIcon, duration / 4, {y:10, ease:Power3.easeOut});
                    TweenMax.to(cartIcon, duration / 2, {y:0, ease:Bounce.easeOut, delay:duration / 8});
                    clone.remove();

                    itemLength++;
                    $("#cartCount").val(itemLength);
                    cFrame.find("#cart_qty").empty().text(str);

                    appendBx += '<div class="bx_item">';
                    appendBx += '    <div class="goods_image">';
                    appendBx += '		<div class="centered">';
                    appendBx += '        	<img src="'+$(".goods_thumbnail img").attr("src")+'" alt="">';
                    appendBx += '    	</div>';
                    appendBx += '	</div>';
                    appendBx += '    <div class="goods_desc">';
                    appendBx += '        <div class="goods_title">'+groupName+'</div>';
                    if(devlDay == "5"){
    					appendBx += '        <div class="goods_caption">��~��/ '+devlWeek+'�� �Ϻ�</div>';

    				}else if(devlDay == "3"){
    					appendBx += '        <div class="goods_caption">��/��/�� / '+devlWeek+'�� �Ϻ�</div>';
    				}

                    appendBx += '        <div class="goods_foot">';
                    appendBx += '            <div class="goods_price">'+sumPriceWeek+'</div>';
                    appendBx += '			<a href="/shop/popup/__ajax_goods_set_options_select.jsp?lightbox[width]=500&lightbox[height]=530&groupName='+groupName+'&groupCode=&groupPrice=&groupPrice1='+sumPriceWeek+'&groupInfo1=&kalInfo=&totalPrice='+sumPriceWeek+'&groupInfo1=&cateCode=&devlType='+devlType+'&cartId='+cartId+'&paramType=list" class="lightbox goods_options">�ɼǺ���</a>';
                    appendBx += '        </div>';
                    appendBx += '    </div>';
                    appendBx += '    <button type="button" class="goods_del" onclick="cartFn.onDelete(this);"></button>';
                    appendBx += '</div>';


                    if(!$("#floating_cart").hasClass("on")){
                        setTimeout(function(){
                            $(".showCart").trigger("click");
                        },200);
                    }

                    setTimeout(function(){
                        $("#floating_cart .fc_inner").css("width",itemLength * 186).append(appendBx);
                        $("#floating_cart .fc_inner .bx_item:last-child").addClass("action");

                        var target = $("#floating_cart .fc_inner .bx_item.action:last-child");
                        var tl = new TimelineMax({
                            paused: false
                        });
                        tl.to(target, .3, {css:{scale: 1.2, opacity: .4},  ease: Back.easeIn} );
                        tl.to(target, .05, {css:{scale: 1, opacity: 1},  ease: Power1.easeOut} );
                    },800);

                    setTimeout(function(){
                        $(".showCart").trigger("click");
                    },1800);
                }
            });
            cartFn.onFold();
        },
        onDelete : function(t){
            var cFrame = $("#floating_cart");
            var _this = $(t);
            var target = _this.closest(".bx_item");
            var itemLength = Number($("#cartCount").val());

            var tl = new TimelineMax({
                paused: false
            });
            tl.to(target, .3, {css:{scale: .4, opacity: .6},  ease: Back.easeIn} );
            tl.to(target, .05, {css:{scale: .8, opacity: 0},  ease: Power1.easeOut} );
            $("#floating_cart .fc_inner").css("width",itemLength * 186);
            tl.addCallback(function(){target.remove();});

            itemLength--;
            $("#cartCount").val(itemLength);
            cFrame.find(".goods_count dd span").empty().text(itemLength);

            cartFn.onInit();

        }
    }
    cartFn.onInit();


    function lnbToggle(e, className){
        var _class = className;

        if(_class == "lnb_list1") {
            var idName = $("#eatsslim_sub");
            lnbToggleInit(e, idName);
        }
        else if(_class == "lnb_list2") {
            var idName = $("#best_sub");
            lnbToggleInit(e, idName);
        }
        else if(_class == "lnb_list3") {
            var idName = $("#recommend_sub");
            lnbToggleInit(e, idName);
        }
        else if(_class == "lnb_list4") {
            var idName = $("#event_sub");
            lnbToggleInit(e, idName);
        }
        else if(_class == "lnb_list5") {
            var idName = $("#bs_sub");
            lnbToggleInit(e, idName);
        }
        else {

        }

        function lnbToggleInit(t, idName){
            var _this = $(t).closest("li");
            var _idName = idName;

            $(".lnb li").removeClass("on");
            _this.addClass("on");
            categoryFn.onToggle('close');

            $(".lnb_sub").removeClass("hasActived");
            _idName.addClass("hasActived");

            $(".lnb").on("mouseleave",function(){
                if($('.lnb_sub.hasActived').length == 0){
                    $(".lnb_sub").removeClass("hasActived");
                    $(".lnb li").removeClass("on");
                }else{
                    $(".lnb_sub.hasActived").on("mouseleave",function(){
                        $(".lnb_sub").removeClass("hasActived");
                        $(".lnb li").removeClass("on");
                    });
                }
            });
        }
    }
