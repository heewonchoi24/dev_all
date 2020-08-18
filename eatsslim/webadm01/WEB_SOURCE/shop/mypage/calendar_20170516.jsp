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
			<h1>마이페이지</h1>
			<div class="pageDepth">
				HOME &gt; 마이페이지 &gt; <strong>배송캘린더</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last  col">
					<ul class="tabNavi">
						<li><a href="index.jsp">홈</a></li>
						<li><a href="orderList.jsp">주문/배송</a></li>
						<li><a href="couponList.jsp">쿠폰내역</a></li>
						<li><a href="myqna.jsp">1:1 문의내역</a></li>
						<li class="active"><a href="calendar.jsp">배송캘린더</a></li>
						<div class="button small iconBtn light">
							<a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> 회원정보수정</a>
						</div>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row calendar_area">
				<div class="calendar_head">
					<div class="calendar_select"> 
						<select name="" id="" class="notCustom">
							<option value="">헬씨퀴진 + 알라까르떼 슬림</option>
							<option value="">헬씨퀴진 + 알라까르떼 슬림</option>
							<option value="">헬씨퀴진 + 알라까르떼 슬림</option>
						</select>
					</div>
					<div class="calendar_range">
						<dl>
							<dt>배송기간</dt>
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
								<p>배송패턴변경</p>
							</a></li>
							<li><a href="javascript:void(0);">
								<div class="img"><img src="/dist/images/common/ico_calendar_range.png" alt="" /></div>
								<p>배송일정변경</p>
							</a></li>
							<li><a href="javascript:void(0);">
								<div class="img"><img src="/dist/images/common/ico_calendar_area.png" alt="" /></div>
								<p>배송지변경</p>
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
// 		month : "yyyy년 MMMM",
// 		week  : "[yyyy] MMM dd일{ [yyyy] MMM dd일}",
// 		day   : "yyyy년 MMM d일 dddd"
// 	},
	defaultView : "month",
	monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
	monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
	dayNames: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"],
	dayNamesShort: ["일","월","화","수","목","금","토"],
	buttonText: {
		today:"오늘",
		month:"월별",
		week:"주별",
		day:"일별"
	}
});
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>