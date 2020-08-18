<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
if (eslMemberId == null || eslMemberId.equals("")) {
	ut.jsAlert(out, "로그인을 해주세요.");
	out.println("<script>self.close();</script>");
}
%>
<%
eslMemberId			= (String)session.getAttribute("esl_member_id");
String bmi		    = ut.inject(request.getParameter("bmi"));
bmi = bmi.replaceAll("<","&lt;");
bmi = bmi.replaceAll(">","&gt;");
String bmr		    = ut.inject(request.getParameter("bmr"));
bmr = bmr.replaceAll("<","&lt;");
bmr = bmr.replaceAll(">","&gt;");
%>
</head>
<body>
	<div class="pop-wrap" id="event_personal">
		<form id="f_submit" name="f_submit" method="post" action="/promotion/personal3.jsp">
			<input type="hidden" id="rec_kcal" name="rec_kcal" />
			<input type="hidden" id="group_code" name="group_code" />
		</form>
		<div class="inner">
			<div class="top_visual">
				적정 섭취열량 제시 및<br/>
				<span>나에게 맞는 <strong>잇슬림 퍼스널 코칭프로그램</strong></span>을<br/>
				추천해드립니다.
			</div>
			<div class="result_box result1">
				<div class="top_text">
					<strong><%=eslMemberId %></strong> 고객님의<br/>
					<span>1일 적정섭취열량</span>은
				</div>
				<div class="circle">
					<div class="inner">
						<p><%=bmr %></p>
						kcal 입니다.
					</div>
				</div>
				<div class="bottom_text">
					BMI 수치
					<p><%=bmi %></p>
				</div>
			</div>
			<p class="em">*해당 정보는 성별, BMI, 가벼운 활동 시 필요한 열량을 기준으로 산출 됩니다.  </p>
			<div class="btns">
				<a href="javascript:recProgram();">잇슬림 프로그램 추천</a>
			</div>
		</div>
	</div>
<script>
/*
>> 1일 처방열량 구하는 계산식
BMI에 따른 비만 판정 결과에 따라
체중감량 효과를 높이기 위해,
1일 필요열량(표준체중X25) 값에서 열량의 10~30%씩 감하여 계산
*/
function recProgram(){

	 var bmr = '<%=bmr %>';
	 var bmi = '<%=bmi %>';
	 var kcal;
	 var recKcal;
	 var groupCode;

	 if(bmr.indexOf(',')){
		bmr = bmr.replace(",", "");
	 }

	 if (bmi < 18.5){	// 저체중
		 kcal = bmr;
	 }
	 if (bmi >= 18.5 && bmi < 23){	// 정상
		 kcal = bmr * 0.9;
	 }
	 else if (bmi >= 23 && bmi < 25){	// 과체중
		 kcal = bmr * 0.8;
	 }
	 else if (bmi >= 25){	// 비만
		 kcal = bmr * 0.7;
	 }
	
	if(kcal >= 1400){
		groupCode = '0301833';
		recKcal = '1,500';
		$("#rec_kcal").val(recKcal);
		$("#group_code").val(groupCode);
	}
	if(kcal >= 1100 && kcal < 1400){
		groupCode = '0301834';
		recKcal = '1,200';
		$("#rec_kcal").val(recKcal);
		$("#group_code").val(groupCode);
	}
	if(kcal < 1100){
		groupCode = '0301835';
		recKcal = '800';
		$("#rec_kcal").val(recKcal);
		$("#group_code").val(groupCode);
	}

	document.f_submit.submit();
}
</script>
</body>
</html>