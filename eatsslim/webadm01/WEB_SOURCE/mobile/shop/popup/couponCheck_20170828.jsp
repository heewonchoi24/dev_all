<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int tcnt			= 0;
int tcnt1			= 0;
int buyQty			= 0;
String mode			= ut.inject(request.getParameter("mode"));
String oyn			= ut.inject(request.getParameter("oyn"));
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
String buyBagYn		= "";
String gubun1		= "";
String gubun2		= "";
String groupCode	= "";
String groupName	= "";
String cartImg		= "";
//int payPrice		= 0;
int totalPrice		= 0;
//int totalPrice1		= 0;
//int totalPrice2		= 0;
//int totalPrice3		= 0;
int devlPrice		= 0;
int bagPrice		= 0;
int zipCnt			= 0;
String devlCheck	= "";
String cpColumns	= " C.ID, C.STDATE, C.LTDATE, CM.MEMBER_ID, CM.USE_YN, CM.COUPON_NUM, C.COUPON_NAME, C.SALE_TYPE, C.SALE_PRICE";
String cpTable		= " ESL_COUPON C, ESL_COUPON_MEMBER CM";
String cpWhere		= "";
String saleType		= "";
int salePrice		= 0;
int couponPrice		= 0;
int couponId		= 0;
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT COUNT(ID) FROM ESL_CART WHERE MEMBER_ID = '"+ eslMemberId +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //�� ���ڵ� ��
}
rs.close();

query		= "SELECT C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK, DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN, G.GUBUN1, G.GUBUN2, G.GROUP_CODE, G.GROUP_NAME, C.ID, G.CART_IMG";
query		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
query		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = '"+ eslMemberId +"' AND C.CART_TYPE = '"+ mode +"'";
if (oyn.equals("Y")) {
	query		+= " AND ORDER_YN = 'Y'";
}
query		+= " ORDER BY C.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>
<script type="text/javascript" src="/common/js/util.js"></script>
</head>
<body>
<div id="cboxContent">
	<div class="pop_header">
		<h1>��밡�� ����</h1>
	</div>
	<div class="pop_content" id="couponCheck">
		<h2 class="ui-title">��ǰ�� ��������</h2>

		<ul class="couponList">
		<%
			if (tcnt > 0) {
				while (rs.next()) {
					couponId	= rs.getInt("ID");
					buyQty		= rs.getInt("BUY_QTY");
					devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "�Ϲ�" : "�ù�";
					gubun1		= rs.getString("GUBUN1");
					gubun2		= rs.getString("GUBUN2");
					groupCode	= rs.getString("GROUP_CODE");
					groupName	= rs.getString("GROUP_NAME");
					if (gubun1.equals("01")) {
						devlDate	= rs.getString("WDATE");
						buyBagYn	= rs.getString("BUY_BAG_YN");
						devlDay		= rs.getString("DEVL_DAY");
						devlWeek	= rs.getString("DEVL_WEEK");
						devlPeriod	= devlWeek +"��("+ devlDay +"��)";
						price		= rs.getInt("PRICE");
						payPrice	= price * buyQty;
						totalPrice1 += payPrice;
					} else {
						devlDate	= "-";
						buyBagYn	= "N";
						devlPeriod	= "-";
						price		= rs.getInt("PRICE");
						payPrice	= price * buyQty;
						totalPrice2 += payPrice;
					}

					// ���� ����
					cpWhere				= "  WHERE C.ID = CM.COUPON_ID";
					cpWhere				+= " AND IF (";
					cpWhere				+= "		(C.USE_LIMIT_CNT > 0 AND C.USE_LIMIT_PRICE > 0),";
					cpWhere				+= "		(C.USE_LIMIT_CNT <= "+ buyQty +" AND C.USE_LIMIT_PRICE <= "+ payPrice +"),";
					cpWhere				+= "		(";
					cpWhere				+= "			IF (";
					cpWhere				+= "				C.USE_LIMIT_CNT > 0,";
					cpWhere				+= "				C.USE_LIMIT_CNT <= "+ buyQty +",";
					cpWhere				+= "				(";
					cpWhere				+= "					IF (";
					cpWhere				+= "						C.USE_LIMIT_PRICE > 0,";
					cpWhere				+= "						C.USE_LIMIT_PRICE <= "+ payPrice +",";
					cpWhere				+= "						1 = 1";
					cpWhere				+= "					)";
					cpWhere				+= "				)";
					cpWhere				+= "			)";
					cpWhere				+= "		)";
					cpWhere				+= "	)";
					cpWhere				+= " AND DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN C.STDATE AND C.LTDATE";
					cpWhere				+= " AND CM.MEMBER_ID = '"+ eslMemberId +"' AND CM.USE_YN = 'N'";

					// ���� ����
					query1		= "SELECT COUNT(COUPON_NUM) COUPON_CNT FROM (";
					query1		+= "	SELECT "+ cpColumns;
					query1		+= "		FROM "+ cpTable;
					query1		+=			cpWhere;
					query1		+= "		AND USE_GOODS = '01'";
					query1		+= "	UNION";
					query1		+= "	SELECT "+ cpColumns;
					query1		+= "		FROM "+ cpTable;
					query1		+=			cpWhere;
					query1		+= "		AND USE_GOODS != '01'";
					query1		+= "		AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE = '"+ groupCode +"')";
					query1		+= "		) X ";
					//query1		+= " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
					//query1		+= " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
					try {
						rs1 = stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query1);
						if(true)return;
					}

					if (rs1.next()) {
						tcnt1		= rs1.getInt(1); //�� ���ڵ� ��
					}
					rs1.close();

					// ���� ����
					query1		= "SELECT * FROM (";
					query1		+= "	SELECT "+ cpColumns;
					query1		+= "		FROM "+ cpTable;
					query1		+=			cpWhere;
					query1		+= "		AND USE_GOODS = '01'";
					query1		+= "	UNION";
					query1		+= "	SELECT "+ cpColumns;
					query1		+= "		FROM "+ cpTable;
					query1		+=			cpWhere;
					query1		+= "		AND USE_GOODS != '01'";
					query1		+= "		AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE = '"+ groupCode +"')";
					query1		+= "		) X ";
					//query1		+= " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
					//query1		+= " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
					try {
						rs1 = stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query1);
						if(true)return;
					}

					if (tcnt1 > 0) {
			%>
			<li>
				<input type="hidden" id="coupon_price_<%=groupCode%>" class="coupon_price" value="0" />
				<div class="tit"><%=ut.getGubun1Name(gubun1)%> <%=groupName%></div>
				<select name="coupon_code_<%=groupCode%>" id="coupon_code_<%=groupCode%>" class="coupon_val inp_st inp_st100p" onchange="setCoupon('<%=groupCode%>')">
					<option value="">����</option>
					<%
					while (rs1.next()) {
						saleType	= rs1.getString("SALE_TYPE");
						salePrice	= rs1.getInt("SALE_PRICE");

						if (saleType.equals("W")) {
							couponPrice		= salePrice;
						} else {
							if (rs1.getInt("ID") == 446 || rs1.getInt("ID") == 447) {
								couponPrice		= Integer.parseInt(String.valueOf(Math.round((double)price * (double)salePrice / 100)));
							} else {
								couponPrice		= Integer.parseInt(String.valueOf(Math.round((double)payPrice * (double)salePrice / 100)));
							}
						}
					%>
					<option value="<%=rs1.getString("COUPON_NUM")+"|"+couponPrice+"|"+couponId%>"><%=rs1.getString("COUPON_NAME") +"("+ nf.format(couponPrice) +"�� ����)"%></option>
					<%
					}
					%>
				</select>
			</li>
			<%
					}
				}

				rs.close();

				totalPrice3		= totalPrice1 + totalPrice2;
				if (totalPrice2 > 0 && totalPrice2 < 40000) {
					devlPrice		= defaultDevlPrice;
				} else {
					devlPrice		= 0;
				}

				totalPrice		= totalPrice3 + devlPrice + bagPrice;
			}

			rs.close();
			%>
		</ul>
		<input type="hidden" name="coupon_tprice" id="coupon_tprice" value="0" />

		<div class="coupon_pop_btns">
			<button type="button" class="btn btn_dgray square half" onclick="setCouponPrice();">��������</button>
			<button type="button" class="btn btn_white square half" onclick="parent.$.fn.colorbox.close();">����ϱ�</button>
		</div>
</div>
<!-- End contentpop -->
</div>
<script type="text/javascript">
function setCoupon(gcd) {
	var selectVal		= $("#coupon_code_"+ gcd).val();
	if (!selectVal) {
		$("#coupon_"+ gcd).text("0�� ����");
		$("#coupon_code_"+ gcd).val("");
		$("#coupon_price_"+ gcd).val(0);
		getCouponPrice(gcd);
		return false;
	} else {
		var i			= 0;
		var selectArr	= selectVal.split("|");

		if (selectArr[2] == 99 || selectArr[2] == 100 || selectArr[2] == 101 || selectArr[2] == 102 || selectArr[2] == 103 || selectArr[2] == 108 || selectArr[2] == 109 || selectArr[2] == 111 || selectArr[2] == 115 || selectArr[2] == 117) {
		} else {
			$(".coupon_val").each(function() {
				if (selectVal == $(this).val() && $(this).attr("name") != "coupon_code_"+ gcd) {
					i++;
				}
			});
		}

		if (i > 0) {
			alert("�̹� �����Ͻ� �����Դϴ�.");
			$("#coupon_code_"+ gcd).val("");
			$("#coupon_"+ gcd).text("0�� ����");
			$("#coupon_price_"+ gcd).val(0);
			getCouponPrice(gcd);
		} else {
			var couponPrice		= selectArr[1];
			$("#coupon_"+ gcd).text(commaSplit(couponPrice) + "�� ����");
			$("#coupon_price_"+ gcd).val(couponPrice);
			getCouponPrice(gcd);
		}
	}
}

function getCouponPrice(gcd) {
	var couponTprice	= 0;
	$(".coupon_price").each(function() {
		couponTprice = parseInt(couponTprice) + parseInt($(this).val());
	});
	$("#coupon_tprice").val(couponTprice);
	$("#coupon_tprice_txt").text(commaSplit(couponTprice) + "��");
}

function setCouponPrice() {
	var couponCnt = 0;
	var couponPrice	= 0;

	$(".coupon_val").each(function() {
		if ($(this).val() != "") {
			couponCnt++;
		}

	});

	if (couponCnt > 1) {
		alert("�� �ֹ��� �ϳ��� ������ ��� �����մϴ�.");
	} else {
		$(".coupon_val").each(function() {
			valArr			= $(this).val().split("|");
			couponPrice		= parseInt(valArr[1]);
			gcdArr			= $(this).attr("id").split("_");
			gcd				= gcdArr[2];
			if ($(this).val()) {
				$("#coupon_fprice_"+ gcd, parent.document).val(couponPrice);
				$("#coupon_fnum_"+ gcd, parent.document).val(valArr[0]);
			} else {
				$("#coupon_fprice_"+ gcd, parent.document).val(0);
				$("#coupon_fnum_"+ gcd, parent.document).val("");
			}
		});
		var couponTprice	= parseInt($("#coupon_tprice").val());
		$("#coupon_price_txt", parent.document).val(commaSplit(couponTprice));
		$("#coupon_ftprice", parent.document).val(couponTprice);
		$("#coupon_fprice_txt", parent.document).text(commaSplit(couponTprice));
		var tprice		= parseInt($("#goodsPrice", parent.document).val()) + parseInt($("#devlPrice", parent.document).val()) + parseInt($("#bagPrice", parent.document).val()) - parseInt(couponTprice);
		if (tprice < 1) tprice = 0;
		$("#tprice", parent.document).text(commaSplit(tprice));
		$("#pay_price", parent.document).val(tprice);
		parent.$.fn.colorbox.close();
	}
}
</script>
</body>
</html>