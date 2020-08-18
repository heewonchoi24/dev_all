<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
if (eslMemberId == null || eslMemberId.equals("")) {
	ut.jsAlert(out, "�α����� ���ּ���.");
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
				���� ���뿭�� ���� ��<br/>
				<span>������ �´� <strong>�ս��� �۽��� ��Ī���α׷�</strong></span>��<br/>
				��õ�ص帳�ϴ�.
			</div>
			<div class="result_box result1">
				<div class="top_text">
					<strong><%=eslMemberId %></strong> ������<br/>
					<span>1�� �������뿭��</span>��
				</div>
				<div class="circle">
					<div class="inner">
						<p><%=bmr %></p>
						kcal �Դϴ�.
					</div>
				</div>
				<div class="bottom_text">
					BMI ��ġ
					<p><%=bmi %></p>
				</div>
			</div>
			<p class="em">*�ش� ������ ����, BMI, ������ Ȱ�� �� �ʿ��� ������ �������� ���� �˴ϴ�.  </p>
			<div class="btns">
				<a href="javascript:recProgram();">�ս��� ���α׷� ��õ</a>
			</div>
		</div>
	</div>
<script>
/*
>> 1�� ó�濭�� ���ϴ� ����
BMI�� ���� �� ���� ����� ����
ü�߰��� ȿ���� ���̱� ����,
1�� �ʿ俭��(ǥ��ü��X25) ������ ������ 10~30%�� ���Ͽ� ���
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

	 if (bmi < 18.5){	// ��ü��
		 kcal = bmr;
	 }
	 if (bmi >= 18.5 && bmi < 23){	// ����
		 kcal = bmr * 0.9;
	 }
	 else if (bmi >= 23 && bmi < 25){	// ��ü��
		 kcal = bmr * 0.8;
	 }
	 else if (bmi >= 25){	// ��
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