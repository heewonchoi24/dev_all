
function leftcon(){
	$("#category_menu li:last-child").addClass("end");
	$("#category_menu li a").bind("click",function(){
		if($(this).hasClass("hover")){
			$(this).parent().children("ul").hide();
			$(this).removeClass("hover");
			$(this).removeClass("hover bg_hover");
		}else{
			$(this).parent().children("ul").show();
			$("#category_menu li a").removeClass("hover");
			$(this).addClass("hover");
			$(this).parent().parent().parent().children("a").addClass("hover");
			$(this).parent().parent().parent().parent().parent().children("a").addClass("hover");
			$(this).parent().parent().parent().parent().parent().parent().parent().children("a").addClass("hover");
			$("#category_menu li ul li ul li ul li a").removeClass("hover");
			$(this).addClass("hover");
		}
	});

	$(".category_open").click(function(){
		$("#category_menu li ul").show(); 
		$("#category_menu li a").addClass("bg_hover");
	})
	$(".category_close").click(function(){
		$("#category_menu li ul").hide(); 
		$("#category_menu li a").removeClass("hover bg_hover");
	})
	
	$("#category_menu > li > a").click(function(){
		$(".category_list2").show();
		$(".category_list1").hide();
		$(".category_list2 .tit_style1").text($(this).text() + " 상품리스트");
	})
}
		

