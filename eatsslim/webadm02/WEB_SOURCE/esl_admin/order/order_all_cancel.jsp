<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ordno"));

if (orderNum == null || orderNum.equals("")) {
	out.println("<script>self.close();</script>");
	if (true) return;
}

String query			= "";
String payType			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String rcvHp			= "";
String pgTid			= "";
String payYn			= ""; 
int payPrice		= 0;

query		= "SELECT ";
query		+= "	PAY_PRICE, PAY_TYPE, RCV_HP, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, PG_TID, PAY_YN ";
query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {

	payPrice		= rs.getInt("PAY_PRICE");
	payType			= rs.getString("PAY_TYPE");
	pgCardNum		= rs.getString("PG_CARDNUM");
	pgFinanceName	= rs.getString("PG_FINANCENAME");
	pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
	rcvHp			= rs.getString("RCV_HP");
	pgTid			= rs.getString("PG_TID");
	payYn			= rs.getString("PAY_YN");
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>Pulmuone EATSSLIM �����ڽý���</title>

	<link rel="stylesheet" type="text/css" href="../css/styles.css" />
	<style type="text/css">
	html, body { height:auto; background:#fff;}
	</style>

	<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="../js/common.js"></script>
</head>
<body>
	<!-- popup_wrap -->
	<div class="popup_wrap">
		<h2>�ֹ����</h2>
		<form id="f_submit" name="f_submit" method="post" action="order_all_cancel_db.jsp" >
			<input type="hidden" id="mode" name="mode" value="cancel" />
			<input type="hidden" id="code" name="code" value="CD1" />
			<input type="hidden" id="order_num" name="order_num" value="<%=orderNum %>" />
			<input type="hidden" id="pay_type" name="pay_type" value="<%=payType %>" />
			<input type="hidden" name="payYn" value="<%=payYn%>">
			<input type="hidden" name="pgTID" value="<%=pgTid%>">
			
			<table class="table01 mt_5" border="1" cellspacing="0">
				<colgroup>
					<col width="100px" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><span>��һ�������</span></th>
						<td>
							<select id="reasonType" name="reasonType" style="min-width: 150px;">
								<option value="1">�����ǻ����</option>
								<option value="2">��ǰ �߸� �ֹ�</option>
								<option value="3">��ǰ���� ����</option>
								<option value="4">���� �� ��ǰ �Ҹ���</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><span>�󼼻����Է�</span></th>
						<td>
							<textarea id="reason" name="reason" rows="6" style="min-width: 600px;"></textarea>
						</td>
					</tr>
					<%if (payType.equals("30")) {%>
					<tr>
					<th>ȯ�� ���¹�ȣ</th>
					<td>
						<select id="bankName" name="bankName" style="width:90px;">
							<option value="�泲">�泲</option>
							<option value="����">����</option>
							<option value="���">���</option>
							<option value="����">����</option>
							<option value="�뱸">�뱸</option>
							<option value="�λ�">�λ�</option>
							<option value="����">����</option>
							<option value="����">����</option>
							<option value="��ȯ">��ȯ</option>
							<option value="�츮">�츮</option>
							<option value="��ü��">��ü��</option>
							<option value="�ϳ�">�ϳ�</option>
							<option value="�������ݰ�">�������ݰ�</option>
							<option value="īī����ũ">īī����ũ</option>
						</select>
						<input style="width:150px;" name="bankAccount" id="bankAccount" type="text" class="input1" required="" label=""  onBlur="this.value=this.value.replace(/[^0-9-]/g,'');"  placeholder ="���¹�ȣ�Է�">
						&nbsp;&nbsp;�����ָ� : <input maxlength="30" style="width:144px;" maxlength="100" name="bankUser" id="bankUser" type="text" class="input1" required="" label="">
					</td>
				</tr>
				<%}%>
			</tbody>
			</table>
		</form>
		<div style="padding: 20px 0; text-align: center;">
			<a class="function_btn" href="javascript:;" onclick="fnCancelSave();"><span>�ֹ���� ��û</span></a>
			<a class="function_btn" href="javascript:;" onclick="self.close();"><span>���</span></a>
		</div>
	</div>
	<!-- //popup_wrap -->
	<script>

	$('#reasonType').change(function(e) {
		$("#reasonType").val($(this).val());
	});

	function fnCancelSave(){
        document.f_submit.submit();
		//var reason = $("#reason").val();
		//location.href = 'order_all_cancel_db.jsp?mode=cancel&code=CD1&order_num=<%=orderNum%>&pay_type=<%=payType%>&reasonType='+$("#reasonType").val()+'&reason='+ encodeURI(reason , "euc-kr")+'&bankName='+encodeURI($("#bankName").val(), "euc-kr")+'&bankAccount='+$("#bankAccount").val()+'&bankUser='+encodeURI($("#bankUser").val() , "euc-kr");		
	}
	</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>