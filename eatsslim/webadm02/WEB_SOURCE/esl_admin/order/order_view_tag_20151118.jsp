<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String tabmenu		= request.getParameter("tabmenu");
if(tabmenu==null){tabmenu="1";}
String orderNum		= ut.inject(request.getParameter("ordno"));
int subNum			= 0;
if (request.getParameter("subno") != null && request.getParameter("subno").length()>0)
	subNum			= Integer.parseInt(request.getParameter("subno"));
String groupCode	= ut.inject(request.getParameter("gcode"));
if (orderNum == null || orderNum.equals("")) {
	out.println("<script>self.close();</script>");
	if (true) return;
}

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int tcnt			= 0;
String memberId			= "";
String memberName		= "";
String payType			= "";
String rcvName			= "";
String rcvTel			= "";
String rcvHp			= "";
String rcvZipcode		= "";
String rcvZipcode1		= "";
String rcvZipcode2		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvRequest		= "";
String tagName			= "";
String tagTel			= "";
String tagHp			= "";
String tagZipcode		= "";
String tagZipcode1		= "";
String tagZipcode2		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
String pgTid			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String orderState		= "";
String orderDate		= "";
String payDate			= "";
String minDate			= "";
String maxDate			= "";
int couponTprice		= 0;
String devlDates		= "";
String shopType			= "";
String outOrderNum		= "";

query		= "SELECT ";
query		+= "	MEMBER_ID, PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
query		+= "	TAG_NAME, TAG_TEL, TAG_HP, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_REQUEST, PG_TID, PG_CARDNUM,";
query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, O.ORDER_STATE, ORDER_DATE, PAY_DATE, O.COUPON_PRICE,";
query		+= "	ORDER_NAME, SHOP_TYPE, OUT_ORDER_NUM";
query		+= " FROM ESL_ORDER O, ESL_ORDER_GOODS OG";
query		+= " WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.ORDER_NUM = '"+ orderNum +"' AND OG.ID = "+ subNum;
try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	memberId		= rs.getString("MEMBER_ID");
	memberName		= rs.getString("ORDER_NAME");
	payType			= rs.getString("PAY_TYPE");
	rcvName			= rs.getString("RCV_NAME");
	rcvTel			= rs.getString("RCV_TEL");
	rcvHp			= rs.getString("RCV_HP");
	rcvZipcode		= rs.getString("RCV_ZIPCODE");
	if (rcvZipcode.length() == 6) {
		rcvZipcode1	= rcvZipcode.substring(0,3);
		rcvZipcode2	= rcvZipcode.substring(3,6);
	}
	rcvAddr1		= rs.getString("RCV_ADDR1");
	rcvAddr2		= rs.getString("RCV_ADDR2");
	rcvRequest		= rs.getString("RCV_REQUEST");
	tagName			= rs.getString("TAG_NAME");
	tagTel			= rs.getString("TAG_TEL");
	tagHp			= rs.getString("TAG_HP");
	tagZipcode		= rs.getString("TAG_ZIPCODE");
	if (tagZipcode.length() == 6) {
		tagZipcode1	= tagZipcode.substring(0,3);
		tagZipcode2	= tagZipcode.substring(3,6);
	}
	tagAddr1		= rs.getString("TAG_ADDR1");
	tagAddr2		= rs.getString("TAG_ADDR2");
	tagRequest		= rs.getString("TAG_REQUEST");
	pgTid			= (rs.getString("PG_TID") == null)? "" : rs.getString("PG_TID");
	pgCardNum		= rs.getString("PG_CARDNUM");
	pgFinanceName	= rs.getString("PG_FINANCENAME");
	pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
	orderState		= rs.getString("ORDER_STATE");
	orderDate		= rs.getString("ORDER_DATE");
	payDate			= rs.getString("PAY_DATE");
	couponTprice	= rs.getInt("COUPON_PRICE");
	shopType		= rs.getString("SHOP_TYPE");
	outOrderNum		= ut.isnull(rs.getString("OUT_ORDER_NUM"));

	query1		= "SELECT DEVL_DATE";
	query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ subNum;
	try {
		rs1			= stmt.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	if (rs1.next()) {
		devlDates		= rs1.getString("DEVL_DATE");
	}
}

rs.close();
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
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>	
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
	<!-- popup_wrap -->
	<div class="popup_wrap">
		<h2>�ֹ�������</h2>
		<table class="table01 mt_5" border="1" cellspacing="0">
			<colgroup>
				<col width="100px" />
				<col width="36%" />
				<col width="100px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span>�ֹ���ȣ</span></th>
					<td colspan="3"><%=orderNum%>-<%=subNum%></td>
				</tr>
				<tr>
					<th scope="row"><span>�ֹ���</span></th>
					<td><%=memberName%>(<%=memberId%>)</td>
					<th scope="row"><span>����ó</span></th>
					<td><%=rcvHp%>/<%=rcvTel%></td>
				</tr>
				<tr>
					<th scope="row"><span>����ּ�</span></th>
					<td colspan="3">[<%=rcvZipcode1%>-<%=rcvZipcode2%>] <%=rcvAddr1%> <%=rcvAddr2%></td>
				</tr>
				<tr>
					<th scope="row"><span>�ֹ��Ͻ�</span></th>
					<td><%=ut.setDateFormat(orderDate, 16)%></td>
					<th scope="row"><span>�ֹ�����</span></th>
					<td>
						<%
						if (payType.equals("10") && Integer.parseInt(orderState)==0) {
							out.print("��������");
						} else {
							out.println(ut.getOrderState(orderState));
						}
						%>
					</td>
				</tr>
				<tr>
					<th scope="row"><span>�Ա��Ͻ�</span></th>
					<td><%=ut.setDateFormat(payDate, 16)%></td>
					<th scope="row"><span>��������</span></th>
					<td><%=ut.getPayType(payType)%></td>
				</tr>
				<tr>
					<th scope="row"><span>�����</span></th>
					<td><%=devlDates%></td>
					<th scope="row"><span>�ŷ���ȣ</span></th>
					<td><%=pgTid%></td>
				</tr>
				<tr>
					<th scope="row"><span>�Ǹ� SHOP</span></th>
					<td><%=ut.getShopType(shopType)%></td>
					<th scope="row"><span>�ܺθ� �ֹ���ȣ</span></th>
					<td><%=outOrderNum%></td>
				</tr>
			</tbody>
		</table>
		<br />
		<h3 class="tit_style1">�ֹ�����������</h3>
		<div class="tagMenu tab_style1">
			<ul class="tabmenu">
				<li class="current" id="t_1" onclick="show(1)">��ȯ/ȯ��</li>
			</ul>
		</div>
		<div class="tab_con tab_style2">
		<!-------------------------------------->
			<div class="tab_layout" style="display:block;" id="tablmenu1">
				<form name="frm_tag" method="post" action="order_view_tag_db.jsp">
					<%
					query		= "SELECT ";
					query		+= "	PAY_PRICE, PAY_TYPE, RCV_HP, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, PG_TID";
					query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
					try {
						rs			= stmt.executeQuery(query);
					} catch(Exception e) {
						out.println(e+"=>"+query);
						if(true)return;
					}

					if (rs.next()) {
						payType			= rs.getString("PAY_TYPE");
						pgCardNum		= rs.getString("PG_CARDNUM");
						pgFinanceName	= rs.getString("PG_FINANCENAME");
						pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
						rcvHp			= rs.getString("RCV_HP");
						pgTid			= rs.getString("PG_TID");
					}
					%>
					<input type="hidden" name="mode" value="cancel" />
					<input type="hidden" name="order_num" value="<%=orderNum%>" />
					<input type="hidden" name="sub_num" value="<%=subNum%>" />
					<input type="hidden" name="group_code" value="<%=groupCode%>" />
					<input type="hidden" name="order_cnt" value="<%=i%>" />
					<input type="hidden" name="refund_price" id="refund_price" value="0" />
					<input type="hidden" name="pay_type" id="pay_type" value="<%=payType%>">
					<input type="hidden" name="LGD_RFPHONE" value="<%=rcvHp%>">
					<input type="hidden" name="refund_fee" value="0">
					<input type="hidden" name="pg_tid" value="<%=pgTid%>">
					<table class="table02 mt_5" border="1" cellspacing="0">
						<colgroup>
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><span>���</span></th>
								<th scope="col"><span>��ȯ����</span></th>
								<th scope="col"><span>ȯ������</span></th>
								<th scope="col"><span>��ȯȮ��</span></th>
								<th scope="col"><span>ȯ��Ȯ��</span></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<%if (Integer.parseInt(orderState) == 1) {%>
									<input type="radio" name="state_type" value="91" />
									<%} else {%>
									<input type="radio" name="state_type" value="91" disabled="disabled" />
									<%}%>
								</td>
								<%if (Integer.parseInt(orderState) == 4) {%>
								<td><input type="radio" name="state_type" value="94" /></td>
								<td><input type="radio" name="state_type" value="96" /></td>
								<td><input type="radio" name="state_type" value="95" /></td>
								<td><input type="radio" name="state_type" value="97" /></td>
								<%} else {%>
								<td><input type="radio" name="state_type" value="94" disabled="disabled" /></td>
								<td><input type="radio" name="state_type" value="96" disabled="disabled" /></td>
								<td><input type="radio" name="state_type" value="95" disabled="disabled" /></td>
								<td><input type="radio" name="state_type" value="97" disabled="disabled" /></td>
								<%}%>
							</tr>
						</tbody>
					</table>
					<div style="text-align:center;margin:10px 0;">
						<input type="button" value="Ȯ��" onclick="cancel('<%=payType%>');" />
					</div>
					<table class="table02 mt_5" border="1" cellspacing="0">
					<colgroup>
						<col width="33%" />
						<col width="*" />
						<col width="33%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><span>�����ݾ�</span></th>
							<th scope="col"><span>�����ݾ�</span></th>
							<th scope="col"><span>ȯ�ұݾ�</span></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
				</table>
				<%if (payType.equals("30")) {%>
					<br />
					<table class="table02 mt_5" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>							
							<tr>
								<th>ȯ�Ұ�������</th>
								<td>
									<select name="bankName" id="bankName" style="width:172px;">
										<!--<option value="�泲����">�泲����</option>
										<option value="��������">��������</option>
										<option value="��������">��������</option>
										<option value="�������">�������</option>
										<option value="����">����</option>
										<option value="�뱸����">�뱸����</option>
										<option value="����ġ��ũ">����ġ��ũ</option>
										<option value="�λ�����">�λ�����</option>
										<option value="�������">�������</option>
										<option value="��ȣ��������">��ȣ��������</option>
										<option value="�������ݰ�">�������ݰ�</option>
										<option value="�����߾�ȸ">�����߾�ȸ</option>
										<option value="�ſ���������">�ſ���������</option>
										<option value="��������">��������</option>
										<option value="��ȯ����">��ȯ����</option>
										<option value="�츮����">�츮����</option>
										<option value="��ü��">��ü��</option>
										<option value="��������">��������</option>
										<option value="��������">��������</option>
										<option value="�ϳ�����">�ϳ�����</option>
										<option value="�ѱ���Ƽ����">�ѱ���Ƽ����</option>
										<option value="HSBC">HSBC</option>
										<option value="SC��������">SC��������</option>-->
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
									</select>
								</td>
							</tr>
							<tr>
								<th>ȯ�Ұ��� ������</th>
								<td><input type="text" class="input1" style="width:94px;" maxlength="30" name="bankUser" id="bankUser" /></td>
							</tr>
							<tr>
								<th>ȯ�Ұ��¹�ȣ</th>
								<td><input type="text" class="input1" style="width:144px;" maxlength="100" onBlur="this.value=this.value.replace(/[^0-9-]/g,'');" name="bankAccount" id="bankAccount" /></td>
							</tr>
						</tbody>
					</table>
					<%}%>
				</form>
			</div>
		</div>
	</div>
	<!-- //popup_wrap -->
	<iframe name="ifrmHidden" id="ifrmHidden" src="about:blank" style="width:100%;height:200px;display:none;"></iframe>
<script type="text/javascript">
function cancel(ptype) {
	var f	= document.frm_tag;
	if (ptype == '10') {
		f.target	= "ifrmHidden";
		f.submit();
	} else {
		if (!$("#bankName").val()) {
			alert("������ �����ϼ���.");
			$("#bankName").focus();
		} else if (!$.trim($("#bankUser").val())) {
			alert("ȯ�Ұ��� �����ָ��� �Է��ϼ���");
			$("#bankUser").focus();
		} else if (!$.trim($("#bankAccount").val())) {
			alert("ȯ�Ұ��¹�ȣ�� �Է��ϼ���");
			$("#bankAccount").focus();
		} else {
			f.target	= "ifrmHidden";
			f.submit();
		}
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>