<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>



<%
String table		= "ESL_PO";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
int pressId			= 0;
String title		= "";
String listImg		= "";
String pressUrl		= "";
String viewLink		= "";
String imgUrl		= "";
String instDate		= "";
int divNum			= 0;
String divClass		= "";
String content = "";
String p_gubun = "";

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




p_gubun =  (request.getParameter("p_gubun") == null)? "" : request.getParameter("p_gubun");

if(p_gubun.equals("1")){
	where += " and press_url='1' ";
	param		+= "&amp;p_gubun=" + p_gubun;
}else if(p_gubun.equals("2")){
	where += " and press_url='2' ";
	param		+= "&amp;p_gubun=" + p_gubun;
}else if(p_gubun.equals("3")){
	where += " and press_url='3' ";
	param		+= "&amp;p_gubun=" + p_gubun;
}

//총분류수
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE 1=1"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun_all_cnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


//'다이어트 먹거리 식사 수 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE PRESS_URL='1'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun1_cnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


//다이어트 생활습관 프로그램 수 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE PRESS_URL='2'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun2_cnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


//다이어트 속설과 과학 수 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE PRESS_URL='3'"; //out.print(query1); if(true)return;
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






query		= "SELECT ID, TITLE, LIST_IMG, PRESS_URL, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE,CONTENT,HIT_CNT,INST_ID,(select count(id) from ESL_PO_REPLY where ID="+table+".ID) as re_cnt";
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
			<h1>
				다이어트 체험후기
			</h1>
			<div class="pageDepth">
				HOME > GO! 다이어트 > <strong>다이어트 체험후기</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
            <div class="row">
                <div class="one last  col">
                    <div class="graytitbox">
                        <h4 class="floatleft"><%=month%>월의 베스트 체험후기</h4>
                        <div class="button dark small floatright">
						
						<%	if (eslMemberId == null || eslMemberId.equals("")) { %>

							<a href="#" onclick="alert('로그인을 해주세요');">체험후기 작성</a>
						<%	}else{	%>
							<a href="#" onclick="window.open('/colums/postWritePopup.jsp','PostWrite','width=1024,height=600,scrollbars=1')">체험후기 작성</a>
						<%	} %>


						
						
						</div>
                    </div>
                </div>
            </div>
            <div class="row">
			    <div class="one last  col">
				   <div class="fluidbox best">
				      

						<%
							int jj = 1;
							while (rs.next()) {
								
								pressId		= rs.getInt("ID");
								title		= rs.getString("TITLE");
								listImg		= rs.getString("LIST_IMG");
								content			= rs.getString("CONTENT");
								hitCnt		= rs.getInt("HIT_CNT");
								content = ut.convertHtmlTags(content);

								if (!listImg.equals("")) {
									imgUrl		= webUploadDir +"board/"+ listImg;
								} else {
									imgUrl		= "";
								}
								pressUrl	= rs.getString("PRESS_URL");
								
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
                              <a href="/colums/postScriptView.jsp?id=<%=pressId + param%>">
                              	  <% if(imgUrl !=""){ %>
									   <img alt="잇슬림컬럼" class="thumbnail" src="<%=imgUrl%>" onerror="this.width=0" >
								   <% } %>
                              </a>
                              <p class="cate">[<%
									if(pressUrl.equals("1")){
										out.print("식사다이어트");
									}else if(pressUrl.equals("2")){
										out.print("프로그램다이어트");
									}else if(pressUrl.equals("3")){
										out.print("타입별다이어트");
									}
								%>]</p>
                              <a href="/colums/postScriptView.jsp?id=<%=pressId + param%>">
                              <h4><%=ut.cutString(40, title, "..")%></h4>
                              <p><%=ut.cutString(250, content, "..")%></p>
                              </a>
                              <ul class="meta-wrap">
                                       <li><span class="user"></span><%= rs.getString("INST_ID")%></li>
                                       <li><span class="date"></span><%=instDate.substring(2,10)%></li>
                                       <li><span class="account"></span><%=hitCnt%></li>
                                       <li><span class="comment"></span><%=rs.getInt("re_cnt")%></li>
                              </ul>
                         </div>
                     </div>

     						<%
							
								jj++;
							}
			
						%>
                     <!-- <div class="box">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/postscript_sample01.jpg">
                              </a>
                              <p class="cate">[다이어트 속설과 과학]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>먼 길 다녀온 당신, 건강부터 챙겨라!</h4>
                              <p>오매불망 기다려온 꿀같은 여름휴가! 도심을 떠나 계곡으로, 바다로 향해 달려보지만
                              쉬려고 떠난 여행에서 오히려 병을 얻어올 수 있다는 사실!
                              오랜시간 같은 자세로 앉아 있거나 장거리 운전으로 인해 당신의 관절들이 외치는 비명에 귀기울여보자!</p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="user"></span>eatsslim</li>
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>


                     <div class="box last">
                         <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/postscript_sample01.jpg">
                              </a>
                              <p class="cate">[생활습관]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>달콤달콤 셀프 아이스바</h4>
                              <p>이렇게 쉬웠어? 집에서 쉽게 즐기는 셀프 아이스바 만들기. </p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="user"></span>food1004</li>
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div> -->



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


                            <li <% if(p_gubun.equals("")){ %> class="current" <% } %>><a href="postScript.jsp">ALL(<%=gubun_all_cnt%>)</a></li>
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

						query		= "SELECT ID, TITLE, LIST_IMG, PRESS_URL, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE,CONTENT,HIT_CNT,INST_ID,(select count(id) from ESL_PO_REPLY where ID="+table+".ID) as re_cnt";
						query		+= " FROM "+ table + where;
						query		+= " ORDER BY INST_DATE DESC";
						query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;


						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();


						if (intTotalCnt > 0) {
							int i		= 0;
							while (rs.next()) {
								pressId		= rs.getInt("ID");
								title		= rs.getString("TITLE");
								listImg		= rs.getString("LIST_IMG");
								content			= rs.getString("CONTENT");
								hitCnt		= rs.getInt("HIT_CNT");
								content = ut.convertHtmlTags(content);

								if (!listImg.equals("")) {
									imgUrl		= webUploadDir +"board/"+ listImg;
								} else {
									imgUrl		= "";
								}
								pressUrl	= rs.getString("PRESS_URL");
								
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
                                  <a href="/colums/postScriptView.jsp?id=<%=pressId + param%>">
                                   
								   <% if(imgUrl !=""){ %>
									   <img alt="잇슬림컬럼" class="thumbnail" src="<%=imgUrl%>" onerror="this.width=0" >
								   <% }else{ %>
									   <img alt="잇슬림컬럼" class="thumbnail" src="/images/post_script_default.jpg" onerror="this.width=0" >
								   <% } %>
                                   </a>
                                   <p class="cate">[
								<%
									if(pressUrl.equals("1")){
										out.print("식사다이어트");
									}else if(pressUrl.equals("2")){
										out.print("프로그램다이어트");
									}else if(pressUrl.equals("3")){
										out.print("타입별다이어트");
									}
								%>							  
							  ]</p>
                                  <a href="/colums/postScriptView.jsp?id=<%=pressId + param%>">
                                   <h4><%=title%></h4>
                                   <p><%=ut.cutString(260, content, "..")%></p>
                                   </a>
                                   <ul class="meta-wrap">
                                       <li><span class="user"></span><%= rs.getString("INST_ID")%></li>
                                       <li><span class="date"></span><%=instDate.substring(2,10)%></li>
                                       <li><span class="account"></span><%=hitCnt%></li>
                                       <li><span class="comment"></span><%=rs.getInt("re_cnt")%></li>
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

							<a href="#" onclick="alert('로그인을 해주세요');">체험후기 작성</a>
						<%	}else{	%>
							<a href="#" onclick="window.open('/colums/postWritePopup.jsp','PostWrite','width=1024,height=600,scrollbars=1')">체험후기 작성</a>
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