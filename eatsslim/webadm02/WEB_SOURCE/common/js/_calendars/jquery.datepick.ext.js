/* http://keith-wood.name/datepick.html
   Datepicker extensions for jQuery v4.0.6.
   Written by Keith Wood (kbwood{at}iinet.com.au) August 2009.
   Dual licensed under the GPL (http://dev.jquery.com/browser/trunk/jquery/GPL-LICENSE.txt) and 
   MIT (http://dev.jquery.com/browser/trunk/jquery/MIT-LICENSE.txt) licenses. 
   Please attribute the author if you use it. */

(function($) { // Hide scope, no $ conflict

$.extend($.datepick, {
	/* Don't allow expo period to be selected.
	   Usage: onDate: $.datepick.noExpo.
	   @param  date  (Date) the current date
	   @return  (object) information about this date */
	noSundays: function(date) {
		return {selectable: date.getDay() != 0};
	},
	noWeekends: function(date) {
		return {selectable: date.getDay() != 0 && date.getDay() != 6};
	}
});

})(jQuery);
