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
int zipCnt			= 0;
String devlCheck	= "";
NumberFormat nf = NumberFormat.getNumberInstance();

String payType			= "";
String rcvName			= "";
String rcvTel			= "";
String rcvTel1			= "";
String rcvTel2			= "";
String rcvTel3			= "";
String rcvHp			= "";
String rcvHp1			= "";
String rcvHp2			= "";
String rcvHp3			= "";
String rcvZipcode		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvRequest		= "";
String tagName			= "";
String tagTel			= "";
String tagTel1			= "";
String tagTel2			= "";
String tagTel3			= "";
String tagHp			= "";
String tagHp1			= "";
String tagHp2			= "";
String tagHp3			= "";
String tagZipcode		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
String rcvType			= "";
String rcvPassYn		= "";
String rcvPass			= "";
String tagType			= "";
String[] tmp			= new String[]{};

query		= "SELECT COUNT(ID) FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //총 레코드 수		
}
rs.close();

query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.ORDER_STATE";
query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID AND O.ORDER_NUM = OG.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
query		+= " ORDER BY OG.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>배송정보 수정</title>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>배송정보 수정</h2>
		<p>해당 상품에 대한배송정보 수정만 가능합니다.</p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>첫배송일</th>
							<th>상품명</th>
							<th>결제금액</th>
							<th>주문상태</th>
						</tr>
						<%
						if (tcnt > 0) {
							while (rs.next()) {
								orderCnt	= rs.getInt("ORDER_CNT");
								devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
								price		= rs.getInt("PRICE");
								gubun1		= rs.getString("GUBUN1");
								groupName	= rs.getString("GROUP_NAME");
								if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
									devlDate	= rs.getString("WDATE");
									buyBagYn	= rs.getString("BUY_BAG_YN");
									devlDay		= rs.getString("DEVL_DAY");
									devlWeek	= rs.getString("DEVL_WEEK");
									devlPeriod	= devlWeek +"주("+ devlDay +"일)";
									goodsPrice	= price * orderCnt;
									dayPrice	+= goodsPrice;
								} else {
									devlDate	= "-";
									buyBagYn	= "N";
									devlPeriod	= "-";
									goodsPrice	= price * orderCnt;
									tagPrice	+= goodsPrice;
								}
						%>
						<tr>
							<td><%=devlDate%></td>
							<td>
								<div class="orderName">
									<h5><%=groupName%></h5>
								</div>
							</td>
							<td><%=nf.format(goodsPrice)%>원</td>
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
							<td><%=devlDate%></td>
							<td>
								<div class="orderName">
									<h5>보냉가방</h5>
								</div>
							</td>
							<td><%=nf.format(bagPrice)%>원</td>
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
							<td><%=devlDate%></td>
							<td>
								<div class="orderName">
									<h5>쉐이크믹스(2포)</h5>
								</div>
							</td>
							<td>0원</td>
							<td>
								<div class="font-blue">
									<%=ut.getOrderState(rs.getString("ORDER_STATE"))%>
								</div>
							</td>
						</tr>
						<%
									totalPrice	+= defaultBagPrice;
								}
							}
						}
						%>
					</table>
					<div class="clear">
					</div>
				</div>
			</div>
			<!-- End row -->
			<%
			query		= "SELECT ";
			query		+= "	PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
			query		+= "	TAG_NAME, TAG_TEL, TAG_HP, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_REQUEST, PG_CARDNUM,";
			query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, RCV_TYPE, RCV_PASS_YN, RCV_PASS, TAG_TYPE";
			query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
			try {
				rs			= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			if (rs.next()) {
				payType			= rs.getString("PAY_TYPE");
				rcvName			= rs.getString("RCV_NAME");
				rcvTel			= rs.getString("RCV_TEL");
				if (rcvTel != null && rcvTel.length()>10) {
					tmp				= rcvTel.split("-");
					rcvTel1			= tmp[0];
					rcvTel2			= tmp[1];
					rcvTel3			= tmp[2];
				}
				rcvHp			= rs.getString("RCV_HP");
				if (rcvHp != null && rcvHp.length()>10) {
					tmp				= rcvHp.split("-");
					rcvHp1			= tmp[0];
					rcvHp2			= tmp[1];
					rcvHp3			= tmp[2];
				}
				rcvZipcode		= rs.getString("RCV_ZIPCODE");
				rcvAddr1		= rs.getString("RCV_ADDR1");
				rcvAddr2		= rs.getString("RCV_ADDR2");
				rcvType		= rs.getString("RCV_TYPE");
				rcvPassYn	= rs.getString("RCV_PASS_YN");
				rcvPass		= rs.getString("RCV_PASS");
				rcvRequest		= rs.getString("RCV_REQUEST");
				tagName			= rs.getString("TAG_NAME");
				tagTel			= rs.getString("TAG_TEL");
				if (tagTel != null && tagTel.length()>10) {
					tmp				= tagTel.split("-");
					tagTel1			= tmp[0];
					tagTel2			= tmp[1];
					tagTel3			= tmp[2];
				}
				tagHp			= rs.getString("TAG_HP");
				if (tagHp != null && tagHp.length()>10) {
					tmp				= tagHp.split("-");
					tagHp1			= tmp[0];
					tagHp2			= tmp[1];
					tagHp3			= tmp[2];
				}
				tagZipcode		= rs.getString("TAG_ZIPCODE");
				tagAddr1		= rs.getString("TAG_ADDR1");
				tagAddr2		= rs.getString("TAG_ADDR2");
				tagType		= rs.getString("TAG_TYPE");
				tagRequest		= rs.getString("TAG_REQUEST");
			}
			%>
			<form name="frmDevl" id="frmDevl" action="" method="post">
				<input type="hidden" name="mode" value="cngPost" />
				<input type="hidden" name="order_num" value="<%=orderNum%>" />
				<%if (dayPrice > 0 && tagPrice > 0) {%>
				<input type="hidden" name="type" value="01" />
				<div class="row">
					<div class="one last col">
						<div class="sectionHeader">
							<h4>
								<span class="f18 font-blue">일배상품 배송지 정보</span>
								<span class="f13">
									<input name="devl_type" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" checked="checked" />
									최근배송지
								</span>
								<span class="f13">
									<input name="devl_type" type="radio" value="N" onclick="newAddr('R');" />
									새 배송지 입력
								</span>
							</h4>
						</div>
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>받으시는분</th>
								<td colspan="3"><input name="rcv_name" type="text" class="ftfd" required label="받으시는분" value="<%=rcvName%>" maxlength="20" /></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>
									<select name="rcv_tel1" id="rcv_tel1" class="formsel">
										<option value="">선택</option>
									 	<option value="02"<%if(rcvTel1.equals("02")){out.print(" selected");}%>>02</option>
									 	<option value="031"<%if(rcvTel1.equals("031")){out.print(" selected");}%>>031</option>
									 	<option value="032"<%if(rcvTel1.equals("032")){out.print(" selected");}%>>032</option>
									 	<option value="033"<%if(rcvTel1.equals("033")){out.print(" selected");}%>>033</option>
									 	<option value="041"<%if(rcvTel1.equals("041")){out.print(" selected");}%>>041</option>
									 	<option value="043"<%if(rcvTel1.equals("043")){out.print(" selected");}%>>043</option>
									 	<option value="051"<%if(rcvTel1.equals("051")){out.print(" selected");}%>>051</option>
									 	<option value="052"<%if(rcvTel1.equals("052")){out.print(" selected");}%>>052</option>
									 	<option value="053"<%if(rcvTel1.equals("053")){out.print(" selected");}%>>053</option>
									 	<option value="054"<%if(rcvTel1.equals("054")){out.print(" selected");}%>>054</option>
									 	<option value="055"<%if(rcvTel1.equals("055")){out.print(" selected");}%>>055</option>
									 	<option value="061"<%if(rcvTel1.equals("061")){out.print(" selected");}%>>061</option>
									 	<option value="064"<%if(rcvTel1.equals("064")){out.print(" selected");}%>>064</option>
									 	<option value="070"<%if(rcvTel1.equals("070")){out.print(" selected");}%>>070</option>
									</select>
									-
									<input name="rcv_tel2" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=rcvTel2%>">
									-
									<input name="rcv_tel3" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=rcvTel3%>">
								</td>
								<th>휴대폰 번호</th>
								<td>
									<select name="rcv_hp1" id="rcv_hp1" class="formsel" required label="휴대폰 번호">
										<option>선택</option>
										<option value="010"<%if(rcvHp1.equals("010")){out.print(" selected");}%>>010</option>
									 	<option value="011"<%if(rcvHp1.equals("011")){out.print(" selected");}%>>011</option>
									 	<option value="016"<%if(rcvHp1.equals("016")){out.print(" selected");}%>>016</option>
									 	<option value="017"<%if(rcvHp1.equals("017")){out.print(" selected");}%>>017</option>
									 	<option value="018"<%if(rcvHp1.equals("018")){out.print(" selected");}%>>018</option>
									 	<option value="019"<%if(rcvHp1.equals("019")){out.print(" selected");}%>>019</option>
									</select>
									-
									<input name="rcv_hp2" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=rcvHp2%>" required label="휴대폰 번호">
									-
									<input name="rcv_hp3" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=rcvHp3%>" required label="휴대폰 번호">
								</td>
							</tr>
							<tr>
								<th>배송지 주소</th>
								<td colspan="3">
									<input name="rcv_zipcode" id="rcv_zipcode" type="text" class="ftfd" style="width:100px;" value="<%=rcvZipcode%>" required label="우편번호" readonly="readonly" maxlength="6" />
									<span class="button light small"><a href="#" onclick="window.open('/shop/popup/AddressSearchJiPop.jsp?ztype=0001','chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');">우편번호 검색</a></span>
									<br />
									<input name="rcv_addr1" id="rcv_addr1" type="text" class="ftfd" style="width:255px; margin-top:5px;" value="<%=rcvAddr1%>" required label="기본주소" readonly="readonly" maxlength="50" />
									<input name="rcv_addr2" id="rcv_addr2" type="text" class="ftfd" style="width:255px; margin-top:5px;" value="<%=rcvAddr2%>" required label="상세주소" maxlength="50">
								</td>
							</tr>
							<tr>
								<th>수령방법</th>
								<td>
									<input name="rcv_type" type="radio" value="01"<%if(rcvType.equals("01")){out.print(" checked");}%>>
									현관 앞 비치
									<input name="rcv_type" type="radio" value="02"<%if(rcvType.equals("02")){out.print(" checked");}%>>
									경비실 위탁 수령
								</td>
								<th>출입시 비밀번호</th>
								<td>
									<input name="rcv_pass_yn" type="radio" value="Y"<%if(rcvPassYn.equals("Y")){out.print(" checked");}%>>
									있음
									<input name="rcv_pass" type="text" class="ftfd" style="width:50px;" value="<%=rcvPass%>" maxlength="15" />
									<input name="rcv_pass_yn" type="radio" value="N"<%if(rcvPassYn.equals("N")){out.print(" checked");}%>>
									없음
								</td>
							</tr>
							<tr>
								<th>배송요청사항</th>
								<td colspan="3">
									<input name="rcv_request" type="text" class="ftfd" style="width:340px; margin-top:5px;" maxlength="60" value="<%=rcvRequest%>" />
									<p class="bold7 mart5">입력글자는 최대 한글 60자, 영문/숫자 120자까지 가능합니다.<br />
									<font class="font-gray">* 일배 상품의 경우 0시~6시에 배송되므로, 새벽출입 방법에 대해 자세히 적어주세요.<br />
									(특이사항은 1:1 게시판 또는 고객센터로 연락주세요)</font></p>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<!-- End row -->
				<div class="row">
					<div class="one last col">
						<div class="sectionHeader">
							<h4>
								<span class="f18 font-green">택배상품 배송지 정보</span>
								<span class="f13">
								<input name="addr_copy" type="radio" value="Y" onclick="copyAddr();">
								일배 상품과 동일
								</span>
								<span class="f13">
								<input name="addr_copy" type="radio" value="N" onclick="newAddr('T');">
								새 배송지 입력
								</span>
							</h4>
						</div>
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>받으시는분</th>
								<td colspan="3"><input name="tag_name" type="text" class="ftfd" required label="받으시는분" value="<%=tagName%>" maxlength="20" /></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>
									<select name="tag_tel1" id="tag_tel1" class="formsel">
										<option value="">선택</option>
									 	<option value="02"<%if(tagTel1.equals("02")){out.print(" selected");}%>>02</option>
									 	<option value="031"<%if(tagTel1.equals("031")){out.print(" selected");}%>>031</option>
									 	<option value="032"<%if(tagTel1.equals("032")){out.print(" selected");}%>>032</option>
									 	<option value="033"<%if(tagTel1.equals("033")){out.print(" selected");}%>>033</option>
									 	<option value="041"<%if(tagTel1.equals("041")){out.print(" selected");}%>>041</option>
									 	<option value="043"<%if(tagTel1.equals("043")){out.print(" selected");}%>>043</option>
									 	<option value="051"<%if(tagTel1.equals("051")){out.print(" selected");}%>>051</option>
									 	<option value="052"<%if(tagTel1.equals("052")){out.print(" selected");}%>>052</option>
									 	<option value="053"<%if(tagTel1.equals("053")){out.print(" selected");}%>>053</option>
									 	<option value="054"<%if(tagTel1.equals("054")){out.print(" selected");}%>>054</option>
									 	<option value="055"<%if(tagTel1.equals("055")){out.print(" selected");}%>>055</option>
									 	<option value="061"<%if(tagTel1.equals("061")){out.print(" selected");}%>>061</option>
									 	<option value="064"<%if(tagTel1.equals("064")){out.print(" selected");}%>>064</option>
									 	<option value="070"<%if(tagTel1.equals("070")){out.print(" selected");}%>>070</option>
									</select>
									-
									<input name="tag_tel2" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=tagTel2%>">
									-
									<input name="tag_tel3" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=tagTel3%>">
								</td>
								<th>휴대폰 번호</th>
								<td>
									<select name="tag_hp1" id="tag_hp1" class="formsel" required label="휴대폰 번호">
										<option>선택</option>
										<option value="010"<%if(tagHp1.equals("010")){out.print(" selected");}%>>010</option>
									 	<option value="011"<%if(tagHp1.equals("011")){out.print(" selected");}%>>011</option>
									 	<option value="016"<%if(tagHp1.equals("016")){out.print(" selected");}%>>016</option>
									 	<option value="017"<%if(tagHp1.equals("017")){out.print(" selected");}%>>017</option>
									 	<option value="018"<%if(tagHp1.equals("018")){out.print(" selected");}%>>018</option>
									 	<option value="019"<%if(tagHp1.equals("019")){out.print(" selected");}%>>019</option>
									</select>
									-
									<input name="tag_hp2" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=tagHp2%>" required label="휴대폰 번호">
									-
									<input name="tag_hp3" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=tagHp3%>" required label="휴대폰 번호">
								</td>
							</tr>
							<tr>
								<th>배송지 주소</th>
								<td colspan="3">
									<input name="tag_zipcode" id="tag_zipcode" type="text" class="ftfd" style="width:100px;" value="<%=tagZipcode%>" required label="우편번호" readonly="readonly" maxlength="6" />
									<span class="button light small"><a href="#" onclick="window.open('/shop/popup/AddressSearchJiPop.jsp?ztype=0002','chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');">우편번호 검색</a></span>
									<br />
									<input name="tag_addr1" id="tag_addr1" type="text" class="ftfd" style="width:255px; margin-top:5px;" value="<%=tagAddr1%>" required label="기본주소" readonly="readonly" maxlength="50" />
									<input name="tag_addr2" id="tag_addr2" type="text" class="ftfd" style="width:255px; margin-top:5px;" value="<%=tagAddr2%>" required label="상세주소" maxlength="50">
								</td>
							</tr>
							<input type="hidden" name="tag_type" value="01" />
							<tr>
								<th>배송요청사항</th>
								<td colspan="3">
									<input name="tag_required" type="text" class="ftfd" style="width:340px; margin-top:5px;" maxlength="60" value="<%=tagRequest%>" />
									<p class="bold7 mart5">입력글자는 최대 한글 60자, 영문/숫자 120자까지 가능합니다.</p>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<%} else if (dayPrice > 0) {%>
				<input type="hidden" name="type" value="02" />
				<div class="row">
					<div class="one last col">
						<div class="sectionHeader">
							<h4>
								<span class="f18 font-blue">일배상품 배송지 정보</span>
								<span class="f13">
									<input name="devl_type" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" checked="checked" />
									최근배송지
								</span>
								<span class="f13">
									<input name="devl_type" type="radio" value="N" onclick="newAddr('R');" />
									새 배송지 입력
								</span>
							</h4>
						</div>
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>받으시는분</th>
								<td colspan="3"><input name="rcv_name" type="text" class="ftfd" required label="받으시는분" value="<%=rcvName%>" maxlength="20" /></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>
									<select name="rcv_tel1" id="rcv_tel1" class="formsel">
										<option value="">선택</option>
									 	<option value="02"<%if(rcvTel1.equals("02")){out.print(" selected");}%>>02</option>
									 	<option value="031"<%if(rcvTel1.equals("031")){out.print(" selected");}%>>031</option>
									 	<option value="032"<%if(rcvTel1.equals("032")){out.print(" selected");}%>>032</option>
									 	<option value="033"<%if(rcvTel1.equals("033")){out.print(" selected");}%>>033</option>
									 	<option value="041"<%if(rcvTel1.equals("041")){out.print(" selected");}%>>041</option>
									 	<option value="043"<%if(rcvTel1.equals("043")){out.print(" selected");}%>>043</option>
									 	<option value="051"<%if(rcvTel1.equals("051")){out.print(" selected");}%>>051</option>
									 	<option value="052"<%if(rcvTel1.equals("052")){out.print(" selected");}%>>052</option>
									 	<option value="053"<%if(rcvTel1.equals("053")){out.print(" selected");}%>>053</option>
									 	<option value="054"<%if(rcvTel1.equals("054")){out.print(" selected");}%>>054</option>
									 	<option value="055"<%if(rcvTel1.equals("055")){out.print(" selected");}%>>055</option>
									 	<option value="061"<%if(rcvTel1.equals("061")){out.print(" selected");}%>>061</option>
									 	<option value="064"<%if(rcvTel1.equals("064")){out.print(" selected");}%>>064</option>
									 	<option value="070"<%if(rcvTel1.equals("070")){out.print(" selected");}%>>070</option>
									</select>
									-
									<input name="rcv_tel2" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=rcvTel2%>">
									-
									<input name="rcv_tel3" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=rcvTel3%>">
								</td>
								<th>휴대폰 번호</th>
								<td>
									<select name="rcv_hp1" id="rcv_hp1" class="formsel" required label="휴대폰 번호">
										<option>선택</option>
										<option value="010"<%if(rcvHp1.equals("010")){out.print(" selected");}%>>010</option>
									 	<option value="011"<%if(rcvHp1.equals("011")){out.print(" selected");}%>>011</option>
									 	<option value="016"<%if(rcvHp1.equals("016")){out.print(" selected");}%>>016</option>
									 	<option value="017"<%if(rcvHp1.equals("017")){out.print(" selected");}%>>017</option>
									 	<option value="018"<%if(rcvHp1.equals("018")){out.print(" selected");}%>>018</option>
									 	<option value="019"<%if(rcvHp1.equals("019")){out.print(" selected");}%>>019</option>
									</select>
									-
									<input name="rcv_hp2" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=rcvHp2%>" required label="휴대폰 번호">
									-
									<input name="rcv_hp3" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=rcvHp3%>" required label="휴대폰 번호">
								</td>
							</tr>
							<tr>
								<th>배송지 주소</th>
								<td colspan="3">
									<input name="rcv_zipcode" id="rcv_zipcode" type="text" class="ftfd" style="width:100px;" value="<%=rcvZipcode%>" required label="우편번호" readonly="readonly" maxlength="6" />
									<span class="button light small"><a href="#" onclick="window.open('/shop/popup/AddressSearchJiPop.jsp?ztype=0001','chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');">우편번호 검색</a></span>
									<br />
									<input name="rcv_addr1" id="rcv_addr1" type="text" class="ftfd" style="width:255px; margin-top:5px;" value="<%=rcvAddr1%>" required label="기본주소" readonly="readonly" maxlength="50" />
									<input name="rcv_addr2" id="rcv_addr2" type="text" class="ftfd" style="width:255px; margin-top:5px;" value="<%=rcvAddr2%>" required label="상세주소" maxlength="50">
								</td>
							</tr>
							<tr>
								<th>수령방법</th>
								<td>
									<input name="rcv_type" type="radio" value="01"<%if(rcvType.equals("01")){out.print(" checked");}%>>
									현관 앞 비치
									<input name="rcv_type" type="radio" value="02"<%if(rcvType.equals("02")){out.print(" checked");}%>>
									경비실 위탁 수령
								</td>
								<th>출입시 비밀번호</th>
								<td>
									<input name="rcv_pass_yn" type="radio" value="Y"<%if(rcvPassYn.equals("Y")){out.print(" checked");}%>>
									있음
									<input name="rcv_pass" type="text" class="ftfd" style="width:50px;" value="<%=rcvPass%>" maxlength="15" />
									<input name="rcv_pass_yn" type="radio" value="N"<%if(rcvPassYn.equals("N")){out.print(" checked");}%>>
									없음
								</td>
							</tr>
							<tr>
								<th>배송요청사항</th>
								<td colspan="3">
									<input name="rcv_request" type="text" class="ftfd" style="width:340px; margin-top:5px;" maxlength="60" value="<%=rcvRequest%>" />
									<p class="bold7 mart5">입력글자는 최대 한글 60자, 영문/숫자 120자까지 가능합니다.<br />
									<font class="font-gray">* 일배 상품의 경우 0시~6시에 배송되므로, 새벽출입 방법에 대해 자세히 적어주세요.<br />
									(특이사항은 1:1 게시판 또는 고객센터로 연락주세요)</font></p>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<%} else {%>
				<input type="hidden" name="type" value="03" />
				<div class="row">
					<div class="one last col">
						<div class="sectionHeader">
							<h4>
								<span class="f18 font-green">택배상품 배송지 정보</span>
								<span class="f13">
									<input name="devl_type" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" checked="checked" />
									최근배송지
								</span>
								<span class="f13">
									<input name="devl_type" type="radio" value="N" onclick="newAddr('T');" />
									새 배송지 입력
								</span>
							</h4>
						</div>
						<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>받으시는분</th>
								<td colspan="3"><input name="tag_name" type="text" class="ftfd" required label="받으시는분" value="<%=tagName%>" maxlength="20" /></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>
									<select name="tag_tel1" id="tag_tel1" class="formsel">
										<option value="">선택</option>
									 	<option value="02"<%if(tagTel1.equals("02")){out.print(" selected");}%>>02</option>
									 	<option value="031"<%if(tagTel1.equals("031")){out.print(" selected");}%>>031</option>
									 	<option value="032"<%if(tagTel1.equals("032")){out.print(" selected");}%>>032</option>
									 	<option value="033"<%if(tagTel1.equals("033")){out.print(" selected");}%>>033</option>
									 	<option value="041"<%if(tagTel1.equals("041")){out.print(" selected");}%>>041</option>
									 	<option value="043"<%if(tagTel1.equals("043")){out.print(" selected");}%>>043</option>
									 	<option value="051"<%if(tagTel1.equals("051")){out.print(" selected");}%>>051</option>
									 	<option value="052"<%if(tagTel1.equals("052")){out.print(" selected");}%>>052</option>
									 	<option value="053"<%if(tagTel1.equals("053")){out.print(" selected");}%>>053</option>
									 	<option value="054"<%if(tagTel1.equals("054")){out.print(" selected");}%>>054</option>
									 	<option value="055"<%if(tagTel1.equals("055")){out.print(" selected");}%>>055</option>
									 	<option value="061"<%if(tagTel1.equals("061")){out.print(" selected");}%>>061</option>
									 	<option value="064"<%if(tagTel1.equals("064")){out.print(" selected");}%>>064</option>
									 	<option value="070"<%if(tagTel1.equals("070")){out.print(" selected");}%>>070</option>
									</select>
									-
									<input name="tag_tel2" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=tagTel2%>">
									-
									<input name="tag_tel3" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=tagTel3%>">
								</td>
								<th>휴대폰 번호</th>
								<td>
									<select name="tag_hp1" id="tag_hp1" class="formsel" required label="휴대폰 번호">
										<option>선택</option>
										<option value="010"<%if(tagHp1.equals("010")){out.print(" selected");}%>>010</option>
									 	<option value="011"<%if(tagHp1.equals("011")){out.print(" selected");}%>>011</option>
									 	<option value="016"<%if(tagHp1.equals("016")){out.print(" selected");}%>>016</option>
									 	<option value="017"<%if(tagHp1.equals("017")){out.print(" selected");}%>>017</option>
									 	<option value="018"<%if(tagHp1.equals("018")){out.print(" selected");}%>>018</option>
									 	<option value="019"<%if(tagHp1.equals("019")){out.print(" selected");}%>>019</option>
									</select>
									-
									<input name="tag_hp2" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=tagHp2%>" required label="휴대폰 번호">
									-
									<input name="tag_hp3" type="text" class="ftfd" style="width:50px;" maxlength="4" value="<%=tagHp3%>" required label="휴대폰 번호">
								</td>
							</tr>
							<tr>
								<th>배송지 주소</th>
								<td colspan="3">
									<input name="tag_zipcode" id="tag_zipcode" type="text" class="ftfd" style="width:100px;" value="<%=tagZipcode%>" required label="우편번호" readonly="readonly" maxlength="6" />
									<span class="button light small"><a href="#" onclick="window.open('/shop/popup/AddressSearchJiPop.jsp?ztype=0002','chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');">우편번호 검색</a></span>
									<br />
									<input name="tag_addr1" id="tag_addr1" type="text" class="ftfd" style="width:255px; margin-top:5px;" value="<%=tagAddr1%>" required label="기본주소" readonly="readonly" maxlength="50" />
									<input name="tag_addr2" id="tag_addr2" type="text" class="ftfd" style="width:255px; margin-top:5px;" value="<%=tagAddr2%>" required label="상세주소" maxlength="50">
								</td>
							</tr>
							<input type="hidden" name="tag_type" value="01" />
							<tr>
								<th>배송요청사항</th>
								<td colspan="3">
									<input name="tag_required" type="text" class="ftfd" style="width:340px; margin-top:5px;" maxlength="60" value="<%=tagRequest%>" />
									<p class="bold7 mart5">입력글자는 최대 한글 60자, 영문/숫자 120자까지 가능합니다.</p>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<%}%>
				<!-- End row -->
			</form>
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="javascript:;" onclick="cngPost();">저장</a>
					</div>
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

function recentAddr(str) {
	if (str == 'n') {
		alert("최근배송지 정보가 없습니다.");
		$("input[name=devl_type]")[0].click();
	} else {
		var f	= document.frmDevl;

		if (f.rcv_name) {
			f.rcv_name.value		= "<%=rcvName%>";
			f.rcv_hp1.value			= "<%=rcvHp1%>";
			f.rcv_hp2.value			= "<%=rcvHp2%>";
			f.rcv_hp3.value			= "<%=rcvHp3%>";
			f.rcv_tel1.value		= "<%=rcvTel1%>";
			f.rcv_tel2.value		= "<%=rcvTel2%>";
			f.rcv_tel3.value		= "<%=rcvTel3%>";
			f.rcv_zipcode.value		= "<%=rcvZipcode%>";
			f.rcv_addr1.value		= "<%=rcvAddr1%>";
			f.rcv_addr2.value		= "<%=rcvAddr2%>";
		} else if (f.tag_name) {
			f.tag_name.value		= "<%=tagName%>";
			f.tag_hp1.value			= "<%=tagHp1%>";
			f.tag_hp2.value			= "<%=tagHp2%>";
			f.tag_hp3.value			= "<%=tagHp3%>";
			f.tag_tel1.value		= "<%=tagTel1%>";
			f.tag_tel2.value		= "<%=tagTel2%>";
			f.tag_tel3.value		= "<%=tagTel3%>";
			f.tag_zipcode.value		= "<%=tagZipcode%>";
			f.tag_addr1.value		= "<%=tagAddr1%>";
			f.tag_addr2.value		= "<%=tagAddr2%>";
		}
	}	
}

function copyAddr() {
	var f	= document.frmDevl;

	f.tag_name.value		= f.rcv_name.value;
	f.tag_hp1.value			= f.rcv_hp1.value;
	f.tag_hp2.value			= f.rcv_hp2.value;
	f.tag_hp3.value			= f.rcv_hp3.value;
	f.tag_tel1.value		= f.rcv_tel1.value;
	f.tag_tel2.value		= f.rcv_tel2.value;
	f.tag_tel3.value		= f.rcv_tel3.value;
	f.tag_zipcode.value		= f.rcv_zipcode.value;
	f.tag_addr1.value		= f.rcv_addr1.value;
	f.tag_addr2.value		= f.rcv_addr2.value;
}

function newAddr(str) {
	var f	= document.frmDevl;

	if (str == "T") {
		f.tag_name.value		= "";
		f.tag_hp1.value			= "";
		f.tag_hp2.value			= "";
		f.tag_hp3.value			= "";
		f.tag_tel1.value		= "";
		f.tag_tel2.value		= "";
		f.tag_tel3.value		= "";
		f.tag_zipcode.value		= "";
		f.tag_addr1.value		= "";
		f.tag_addr2.value		= "";
	} else {
		f.rcv_name.value		= "";
		f.rcv_hp1.value			= "";
		f.rcv_hp2.value			= "";
		f.rcv_hp3.value			= "";
		f.rcv_tel1.value		= "";
		f.rcv_tel2.value		= "";
		f.rcv_tel3.value		= "";
		f.rcv_zipcode.value		= "";
		f.rcv_addr1.value		= "";
		f.rcv_addr2.value		= "";
	}
}

function cngPost() {
	$.post("/shop/delivery_ajax.jsp", $("#frmDevl").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("저장되었습니다.");
				$.lightbox().close();
			} else {
				var error_txt;
				$(data).find("error").each(function() {
					error_txt = $(this).text().split(":");
					alert(error_txt[1]);
					if (error_txt[0] != "no_txt")
						$("#" + error_txt[0]).focus();
				});
			}
		});
	}, "xml");
	return false;
}
</script>
</body>
</html>