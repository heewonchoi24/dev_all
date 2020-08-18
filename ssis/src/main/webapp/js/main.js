$(document).ready(function(){ 
    js_visual();
    
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
});
/* banner */
function js_visual(){
    var slide = $(".main_banner");
    slide.controls = slide.find(">.vi_control");
    slide.counts = slide.controls.find(">.control");
    slide.btn_left = slide.controls.find(">.btn_left");
    slide.btn_right = slide.controls.find(">.btn_right");    
    slide.btn_play = slide.controls.find(">.btn_play");
    slide.btn_stop = slide.controls.find(">.btn_stop");
    slide.ul = slide.find(">.visual");
    slide.li = slide.ul.find(">li");
    slide.a = slide.ul.find(">li>a");
    slide.speeds = 500;
    slide.autos = "Y";
    slide.times = "";
    slide.times_speeds = 3000;
    slide.nums = 1;
    
    if(slide.li.size()<3){
        slide.controls.remove();
        return false;
    }
    
    $("<ul></ul>").appendTo(slide.controls);
    for(var i=0; i<slide.li.size(); i++){
        $("<li><a href='#'>"+(i+1)+"번</a></li>").appendTo(slide.controls.find(">ul"));
    }
    
    slide.simbols = slide.controls.find(">ul>li");
    slide.simbols.eq(0).find(">a").addClass("on");
    
    for(var i=0; i<slide.li.size(); i++){
        slide.li.eq(i).attr("data-count",(i+1));
    }
    
    slide.counts.html(slide.nums+"/<span>"+slide.li.size()+"</span>");
    
    slide.btn_right.click(function(){
        slide.btn_stop.click();
        movement("right");
        return false;
    });
    
    slide.btn_left.click(function(){
        slide.btn_stop.click();
        movement("left");
        return false;
    });
    
    slide.btn_play.click(function(){
        slide.btn_play.hide();
        slide.btn_stop.css("display","inline-block");
        slide.autos = "Y";
        slide.times = setTimeout(function(){
            movement("right");
        }, slide.times_speeds);
        return false;
    });
    
    slide.btn_stop.click(function(){
        slide.btn_stop.hide();
        slide.btn_play.css("display","inline-block");
        slide.autos = "N";
        clearTimeout(slide.times);
        return false;
    });
    
    slide.simbols.find(">a").click(function(){
        if($(this).hasClass("on")) return false;
        var idx = slide.simbols.index($(this).parent());
        slide.btn_stop.click();
        movement(idx);
        return false;
    });
    
    if(slide.autos == "Y"){
        slide.btn_play.click();        
    } else {
        
    }
    
    //animate
    function movement(ty){
        slide.li = slide.ul.find(">li");
        
        var olds = 0;
        var news = 0;
        
        if(ty == "right"){
            olds = slide.nums;
            news = slide.nums + 1;
            
            if(news >= slide.li.size()) news = 0;
        } else if(ty == "left"){
            olds = slide.nums;
            news = slide.nums - 1;
            
            if(news < 1) news = slide.li.size();            
        } else {
            olds = slide.nums;
            news = ty + 1;
            if(news >= slide.li.size()) news = 0;            
        }
        
        if(slide.li.eq(news-1).is(":animated")) return false;
        
        slide.li.eq(olds-1).stop().css({"opacity":"1","left":"0","z-index":"10"}).animate({"opacity":"0"},slide.speeds, function(){
            slide.li.eq(olds-1).css("left","100%");
            if(slide.autos == "Y"){
                slide.times = setTimeout(function(){
                    movement("right");
                }, slide.times_speeds);
            }
        });
        
        slide.li.eq(news-1).stop().css({"opacity":"1","left":"0","z-index":"9"}).animate({"opacity":"1"},slide.speeds, function(){
        });
        
        slide.nums = news;
        
        slide.counts.html(slide.nums+"/<span>"+slide.li.size()+"</span>");
        
        slide.simbols.find(">a.on").removeClass("on");
        slide.simbols.eq(slide.nums-1).find(">a").addClass("on");
    }
};
