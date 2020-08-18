
$(document).ready(function(){
	$("a").focus(function(){
		$(this).blur();
	})
	
	//레이어 팝업 배경
	wrapMask();
	
	//tabMenu
    //$("ul.tabmenu li:first-child").addClass("current").css({"margin-left":"0"});
	$("ul.tabmenu li:first-child").css({"margin-left":"0"});
    $("ul.tabmenu li:last-child").css({"margin-right":"0"});
    $("div.tab_con").find("div.tab_layout:not(:first-child)").hide();
    $("div.tab_con div.tab_layout").attr("id", function(){return idNumber("No")+ $("div.tab_con div.tab_layout").index(this)});
	$("ul.tabmenu li").click(function(){
        var c = $("ul.tabmenu li");
        var index = c.index(this);
        var p = idNumber("No");
        show(c,index,p);
    });
    function show(controlMenu,num,prefix){
        var content= prefix + num;
        $('#'+content).siblings().hide();
        $('#'+content).show();
        controlMenu.eq(num).addClass("current").siblings().removeClass("current");
    };
    function idNumber(prefix){
        var idNum = prefix;
        return idNum;
    };
	
	//SMS 메세지관리 팝업
	/*$(".msg_add").click(function(){
		$(".bg_mask2, .msg_pop").show();
	})
	$(".msg_close").click(function(){
		$(".bg_mask2, .msg_pop").hide();
	})
	//esc 키다운시 SMS 메세지관리 팝업 숨김
	$("body").keydown(function(evt){
		if($(".msg_pop").css("display")=="block"){
			if(evt.keyCode=="27"){
				$(".bg_mask2, .msg_pop").hide();
			}
		}
	});*/
	
	//레이어 팝업 열기
	$(".pop_open").click(function(){
		$(".bg_mask, .pop_style1").show();
	})
	$(".pop_open2").click(function(){
		$(".bg_mask, .pop_style2").show();
	})
	//레이어 팝업 닫기
	$(".pop_close").click(function(){
		$(".bg_mask, .pop_style1, .pop_style2").hide();
	})
	
	//상담요청 관리 예약버튼
/*	$(".reservation_check li a").click(function(){
		if($(this).hasClass("on")){
			$(this).removeClass("on");
			$(this).text("예약가능");
		}else{
			$(this).addClass("on");
			$(this).text("예약불가");
		}
	})*/
});
//팝업 배경	
function wrapMask(){
	$(".bg_mask").css({'width':$(window).width(),'height':$(document).height()});
}
$(window).resize(function(){
	wrapMask();
})

































