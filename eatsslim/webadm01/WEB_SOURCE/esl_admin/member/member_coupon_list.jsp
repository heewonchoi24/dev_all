<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String memberId		= ut.inject(request.getParameter("mid"));

if (memberId == null || memberId.equals("")) {
	out.println("<script>self.close();</script>");
	if (true) return;
}

String table		= "ESL_COUPON C, ESL_COUPON_MEMBER CM";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String where		= "";
String param		= "";
int couponId		= 0;
int cmemberId		= 0;
String couponName	= "";
String couponNum	= "";
String useYn		= "";
String useYnTxt		= "";
String useDate		= "";
String useOrderNum	= "";
String stdate		= "";
String ltdate		= "";
String saleType		= "";
int salePrice		= 0;
NumberFormat nf		= NumberFormat.getNumberInstance();
String productName	= "";

///////////////////////////
int pgsize		= 10; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

where			= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"'";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

query		= "SELECT COUNT(CM.ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // 총 페이지 수
endpage		= startpage + pagelist - 1;
if (endpage > totalPage) {
	endpage = totalPage;
}
curNum		= intTotalCnt-pgsize*(iPage-1);
param		+= "&amp;pgsize=" + pgsize + "&amp;mid=" + memberId;

query		= "SELECT C.ID COUPON_ID, CM.ID, CM.COUPON_NUM, CM.USE_YN, CM.USE_ORDER_NUM, DATE_FORMAT(CM.USE_DATE, '%Y%m%d') USE_DATE,";
query		+= "	C.COUPON_NAME, C.STDATE, C.LTDATE, C.SALE_TYPE, C.SALE_PRICE";
query		+= " FROM "+ table + where;
query		+= " ORDER BY CM.ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>Pulmuone EATSSLIM 관리자시스템</title>

	<link rel="stylesheet" type="text/css" href="../css/styles.css" />
	<style type="text/css">
	html, body { height:auto; background:#fff;}
	</style>

	<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="../js/common.js"></script>
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
		<div class="tab_con tab_style2"><!-------------------------------------->
			<h3 class="tit_style1 mt_25">쿠폰발급내역</h3>
			<div class="btn_style1">
				<p class="right_btn">
					<input type="button" value="신규쿠폰발급" onclick="location.href='member_coupon_write.jsp?mid=<%=memberId%>';" />
				</p>
			</div>
			<form name="frm_coupon">
				<input type="hidden" name="member_id" id="member_id" value="<%=memberId%>" />
				<table class="table02 mt_5" border="1" cellspacing="0">
					<colgroup>
						<col width="8%" />
						<col width="*" />
						<col width="8%" />
						<col width="8%" />
						<col width="15%" />
						<col width="8%" />
						<col width="12%" />
						<col width="12%" />
						<col width="6%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><span>회원아이디</span></th>
							<th scope="col"><span>쿠폰명</span></th>
							<th scope="col"><span>쿠폰번호</span></th>
							<th scope="col"><span>금액</span></th>
							<th scope="col"><span>사용기간</span></th>
							<th scope="col"><span>사용여부</span></th>
							<th scope="col"><span>사용일</span></th>
							<th scope="col"><span>사용주문번호</span></th>
							<th scope="col"><span>비고</span></th>
						</tr>
					</thead>
					<tbody>
					<%
					if (intTotalCnt > 0) {
						while (rs.next()) {
							couponId		= rs.getInt("COUPON_ID");
							cmemberId		= rs.getInt("ID");
							couponName		= rs.getString("COUPON_NAME");
							couponNum		= rs.getString("COUPON_NUM");
							saleType		= (rs.getString("SALE_TYPE").equals("P"))? "%" : "원";
							salePrice		= rs.getInt("SALE_PRICE");
							stdate			= rs.getString("STDATE");
							ltdate			= rs.getString("LTDATE");
							useYn			= rs.getString("USE_YN");
							if (useYn.equals("Y")) {
								useYnTxt	= "사용";
							} else if (useYn.equals("C")) {
								useYnTxt	= "사용중지";
							} else if (useYn.equals("N")) {
								useYnTxt	= "미사용";
							}
							useDate			= ut.isnull(rs.getString("USE_DATE"));
							useDate			= (useDate.equals(""))? "&nbsp;" : useDate;
							useOrderNum		= ut.isnull(rs.getString("USE_ORDER_NUM"));
							useOrderNum		= (useOrderNum.equals(""))? "&nbsp;" : useOrderNum;

							if (useYn.equals("Y")) {
								query1		= "SELECT ";
								query1		+= "		GROUP_NAME";
								query1		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O";
								query1		+= " WHERE G.ID = OG.GROUP_ID";
								query1		+= " AND OG.ORDER_NUM = O.ORDER_NUM AND OG.ORDER_NUM = '"+ useOrderNum +"'";
								query1		+= " ORDER BY O.ID DESC";
								try {
									rs1 = stmt1.executeQuery(query1);
								} catch(Exception e) {
									out.println(e+"=>"+query1);
									if(true)return;
								}

								i		= 0;
								while (rs1.next()) {
									if (i > 0) {
										productName	= rs1.getString("GROUP_NAME")+" 외 "+ i +"건";
									} else {
										productName	= rs1.getString("GROUP_NAME");
									}
									i++;
								}
							} else {
								productName		= "";
							}
					%>
						<tr>
							<td><%=memberId%></td>
							<td><%=couponName%></td>
							<td><%=couponNum%></td>
							<td><%=nf.format(salePrice) + saleType%> 할인</td>
							<td>
								<input type="text" name="stdate_<%=couponId%>" id="stdate_<%=couponId%>" class="input1 date-pick" maxlength="10" readonly="readonly" value="<%=stdate%>" /><br />
								~<br />
								<input type="text" name="ltdate_<%=couponId%>" id="ltdate_<%=couponId%>" class="input1 date-pick" maxlength="10" readonly="readonly" value="<%=ltdate%>" />
							</td>
							<td><%=useYnTxt%></td>
							<td><%=useDate%></td>
							<td><%=useOrderNum%><br /><%=productName%></td>
							<td>								
					<%		if (useYn.equals("N")) {%>
								<input type="button" value="수정" onclick="cngCoupon(<%=couponId%>, <%=cmemberId%>, '<%=stdate%>', '<%=ltdate%>');" />
					<%		} else {%>
								&nbsp;
					<%		}%>
							</td>
						</tr>
					<%
						}
					}
					%>
					</tbody>
				</table>
			</form>
			<%@ include file="../include/inc-paging.jsp"%>
		</div>
	</div>
	<!-- //popup_wrap -->
<script type="text/javascript">
$(document).ready(function() {
	$('.date-pick').datepick({ 
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function cngCoupon(cid, cmid, stdate, ltdate) {
	$.post("member_coupon_list_ajax.jsp", {
		mode: "upd",
		cid: cid,
		cmid: cmid,
		stdate: $("#stdate_"+ cid).val(),
		ltdate: $("#ltdate_"+ cid).val(),
		mid: $("#member_id").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("정상적으로 처리되었습니다.");
				self.location.href = "member_coupon_list.jsp?mid=" + $("#member_id").val();
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>