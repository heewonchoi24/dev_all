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
$(function() {
    function moveFloatMenu() {
        var menuOffset = menuYloc.top + $(this).scrollTop() + "px";
        $('#floatMenu').animate({
            top: menuOffset
        }, {
            duration: 500,
            queue: false
        });
    }

    menuYloc = $('#floatMenu').offset();

    $(window).scroll(moveFloatMenu);

    moveFloatMenu();
});

