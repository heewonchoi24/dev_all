<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>����� �������� Ȯ��</h2>
        <button id="cboxClose" type="button">close</button>
		<div class="clear"></div>
	</div>
	<div class="contentpop">
		<div class="bg-gray">
			<p>��ް����� ������ Ȯ���غ�����.</p>
			<p>��/��/��/�� �̸��� �Է��ϼ���. ��) ���ﵿ,ȭ����,������</p>
			<table class="form-line" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="70"><label>�����˻�</label></td>
					<td style="padding-right:20px;"><input type="text" name="dong" id="dong" style="width:100%;"></td>
					<td width="40"><button class="ui-btn ui-mini ui-btn-up-b" onClick="schZipCode();" value="��ȸ" /><span class="ui-btn-inner"><span class="ui-btn-text">��ȸ</span></span></button></td>
				</tr>
			</table>
			<p>
				<font color="blue">�Է¶��� �������� �Է��Ͻð� ����ȸ�� ��ư�� Ŭ���Ͻñ� �ٶ��ϴ�</font>
			</p>
			<p>
				<font color="green">
					- �Ϲ��ǰ: �������Ϲ�� ��ǰ(����,�˶���,��ũ������)<br />
					- �ù��ǰ: ��½�ǰ(�ս����뷱������ũ)
				</font>
			</p>
		</div>
		<div class="row">
			<table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th width="60">�����ȣ</th>
				  <th>�ּ�</th>
					<th width="40">�ù�</th>
				  <th width="40">�Ϲ�</th>
			  </tr>
			</table>
		</div>
	</div>
	<!-- End contentpop -->
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#dong").focus();
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
				$(".spectable").html('<tr><th width="60">�����ȣ</th><th>�ּ�</th><th width="40">�Ϲ�</th><th width="40">�ù�</th></tr>');
				var zipcodeArr;
				$(data).find("address").each(function() {
					zipcodeArr = $(this).text().split("|");
					if (zipcodeArr[0] == "nodata") {
						$(".spectable").append('<tr><td colspan="2">�˻��� ��ް��������� �����ϴ�.</td></tr>');
					} else {
						$(".spectable").append('<tr><td>'+ zipcodeArr[0] +'</td><td>'+ zipcodeArr[1] +'</td><td>'+ zipcodeArr[4] +'</td><td>'+ zipcodeArr[5] +'</td></tr>');
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