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
  
  var msie6 = $.browser == 'msie' && $.browser.version < 7;
  
  if (!msie6) {
    var top = $('#floatMenu').offset().top - parseFloat($('#floatMenu').css('margin-top').replace(/auto/, 0));
    $(window).scroll(function (event) {
      // what the y position of the scroll is
      var y = $(this).scrollTop();
      
      // whether that's below the form
      if (y >= top) {
        // if so, ad the fixed class
        $('#floatMenu').addClass('fixed');
      } else {
        // otherwise remove it
        $('#floatMenu').removeClass('fixed');
      }
    });
  }  
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
    });
	
// Sliding Drawer //
$(function(){
	$('.drawer').slideDrawer({
		showDrawer: true,
		slideTimeout: true,
		slideSpeed: 600,
		slideTimeoutCount: 3000,
	});
});
