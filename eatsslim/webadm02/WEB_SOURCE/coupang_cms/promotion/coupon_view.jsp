<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String table		= "";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String ctype		= ut.inject(request.getParameter("ctype"));
String schCtype		= ut.inject(request.getParameter("sch_ctype"));
String schStdate	= ut.inject(request.getParameter("sch_stdate"));
String schLtdate	= ut.inject(request.getParameter("sch_ltdate"));
String schVendor	= ut.inject(request.getParameter("sch_vendor"));
int couponId		= 0;
String couponNum	= "";
String memmberId	= "";
String memberName	= "";
String groupName	= "";
int payPrice		= 0;
int salePrice		= 0;
String useYn		= "";
String where		= "";
String vparam		= "";
String column		= "";
String couponName	= "";
String couponType	= "";
String stdate		= "";
String ltdate		= "";
String vendor		= "";
String saleType		= "";
String saleTxt		= "";
String useLimitTxt	= "";
String useGoodsTxt	= "";
int couponCnt		= 0;
int useCnt			= 0;
int useLimitCnt		= 0;
int useLimitPrice	= 0;
String useGoods		= "";
String memberId		= "";
String useDate		= "";
String param		= "";
String useYnTxt		= "";
String useOrderNum	= "";
NumberFormat nf		= NumberFormat.getNumberInstance();

///////////////////////////
int vpgsize		= 10; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int viPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));

param		= "page="+ iPage +"&pgsize="+ pgsize;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	couponId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT COUPON_NAME, SALE_TYPE, SALE_PRICE, USE_LIMIT_CNT, USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT,";
	query		+= "	DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE";
	query		+= " FROM ESL_COUPON";
	query		+= " WHERE ID = "+ couponId;
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if (true) return;
	}

	if (rs.next()) {
		couponName			= rs.getString("COUPON_NAME");
		saleType			= (rs.getString("SALE_TYPE").equals("P"))? "%" : "원";
		salePrice			= rs.getInt("SALE_PRICE");
		useLimitCnt			= rs.getInt("USE_LIMIT_CNT");
		useLimitPrice		= rs.getInt("USE_LIMIT_PRICE");
		if (useLimitCnt > 0 && useLimitPrice > 0) {
			useLimitTxt			+= "<p>"+ nf.format(useLimitCnt) + "개 이상 구매 시 사용</p>\n";
			useLimitTxt			+= "<p>"+ nf.format(useLimitPrice) + "원 이상 구매 시 사용</p>\n";
		} else if (useLimitCnt > 0) {
			useLimitTxt			+= "<p>"+ nf.format(useLimitCnt) + "개 이상 구매 시 사용</p>\n";
		} else  if (useLimitPrice > 0) {
			useLimitTxt			+= "<p>"+ nf.format(useLimitPrice) + "원 이상 구매 시 사용</p>\n";
		} else {
			useLimitTxt			= "";
		}
		useGoods			= rs.getString("USE_GOODS");
		if (useGoods.equals("01")) {
			useGoodsTxt			= "<p>전체 상품에 사용 가능</p>\n";
		} else if (useGoods.equals("03")) {
			useGoodsTxt			= "<p>일배상품 주문시 사용 가능</p>\n";
		} else if (useGoods.equals("03")) {
			useGoodsTxt			= "<p>택배상품 주문시 사용 가능</p>\n";
		} else {
			query1		= "SELECT GROUP_NAME FROM ESL_COUPON_GOODS WHERE COUPON_ID = "+ couponId;
			try {
				rs1 = stmt1.executeQuery(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			while (rs1.next()) {
				useGoodsTxt		+= "<p>"+ rs1.getString("GROUP_NAME") + " 주문시 사용 가능</p>\n";
			}
		}
		stdate				= rs.getString("STDATE");
		ltdate				= rs.getString("LTDATE");
		if (ctype.equals("01")) {
			query1		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER WHERE COUPON_ID = "+ couponId;
			try {
				rs1			= stmt1.executeQuery(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			if (rs1.next()) {
				couponCnt	= rs1.getInt(1);
			}
			rs1.close();
		} else {
			couponCnt	= rs.getInt("MAX_COUPON_CNT");
		}

		query1		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
		query1		+= " WHERE COUPON_ID = "+ couponId +" AND USE_YN = 'Y'";
		try {
			rs1			= stmt1.executeQuery(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}

		if (rs1.next()) {
			useCnt		= rs1.getInt(1);
		}
		rs1.close();
	}	

	where			= " WHERE CR.COUPON_ID = "+ couponId;
	where			+= " AND C.ID = CR.COUPON_ID";
	if (ctype.equals("01")) {
		table			= "ESL_COUPON C, ESL_COUPON_MEMBER CR";
		column			= "CR.ID, CR.COUPON_NUM, CR.MEMBER_ID, CR.USE_YN, CR.USE_ORDER_NUM, DATE_FORMAT(CR.USE_DATE, '%Y-%m-%d %H:%m') USE_DATE";
	} else {
		table			= "ESL_COUPON C, ESL_COUPON_RANDNUM CR";
		column			= "CR.ID, CR.RAND_NUM AS COUPON_NUM, CR.USE_YN";
	}

	if (request.getParameter("vpage") != null && request.getParameter("vpage").length()>0){
		viPage		= Integer.parseInt(request.getParameter("vpage"));
		startpage	= ((int)(viPage-1) / pagelist) * pagelist + 1;
	}else{
		viPage		= 1;
		startpage	= 1;
	}
	if (request.getParameter("vpgsize") != null && request.getParameter("vpgsize").length()>0)
		vpgsize		= Integer.parseInt(request.getParameter("vpgsize"));

	query		= "SELECT COUNT(CR.ID) FROM "+ table + where; //out.print(query1); if(true)return;
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();
	if (rs.next()) {
		intTotalCnt = rs.getInt(1); //총 레코드 수		
	}
	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

	totalPage	= (int)(Math.ceil((float)intTotalCnt/vpgsize)); // 총 페이지 수
	endpage		= startpage + pagelist - 1;
	if (endpage > totalPage) {
		endpage = totalPage;
	}
	curNum		= intTotalCnt-vpgsize*(viPage-1);
	vparam		+= "&amp;id=" + couponId +"&amp;ctype=" + ctype +"&amp;vpgsize=" + vpgsize;

	query		= "SELECT "+ column;
	query		+= " FROM "+ table + where;
	query		+= " ORDER BY ID DESC";
	query		+= " LIMIT "+String.valueOf((viPage-1) * vpgsize)+", "+String.valueOf(vpgsize); //out.print(query); if(true)return;
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();
	///////////////////////////
} else {
	ut.jsBack(out);
	if (true) return;
}
%>
	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:1,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>	
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>쿠폰관리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<table class="table01" border="1" cellspacing="0">
					<colgroup>
						<col width="140px" />
						<col width="40%" />
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">
								<span>쿠폰명</span>
							</th>
							<td colspan="3"><%=couponName%></td>
						</tr>
						<tr>
							<th scope="row">
								<span>구분</span>
							</th>
							<td><%=ut.getCouponType(ctype)%></td>
							<th scope="row">
								<span>사용기간</span>
							</th>
							<td><%=stdate+"~"+ltdate%></td>
						</tr>
						<tr>
							<th scope="row">
								<span>쿠폰할인금액</span>
							</th>
							<td>상품판매가격의 <%=nf.format(salePrice)%><%=saleType%> 할인</td>
							<th scope="row">
								<span>사용제한</span>
							</th>
							<td><%=useLimitTxt%></td>
						</tr>
						<tr>
							<th scope="row">
								<span>사용가능<br />상품설정</span>
							</th>
							<td><%=useGoodsTxt%></td>
							<th scope="row">
								<span>발급/사용</span>
							</th>
							<td><%=couponCnt+"건/"+useCnt+"건"%></td>
						</tr>
					</tbody>
				</table>
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<input type="hidden" name="id" value="<%=couponId%>" />
					<input type="hidden" name="vparam" value="<%=vparam%>" />
					<div class="member_box">
						<p class="search_result">총 <strong><%=intTotalCnt%></strong>명</p>
						<p class="right_box">
							<select name="vpgsize" onchange="this.form.submit()">
								<option value="10"<%if(vpgsize==10)out.print(" selected");%>>10개씩보기</option>
								<option value="20"<%if(vpgsize==20)out.print(" selected");%>>20개씩보기</option>
								<option value="30"<%if(vpgsize==30)out.print(" selected");%>>30개씩보기</option>
								<option value="100"<%if(vpgsize==100)out.print(" selected");%>>100개씩보기</option>
							</select>
						</p>
					</div>
				</form>
				<form name="frm_list" id="frm_list" method="post">
					<input type="hidden" name="mode" value="updAll" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="4%" />
							<col width="4%" />
							<col width="10%" />
							<col width="20%" />
							<col width="*" />
							<col width="10%" />
							<col width="6%" />
							<col width="10%" />
							<col width="10%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span><input type="checkbox" id="selectall" /></span></td>
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>쿠폰번호</span></th>
								<th scope="col"><span>발급받은회원</span></th>
								<th scope="col"><span>구매상품</span></th>
								<th scope="col"><span>상품구매금액</span></th>
								<th scope="col"><span>할인금액</span></th>
								<th scope="col"><span>사용여부</span></th>
								<th scope="col"><span>사용일</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									couponNum	= rs.getString("COUPON_NUM");
									useYn		= rs.getString("USE_YN");
									if (ctype.equals("01")) {
										memberId	= rs.getString("MEMBER_ID");
										useDate		= ut.isnull(rs.getString("USE_DATE"));
										useOrderNum	= rs.getString("USE_ORDER_NUM");
										query1		= "SELECT MEM_NAME FROM ESL_MEMBER WHERE MEM_ID = '"+ memberId +"'";
										try {
											rs1		= stmt1.executeQuery(query1);
										} catch(Exception e) {
											out.println(e+"=>"+query);
											if(true)return;
										}

										if (rs1.next()) {
											memberName	= rs1.getString("MEM_NAME");
										}										
									} else {
										query1		= "SELECT MEM_ID, MEM_NAME, USE_ORDER_NUM, DATE_FORMAT(USE_DATE, '%Y-%m-%d %H:%m') USE_DATE, USE_YN";
										query1		+= " FROM ESL_MEMBER M, ESL_COUPON_MEMBER CM";
										query1		+= " WHERE M.MEM_ID = CM.MEMBER_ID AND COUPON_NUM = '"+ couponNum +"'";
										try {
											rs1		= stmt1.executeQuery(query1);
										} catch(Exception e) {
											out.println(e+"=>"+query);
											if(true)return;
										}

										if (rs1.next()) {
											memberId	= rs1.getString("MEM_ID");
											memberName	= rs1.getString("MEM_NAME");
											useDate		= ut.isnull(rs1.getString("USE_DATE"));
											useOrderNum	= rs1.getString("USE_ORDER_NUM");
											useYn		= rs1.getString("USE_YN");
										}
									}

									if (useYn.equals("Y")) {
										useYnTxt	= "사용";
									} else if (useYn.equals("C")) {
										useYnTxt	= "사용중지";
									} else if (useYn.equals("N")) {
										useYnTxt	= "미사용";
									}

									if (useYn.equals("Y")) {
										query1		= "SELECT G.GROUP_NAME, O.PAY_PRICE, O.COUPON_PRICE";
										query1		+= " FROM ESL_ORDER O, ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G";
										query1		+= " WHERE O.ORDER_NUM = OG.ORDER_NUM AND OG.GROUP_ID = G.ID";
										query1		+= " AND OG.ORDER_NUM = '"+ useOrderNum +"'";
										query1		+= " AND O.MEMBER_ID = '"+ memberId +"'";
										
										try {
											rs1		= stmt1.executeQuery(query1);
										} catch(Exception e) {
											out.println(e+"=>"+query);
											if(true)return;
										}

										i		= 0;
										while (rs1.next()) {
											if (i > 0) {
												groupName	= rs1.getString("GROUP_NAME")+" 외 "+ i +"건";
											} else {
												groupName	= rs1.getString("GROUP_NAME");
											}
											payPrice		= rs1.getInt("PAY_PRICE");
											salePrice		= rs1.getInt("COUPON_PRICE");
											i++;
										}
									} else {
										memberId	= "";
										memberName	= "";
										groupName	= "";
										payPrice	= 0;
										salePrice	= 0;
										useDate		= "";
									}
							%>
							<tr>
								<td>
									<%if (useYn.equals("N")) {%>
									<input type="checkbox" class="selectable" value="<%=couponNum%>" />
									<%}%>
								</td>
								<td><%=curNum%></td>
								<td><%=couponNum%></td>
								<td><%=memberName+"("+memberId+")"%></td>
								<td><%=groupName%></td>
								<td><%=nf.format(payPrice)%></td>
								<td><%=nf.format(salePrice)%></td>
								<td><%=useYnTxt%></td>
								<td><%=useDate%></td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="9">등록된 쿠폰이 없습니다.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<p class="left_btn">
						<a href="javascript:;" onclick="cancelCoupon();" class="function_btn"><span>사용중지</span></a>
						<!--a href="javascript:;" onclick="excelDown();" class="function_btn"><span>엑셀다운로드</span></a-->
					</p>
					<p class="right_btn">
						<a href="coupon_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
					</p>
				</div>
				<%@ include file="../include/inc-paging-view.jsp"%>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
<script type="text/javascript">
$(document).ready(function() {
	$("#selectall").click(selectAll);
});

function selectAll() {
    var checked = $("#selectall").attr("checked");

    $(".selectable").each(function(){
       var subChecked = $(this).attr("checked");
       if (subChecked != checked)
          $(this).click();
    });
}

function cancelCoupon() {
	var chk_del = $(".selectable:checked");

	if(chk_del.length < 1) {
		alert("사용중지할 쿠폰번호를 선택하세요!");
	} else {
		if (confirm("정말로 사용중지 하시겠습니까?")) {
			var del_arr = new Array();
			var i = 0;
			$(".selectable:checked").each(function() {
				del_arr[i] = $(this).val();
				i++;
			});
			var del_ids_val = del_arr.join();
			$.post("coupon_ajax.jsp", {
				mode: 'cancel', 
				del_ids: del_ids_val
			},
			function(data) {
				$(data).find('result').each(function() {
					if ($(this).text() == 'success') {
						alert("사용중지가 완료되었습니다.");
						document.location.reload();
					} else {
						$(data).find('error').each(function() {
							alert($(this).text());
						});
					}
				});
			}, "xml");
		}
	}
}

function excelDown(){
	<%if(intTotalCnt==0){%>alert("검색된 회원이 없습니다.");return;<%}%>
	var f	= document.frm_search;
	f.target	= "ifrmHidden";
	f.action	= "coupon_view_excel.jsp";
	//f.encoding="application/x-www-form-urlencoded";
	f.submit();	
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>