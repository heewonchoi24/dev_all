<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("utf-8");

String ztype			= ut.inject(request.getParameter("ztype"));
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>�����ȣ �˻�</title>
</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
			<h2>�����ȣ �˻�</h2>
			<p></p>
		</div>
		<div class="contentpop">
			<div class="popup columns offset-by-one"> 
				<div class="row">
					<div class="one last col">
						<form name="frm_zipcode">
							<input type="hidden" name="ztype" id="ztype" value="<%=ztype%>" />
							<div class="postSearchBox">
								<p>�����ȣ�� �˻��ϼ���.</p>
								<p>��/��/��/�� �̸��� �Է��ϼ���. ��) ���ﵿ,ȭ����,������</p>
								<!--p>�����ּ�:��/��/��/�� �̸��� �Է��ϼ���. ��) ���ﵿ,ȭ����,������</p>
                                <p>���θ��ּ�(���ּ�):���θ��� �Է��ϼ���. ��) �߾ӷ�,������ 432����</p>
								<label>����/���θ�</label>
								<label>����</label-->
								<input type="text" class="inputfield" name="dong" id="dong"> <span class="button small light" style="margin:0;"><a href="javascript:;" onclick="schZipCode();">��ȸ</a></span>
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
		ztype: $("#ztype").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				$(".tbmulti").html('<tr><th>�����ȣ</th><th>�ּ�</th></tr>');
				var zipcodeArr;
				$(data).find("address").each(function() {
					zipcodeArr = $(this).text().split("|");
					if (zipcodeArr[0] == "nodata") {
						$(".tbmulti").append('<tr><td colspan="2">�˻��� �����ȣ�� �����ϴ�.</td></tr>');
					} else {
						$(".tbmulti").append('<tr><td>'+ zipcodeArr[0] +'</td><td><a href="javascript:;" onclick="setZipcode(\''+ zipcodeArr[0] +'\',\''+ zipcodeArr[1] +'\');">'+ zipcodeArr[1] +'</a></td></tr>');
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

function setZipcode(zip, addr) {
	if ($("#ztype").val() == "1") {
		$("#rcv_zipcode").val(zip);
		$("#rcv_addr1").val(addr);
	} else {
		$("#tag_zipcode").val(zip);
		$("#tag_addr1").val(addr);
	}
	$.lightbox().close();
}
</script>
</body>
</html>