<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>

<link rel="stylesheet" type="text/css" media="all" href="/common/css/fullcalendar_cal.css" />
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>����������</h1>
			<div class="pageDepth">
				HOME &gt; ���������� &gt; <strong>���Ķ����</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last  col">
					<ul class="tabNavi">
						<li><a href="index.jsp">Ȩ</a></li>
						<li><a href="orderList.jsp">�ֹ�/���</a></li>
						<li><a href="couponList.jsp">��������</a></li>
						<li><a href="myqna.jsp">1:1 ���ǳ���</a></li>
						<li class="active"><a href="calendar.jsp">���Ķ����</a></li>
						<div class="button small iconBtn light">
							<a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> ȸ����������</a>
						</div>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row calendar_area">
				<div class="calendar_head">
					<div class="calendar_select"> 
						<select name="" id="" class="notCustom">
							<option value="">�ﾾ���� + �˶��� ����</option>
							<option value="">�ﾾ���� + �˶��� ����</option>
							<option value="">�ﾾ���� + �˶��� ����</option>
						</select>
					</div>
					<div class="calendar_range">
						<dl>
							<dt>��۱Ⱓ</dt>
							<dd>2017.05.01 ~ 2017.05.31</dd>
						</dl>
					</div>
				</div>
				<div class="calendar_body">
					<div id="bx_calendar"></div>
				</div>
				<div class="calendar_foot">
					<div class="calender_opt">
						<ul>
							<li><a href="javascript:void(0);">
								<div class="img"><img src="/dist/images/common/ico_calendar_pattern.png" alt="" /></div>
								<p>������Ϻ���</p>
							</a></li>
							<li><a href="javascript:void(0);">
								<div class="img"><img src="/dist/images/common/ico_calendar_range.png" alt="" /></div>
								<p>�����������</p>
							</a></li>
							<li><a href="javascript:void(0);">
								<div class="img"><img src="/dist/images/common/ico_calendar_area.png" alt="" /></div>
								<p>���������</p>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
			
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
<script type="text/javascript">


$('#bx_calendar').fullCalendar({
	hiddenDays : [0,6],
	left: "",
	center : "title",
 	right : "",
	editable : true,
// 	titleFormat : {
// 		month : "yyyy�� MMMM",
// 		week  : "[yyyy] MMM dd��{ [yyyy] MMM dd��}",
// 		day   : "yyyy�� MMM d�� dddd"
// 	},
	defaultView : "month",
	monthNames: ["1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��"],
	monthNamesShort: ["1��","2��","3��","4��","5��","6��","7��","8��","9��","10��","11��","12��"],
	dayNames: ["�Ͽ���","������","ȭ����","������","�����","�ݿ���","�����"],
	dayNamesShort: ["��","��","ȭ","��","��","��","��"],
	buttonText: {
		today:"����",
		month:"����",
		week:"�ֺ�",
		day:"�Ϻ�"
	}
});
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>