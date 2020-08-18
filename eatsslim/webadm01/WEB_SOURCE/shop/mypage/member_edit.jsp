<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.net.URLDecoder"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>

<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int tcnt			= 0;
int couponId		= 0;
String couponName	= "";
String couponNum	= "";
String saleType		= "";
int salePrice		= 0;
int useLimitCnt		= 0;
int useLimitPrice	= 0;
String useLimitTxt	= "";
String useGoods		= "";
String useGoodsTxt	= "";
String stdate		= "";
String ltdate		= "";
String counselID	= "";
String btnMod		= "";
String btnDel		= "";
String upFile		= "";
String imgUrl		= "";
NumberFormat nf		= NumberFormat.getNumberInstance();

String p_mem_name 	= "";
String p_hp1 			= "";
String p_hp2 			= "";
String p_hp3 			= "";
String p_email1 		= "";
String p_emailInput 	= "";
String p_cb_sns_yn 	= "";
String p_cb_email_yn 	= "";

String hp1 			= "";
String hp2 			= "";
String hp3 			= "";
String email1 		= "";
String emailInput 	= "";

String memName 		= "";
String memHp 		= "";
String memEmail 	= "";
String emailYn 		= "";
String snsYn 		= "";

String hpTmp[] = new String[3];
String emailTmp[] = new String[2];

query				= "SELECT MEM_NAME, HP, ifnull(EMAIL,'') AS EMAIL, ifnull(EMAIL_YN,'N') AS EMAIL_YN, ifnull(SMS_YN,'N') AS SMS_YN FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"' AND CUSTOMER_NUM = '"+ eslCustomerNum +"'";
try {
	rs				= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true) return;
}
if (rs.next()) {
	memName			= rs.getString("MEM_NAME");
	memHp			= rs.getString("HP");
	if (memHp != null && memHp.length()>10) {
		hpTmp		= memHp.split("-");
		hp1			= hpTmp[0];
		hp2			= hpTmp[1];
		hp3			= hpTmp[2];
	}
	memEmail		= rs.getString("EMAIL");
	if (memEmail != null && memEmail != "") {		
		emailTmp	= memEmail.split("@");
		email1		= emailTmp[0];
		emailInput	= emailTmp[1];
	}
	emailYn			= rs.getString("EMAIL_YN");
	snsYn			= rs.getString("SMS_YN");
}
rs.close();
%>

<script type="text/javascript">
//	소셜계정개인정보수정
function btn_memberEdit(){
	p_mem_name 		= $("#mem_name").val();
	p_hp1 			= $("#hp1").val();
	p_hp2 			= $("#hp2").val();
	p_hp3 			= $("#hp3").val();
	p_email1 		= $("#email1").val();
	p_emailInput 	= $("#emailInput").val();
	p_cb_sns_yn 	= $("#cb_sns_yn").is(":checked");
	p_cb_email_yn 	= $("#cb_email_yn").is(":checked");
	
	if(p_cb_sns_yn) p_cb_sns_yn = "Y";
	else p_cb_sns_yn = "N";
	if(p_cb_email_yn) p_cb_email_yn = "Y";
	else p_cb_email_yn = "N";

	//	본인 이름 확인
 	if(p_mem_name == ""){
		alert("이름은 필수사항입니다.");
		return;
	}
	//	이름 길이 확인
 	if(p_mem_name.length > 10){
		alert("이름은 한글, 영문 10자 내외로 입력해주세요.");
		return;
	}
	//	휴대폰 번호 확인
    $("#hp").val($("#hp1").val() + $("#hp2").val() + $("#hp3").val());
    var p_mem_hp = $("#hp1").val() + "-" + $("#hp2").val() + "-" + $("#hp3").val();
    if ($("#hp").val() == "" || $("#hp").val().length != 11 || isNaN($("#hp").val())) {
    	alert("휴대폰 번호를 정확히 입력해 주세요.");
     	return;
    }
    for (var i=0; i<$("#hp").val().length; i++)  {
    	var chk = $("#hp").val().substring(i,i+1);
        if(chk == " "){
        	alert("휴대폰 번호를 정확히 입력해주세요.");
            return;
       	}
    }
    //	이메일 확인
    $("#email").val($("#email1").val() + $("#emailInput").val());
    var p_mem_email = $("#email1").val() + "@" + $("#emailInput").val();
    if ($("#email").val() == "" || p_email1 == "" || p_emailInput == "") {
    	alert("이메일 주소를 입력해 주세요.");
     	return;
    }
    //	이메일 유효성 체크
    var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
	//	이메일 형식에 맞지않으면
	if (regExp.test(p_mem_email) == false){
		alert("이메일 형식이 올바르지 않습니다.");
		return;
	}
    //	post 방식으로 파라미터 값 전송
    if (confirm("반영 하시겠습니까?")) {
	   $.post("member_edit_ajax.jsp", {
	    	p_mem_name     : p_mem_name
	    	,p_mem_hp      : p_mem_hp
	    	,p_mem_email   : p_mem_email
	    	,p_cb_sns_yn   : p_cb_sns_yn
	    	,p_cb_email_yn : p_cb_email_yn
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					alert("정상적으로 등록되었습니다.");
					location.href = '/index_es.jsp';
				} 
				else {
					$(data).find("error").each(function() {
						alert($(this).text());
					});
				}
			});
		}, "xml");
	   return false;
    }
}
</script>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<div class="pageDepth">
				<span>홈</span><span>마이페이지</span><strong>회원정보 수정</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<ul class="tabNavi">
						<li><a href="javascript:void(0);">회원정보 수정</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<form id="memberEditForm" method="post">
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>이름</th>
								<td>
									<input id="mem_name" name="mem_name" type="text" class="ftfd" value="<%=memName%>" />
									<br>
									<p style="color:red; font-size: 12px;">* 이름은 한글, 영문 10자 내외로 입력해주세요.</p>
								</td>
							</tr>
							<tr>
								<th id="hp">휴대폰번호</th>
								<td>
									<select style="width:50px;" maxlength="4" id="hp1" name="hp1">
										<option>선택</option>
										<option value="010" <%if(hp1.equals("010")){%>selected<%}%>>010</option>
									 	<option value="011" <%if(hp1.equals("011")){%>selected<%}%>>011</option>
									 	<option value="016" <%if(hp1.equals("016")){%>selected<%}%>>016</option>
									 	<option value="017" <%if(hp1.equals("017")){%>selected<%}%>>017</option>
									 	<option value="018" <%if(hp1.equals("018")){%>selected<%}%>>018</option>
									 	<option value="019" <%if(hp1.equals("019")){%>selected<%}%>>019</option>
									</select>
									-
									<input type="number" id="hp2" name="hp2" type="text" class="ftfd" style="width:80px;" maxlength="4" value="<%=hp2%>" required />
									-
									<input type="number" id="hp3" name="hp3" type="text" class="ftfd" style="width:80px;" maxlength="4" value="<%=hp3%>" required />
								</td>
							</tr>
							<tr>
								<th id="email">이메일</th>
								<td>
									<input id="email1" name="email1" type="text" class="ftfd" style="width:150px;" value="<%=email1%>" />
									@
									<input type="text" name="emailInput" class="ftfd" id="emailInput" style="width:150px;" value="<%=emailInput%>" />
									<select style="width:150px;" id="emailSelect">
							 			<option value="">직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="nate.com">nate.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="lycos.co.kr">lycos.co.kr</option>
										<option value="empal.com">empal.com</option>
										<option value="dreamwiz.com">dreamwiz.com</option>
										<option value="korea.com">korea.com</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>마케팅 수신 동의</th>
								<td>
										
									<input id="cb_sns_yn" type="checkbox" name="cb_sns_yn" <%if(snsYn.equals("Y")){%>checked<%}%>>
									<label for="cb_sns_yn">SMS 수신동의</label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input id="cb_email_yn" type="checkbox" name="cb_email_yn" <%if(emailYn.equals("Y")){%>checked<%}%>>
									<label for="cb_email_yn">E-mail 수신동의</label>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<div class="divider"></div>
			<div class="row">
				<div class="last col">
					<div class="center">
						<a href="javascript:void(0);" onclick="btn_memberEdit();" class="button2 large black">회원정보 수정</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/index_es.jsp" class="button2 large">취소</a>
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
	$("#emailSelect").change(function(e) {
		var v = $(this).val();

		if(v != ""){
			$("#emailInput").prop('readonly', true);
		}else{
			$("#emailInput").prop('readonly', false);
		}

		$("#emailInput").val(v);
	});
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>