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











totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // 총 페이지 수
endpage		= startpage + pagelist - 1;
if (endpage > totalPage) {
	endpage = totalPage;
}
curNum		= intTotalCnt-pgsize*(iPage-1);
param		+= "&amp;pgsize=" + pgsize;

query		= "SELECT ID, TITLE, LIST_IMG, PRESS_URL, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE,CONTENT,HIT_CNT,(select count(id) from ESL_DC_REPLY where ID="+table+".ID) as re_cnt";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;


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
                        <h4 class="floatleft">8월의 베스트 체험후기</h4>
                        <div class="button dark small floatright"><a href="/colums/postWrite.jsp">체험후기 작성</a></div>
                    </div>
                </div>
            </div>
            <div class="row">
			    <div class="one last  col">
				   <div class="fluidbox best">
				      <div class="box">
                        <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="잇슬림컬럼" class="thumbnail" src="/images/postscript_sample01.jpg">
                              </a>
                              <p class="cate">[생활습관]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>헬스트렌드 폴댄스</h4>
                              <p>얼마전 인기걸그룹 "에프터스쿨"이 선보인 안무가 화제입니다.
                              별도의 장치 없이 맨몸으로 기둥에 매달려 묘기에 가까운 퍼포먼스를 선보였기 
                              때문인데요. 안무로 한층 탄탄해진 멤버들의 몸매도 시선을 잡았습니다.</p>
                              </a>
                              <ul class="meta-wrap">
                                  <li><span class="user"></span>lucky</li>
                                  <li><span class="date"></span>13.08.29</li>
                                  <li><span class="account"></span>3,105</li>
                                  <li><span class="comment"></span>121</li>
                              </ul>
                         </div>
                     </div>
                     <div class="box">
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
                     </div>
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


                            <li <% if(p_gubun.equals("")){ %> class="current" <% } %>><a href="dietColum.jsp">ALL(<%=gubun_all_cnt%>)</a></li>
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
                        <div class="box">
                             <div class="article">
                                  <a href="/colums/dietColumView.jsp">
                                   <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-1.jpg">
                                   </a>
                                   <p class="cate">[생활습관]</p>
                                   <a href="/colums/dietColumView.jsp">
                                   <h4>헬스트렌드 폴댄스</h4>
                                   <p>얼마전 인기걸그룹 "에프터스쿨"이 선보인 안무가 화제입니다.
                                   별도의 장치 없이 맨몸으로 기둥에 매달려 묘기에 가까운 퍼포먼스를 선보였기 
                                   때문인데요. 안무로 한층 탄탄해진 멤버들의 몸매도 시선을 잡았습니다.</p>
                                   </a>
                                   <ul class="meta-wrap">
                                       <li><span class="user"></span>food1004</li>
                                       <li><span class="date"></span>13.08.29</li>
                                       <li><span class="account"></span>3,105</li>
                                       <li><span class="comment"></span>121</li>
                                   </ul>
                              </div>
                          </div>
                        <!-- End box -->
                        <div class="box">
                             <div class="article">
                                  <a href="/colums/dietColumView.jsp">
                                   <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-1.jpg">
                                   </a>
                                   <p class="cate">[생활습관]</p>
                                   <a href="/colums/dietColumView.jsp">
                                   <h4>헬스트렌드 폴댄스</h4>
                                   <p>얼마전 인기걸그룹 "에프터스쿨"이 선보인 안무가 화제입니다.
                                   별도의 장치 없이 맨몸으로 기둥에 매달려 묘기에 가까운 퍼포먼스를 선보였기 
                                   때문인데요. 안무로 한층 탄탄해진 멤버들의 몸매도 시선을 잡았습니다.</p>
                                   </a>
                                   <ul class="meta-wrap">
                                       <li><span class="user"></span>lucky</li>
                                       <li><span class="date"></span>13.08.29</li>
                                       <li><span class="account"></span>3,105</li>
                                       <li><span class="comment"></span>121</li>
                                   </ul>
                              </div>
                          </div>
                        <!-- End box -->
                        <div class="box">
                             <div class="article">
                                  <a href="/colums/dietColumView.jsp">
                                   <img alt="잇슬림컬럼" class="thumbnail" src="/images/Jaipur-1.jpg">
                                   </a>
                                   <p class="cate">[생활습관]</p>
                                   <a href="/colums/dietColumView.jsp">
                                   <h4>헬스트렌드 폴댄스</h4>
                                   <p>얼마전 인기걸그룹 "에프터스쿨"이 선보인 안무가 화제입니다.
                                   별도의 장치 없이 맨몸으로 기둥에 매달려 묘기에 가까운 퍼포먼스를 선보였기 
                                   때문인데요. 안무로 한층 탄탄해진 멤버들의 몸매도 시선을 잡았습니다.</p>
                                   </a>
                                   <ul class="meta-wrap">
                                       <li><span class="user"></span>eatsslim</li>
                                       <li><span class="date"></span>13.08.29</li>
                                       <li><span class="account"></span>3,105</li>
                                       <li><span class="comment"></span>121</li>
                                   </ul>
                              </div>
                          </div>
                        <!-- End box -->
                   </div>
                </div>   
                <div class="button small dark floatright"><a href="/colums/postWrite.jsp">체험후기 작성</a></div>
                <div class="divider"></div>
			</div>
            <!-- End Row -->
            <div class="row">
			    <div class="sixteen last col center;">
				<div class="pageNavi">
					  <a class="latelypostslink" href="#"><<</a>
					  <a class="previouspostslink" href="#"><</a>
					  <span class="current">1</span>
					  <a href="#">2</a>
					  <a href="#">3</a>
					  <a href="#">4</a>
					  <a href="#">5</a>
					  <a class="firstpostslink" href="#">></a>
					  <a class="nextpostslink" href="#">>></a>
					</div>
				</div>	
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