<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ page import="java.sql.*"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
String ztype		= ut.inject(request.getParameter("ztype"));
String query		= "";
String sido			= "";
String gugun		= "";

query		= "SELECT DISTINCT SIDO FROM PHIBABY.V_ZIPCODE_OLD ORDER BY SIDO";
try {
	rs_phi	= stmt_phi.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta name="robots" content="noindex,nofollow,noarchive">

	<title>�ٸ� ���̾�Ʈ �ս���</title>

	<link rel="stylesheet" type="text/css" media="all" href="/common/css/layout.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/skeleton.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/color-theme.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.selectBox.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.lightbox.css" />
    <link rel="stylesheet" type="text/css" media="print" href="/common/css/print.css" />

	<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
    <!--[if gte IE 9]>
	<style type="text/css">
	.gradient {filter: none;}
	</style>
    <![endif]-->
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>����� �������� Ȯ��</h2>
		<p></p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<h4 class="marb20"> ��� ������ ������ Ȯ���� ������.</span></h4>
					<p>���θ����� �˻��ϸ� �� �� ��Ȯ�� ������ Ȯ���Ͻ� �� �ֽ��ϴ�.</p>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<form name="frm_zipcode" id="frm_zipcode">
						<input type="hidden" name="mode" value="sch" />
						<div style="width:49%;float:left;">
							<div class="postSearchBox" style="padding:51px 20px;">
								<label>
									<input type="radio" name="zip_type" value="1" onclick="clearZip(1);" /> ��/��/������ �˻�
								</label>
								<p>(��: ���ﵿ, ȭ����, ������)</p>
								<label>��/��/��</label>
									<input type="text" class="inputfield" name="dong1" id="dong1" />
									<span class="button small darkbrown" style="margin:0;"><a href="javascript:;" onclick="schZipCode();">��ȸ</a>
								</span>
							</div>
						</div>
						<div style="width:49%;float:right;">
							<div class="postSearchBox" style="padding:10px 20px;">
								<label>
									<input type="radio" name="zip_type" value="2" onclick="clearZip(2);" /> ���θ� �Ǵ� �ǹ������� �˻�
								</label>
								<p>(��: �����, �������, ��������)</p>
								<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<th><span class="font-maple">*</span>��/��</th>
										<td>
											<select name="sido" id="sido" style="width:100px;" onchange="getGugun();">
												<option value="">����</option>
												<%
												while (rs_phi.next()) {
													sido		= rs_phi.getString("SIDO");
												%>
												<option value="<%=sido%>"><%=sido%></option>
												<%
												}

												rs_phi.close();
												%>
											</select>
										</td>
										<th><span class="font-maple">*</span>��/��</th>
										<td>
											<select name="gugun" id="gugun" style="width:100px;" onchange="this.form.dong2.focus()">
												<option value="">����</option>
											</select>
										</td>
									</tr>
									<tr>
										<th><span class="font-maple">*</span>���θ�</th>
										<td><input name="dong2" id="dong2" type="text" class="ftfd" style="width:90px; margin-top:5px;" /></td>
										<th>�ǹ���</th>
										<td><input name="bunji" id="bunji" type="text" class="ftfd" style="width:90px; margin-top:5px;" /></td>
									</tr>
								</table>
								<div class="center mart10">
									<div class="button small darkbrown"><a href="javascript:;" onclick="schZipCode();">��ȸ</a></div> 
								</div> 
							</div>  
						</div>
					</form>
					<div class="clear"></div>
					<div class="row">
						<div class="one last col">
							<div class="frameBox mart20">
								<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<th>�����ȣ</th>
										<th>�ּ�</th>
										<th>�Ϲ�</th>
										<th>�ù�</th>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- End row -->
		</div>
		<!-- End popup columns offset-by-one -->
	</div>
	<!-- End contentpop -->
	<div id="floatMenu" style="display:none;">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
<iframe id="ifrmHidden" name="ifrmHidden" src="about:blank" style="width:100%;height:200px;display:none;"></iframe>
<script type="text/javascript">
function clearZip(obj) {
	if (obj == '1') {
		$("#sido").val("");
		$("#gugun").val("");
		$("#dong2").val("");
		$("#bunji").val("");
	}
}

function getGugun() {
	if (!$.trim($("#sido").val())) {
		alert("�˻��Ͻ� �õ��� �����ϼ���.");
		$("#sido").select();
		return false;
	} else {
		var f	= document.frm_zipcode;
		f.action	= "/shop/sch_gugun.jsp";
		f.target	= "ifrmHidden";
		f.submit();
	}
}

function schZipCode() {
	var zipType		= $("input[name=zip_type]:checked").val();
	if (!zipType) {
		alert("��/��/�� �Ǵ� ���θ� �˻��� �����ϼ���.");
		return false;
	} else if (zipType == "1" && !$("#dong1").val()) {
		alert("��/��/���� �Է��ϼ���.");
		$("#dong1").focus();
		return false;
	} else if (zipType == "2" && !$("#sido").val()) {
		alert("��/���� �����ϼ���.");
		$("#sido").focus();
		return false;
	} else if (zipType == "2" && !$("#gugun").val()) {
		alert("��/���� �����ϼ���.");
		$("#gugun").focus();
		return false;
	} else if (zipType == "2" && !$.trim($("#dong2").val())) {
		alert("����/���θ��� �Է��ϼ���.");
		$("#dong2").focus();
		return false;
	} else {
		if (zipType == "1") {
			dong	= $("#dong1").val();
		} else {
			dong	= $("#dong2").val();
		}
		$.post("zipcode_ajax_test.jsp", {
			mode: 'post',
			zip_type: zipType,
			sido: $("#sido").val(),
			gugun: $("#gugun").val(),
			dong: dong,
			bunji: $("#bunji").val(),
			ztype: "2"
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					$(".tbmulti").html('<tr><th>�����ȣ</th><th>�ּ�</th><th>�Ϲ�</th><th>�ù�</th></tr>');
					var zipcodeArr;
					$(data).find("address").each(function() {
						zipcodeArr = $(this).text().split("|");
						if (zipcodeArr[0] == "nodata") {
							$(".tbmulti").append('<tr><td colspan="4">�˻��� ��۰��������� �����ϴ�.</td></tr>');
						} else {
							$(".tbmulti").append('<tr><td>'+ zipcodeArr[0] +'</td><td>'+ zipcodeArr[1] +'</td><td>'+ zipcodeArr[4] +'</td><td>'+ zipcodeArr[5] +'</td></tr>');
						}
					});
				} else {
					$(data).find("error").each(function() {
						$(data).find("error").each(function() {
							alert($(this).text());
							$("#dong").focus();
						});
					});
				}
			});
		}, "xml");
		return false;
	}
}
</script>
</body>
</html>