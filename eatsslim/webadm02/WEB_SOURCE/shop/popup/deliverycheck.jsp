<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta name="robots" content="noindex,nofollow,noarchive">

	<title>�ս��� ����� �������� Ȯ��</title>

	<link rel="stylesheet" type="text/css" media="all" href="http://www.eatsslim.com/common/css/layout.css" />
    <link rel="stylesheet" type="text/css" media="all" href="http://www.eatsslim.com/common/css/skeleton.css" />
    <link rel="stylesheet" type="text/css" media="all" href="http://www.eatsslim.com/common/css/color-theme.css" />
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
						<form name="frm_zipcode" id="frm_zipcode">
							<div class="postSearchBox">
								<p>��� ������ ������ Ȯ���غ�����.</p>
								<p>��/��/��/�� �̸��� �Է��ϼ���. ��) ���ﵿ,ȭ����,������</p>
								<!--p>�����ּ�:��/��/��/�� �̸��� �Է��ϼ���. ��) ���ﵿ,ȭ����,������</p>
                                <p>���θ��ּ�(���ּ�):���θ��� �Է��ϼ���. ��) �߾ӷ�,������ 432����</p>
								<label>����/���θ�</label>
								<label>����</label-->
								<input type="text" class="inputfield" name="dong" id="dong"> <span class="button small light" style="margin:0;"><a href="javascript:;" onClick="schZipCode();">��ȸ</a></span>
								<p><font color="blue">�Է¶��� �������� �Է��Ͻð� ����ȸ�� ��ư�� Ŭ���Ͻñ� �ٶ��ϴ�.</font></p>
								<p>
									<font color="green">
										- �Ϲ��ǰ: �������Ϲ�� ��ǰ(����,�˶���,��ũ������)<br />
										- �ù��ǰ: ��½�ǰ(�ս����뷱������ũ)
									</font>
								</p>
							</div>
						</form>
						<!--div class="marb20 mart20" style="text-align:center;">
							<p class="bold7">�˻������ �ּҰ� �˻��� ���, ��۰����� �����Դϴ�.<br />
							<font class="f12 font-gray">(�ּ� ����Ʈ�� �˻����� ���� ��� ��� �Ұ��� �����Դϴ�.)</font></p>
						</div-->
                        <div class="divider"></div>
						<div class="frameBox">
							<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<th>�����ȣ</th>
									<th>�ּ�</th>
                                    <th>�Ϲ�</th>
                                    <th>�ù�</th>
								</tr>
							</table>
						</div> 
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<!-- End popup columns offset-by-one -->	
		</div>
		<!-- End contentpop -->
	</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#dong").focus();
	$("#frm_zipcode").submit(schZipCode);
});

function schZipCode() {
	$.post("/shop/zipcode_ajax.jsp", {
		mode: 'post',
		dong: $("#dong").val(),
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
						$(".tbmulti").append('<tr><td colspan="2">�˻��� ��۰��������� �����ϴ�.</td></tr>');
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
</script>
</body>
</html>