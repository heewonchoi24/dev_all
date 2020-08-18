<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String table		= "ESL_CHOI_POSTSCRIPT";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
int postId			= 0;
String title		= "";
String listImg		= "";
String category		= "";
String viewLink		= "";
String imgUrl		= "";
String instDate		= "";
int divNum			= 0;
String divClass		= "";
String content		= "";
String p_gubun		= ut.inject(request.getParameter("p_gubun"));

///////////////////////////
int pgsize		= 12; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;
int hitCnt = 0;

int gubun_all_cnt = 0;
int gubun1_cnt = 0;
int gubun2_cnt = 0;
int gubun3_cnt = 0;
int gubun4_cnt = 0;

where			= " WHERE 1=1";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

if (p_gubun != null && p_gubun.length() > 0) {
	param		+= "&amp;p_gubun="+ p_gubun;
	where		+= " AND CATEGORY = '"+ p_gubun +"'";
}

//총분류수
query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun_all_cnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


//식사다이어트 수 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE CATEGORY='1'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun1_cnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


//프로그램다이어트 수 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE CATEGORY='2'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun2_cnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


//타입별다이어트 수 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE CATEGORY='3'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun3_cnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

DecimalFormat df = new DecimalFormat("00");
Calendar calendar = Calendar.getInstance();

String year = Integer.toString(calendar.get(Calendar.YEAR)); //년도를 구한다
String month = df.format(calendar.get(Calendar.MONTH) + 1); //달을 구한다


query		= "SELECT ID, TITLE, LIST_IMG, CATEGORY, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE, CONTENT, HIT_CNT, INST_ID";
query		+= " ,(SELECT COUNT(ID) FROM "+ table +"_COMMENT WHERE CP_ID = "+ table +".ID) AS RE_CNT";
query		+= " FROM "+ table + " where best_set='"+year+"-"+month+"'";
query		+= " ORDER BY ID DESC";
query		+= " LIMIT 3";

pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>최과장이 쏘는 잇슬림 체험후기</h1>
			<div class="pageDepth">
				HOME &gt 이벤트 &gt <strong>최과장이 쏘는 잇슬림 체험후기</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
            <div class="row">
                <div class="one last  col">
                    <div class="graytitbox">
                        <h4 class="floatleft">베스트 체험후기</h4>
                        <div class="button dark small floatright">						
						<%	if (eslMemberId == null || eslMemberId.equals("")) { %>
							<a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">체험후기 작성</a>
						<%	} else {	%>
							<a href="javascript:;" onclick="window.open('/event/choiPostWrite.jsp','PostWrite','width=1024,height=600,scrollbars=1')">체험후기 작성</a>
						<%	} %>
						</div>
                    </div>
                </div>
            </div>
            <div class="row">
			    <div class="one last col">
				   <div class="fluidbox best">
						<%
							int jj = 1;
							while (rs.next()) {								
								postId		= rs.getInt("ID");
								title		= rs.getString("TITLE");
								listImg		= rs.getString("LIST_IMG");
								content		= rs.getString("CONTENT");
								hitCnt		= rs.getInt("HIT_CNT");
								content		= ut.delHtmlTag(content);

								if (!listImg.equals("")) {
									imgUrl		= webUploadDir +"board/"+ listImg;
								} else {
									imgUrl		= "";
								}
								category	= rs.getString("CATEGORY");
								
								instDate	= rs.getString("WDATE");
								divNum		= jj % 3;

								
								if (divNum == 0) {
									divClass	= " last";
								} else if (divNum == 3) {
									divClass	= "";
								}
						%>
					<div class="box<%=divClass%>">
                        <div class="article">
                              <a href="/event/choiPostView.jsp?id=<%=postId + param%>">
                              	  <% if(imgUrl !=""){ %>
									   <img alt="잇슬림컬럼" class="thumbnail" src="<%=imgUrl%>" onerror="this.width=0" >
								   <% } %>
                              </a>
                              <p class="cate">[ <%=ut.getPostType(category)%> ]</p>
                              <a href="/event/choiPostView.jsp?id=<%=postId + param%>">
                              <h4><%=ut.cutString(40, title, "..")%></h4>
                              <p><%=ut.cutString(250, content, "..")%></p>
                              </a>
                              <ul class="meta-wrap">
                                       <li><span class="user"></span><%= rs.getString("INST_ID")%></li>
                                       <li><span class="date"></span><%=instDate.substring(2,10)%></li>
                                       <li><span class="account"></span><%=hitCnt%></li>
                                       <li><span class="comment"></span><%=rs.getInt("RE_CNT")%></li>
                              </ul>
                         </div>
                     </div>

     						<%
							
								jj++;
							}
			
						%>
                     <div class="clear"></div>									
				   </div>
                   <!-- End Fluidbox -->
				</div>
			</div>
			<!-- End Row -->
            <div class="row">
                <div class="one last  col">
                    <div class="graytitbox">
                        <ul class="filter floatleft" style="margin-top:5px;">
                            <li <% if(p_gubun.equals("")){ %> class="current" <% } %>><a href="choiPost.jsp">ALL(<%=gubun_all_cnt%>)</a></li>
                            <li <% if(p_gubun.equals("1")){ %> class="current" <% } %>><a href="?p_gubun=1" >식사다이어트(<%=gubun1_cnt%>)</a></li>
                            <li <% if(p_gubun.equals("2")){ %> class="current" <% } %>><a href="?p_gubun=2" >프로그램다이어트(<%=gubun2_cnt%>)</a></li>
                            <li <% if(p_gubun.equals("3")){ %> class="current" <% } %>><a href="?p_gubun=3" >타입별다이어트(<%=gubun3_cnt%>)</a></li>
                        </ul>
						<form name="frm_search" method="get" action="<%=request.getRequestURI()%>">

						<div class="searchBar floatright">
							<label>
								<select name="field" id="field" style="width:70px;" onchange="this.form.keyword.focus()">
									<option value="TITLE"<%if(field.equals("TITLE")){out.print(" selected=\"selected\"");}%>>제목</option>
									<option value="CONTENT"<%if(field.equals("CONTENT")){out.print(" selected=\"selected\"");}%>>내용</option>
								</select>
							</label>
							<label>
							<input type="text" name="keyword" maxlength="30" value="<%=keyword%>" onfocus="this.select()" />
							</label>
							<label>
							<input type="submit" class="button dark small" name="button" value="검색">
							</label>
                        </div>
                        </form>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <!-- End Row -->
            <div class="row">
			    <div class="one last  col">
				   <div class="post-wrapper">
						<%
						totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // 총 페이지 수
						endpage		= startpage + pagelist - 1;
						if (endpage > totalPage) {
							endpage = totalPage;
						}
						curNum		= intTotalCnt-pgsize*(iPage-1);
						param		+= "&amp;pgsize=" + pgsize;

						query		= "SELECT ID, TITLE, LIST_IMG, CATEGORY, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE, CONTENT";
						query		+= " , HIT_CNT, INST_ID,(SELECT COUNT(ID) FROM "+ table +"_COMMENT WHERE CP_ID = "+ table +".ID) AS RE_CNT";
						query		+= " FROM "+ table + where;
						query		+= " ORDER BY INST_DATE DESC";
						query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;

						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();

						if (intTotalCnt > 0) {
							int i		= 0;
							while (rs.next()) {
								postId		= rs.getInt("ID");
								title		= rs.getString("TITLE");
								listImg		= rs.getString("LIST_IMG");
								content		= rs.getString("CONTENT");
								hitCnt		= rs.getInt("HIT_CNT");
								content		= ut.delHtmlTag(content);

								if (!listImg.equals("")) {
									imgUrl		= webUploadDir +"board/"+ listImg;
								} else {
									imgUrl		= "";
								}
								category	= rs.getString("CATEGORY");
								
								instDate	= rs.getString("WDATE");
								divNum		= i % 4;
								if (divNum == 0) {
									divClass	= " first";
								} else if (divNum == 3) {
									divClass	= " last";
								} else {
									divClass	= "";
								}
						%>
                        <div class="box">
                             <div class="article">
                                  <a href="/event/choiPostView.jsp?id=<%=postId + param%>">                                   
								   <% if(imgUrl !=""){ %>
									   <img alt="잇슬림컬럼" class="thumbnail" src="<%=imgUrl%>" onerror="this.width=0" >
								   <% }else{ %>
									   <img alt="잇슬림컬럼" class="thumbnail" src="/images/post_script_default.jpg" onerror="this.width=0" >
								   <% } %>
                                   </a>
                                   <p class="cate">[ <%=ut.getPostType(category)%> ]</p>
                                  <a href="/event/choiPostView.jsp?id=<%=postId + param%>">
                                   <h4><%=title%></h4>
                                   <p><%=ut.cutString(260, content, "..")%></p>
                                   </a>
                                   <ul class="meta-wrap">
                                       <li><span class="user"></span><%=rs.getString("INST_ID")%></li>
                                       <li><span class="date"></span><%=instDate.substring(2,10)%></li>
                                       <li><span class="account"></span><%=hitCnt%></li>
                                       <li><span class="comment"></span><%=rs.getInt("RE_CNT")%></li>
                                   </ul>
                              </div>
                          </div>                
     						<%
								curNum--;
								i++;
							}
						}
						%>
                        <!-- End box -->
                   </div>
                </div>   
                <div class="button small dark floatright">				
						<%	if (eslMemberId == null || eslMemberId.equals("")) { %>
							<a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">체험후기 작성</a>
						<%	}else{	%>
							<a href="javascript:;" onclick="window.open('/event/choiPostWrite.jsp','PostWrite','width=1024,height=600,scrollbars=1')">체험후기 작성</a>
						<%	} %>				
				</div>
                <div class="divider"></div>
			</div>
            <!-- End Row -->
			<div class="readmore">
					<%@ include file="../common/include/inc-paging.jsp"%>
			</div>
            <!-- End Row -->
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear">
		</div>
	</div>
	<!-- End container -->
	<div id="footer">		
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div> <!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>