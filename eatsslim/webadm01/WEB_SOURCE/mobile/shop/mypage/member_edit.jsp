<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
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

String hp1 			= "";
String hp2 			= "";
String hp3 			= "";
String email		= "";

String memName 		= "";
String memHp 		= "";
String memEmail 	= "";
String emailYn 		= "";
String snsYn 		= "";

String hpTmp[] = new String[3];
String emailTmp[] = new String[2];

query				= "SELECT MEM_NAME, HP, EMAIL, EMAIL_YN, SMS_YN FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"' AND CUSTOMER_NUM = '"+ eslCustomerNum +"'";;
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
	p_email 		= $("#email").val();
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
	//	이름 길이 확인
 	if(p_mem_name.length > 10){
		alert("이름은 한글, 영문 10자 내외로 입력해주세요.");
		return;
	}
	//	휴대폰 번호 확인
    $("#hp").val($("#hp1").val() + $("#hp2").val() + $("#hp3").val());
    var p_mem_hp = $("#hp1").val() + "-" + $("#hp2").val() + "-" + $("#hp3").val();
    if ($("#hp").val() == "" || $("#hp").val().length != 11 || isNaN($("#hp").val())) {
    	alert("휴대폰 번호를 정확히 입력해 주세요");
     	return;
    }
    for (var i=0; i<$("#hp").val().length; i++)  {
    	var chk = $("#hp").val().substring(i,i+1);
        if(chk == " "){
        	alert("휴대폰 번호를 정확히 입력해주세요");
            return;
       	}
    }
    //	이메일 유효성 체크
    var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
  	//입력을 안했으면
    if(p_email.length == 0){
    	return;
    }
	//	이메일 형식에 맞지않으면
	if (regExp.test(p_email) == false){
		alert("이메일 형식이 올바르지 않습니다.");
		return;
	}
    //	post 방식으로 파라미터 값 전송
    if (confirm("반영 하시겠습니까?")) {
	   $.post("member_edit_ajax.jsp", {
	    	p_mem_name     : p_mem_name
	    	,p_mem_hp      : p_mem_hp
	    	,p_email       : p_email
	    	,p_cb_sns_yn   : p_cb_sns_yn
	    	,p_cb_email_yn : p_cb_email_yn
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					alert("정상적으로 등록되었습니다.");
					location.href = '/mobile/index.jsp';
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

<script type="text/javascript" src="/common/js/date.js"></script>
<script type="text/javascript" src="/common/js/jquery.datePicker.js"></script>
<script type="text/javascript" src="/common/js/common.js"></script>
</head>
<body>
<div id="wrap" class="expansioncss">
	<%@ include file="/mobile/common/include/inc-header.jsp"%>
	<!-- End header -->
	<div id="container">
		<div class="container_inner">
			<section id="index_content" class="contents">
				<header class="cont_header">
					<h2>회원정보 수정</h2>
				</header>
				<div class="content" id="member_edit">
					<div class="boxTable">
						<table>
							<tbody>
								<tr>
									<th>이름</th>
									<td>
									    <input style="width:130px;" id="mem_name" name="mem_name" type="text" class="ipt" value="<%=memName%>" />
										<p style="color:red; font-size: 9px;">* 이름은 한글, 영문 10자 내외로 입력해주세요.</p>
									</td>
								</tr>
								<tr>
									<th id="hp">휴대폰 번호</th>
									<td>
									    <select style="width:70px;" id="hp1" name="hp1" class="inp_st">
											<option>선택</option>
											<option value="010" <%if(hp1.equals("010")){%>selected<%}%>>010</option>
										 	<option value="011" <%if(hp1.equals("011")){%>selected<%}%>>011</option>
										 	<option value="016" <%if(hp1.equals("016")){%>selected<%}%>>016</option>
										 	<option value="017" <%if(hp1.equals("017")){%>selected<%}%>>017</option>
										 	<option value="018" <%if(hp1.equals("018")){%>selected<%}%>>018</option>
										 	<option value="019" <%if(hp1.equals("019")){%>selected<%}%>>019</option>
										</select>
								    	-
								    	<input type="number" id="hp2" name="hp2" type="text" class="ipt" style="width:70px;" value="<%=hp2%>" require />
								    	-
								    	<input type="number" id="hp3" name="hp3" type="text" class="ipt" style="width:70px;" value="<%=hp3%>" required />
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<input id="email" name="email" type="text" class="ipt" style="width:231px;" value="<%= memEmail%>">
									</td>
								</tr>
								<tr>
									<th>마케팅 <br/>수신동의</th>
									<td>
									<input id="cb_sns_yn" type="checkbox" name="cb_sns_yn" <%if(snsYn.equals("Y")){%>checked<%}%>>
									<label for="cb_sns_yn" style="font-size: 14px">SMS 수신동의</label>
									&nbsp;&nbsp;&nbsp;
									<input id="cb_email_yn" type="checkbox" name="cb_email_yn" <%if(emailYn.equals("Y")){%>checked<%}%>>
									<label for="cb_email_yn" style="font-size: 14px">E-mail 수신동의</label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="qnaBtns">
						<a href="javascript:void(0);" onclick="btn_memberEdit();" class="btn btn_dgray square" style="min-width: 100px;">회원정보 수정</a>
						&nbsp;&nbsp;&nbsp;
						<a href="/mobile/index.jsp" class="btn btn_gray square" style="min-width: 60px;">취소</a>
					</div>
				</div>
			</section>
			<section id="load_content" class="contents">

			</section>
		</div>
	</div>
	<!-- End container -->

		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	<!-- End footer -->
</div>
</body>
</html>
