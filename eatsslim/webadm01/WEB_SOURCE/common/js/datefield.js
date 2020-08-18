//onload
$(document).ready(function(){
//loop through every datefield
$(".df").each(function(){
//add name datefield to variable
var nm = $(this).attr("name");
//click on icon or field and show the calendar
$("input[name="+nm+"],#"+nm+"_cal").click(function(){showCalendar(nm)});
//add date to date field
$("input[name="+nm+"]").val($("input[name=dt_field_"+nm+"]").val());
//if user enters text in inputfield, then reset text to active date
$("input[name="+nm+"]").keyup(function(){$(this).val($("input[name=dt_field_"+nm+"]").val());});
//navigatie calendar
updateNavCalendar(nm);
});
});
function showCalendar(nm){
//hide all other calendars
$("div[id^=cal_container]").hide();
//add calendar rendered in php to container js
if($("#cal_container_"+nm).size()==0){
//calculate left and top from icon
var int_left = $("#"+nm+"_cal").offset().left+$("#"+nm+"_cal").width();
var int_top = $("#"+nm+"_cal").offset().top;
//make container
var container = "<div id='cal_container_"+nm+"' class='cal_container'></div>";
//add container to body
$("body").append(container);
//add php rendered calendar tp container
$("#cal_container_"+nm).append($("#calendar_"+nm));
//show the calendar
$("#calendar_"+nm).show();
//position the container next to the icon
$("#cal_container_"+nm).css({"position":"absolute","left":int_left+"px","top":int_top+"px"});
}else{
//show calendar
$("#cal_container_"+nm).show();
}
$("#overlay").show();
}
function enterDateInField(dt,nm){
//add year,month and date to vars
var year = dt.substr(0,4);
var month = dt.substr(4,2);
var day = dt.substr(6,2);
//add format dates to var
var format = $("input[name=dt_format_"+nm+"]").val();
//convert new date to correct date format
var newDate = format.replace("YYYY",year).replace("MM",month).replace("DD",day);
//get positions year,month and day in the format
var int_year = format.indexOf("YYYY");
var int_month = format.indexOf("MM");
var int_day = format.indexOf("DD");
//old date
var old = $("input[name="+nm+"]").val();
var oldDate = old.substr(int_year,4)+""+old.substr(int_month,2)+""+old.substr(int_day,2);
//get class for active date
var css_class = $("#day_"+nm+"_"+oldDate).attr("class");
//remove the class
$("#day_"+nm+"_"+oldDate).removeClass(css_class);
//add the class to the new date
$("#day_"+nm+"_"+dt).addClass(css_class);
//add date to field
$("input[name="+nm+"],input[name=dt_field_"+nm+"]").val(newDate);
//hide calendar
$("#cal_container_"+nm).hide();
}
function updateNavCalendar(nm){
//today
var today = new Date();
//year, month and date
var year = today.getFullYear();
var month = (today.getMonth()+1);
var day = today.getDate();
//add leading zero to month if needed
month = month.toString().length==2?month:"0"+month;
//add leading zero to day if needed
day = day.toString().length==2?day:"0"+day;
//take current date but first day of month
var current = getDateFromInputField(nm).substr(0,6)+"01";
var first = year+""+month+"01";
//return to days in past
var boo_past = $("input[name=dt_past_"+nm+"]").val();
//first day off the month currently show is in the past so dispable prev button
if(first>=current && boo_past!=1){
$("#prev_"+nm).html("");
$("#prev_"+nm).css("cursor","default");
$("#next_"+nm).css("cursor","pointer");
$("#next_"+nm).click(function(){showNextMonth(nm)});
//enable prev button
}else{
$("#prev_"+nm).html("&lt;");
$("#next_"+nm+",#prev_"+nm).css("cursor","pointer");
$("#prev_"+nm).click(function(){showPrevMonth(nm)});
$("#next_"+nm).click(function(){showNextMonth(nm)});
}
//add pointer css to all days in the calendar
$("td[id^=day_"+nm+"]").css("cursor","pointer");
//add click-event on all days in calendar
$("td[id^=day_"+nm+"]").click(function(){enterDateInField($(this).attr("id").replace("day_"+nm+"_",""),nm)});
}
function getDateFromInputField(nm){
//add format dates to var
var format = $("input[name=dt_format_"+nm+"]").val();
//get positions year,month and day in the format
var int_year = format.indexOf("YYYY");
var int_month = format.indexOf("MM");
var int_day = format.indexOf("DD");
//inputfield date
var ifield = $("input[name="+nm+"]").val();
var ifieldDate = ifield.substr(int_year,4)+""+ifield.substr(int_month,2)+""+ifield.substr(int_day,2);
return ifieldDate;
}
function showNextMonth(nm){
//get nextmonth
showMonth("next",nm);
}
function showPrevMonth(nm){
//get prevmonth
showMonth("prev",nm);
}
function showMonth(mode,nm){
//make ajax call to get next or prev month
$.post("ajax/renderMonth.php",{"action":"renderMonth","mode":mode,"date":getDateFromInputField(nm),"name":nm},
function(data){
//add new date to inputfield
enterDateInField(data.newDate,nm);
//remove old calendar
$("#calendar_"+nm).remove();
//add new calendar
$("#cal_container_"+nm).append(data.calendar);
//show the calendar
$("#cal_container_"+nm+",#calendar_"+nm).show();
//update the calendar navigation
updateNavCalendar(nm);
}
,"json");
}