<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
int tcnt			= 0;
int cartId			= 0;
int groupId			= 0;
int buyQty			= 0;
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
String buyBagYn		= "";
String gubun1		= "";
String gubun2		= "";
String groupName	= "";
String cartImg		= "";
String imgUrl		= "";
int payPrice		= 0;
int totalPrice		= 0;
int totalPrice1		= 0;
int totalPrice2		= 0;
int totalPrice3		= 0;
int devlPrice		= 0;
int bagPrice		= 0;
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "UPDATE ESL_CART SET ORDER_YN = 'N' WHERE MEMBER_ID = '"+ eslMemberId +"'";
try {
	stmt.executeUpdate(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
%>

	<!-- Calendar -->
	<link rel="stylesheet" type="text/css" href="/mobile/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick.ext.js"></script>
	<script type="text/javascript" src="/mobile/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed" style="overflow:hidden;"> 
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">��ٱ���</span></span></h1>
		<div class="row bg-gray">
			<h2>�Ϲ��ǰ</h2>
			<%
			query		= "SELECT COUNT(ID) FROM ESL_CART WHERE MEMBER_ID = ? AND DEVL_TYPE = '0001' AND CART_TYPE = 'C'";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, eslMemberId);
			rs			= pstmt.executeQuery();
			if (rs.next()) {
				tcnt		= rs.getInt(1);
			}

			if (rs != null) try { rs.close(); } catch (Exception e) {}
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
			
			query		= "SELECT C.ID, C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK,";
			query		+= "	DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN,";
			query		+= "	G.GUBUN1, G.GUBUN2, G.GROUP_NAME, G.CART_IMG";
			query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
			query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = ? AND C.DEVL_TYPE = '0001' AND CART_TYPE = 'C'";
			query		+= " ORDER BY C.DEVL_TYPE";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, eslMemberId);
			rs			= pstmt.executeQuery();

			if (tcnt > 0) {
				while (rs.next()) {
					cartId		= rs.getInt("ID");
					groupId		= rs.getInt("GROUP_ID");
					buyQty		= rs.getInt("BUY_QTY");
					devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "�Ϲ�" : "�ù�";
					devlDate	= rs.getString("WDATE");
					devlDate	= devlDate.replace("-", ".");
					gubun1		= rs.getString("GUBUN1");
					gubun2		= rs.getString("GUBUN2");
					groupName	= rs.getString("GROUP_NAME");
					buyBagYn	= rs.getString("BUY_BAG_YN");
					devlDay		= rs.getString("DEVL_DAY");
					devlWeek	= rs.getString("DEVL_WEEK");
					devlPeriod	= devlWeek +"��("+ devlDay +"��)";
					price		= rs.getInt("PRICE");
					payPrice	= price * buyQty;
					totalPrice1	+= payPrice;
			%>
			<ul class="ui-listview bginner">
				<li class="ui-btn ui-li ui-li-has-thumb">
					<div class="ui-btn-inner ui-li">
						<a class="ui-link-inherit iframe" href="/mobile/shop/cuisineinfo/cuisineA.jsp"> 
							<h3 class="ui-li-heading"><%=ut.getGubun1Name(gubun1)%></h3>
							<p class="ui-li-desc"><%=ut.getGubun1Name(gubun2)%>(<%=groupName%>)</p>
							<p><%=nf.format(payPrice)%>��</p>
						</a>
					</div>
				</li>
			</ul>
			<div class="divider"></div>
			<ul class="itembox">
				<li>
					<h3>�Ļ� �Ⱓ</h3>
					<ul class="form-line ui-inline2">
						<li style="margin-right:10px;">
							<div class="select-box">
								<select>
									<option value="1">�� 5��</option>
								</select>
							</div>
						</li>
						<li>
							<div class="select-box">
								<select>
									<option value="1">2�ְ�</option>
								</select>
							</div>
						</li>
						<div class="clear"></div>
					</ul>
				</li>
				<li>
					<h3>��������</h3>
					<div class="quantity" style="width:100%;">
						<input class="minus" type="button" value="-">
						<input class="input-text qty text" maxlength="12" title="Qty" size="4" value="1" data-max="0" data-min="1" name="quantity">
						<input class="plus" type="button" value="+">
					</div>
					<div class="clear"></div>
				</li>
				<li>
					<h3>ù ����� ����</h3>
					<div><input name="date1" id="date1" class="date-pick" /></div>
					<div class="clear"></div>
				</li>
			</ul>
		</div>
		<!-- End row -->
		<div class="row bg-gray cartplus">
			<div class="plusicon"></div>
			<div class="cartdelete"></div>
			<ul class="ui-listview bginner">
				<li class="ui-btn ui-li ui-li-has-thumb">
					<div class="ui-btn-inner ui-li">
						<a class="ui-link-inherit iframe" href="/mobile/shop/cuisineinfo/cuisineA.jsp">
							<h3 class="ui-li-heading">���ð���</h3>
							<p class="ui-li-desc"></p>
							<p>5,400��</p>
						</a>
					</div>
				</li>
			</ul>
			<div class="divider"></div>
			<ul class="itembox">
				<li>
					<h3>��������</h3>
					<div class="quantity" style="width:100%;">
						<input class="minus" type="button" value="-">
						<input class="input-text qty text" maxlength="12" title="Qty" size="4" value="1" data-max="0" data-min="1" name="quantity">
						<input class="plus" type="button" value="+">
					</div>
					<div class="clear"></div>
				</li>
			</ul>
		</div>
		<!-- End row -->
		<div class="cart-total">�� �Ϲ��ֹ��ݾ� <span class="won">112,400��</span></div>
		<!-- End Plus -->
		<div class="row bg-gray">
			<h2>�ù��ǰ</h2>
			<div class="cartdelete"></div>
			<ul class="ui-listview bginner">
				<li class="ui-btn ui-li ui-li-has-thumb">
					<div class="ui-btn-inner ui-li">
						<a class="ui-link-inherit iframe" href="/mobile/shop/cuisineinfo/cuisineA.jsp">
							<h3 class="ui-li-heading">��Ƽ����Ƽ(BOX)</h3>
							<p class="ui-li-desc"></p>
							<p>5,400��</p>
						</a>
					</div>
				</li>
			</ul>
			<div class="divider"></div>
			<ul class="itembox">
				<li>
					<h3>��������</h3>
					<div class="quantity" style="width:100%;">
						<input class="minus" type="button" value="-" />
						<input class="input-text qty text" maxlength="12" title="Qty" size="4" value="1" data-max="0" data-min="1" name="quantity">
						<input class="plus" type="button" value="+" />
					</div>
					<div class="clear"></div>
				</li>
			</ul>
		</div>
		<!-- End row -->
		<div class="cart-total">�� �ù��ֹ��ݾ� <span class="won">112,400��</span></div>
		<!-- End Plus -->
		<dl class="itemlist redline">
			<dt class="f14" style="width:40%;">�Ϲ�+�ù� �� �ݾ�</dt>
			<dd class="f16" style="width:60%;">109,400��</dd>
			<div class="clear"></div>
			<dt class="f14" style="width:40%;">��ۺ�</dt>
			<dd class="f16" style="width:60%;">2,500��</dd>
		</dl>
		<dl class="itemlist bg-brown">
			<dt class="f16">�� �����ݾ�</dt>
			<dd class="f16 font-orange">111,900��</dd>
		</dl>
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��� �����ϱ�</span></span></a></td>
					<td><a href="/mobile/shop/order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ��ϱ�</span></span></a></td>
				</tr>
			</table>
		</div>
	</div>
	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
</body>
</html>