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
								<p>ã���� �ϴ� ������ ��/��/��/�� �ǹ����� �Է��ϼ���.</p>
								<p>(��: ����� ������ �Ż�1���� ���, '�Ż�' �Ǵ� '�Ż絿'�� �Է��Ͻø� �˴ϴ�.</p>
								<label>���� �˻���</label>
								<input type="text" class="inputfield" name="dong" id="dong"> <span class="button small light" style="margin:0;"><a href="javascript:;" onclick="schZipCode();">��ȸ</a></span>
							</div>
						</form>
						<div class="marb20 mart20" style="text-align:center;">
							<p class="bold7">�˻������ �ּҰ� �˻��� ���, ��۰����� �����Դϴ�.<br />
							<font class="f12 font-gray">(�ּ� ����Ʈ�� �˻����� ���� ��� ��� �Ұ��� �����Դϴ�.)</font></p>
						</div>
						<div class="frameBox">
							<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<th>�����ȣ</th>
									<th>�ּ�</th>
								</tr>
								<tr>
								<td>151-015</td>
								<td class="left">���� ���Ǳ� �Ÿ���</td>
								</tr>
								<tr>
								<td>151-016</td>
								<td class="left">���� ���Ǳ� �Ÿ��� ������ǿ�ü��</td>
								</tr>
								<tr>
								<td>151-708</td>
								<td class="left">���� ���Ǳ� �Ÿ��� �¿�����Ʈ</td>
								</tr>
								<tr>
								<td>151-706</td>
								<td class="left">���� ���Ǳ� �Ÿ��� ������ǿ�ü��</td>
								</tr>
								<tr>
								<td>151-800</td>
								<td class="left">���� ���Ǳ� �Ÿ��� �¿�����Ʈ</td>
								</tr>
							</table>
						</div> 
						<div class="clear"></div>
					</div>
				</div>
				<!-- End row -->
				<div class="row">
					<div class="one last col">
						<div class="pageNavi">
							<a class="latelypostslink" href="#"><<</a>
							<a class="previouspostslink" href="#"><</a>
							<span class="current">1</span>
							<a href="#">2</a>
							<a href="#">3</a>
							<a href="#">4</a>
							<a href="#">5</a>
							<a class="firstpostslink" href="#">></a>
							<a class="nextpostslink" href="#">>></a>
						</div>
					</div>	
				</div>
			</div>
			<!-- End popup columns offset-by-one -->	
		</div>
		<!-- End contentpop -->
	</div>
</body>
</html>