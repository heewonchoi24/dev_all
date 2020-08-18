
$(document).ready(function(){
	//tabMenu
    $("ul.tabmenu li:first-child").addClass("current").css({"margin-left":"0"});
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
});
