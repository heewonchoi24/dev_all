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
// File Field Style //
$(window).load(function(){
;(function( $ ) {

  // Browser supports HTML5 multiple file?
  var multipleSupport = typeof $('<input/>')[0].multiple !== 'undefined',
      isIE = /msie/i.test( navigator.userAgent );

  $.fn.customFile = function() {

    return this.each(function() {

      var $file = $(this).addClass('customfile'), // the original file input
          $wrap = $('<div class="customfile-wrap">'),
          $input = $('<input type="text" class="customfile-filename" />'),
          // Button that will be used in non-IE browsers
          $button = $('<button type="button" class="customfile-upload">찾아보기</button>'),
          // Hack for IE
          $label = $('<label class="customfile-upload" for="'+ $file[0].id +'">찾아보기</label>');

      // Hide by shifting to the left so we
      // can still trigger events
      $file.css({
        position: 'absolute',
        left: '-9999px'
      });

      $wrap.insertAfter( $file )
        .append( $file, $input, ( isIE ? $label : $button ) );

      // Prevent focus
      $file.attr('tabIndex', -1);
      $button.attr('tabIndex', -1);

      $button.click(function () {
        $file.focus().click(); // Open dialog
      });

      $file.change(function() {

        var files = [], fileArr, filename;

        // If multiple is supported then extract
        // all filenames from the file array
        if ( multipleSupport ) {
          fileArr = $file[0].files;
          for ( var i = 0, len = fileArr.length; i < len; i++ ) {
            files.push( fileArr[i].name );
          }
          filename = files.join(', ');

        // If not supported then just take the value
        // and remove the path to just show the filename
        } else {
          filename = $file.val().split('\\').pop();
        }

        $input.val( filename ) // Set the value
          .attr('title', filename) // Show filename in title tootlip
          .focus(); // Regain focus

      });

      $input.on({
        blur: function() { $file.trigger('blur'); },
        keydown: function( e ) {
          if ( e.which === 13 ) { // Enter
            if ( !isIE ) { $file.trigger('click'); }
          } else if ( e.which === 8 || e.which === 46 ) { // Backspace & Del
            // On some browsers the value is read-only
            // with this trick we remove the old input and add
            // a clean clone with all the original events attached
            $file.replaceWith( $file = $file.clone( true ) );
            $file.trigger('change');
            $input.val('');
          } else if ( e.which === 9 ){ // TAB
            return;
          } else { // All other keys
            return false;
          }
        }
      });

    });

  };

  // Old browser fallback
  if ( !multipleSupport ) {
    $( document ).on('change', 'input.customfile', function() {

      var $this = $(this),
          // Create a unique ID so we
          // can attach the label to the input
          uniqId = 'customfile_'+ (new Date()).getTime(),
          $wrap = $this.parent(),

          // Filter empty input
          $inputs = $wrap.siblings().find('.customfile-filename')
            .filter(function(){ return !this.value }),

          $file = $('<input type="file" id="'+ uniqId +'" name="'+ $this.attr('name') +'"/>');

      // 1ms timeout so it runs after all other events
      // that modify the value have triggered
      setTimeout(function() {
        // Add a new input
        if ( $this.val() ) {
          // Check for empty fields to prevent
          // creating new inputs when changing files
          if ( !$inputs.length ) {
            $wrap.after( $file );
            $file.customFile();
          }
        // Remove and reorganize inputs
        } else {
          $inputs.parent().remove();
          // Move the input so it's always last on the list
          $wrap.appendTo( $wrap.parent() );
          $wrap.find('input').focus();
        }
      }, 1);

    });
  }

}( jQuery ));

$('input[type=file]').customFile();

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
