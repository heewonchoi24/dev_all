<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
String orderNum			= ut.inject(request.getParameter("ono"));
int goodsPrice			= 0;
payPrice			= 0;
int couponPrice			= 0;
int devlPrice			= 0;
String payType			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String orderDate		= "";
String rcvHp		= "";
String pgTid		= "";
String orderName = "";
int orderCnt		= 0;
String payYn = "";
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT DATE_FORMAT(ORDER_DATE, '%Y.%m.%d %H:%i') ORDER_DATE, GOODS_PRICE, PAY_PRICE, ORDER_NAME,  ";
query		+= "	COUPON_PRICE, DEVL_PRICE, PAY_TYPE, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, ORDER_STATE, RCV_HP, PG_TID, PAY_YN ";
query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
try {
rs			= stmt.executeQuery(query);
} catch(Exception e) {
out.println(e+"=>"+query);
if(true)return;
}

if (rs.next()) {
	goodsPrice		= rs.getInt("GOODS_PRICE");
	payPrice		= rs.getInt("PAY_PRICE");
	couponPrice		= rs.getInt("COUPON_PRICE");
	devlPrice		= rs.getInt("DEVL_PRICE");
	payType			= rs.getString("PAY_TYPE");
	pgCardNum		= ut.isnull(rs.getString("PG_CARDNUM"));
	pgFinanceName	= ut.isnull(rs.getString("PG_FINANCENAME"));
	pgAccountNum	= ut.isnull(rs.getString("PG_ACCOUNTNUM"));
	orderDate		= rs.getString("ORDER_DATE");
	rcvHp			= rs.getString("RCV_HP");
	pgTid			= rs.getString("PG_TID");
	orderName		= rs.getString("ORDER_NAME");
	payYn   		= rs.getString("PAY_YN");
}
%>
<script type="text/javascript">
function orderCancel(ono) {
	var msg = "������ �ֹ��� ����Ͻðڽ��ϱ�?"
	if(confirm(msg)){
		document.frm_cancel.submit();
	}else{
		return;
	}
}
</script>
</head>
<body>
<form name="frm_cancel" method="post" action="/proc/order_edit_proc.jsp">
	<input type="hidden" name="mode" value="cancel">
	<input type="hidden" name="code" value="CD1">
	<input type="hidden" name="order_num" id="order_num" value="<%=orderNum%>">
	<input type="hidden" name="pay_type" id="pay_type" value="<%=payType%>">
	<input type="hidden" name="LGD_RFPHONE" id="LGD_RFPHONE" value="<%=rcvHp%>">
	<input type="hidden" name="item_cnt" id="item_cnt" value="<%=orderCnt%>">
	<input type="hidden" name="rprice" id="rprice" value="<%=payPrice%>">
	<input type="hidden" name="rfee" id="rfee" value="1">
	<input type="hidden" name="pgTID" id="pgTID" value="<%=pgTid%>">
	<input type="hidden" name="cancelFrom" value="mobile" />
	<input type="hidden" name="payYn" id="payYn" value="<%=payYn%>">

	<div id="wrap">
		<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
			<%@ include file="/mobile/common/include/inc-header.jsp"%>
		</div>
		<!-- End ui-header -->
		<!-- Start Content -->
		<div id="content" class="oldClass">
			<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ����</span></span></h1>
			<div class="row" id="shopOrder">
				<div class="orderBox totalPriceArea">
					<h1 class="tit">�ֹ�����</h1>
					<div class="totalPriceTable">
						<table>
							<colgroup>
								<col>
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>�ֹ���ȣ</th>
									<td><%=orderNum%></td>
								</tr>
								<tr>
									<th>�ֹ��Ͻ�</th>
									<td><%=orderDate%></td>
								</tr>
								<tr>
									<th>�ֹ��ڸ�</th>
									<td><%=orderName%></td>
								</tr>
								<tr>
									<th>�������</th>
									<td><%=ut.getPayType(payType)%></td>
								</tr>
								<tr>
									<th>��ǰ�ݾ�</th>
									<td><span><%=nf.format(goodsPrice)%></span> ��</td>
								</tr>
								<%if(devlPrice>0){%>
								<tr>
									<th>��ü ��ۺ�</th>
									<td><span><%=nf.format(devlPrice)%></span> ��</td>
								</tr>									
								<%}%>
							</tbody>
						</table>
					</div>
					<div class="totalPrice">
						�� �����ݾ� <span id="tprice"><%=nf.format(payPrice)%></span> ��
					</div>
				</div>

<%if (payType.equals("30")) {%>
				<div class="orderBox">
					<h1 class="tit">ȯ�Ұ�������</h1>
					<div class="boxTable">
						<table>
							<tbody>
								<tr>
									<th>��һ�������</th>
									<td>
										<select name="rcv_hp1" id="rcv_hp1" class="inp_st" required label="�޴��� ��ȣ">
	                                       	<option value="">��һ����� ����</option>
											<option value="1">�����ǻ����</option>
											<option value="2">��ǰ �߸� �ֹ�</option>
											<option value="3">��ǰ���� ����</option>
											<option value="4">���� �� ��ǰ �Ҹ���</option>
	                                   	</select>
									</td>
								</tr>
								<tr>
									<th>ȯ�Ұ�������</th>
									<td>
										<select name="bankName" id="bankName" class="inp_st" required>
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
									</td>
								</tr>
								<tr>
									<th>ȯ�Ұ��� ������</th>
									<td>
										<div class="ipt_group">
									    	<input type="text" class="ipt" maxlength="30" name="bankUser" id="bankUser" />
									    </div>
									</td>
								</tr>
								<tr>
									<th>ȯ�Ұ��¹�ȣ</th>
									<td>
										<div class="ipt_group">
									    	<input type="text" class="ipt" maxlength="100" onBlur="this.value=this.value.replace(/[^0-9-]/g,'');" name="bankAccount" id="bankAccount" />
									    </div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
<%}%>

				<div class="orderBox">
					<div class="orderBtns">
						<a href="javascript:void(0);" onclick="orderCancel('<%=orderNum%>');"><button type="button" class="btn btn_dgray square" style="float: none;">��ҽ�û</button></a>
					</div>
				</div>
			</div>
		</div>
		<!-- End Content -->
		<div class="ui-footer">
			<%@ include file="/mobile/common/include/inc-footer.jsp"%>
		</div>
	</div>
</form>
</body>
</html>