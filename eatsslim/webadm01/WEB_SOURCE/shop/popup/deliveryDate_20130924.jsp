<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

	<title>ù ����� Ȯ��</title>

	<link rel="stylesheet" type="text/css" media="all" href="/common/css/fullcalendar.css" />
    <link rel="stylesheet" type="text/css" media="print" href="/common/css/fullcalendar.print.css" />
	<script type="text/javascript" src='/common/js/fullcalendar.js'></script>
	<script type="text/javascript" src="/common/js/date.js"></script>
	<script type="text/javascript" src="/common/js/jquery.datePicker.js"></script>
	<script type="text/javascript">  
	$(function()
				{
					$('.date-pick').datePicker().val(new Date().asString()).trigger('change');
				});  
	</script>
	<script type="text/javascript">

	$(document).ready(function() {
	
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		$('#calendar').fullCalendar({
			header: {
				left: '',
				center: 'prev,title,next',
				right: ''
			},
			editable: true,
			events: [
				{
					title: 'All Day Event',
					start: new Date(y, m, 1)
				},
				{
					title: 'Long Event',
					start: new Date(y, m, d-5),
					end: new Date(y, m, d-2)
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: new Date(y, m, d-3, 16, 0),
					allDay: false
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: new Date(y, m, d+4, 16, 0),
					allDay: false
				},
				{
					title: 'Meeting',
					start: new Date(y, m, d, 10, 30),
					allDay: false
				},
				{
					title: 'Lunch',
					start: new Date(y, m, d, 12, 0),
					end: new Date(y, m, d, 14, 0),
					allDay: false
				},
				{
					title: 'Birthday Party',
					start: new Date(y, m, d+1, 19, 0),
					end: new Date(y, m, d+1, 22, 30),
					allDay: false
				},
				{
					title: 'Click for Google',
					start: new Date(y, m, 28),
					end: new Date(y, m, 29),
					url: 'http://google.com/'
				}
			]
		});
		
	});

</script>
<style>

	#calendar {
		width: 800px;
		margin: 0 auto;
		}

</style>
</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
		    <h2>ù ����� Ȯ��</h2>
			<p>���Բ��� �����Ͻ� ��۱Ⱓ�� �������� �ֽ��ϴ�. ��ۿ��θ� Ȯ���� �ֽʽÿ�.</p>
		</div>
	    <div class="contentpop">
		    <div class="popup columns offset-by-one"> 
					<div class="row">
					   <div class="one last col">
					       <p class="floatleft">ù ����� ����</p> 
							 <div class="floatleft">
                               <input name="date2" id="date2" class="date-pick" />
							  </div>
						 <div class="clear"></div>	  
					   </div>
					   <div class="one last col">
					      <table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>�޹���</th>
								<th>�޹���</th>
								<th>��ۿ���Ȯ��</th>
							</tr>
							<tr>
								<td>2013.07.01</td>
								<td>������</td>
								<td class="last" style="text-align:center;">
								  <select name="" class="formsel">
								  	<option>��ۿ��μ���</option>
								  </select>
								</td>
							</tr>
						</table>

					   </div>
					</div>
					<!-- End row -->
					<div class="divider"></div>
					<div class="row">
					   <div class="one last col">
                           <div id='calendar'></div>
					   </div>
					</div>
					<!-- End row -->
					<div class="row">
					   <div class="one last col center">
						   <span class="button large light"><a href="#">Ȯ��</a></span>
					   </div>
					</div>
					<!-- End row -->
			  </div>
			  <!-- End popup columns offset-by-one -->	
		</div>
		<!-- End contentpop -->
	</div>
</body>
</html>