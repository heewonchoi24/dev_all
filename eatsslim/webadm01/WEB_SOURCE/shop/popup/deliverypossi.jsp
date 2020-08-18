<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>����� �������� Ȯ��</title>
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
						<form name="frm_zipcode">
							<div class="postSearchBox">
								<p>��� ������ ������ Ȯ���غ�����.</p>
								<p>��/��/��/�� �̸��� �Է��ϼ���. ��) ���ﵿ,ȭ����,������</p>
								<!--p>�����ּ�:��/��/��/�� �̸��� �Է��ϼ���. ��) ���ﵿ,ȭ����,������</p>
                                <p>���θ��ּ�(���ּ�):���θ��� �Է��ϼ���. ��) �߾ӷ�,������ 432����</p>
								<label>����/���θ�</label>
								<label>����</label-->
								<input type="text" class="inputfield" name="dong" id="dong"> <span class="button small light" style="margin:0;"><a href="javascript:;" onclick="schZipCode();">��ȸ</a></span>
								<p><font color="blue">�Է¶��� �������� �Է��Ͻð� ����ȸ�� ��ư�� Ŭ���Ͻñ� �ٶ��ϴ�.</font></p>
								<p>
									<font color="green">
										- �Ϲ��ǰ : ���� ���Ϲ�� ��ǰ(����,�˶���, ��ũ������, 2��/4�� ���α׷�)<br />
										- �ù��ǰ : ���(�뷱������ũ)/�����ǰ(�̴Ϲ�, ���̽�, 6�� ���α׷�)
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
$('html').bind('keypress', function(e){
   if(e.keyCode == 13)   {
      return false;
   }
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