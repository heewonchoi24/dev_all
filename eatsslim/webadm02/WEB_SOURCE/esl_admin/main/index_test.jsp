<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
String query		= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
String table		= "";
NumberFormat nf		= NumberFormat.getNumberInstance();
%>

	<script type="text/javascript" src="../js/main.js"></script>
	<%//@ include file="../include/inc-cal-script.jsp" %>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:1,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
	})
	//]]>
	</script>
	<script type="text/javascript">
	function refreshData(){
		document.getElementById("oFrame").src="main_state.jsp";
	}
	</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="main_container">
		<!-- location -->
		<div id="main_location">
			<strong><%=eslAdminName%></strong> 님 반갑습니다.
			<a href="../login_db.jsp?mode=<%=URLEncoder.encode("logout")%>" class="btn_logout"><img src="../images/main/btn_logout.png" alt="로그아웃" /></a>
			<a href="<%=shopUrl%>" target="_new"><img src="../images/main/btn_homepage.gif" alt="" /></a>
		</div>
		<!-- //location -->
		<!-- contents -->
		<div id="main_contents">
			<div class="group">
				<div id="main_box1">
					<div class="main_title">
						<div class="bgright_tit"></div>
						<h2>요약통계 <a href="javascript:refreshData()"><img src="../images/main/ico_refresh.png" alt="새로고침" /></a></h2>
					</div>
					<div class="main_con">
						<iframe src="main_state.jsp" id="oFrame" name="oFrame" width="100%" height="258px" frameborder="0" marginwidth="0" marginheight="0" vspace="0" hspace="0" scrolling="yes" ></iframe>						
					</div>
				</div>
				<div id="main_box2">
					<div class="main_title">
						<div class="bgright_tit"></div>
						<h2>최근 주문내역 <a href="../order/order_list.jsp"><img src="../images/main/ico_more.png" alt="더보기" /></a></h2>
					</div>
					<div class="main_con">
					<table class="main_tbl01" border="1" cellspacing="0">
							<colgroup>
								<col width="20%" />
								<col width="*" />
								<col width="22%" />
								<col width="15%" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">주문번호</th>
									<th scope="col">주문상품</th>
									<th scope="col">날짜</th>
									<th scope="col" class="align_right">결제금액</th>
								</tr>
							</thead>
							<tbody>
								<%//==========주문관리
								cnt			= 0;
								i			= 0;
								table		= "ESL_ORDER";
								String orderNum		= "";
								String payDate		= "";
								String productName	= "";

								query		= "SELECT COUNT(ID) FROM "+ table;
								query		+= " WHERE DATE_FORMAT(PAY_DATE, '%Y%m%d') = DATE_FORMAT(now(), '%Y%m%d')";
								query		+= " AND (ORDER_STATE > 0 AND ORDER_STATE < 90)";
								query		+= " AND ORDER_NUM NOT IN (SELECT ORDER_NUM FROM ESL_ORDER WHERE ORDER_STATE = '00' AND PAY_TYPE = '10')";
								try {
									rs = stmt.executeQuery(query);
								} catch(Exception e) {
									out.println(e+"=>"+query);
									if(true)return;
								}
								if (rs.next()) {
									cnt			= rs.getInt(1);
								}

								query		= "SELECT ORDER_NUM, DATE_FORMAT(PAY_DATE, '%Y-%m-%d %H:%m') PAY_DATE, PAY_PRICE";
								query		+= " FROM "+ table +" WHERE (ORDER_STATE > 0 AND ORDER_STATE < 90)";
								query		+= " AND ORDER_NUM NOT IN (SELECT ORDER_NUM FROM ESL_ORDER WHERE ORDER_STATE = '00' AND PAY_TYPE = '10')";
								query		+= " ORDER BY ORDER_NUM DESC";
								query		+= " LIMIT 0, 7";
								try {
									rs = stmt.executeQuery(query);
								} catch(Exception e) {
									out.println(e+"=>"+query);
									if(true)return;
								}
								while (rs.next()) {
									orderNum	= rs.getString("ORDER_NUM");
									payDate		= (rs.getString("PAY_DATE") == null)? "" : rs.getString("PAY_DATE");
									query1		= "SELECT ";
									query1		+= "		GROUP_NAME, GUBUN1, GUBUN2, DEVL_TYPE, ORDER_CNT, PRICE, BUY_BAG_YN,";
									query1		+= "		DEVL_DAY, DEVL_WEEK";
									query1		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O";
									query1		+= " WHERE G.ID = OG.GROUP_ID";
									query1		+= " AND OG.ORDER_NUM = O.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
									query1		+= " ORDER BY O.ID DESC";
									try {
										rs1 = stmt1.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									int rowNum		= 0;
									while (rs1.next()) {
										if (rowNum > 0) {
											productName	= rs1.getString("GROUP_NAME")+" 외 "+ i +"건";
										} else {
											productName	= rs1.getString("GROUP_NAME");
										}
										rowNum++;
									}
								%>
								<tr>
									<td><a href="javascript:;" onclick="popup('../order/order_view.jsp?ordno=<%=orderNum%>',900,720,'order_view');"><%=orderNum%></a></td>
									<td><%=productName%></td>
									<td><%=payDate%></td>
									<td class="align_right"><%=nf.format(rs.getInt("PAY_PRICE"))%>원</td>
								</tr>
								<%
									i++;
								}
								for (int ii=(i+1);ii<=7;ii++) {
									out.println("<tr><td colspan='3'>&nbsp;</td></tr>");
								}
								%>
							</tbody>
							<tfoot>
								<th colspan="4">금일 등록된 주문 : <strong><%=cnt%></strong>건</th>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
			<div class="group" style="margin-top:12px;">
				<div id="main_box3">
					<div class="main_title">
						<div class="bgright_tit"></div>
						<h2>1:1 상담문의 <a href="../counsel/counsel_list.jsp"><img src="../images/main/ico_more.png" alt="더보기" /></a></h2>
					</div>
					<div class="main_con">
						<ul class="main_list01">
							<%//==========1:1 상담문의
							cnt			= 0;
							i			= 0;
							table		= "ESL_COUNSEL";
							String state = "";

							query		= "SELECT ID, TITLE, DATE_FORMAT(INST_DATE, '%Y.%m.%d') INST_DATE, ANSWER_YN";
							query		+= " FROM "+ table;
							query		+= " ORDER BY ID DESC LIMIT 0, 5";
							try {
								rs = stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}
							while (rs.next()) {
								if(rs.getString("ANSWER_YN").equals("N")){
									state="<img src='../images/main/txt_uncomplete.gif' alt='미처리' />";
									cnt++;
								}else{
									state="<img src='../images/main/txt_complete.gif' alt='처리' />";
								}								
							%>
							<li>
								<a href="../counsel/counsel_edit.jsp?id=<%=rs.getString("ID")%>"><%=ut.cutString(36, rs.getString("TITLE"), "..")%></a>
								<%=state%>
								<span><%=rs.getString("INST_DATE")%></span>
							</li>
							<%
								i++;
							}
							for (int ii=(i+1);ii<=5;ii++) {
								out.println("<li><a href='#'>&nbsp;</a><span>&nbsp;</span></li>");
							}
							%>						  			
						</ul>
						<p class="main_txt01">미처리 건수 : <strong><%=cnt%></strong>건</p>
					</div>
				</div>
				<div id="main_box4">
					<div class="main_title">
						<div class="bgright_tit"></div>
						<h2>다이어트체험후기 <a href="../board/po_list.jsp"><img src="../images/main/ico_more.png" alt="더보기" /></a></h2>
					</div>
					<div class="main_con">
						<ul class="main_list01">
							<%//==========다이어트체험후기
							cnt			= 0;
							i			= 0;
							table		= "ESL_PO";	

							query		= "SELECT COUNT(ID) FROM "+ table;
							query		+= " WHERE DATE_FORMAT(INST_DATE, '%Y%m%d') = DATE_FORMAT(now(), '%Y%m%d')";
							try {
								rs = stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}
							if (rs.next()) {
								cnt			= rs.getInt(1);
							}

							query		= "SELECT ID, TITLE, DATE_FORMAT(INST_DATE, '%Y.%m.%d') INST_DATE";
							query		+= " FROM "+ table;
							query		+= " ORDER BY ID DESC LIMIT 0, 5";
							try {
								rs = stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}
							while(rs.next()){
							%>
								<li>
									<a href="../board/po_edit.jsp?id=<%=rs.getString("ID")%>"><%=ut.cutString(36, rs.getString("TITLE"), "..")%></a>
									<span><%=rs.getString("INST_DATE")%></span>
								</li>
							<%
								i++;
							}
							for(int ii=(i+1);ii<=5;ii++){
								out.println("<li><a href='#'>&nbsp;</a><span>&nbsp;</span></li>");
							}
							%>
						</ul>
						<p class="main_txt01">금일 등록된 다이어트체험후기 : <strong><%=cnt%></strong>건</p>
					</div>
				</div>
				<div id="main_box5">
					<div class="main_title">
						<div class="bgright_tit"></div>
						<h2>이벤트 댓글관리 <a href="../board/comment_list.jsp"><img src="../images/main/ico_more.png" alt="더보기" /></a></h2>
					</div>
					<div class="main_con">
						<ul class="main_list01">
							<%//==========이벤트 댓글관리 
							cnt			= 0;
							i			= 0;
							table		= "ESL_EVENT_REPLY";

							query		= "SELECT COUNT(ID) FROM "+ table;
							query		+= " WHERE DATE_FORMAT(INST_DATE, '%Y%m%d') = DATE_FORMAT(now(), '%Y%m%d')";
							try {
								rs = stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}
							if (rs.next()) {
								cnt			= rs.getInt(1);
							}

							query		= "SELECT ID, CONTENT, DATE_FORMAT(INST_DATE, '%Y.%m.%d') INST_DATE";
							query		+= " FROM "+ table;
							query		+= " ORDER BY IDX DESC LIMIT 0, 5";
							try {
								rs = stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}
							while(rs.next()){
							%>
								<li>
									<a href="../promotion/event_edit.jsp?id=<%=rs.getString("ID")%>"><%=ut.cutString(36, rs.getString("CONTENT"), "..")%></a>
									<span><%=rs.getString("INST_DATE")%></span>
								</li>
							<%
								i++;
							}
							for(int ii=(i+1);ii<=5;ii++){
								out.println("<li><a href='#'>&nbsp;</a><span>&nbsp;</span></li>");
							}
							%>
						</ul>
						<p class="main_txt01">금일 등록된 게시물 : <strong><%=cnt%></strong>건</p>
					</div>
				</div>
			</div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>