function wrapWindowByMask(){
    var maskHeight = $(document).height();

    $(".layer_bg").css({"height":maskHeight});
    $(".layer_bg").fadeIn(0);
    $(".layer_bg").fadeTo("slow",0.7)
    
    var left = ($(window).scrollLeft() + ($(window).width() - $(".layer").width()) / 2);
    var top = ($(window).scrollTop() + ($(window).height() - $(".layer").height()) / 2);
    
    $(".layer").css({'left':left, 'top':top, 'position':"absolute"});    
    $(".layer").show(); 
}

function wrapWindowByMask2(){
    var maskHeight = $(document).height();
    var maskWidth = $(window).width();    
    
    $(".layer_bg").css({"width":maskWidth,"height":maskHeight});
    $(".layer_bg").fadeIn(0);
    $(".layer_bg").fadeTo("slow",0.7)
    
    var left = ($(window).scrollLeft() + ($(window).width() - $(".layer2").width()) / 2);
    var top = ($(window).scrollTop() + ($(window).height() - $(".layer2").height()) / 2);
    
    $(".layer2").css({'left':left, 'top':top, 'position':"absolute"});    
    $(".layer2").show();
}

function wrapWindowByMask3(){
    var maskHeight = $(document).height();
    
    $(".layer_bg").css({"height":maskHeight});
    $(".layer_bg").fadeIn(0);
    $(".layer_bg").fadeTo("slow",0.7)
    
    var left = ($(window).scrollLeft() + ($(window).width() - $(".loading").width()) / 2);
    var top = ($(window).scrollTop() + ($(window).height() - $(".loading").height()) / 2);
    
    $(".loading").css({'left':left, 'top':top, 'position':"absolute"});    
    $(".loading").show(); 
}

function wrapWindowByMask4(){
    var maskHeight = $(document).height();

    $(".layer_bg").css({"height":maskHeight});
    $(".layer_bg").fadeIn(0);
    $(".layer_bg").fadeTo("slow",0.7)
}

function scrollX() {
    document.all.mainDisplayRock.scrollLeft = document.all.bottomLine.scrollLeft;
    document.all.topLine.scrollLeft = document.all.bottomLine.scrollLeft;    
}

function scrollY() {
    document.all.leftDisplay.scrollTop = document.all.mainDisplayRock.scrollTop;
    document.all.mainDisplayRock.scrollTop = document.all.leftDisplay.scrollTop;    
}

function go_url(formEI){
    var site = formEI.site_link.value;
    if(site == "" || site == "http://"){
        return false;
    } else {
        formEI.action = site;
        return true; 
    }
}

function close_tip(obj){
    $(obj).parent().hide();
}

$(function(){
    $(".btn_tip").click(function(e){
        var sWidth = window.innerWidth;
        var sHeight = window.innerHeight;
        
        var oWidth = $(".tip_wrap").width();
        var oHeight = $(".tip_wrap").height();
        
        var divLeft = e.clientX + 10;
        var divTop = e.clientY + 5;
        
        if(divLeft + oWidth > sWidth) divLeft -= oWidth;
        if(divTop + oHeight > sHeight) divTop -= oHeight;
        
        if(divLeft < 0) divLeft = 0;
        if(divTop < 0) divTop = 0;
        
        $(".tip_wrap").css({
            "top" : divTop,
            "left" : divLeft,
            "position" : "absolute"
        }).show();
        
    });
})

function file_w(){
    var table = $(".option_area").parent().parent().parent();
    document.getElementById(file_table).style.tableLayout = "fixed";
    console.log(table);
}


$(document).ready(function(){    
    $(".allMenu a").click(function(){
        var mask = $(".layer_bg");
        var all = $(".all_menu_wrap");
        
//        $(".layer_bg").fadeIn(150);
        wrapWindowByMask4();
        $(".all_menu_wrap").fadeIn(150);
        $("body").css("overflowY", "hidden");
    })
    
    $(".all_menu_wrap .close").click(function(){
        $(".layer_bg").fadeOut(150);
        $(".all_menu_wrap").fadeOut(150);
        $("body").css("overflowY", "visible");
    });
    
	$(".gnb_depth1 > a").on ("mouseover",function(e){
		$(".gnb_depth2").stop().slideUp(0);
		$(this).parent().find(".gnb_depth2").stop().slideDown(0);
		return false;
	});
	$(".gnb_depth1").on("mouseleave",function(e){
		$(".gnb_depth2").stop().slideUp(0);

    });
    
	$(".snb_depth1 > a").on("click",function(e){
		$(".snb_depth2").stop().slideUp(200);
		$(this).parent().find(".snb_depth2").stop().slideDown(200);
		return false;
	});
	$(".snb_depth1").on("mouseleave",function(e){
		$(".snb_depth2").stop().slideUp(200);
	}); 
    
    /* layer popup */
    $(".layer_open").click(function(e){
        e.preventDefault();
        wrapWindowByMask();  
        $("body").css("overflowY", "hidden");
    });
    
    $(".layer .close").click(function(e){
        e.preventDefault();
        $(".layer_bg, .layer").hide();
        $("body").css("overflowY", "visible");
    });

    /* layer popup */
    $(".layer_open2").click(function(e){
        e.preventDefault();
        wrapWindowByMask2();
        $("body").css("overflowY", "hidden");
    });
    
    $(".layer2 .close").click(function(e){
        e.preventDefault();
        $(".layer_bg, .layer2").hide();
        $("body").css("overflowY", "visible");
    });
    
    $(".layer_open3").click(function(e){
        e.preventDefault();
        wrapWindowByMask3();
    });
        
    /* faq */
    $(".faq_list dl dt a").on("click", function(){
        if($(this).parent().next().css("display")=="none"){
            $(".faq_list dl dt a").removeClass("on");
            $(".faq_list dl dd").slideUp(150);
            $(this).addClass("on");
            $(this).parent().next().slideDown(150);
        } else {
            $(".faq_list dl dt a").removeClass("on");
            $(".faq_list dl dd").slideUp(150);
        }
    });
    
    $(".alram a").on("click", function(){
        $(".alram_wrap").toggle();
    });
    
    $(".alrm_close").on("click", function(){
        $(".alram_wrap").hide();
    });
        
    $(".tool_text").hover(function(){
        var title = $(this).attr("title");
        $(this).data("tipText", title).removeAttr("title");
        $('<p class="tooltip"></p>')
        .text(title)
        .appendTo('body')
        .fadeIn('slow');                                                        
    }, function(){
        $(this).attr("title", $(this).data("tipText"));
        $(".tooltip").remove();
    }).mousemove(function(e){
        var mousex = e.pageX + 20; 
        var mousey = e.pageY + 0;
        $(".tooltip")
        .css({top: mousey, left: mousex})
    });
    
    /* admin menu */    
    var a_height;
    a_height = $("#admin ul").height();

    $("#admin").mouseover(function(){
        $(this).addClass("on");
        $("#admin").css({"height" : a_height});        
    }).mouseout(function(){
        $(this).removeClass("on");
        $("#admin").css({"height" : 25});        
    }).focusin(function(){
        $(this).trigger("mouseover")
    }).focusout(function(){
        $(this).trigger("mouseout")
    });        

    /* data table width */
    var t_width;
    t_width = $("#topLine table").width();
    $("#bottomLine div").css("width",t_width);
    
    /* data table hegith */
    var t_height;
    t_height = $("#topLine table thead").height();
    $(".th_bg").css("height",t_height - 11);
    //console.log(t_height);
    
    /* file width */    
    $(".file_list").parent().parent().parent().parent().parent().css({"tableLayout":"fixed"});    
    var f_width;
    f_width = $(".file_list").parent().parent().width();
    $(".file_list li").css("width",f_width - 20);
    
});

/* file upload */
var uploadFile = $('.upload_bt');
uploadFile.on('change', function(){
    if(window.FileReader){
        var filename = $(this)[0].files.name;
    } else {
        var filename = $(this).val().split('/').pop().split('\\').pop();
    }
    $(this).siblings('.fileName').val(filename);
});