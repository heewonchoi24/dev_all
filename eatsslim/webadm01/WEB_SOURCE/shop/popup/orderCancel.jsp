<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ono"));
String orderDate	= ut.inject(request.getParameter("odate"));

String query		= "";
int tcnt			= 0;
int orderCnt		= 0;
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
String buyBagYn		= "";
String gubun1		= "";
String groupName	= "";
String cartImg		= "";
int goodsTprice		= 0;
int orderPrice		= 0;
int payPrice		= 0;
int totalPrice		= 0;
int dayPrice		= 0;
int tagPrice		= 0;
int goodsPrice		= 0;
int devlPrice		= 0;
int bagPrice		= 0;
int couponPrice		= 0;
int zipCnt			= 0;
String devlCheck	= "";
NumberFormat nf = NumberFormat.getNumberInstance();

String payType			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String rcvHp			= "";
String pgTid			= "";
String payYn			= ""; 
query		= "SELECT COUNT(ID) FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //�� ���ڵ� ��		
}
rs.close();

query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.ORDER_STATE, O.DEVL_PRICE, OG.COUPON_PRICE ";
query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID AND O.ORDER_NUM = OG.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
query		+= " ORDER BY OG.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>�ֹ����</title>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>�ֹ����</h2>
		<p>�ֹ��� ����Ͻðڽ��ϱ�? �ֹ������� Ȯ���Ͻð� ��ҽ�û�� ���ֽʽÿ�.</p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4> �ֹ�����<span class="font-blue f14 padl50"><%=orderNum%></span> �� <span class="f14"><%=orderDate%></span> </h4>
					</div>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th class="none">�ù豸��</th>
							<th>��ǰ��</th>
							<th>ù�����</th>
							<th>����</th>
							<th>��ǰ�ݾ�</th>
							<th>��ۺ�</th>
							<th>���αݾ�</th>
							<th class="last">�ֹ�����</th>
						</tr>
						<%
						if (tcnt > 0) {
							while (rs.next()) {
								orderCnt	= rs.getInt("ORDER_CNT");
								devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "�Ϲ�" : "�ù�";
								price		= rs.getInt("PRICE");
								gubun1		= rs.getString("GUBUN1");
								groupName	= rs.getString("GROUP_NAME");
								couponPrice	= rs.getInt("COUPON_PRICE");
																
								if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
									devlDate	= rs.getString("WDATE");
									buyBagYn	= rs.getString("BUY_BAG_YN");
									devlDay		= rs.getString("DEVL_DAY");
									devlWeek	= rs.getString("DEVL_WEEK");
									devlPeriod	= devlWeek +"��("+ devlDay +"��)";
									price		= rs.getInt("PRICE");
									goodsPrice	= price * orderCnt;
									dayPrice += goodsPrice;
								} else {
									devlDate	= "-";
									buyBagYn	= "N";
									devlPeriod	= "-";
									devlPrice	= rs.getInt("DEVL_PRICE");
									price		= rs.getInt("PRICE");
									goodsPrice	= price * orderCnt;
									tagPrice	+= goodsPrice;
								}
						%>
						<tr>
							<td><%=devlType%></td>
							<td>
								<div class="orderName">
									<h5><%=groupName%></h5>
								</div>
							</td>
							<td><%=devlDate%></td>
							<td><%=orderCnt%></td>
							<td><%=nf.format(price)%>��</td>
							<td><%=nf.format(devlPrice)%>��</td>
							<td><%=nf.format(couponPrice)%>��</td>
							<td>
								<div class="font-blue">
									<%=ut.getOrderState(rs.getString("ORDER_STATE"))%>
								</div>
							</td>
						</tr>
						<%
								if (buyBagYn.equals("Y")) {
									bagPrice	+= defaultBagPrice * orderCnt;
						%>
						<tr>
							<td>�Ϲ�</td>
							<td>
								<div class="orderName">
									<h5>���ð���</h5>
								</div>
							</td>
							<td>-</td>
							<td>1</td>
							<td><%=nf.format(bagPrice)%>��</td>
							<td>0��</td>
							<td>0��</td>
							<td>
								<div class="font-blue">
									<%=ut.getOrderState(rs.getString("ORDER_STATE"))%>
								</div>
							</td>
						</tr>
						<%
								}

								if (gubun1.equals("01") && Integer.parseInt(orderDate.replace(".", "")) < 20131031) {
						%>
						<tr>
							<td>����</td>
							<td>
								<div class="orderName">
									<h5>����ũ�ͽ�(2��)</h5>
								</div>
							</td>
							<td>-</td>
							<td>1</td>
							<td>0��</td>
							<td>0��</td>
							<td>0��</td>
							<td>
								<div class="font-blue">
									<%=ut.getOrderState(rs.getString("ORDER_STATE"))%>
								</div>
							</td>
						</tr>
						<%
								}
							}

							rs.close();
						}
						%>
					</table>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<form method="post" name="frm" action="/proc/order_edit_proc.jsp">
				<%
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
				<input type="hidden" name="mode" value="">
				<input type="hidden" name="order_num" value="<%=orderNum%>">
				<input type="hidden" name="code" value="">
				<input type="hidden" name="pay_type" id="pay_type" value="<%=payType%>">
				<input type="hidden" name="LGD_RFPHONE" value="<%=rcvHp%>">
				<input type="hidden" name="payYn" value="<%=payYn%>">
				<div class="row">
					<div class="one last col">
						<div class="sectionHeader">
							<h4>��һ���</h4>
						</div>
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>��һ�������</th>
								<td>
									<select name="reason_type" id="reason_type" style="width:200px;" required label="��һ�������">
										<option value="">��һ����� ����</option>
										<option value="1">�����ǻ����</option>
										<option value="2">��ǰ �߸� �ֹ�</option>
										<option value="3">��ǰ���� ����</option>
										<option value="4">���� �� ��ǰ �Ҹ���</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>
									��һ��� ��<br />
									��Ÿ ��û����
								</th>
								<td>
									<input type="text" name="reason" id="reason" style="width:500px;" maxlength="60" />
									<p class="font-gray">�Է±��ڴ� �ִ� �ѱ�60��, ����/���� 120�ڱ��� �����մϴ�.</p>
								</td>
							</tr>
							<%if (payType.equals("30")) {%>
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
										<option value="�������ݰ�">�������ݰ�</option>
										<option value="īī����ũ">īī����ũ</option>
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
							<%}%>
						</table>
						<!-- End inputfield -->
					</div>
				</div>
				<!-- End row -->
				<div class="row">
					<div class="one last col">
						<div class="sectionHeader">
							<h4>��������</h4>
						</div>
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>�������</th>
								<td><%=ut.getPayType(payType)%></td>
							</tr>
							<tr>
								<th>��������</th>
								<td><%=ut.isnull(pgFinanceName)%></td>
							</tr>
						</table>
						<!-- End inputfield -->
					</div>
				</div>
				<!-- End row -->
				<div class="row">
					<div class="one last col">
						<div class="sectionHeader">
							<h4>ȯ�ұݾ�</h4>
						</div>
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<!--tr>
								<th>�������</th>
								<td>��ǰ�ݾ�:<%=nf.format(totalPrice)%>�� - ���αݾ�:0�� = <%=nf.format(totalPrice)%>��</td>
							</tr>
							<tr>
								<th>��������</th>
								<td>50,000��(��20�� �� 5�� ���)</td>
							</tr-->
							<tr>
								<th>��������</th>
								<td><span class="font-maple"><%=nf.format(payPrice)%>��</span></td>
							</tr>
						</table>
						<!-- End inputfield -->
						<p>- �ֹ� ��Ҹ� �Ͻð� �Ǹ�, �ֹ� �� �����ϼ̴� ������ �Ҹ�Ǹ�, ����� ���� �ʽ��ϴ�.</p>
						<p>- �����ָ��� �ֹ��ڸ�� ���� �ڵ������� ���� �˴ϴ�.</p>
						<p>- ī��纰�� ���� ������� ������ �� �ֽ��ϴ�.</p>
					</div>
				</div>
				<input type="hidden" name="item_cnt" value="<%=orderCnt%>">
				<input type="hidden" name="rprice" value="<%=payPrice%>">
				<input type="hidden" name="rfee" value="0">
				<input type="hidden" name="pgTID" value="<%=pgTid%>">
			</form>
			<!-- End row -->
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="javascript:;" onclick="orderCancel();">��ҽ�û</a>
					</div>
				</div>
			</div>
			<!-- End row -->
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

function orderCancel(){
	var f	= document.frm;
	if (!$.trim($("#reason_type").val())) {
		alert("��һ����� �����ϼ���.");
		$("#reason_type").focus();
		return;
	} else if ($("#pay_type").val() == "30") {
		if (!$.trim($("#bankName").val())) {
			alert("ȯ�Ұ��������� �����ϼ���.");
			$("#bankName").focus();
			return;
		} else if (!$.trim($("#bankUser").val())) {
			alert("ȯ�Ұ��� �����ָ� �Է��ϼ���.");
			$("#bankUser").focus();
			return;
		} else if (!$.trim($("#bankAccount").val())) {
			alert("ȯ�Ұ��¹�ȣ�� �Է��ϼ���.");
			$("#bankAccount").focus();
			return;
		}
	}
	if(confirm('���� ����Ͻðڽ��ϱ�?') ){
		f.mode.value="cancel";
		f.code.value="CD1";
		f.submit();	
	}
}
</script>
</body>
</html>