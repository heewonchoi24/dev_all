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
//	�ҼȰ���������������
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

	//	���� �̸� Ȯ��
 	if(p_mem_name == ""){
		alert("�̸��� �ʼ������Դϴ�.");
		return;
	}
	//	�̸� ���� Ȯ��
 	if(p_mem_name.length > 10){
		alert("�̸��� �ѱ�, ���� 10�� ���ܷ� �Է����ּ���.");
		return;
	}
	//	�޴��� ��ȣ Ȯ��
    $("#hp").val($("#hp1").val() + $("#hp2").val() + $("#hp3").val());
    var p_mem_hp = $("#hp1").val() + "-" + $("#hp2").val() + "-" + $("#hp3").val();
    if ($("#hp").val() == "" || $("#hp").val().length != 11 || isNaN($("#hp").val())) {
    	alert("�޴��� ��ȣ�� ��Ȯ�� �Է��� �ּ���.");
     	return;
    }
    for (var i=0; i<$("#hp").val().length; i++)  {
    	var chk = $("#hp").val().substring(i,i+1);
        if(chk == " "){
        	alert("�޴��� ��ȣ�� ��Ȯ�� �Է����ּ���.");
            return;
       	}
    }
    //	�̸��� Ȯ��
    $("#email").val($("#email1").val() + $("#emailInput").val());
    var p_mem_email = $("#email1").val() + "@" + $("#emailInput").val();
    if ($("#email").val() == "" || p_email1 == "" || p_emailInput == "") {
    	alert("�̸��� �ּҸ� �Է��� �ּ���.");
     	return;
    }
    //	�̸��� ��ȿ�� üũ
    var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
	//	�̸��� ���Ŀ� ����������
	if (regExp.test(p_mem_email) == false){
		alert("�̸��� ������ �ùٸ��� �ʽ��ϴ�.");
		return;
	}
    //	post ������� �Ķ���� �� ����
    if (confirm("�ݿ� �Ͻðڽ��ϱ�?")) {
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
					alert("���������� ��ϵǾ����ϴ�.");
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
				<span>Ȩ</span><span>����������</span><strong>ȸ������ ����</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<ul class="tabNavi">
						<li><a href="javascript:void(0);">ȸ������ ����</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<form id="memberEditForm" method="post">
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>�̸�</th>
								<td>
									<input id="mem_name" name="mem_name" type="text" class="ftfd" value="<%=memName%>" />
									<br>
									<p style="color:red; font-size: 12px;">* �̸��� �ѱ�, ���� 10�� ���ܷ� �Է����ּ���.</p>
								</td>
							</tr>
							<tr>
								<th id="hp">�޴�����ȣ</th>
								<td>
									<select style="width:50px;" maxlength="4" id="hp1" name="hp1">
										<option>����</option>
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
								<th id="email">�̸���</th>
								<td>
									<input id="email1" name="email1" type="text" class="ftfd" style="width:150px;" value="<%=email1%>" />
									@
									<input type="text" name="emailInput" class="ftfd" id="emailInput" style="width:150px;" value="<%=emailInput%>" />
									<select style="width:150px;" id="emailSelect">
							 			<option value="">�����Է�</option>
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
								<th>������ ���� ����</th>
								<td>
										
									<input id="cb_sns_yn" type="checkbox" name="cb_sns_yn" <%if(snsYn.equals("Y")){%>checked<%}%>>
									<label for="cb_sns_yn">SMS ���ŵ���</label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input id="cb_email_yn" type="checkbox" name="cb_email_yn" <%if(emailYn.equals("Y")){%>checked<%}%>>
									<label for="cb_email_yn">E-mail ���ŵ���</label>
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
						<a href="javascript:void(0);" onclick="btn_memberEdit();" class="button2 large black">ȸ������ ����</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/index_es.jsp" class="button2 large">���</a>
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