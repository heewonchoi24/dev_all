<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>

<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_DC";
int noticeId		= 0;
String query		= "";
String topYn		= "";
String title		= "";
String content		= "";
String instDate		= "";
String listImg		= "";
String param		= "";
String keyword		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String schCate		= ut.inject(request.getParameter("sch_cate"));
String field		= ut.inject(request.getParameter("field"));
String p_gubun		= ut.inject(request.getParameter("p_gubun"));
String pressUrl		= "";
int HIT_CNT = 0;

String login_stat_str = "";

int reply_count = 0;
int reply_id = 0;
int reply_idx = 0;

String m_id = "";
String m_name = "";
String reply_content = "";
String reply_content2 = "";
String reply_date = "";
String reply_date2 = "";
String reply_mode = "write";

String imgUrl = "";

if (!ut.isNaN(iPage)) {
	iPage = "";
}
if (!ut.isNaN(pgsize)) {
	pgsize = "12";
}

if (request.getParameter("reply_idx") != null && request.getParameter("reply_idx").length() > 0) {
	reply_idx = Integer.parseInt(request.getParameter("reply_idx"));
}

if (request.getParameter("field") != null) {
	field					= ut.inject2(request.getParameter("field"));
}
if (request.getParameter("keyword") != null) {
	keyword					= ut.inject2(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
if (request.getParameter("p_gubun") != null) {
	p_gubun					= ut.inject2(request.getParameter("p_gubun"));
}
param		= "&amp;page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword +"&p_gubun="+p_gubun;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	noticeId	= Integer.parseInt(request.getParameter("id"));


	//댓글수
	query		= "SELECT COUNT(ID) FROM ESL_DC_REPLY where ID="+noticeId+"";

	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();
	if (rs.next()) {
		reply_count = rs.getInt(1); //총 레코드 수		
	}
	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}



	query		= "UPDATE "+ table +" SET HIT_CNT = HIT_CNT + 1 WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, noticeId);
	pstmt.executeUpdate();
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

	query		= "SELECT TITLE, CONTENT, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE, PRESS_URL,HIT_CNT";
	query		+= " FROM "+ table;
	query		+= " WHERE ID = ?";


	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, noticeId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {

		title			= rs.getString("TITLE");
		content			= rs.getString("CONTENT");
		instDate		= rs.getString("WDATE");
		pressUrl		= rs.getString("PRESS_URL");
		HIT_CNT		= rs.getInt("HIT_CNT");
	}

	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
} else {
	ut.jsBack(out);
	if (true) return;
}
%>

<script type="text/javascript">
    $(document).ready(function(){
        //  Focus auto-focus fields
        $('.auto-focus:first').focus();
        
        //  Initialize auto-hint fields
        $('INPUT.auto-hint, TEXTAREA.auto-hint').focus(function(){
            if($(this).val() == $(this).attr('title')){ 
                $(this).val('');
                $(this).removeClass('auto-hint');
            }
        });
        
        $('INPUT.auto-hint, TEXTAREA.auto-hint').blur(function(){
            if($(this).val() == '' && $(this).attr('title') != ''){ 
                $(this).val($(this).attr('title'));
                $(this).addClass('auto-hint'); 
            }
        });
        
        $('INPUT.auto-hint, TEXTAREA.auto-hint').each(function(){
            if($(this).attr('title') == ''){ return; }
            if($(this).val() == ''){ $(this).val($(this).attr('title')); }
            else { $(this).removeClass('auto-hint'); } 
        });
    });
</script>

<script src="dietColumView.js"></script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				다이어트 칼럼
			</h1>
			<div class="pageDepth">
				HOME > GO! 다이어트 > <strong>다이어트 칼럼</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="thirteen columns offset-by-one">
            <div class="row">
			    <div class="one last  col">
				   <div class="post-wrapper">
				      <div class="post-read">
					      <h2><%=title%></h2>
							  <ul class="meta-wrap">
								  <li><span class="cate"></span>
								  
								<%
									if(pressUrl.equals("1")){
										out.print("다이어트 먹거리");
									}else if(pressUrl.equals("2")){
										out.print("다이어트 생활습관");
									}else if(pressUrl.equals("3")){
										out.print("다이어트 속설과 과학");
									}
								%>								  </li>
                                  <li><span class="date"></span><%=instDate.substring(2,10)%></li>
								  <li><span class="account"></span><%=HIT_CNT%></li>
								  <li><span class="comment"></span><%=reply_count%></li>
                                  <div class="share floatright">
                                    <ul>
                                        <li>
                                            <a class="facebook" href="http://www.facebook.com/share.php?u=<%=request.getRequestURL()%>?id=<%=noticeId%>" target="_blank"></a>
                                        </li>
                                        <li>
                                            <a class="twitter" href="http://twitter.com/share?url=<%=request.getRequestURL()%>?id=<%=noticeId%>&text=eatsslim diet" target="_blank"></a>
                                        </li>
                                        <li>
                                            <a class="me2day" href="http://me2day.net/posts/new?new_post[body]=<%=request.getRequestURL()%>?id=<%=noticeId%>" target="_blank"></a>
                                        </li>
                                        <li>
                                            <a class="print" href="#" onClick="window.print();return false;"></a>
                                        </li>
                                    </ul>
                                </div>
							  </ul>
							  <div class="clear"></div>
						  <div class="post-contents">
						      <%=content%>
                            <!-- 이전/다음 컬럼 보기 -->
                            <!-- <div class="viewNavi">
                               <span class="prebtn floatleft"><a href="#"></a></span>
                               <span class="nextbtn floatright"><a href="#"></a></span>
                            </div> -->
                            <!-- End 이전/다음 컬럼 보기-->
						  </div>
						  <div class="col center"><div class="button small dark"><a href="/colums/dietColum.jsp?<%=param%>">목록</a></div></div>
						  <div class="comment-wrap">

						      <div class="sectionHeader">
								  <h4>
									  댓글(<%=reply_count%>)
								  </h4>
								  <div class="floatright button dark small">
								     <a href="javascript:reply_write();">댓글등록</a>
								  </div>
								  <div class="clear"></div>
							  </div>
							  <%

									if(eslMemberId.equals("")){
										login_stat_str = "로그인 후 댓글을 입력해 주세요. ";
									}

									//댓글 수정 처리
									if(reply_idx > 0){
										query		= "SELECT * ";
										query		+= " FROM ESL_DC_REPLY where ID="+noticeId+" and IDX="+reply_idx+" and M_ID='"+eslMemberId+"'";
										query		+= " ORDER BY IDX ASC";
			
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();			


										reply_idx= 0;
										
										if (rs.next()) {
											reply_idx = rs.getInt("IDX");
											reply_content = rs.getString("CONTENT");
										}
										
										if(reply_idx > 0){
											reply_mode = "edit";
										}
										
									}
							  %>
							  <form name="reply_write" method="post" action="" enctype="multipart/form-data">
							  <input type="hidden" name="m_id" value="<%=eslMemberId%>">
							  <input type="hidden" name="m_name" value="<%=eslMemberName%>">
							  <input type="hidden" name="id" value="<%=noticeId%>">
							  <input type="hidden" name="idx" value="">
							  <input type="hidden" name="mode" value="<%=reply_mode%>">
							  <input type="hidden" name="reply_idx" value="<%=reply_idx%>">
							  <input type="hidden" name="iPage" value="<%=iPage%>">
							  <input type="hidden" name="pgsize" value="<%=pgsize%>">
							  <input type="hidden" name="keyword" value="<%=keyword%>">
							  <input type="hidden" name="field" value="<%=field%>">
							  <input type="hidden" name="p_gubun" value="<%=p_gubun%>">

								<textarea id="content" name="content" class="auto-hint" title="<%=login_stat_str%>게시판과 무관한 욕설, 비방, 광고댓글은 임의로 삭제될 수 있습니다." wrap="virtual" <%if(eslMemberId.equals("")){%>disabled="true"<%}%>><%=reply_content%></textarea>
							  </form>
						      <ul>
							    <li class="comment depth-1" >

									<%
									query		= "SELECT * ";
									query		+= " FROM ESL_DC_REPLY where ID="+noticeId+"";
									query		+= " ORDER BY IDX ASC";
									
									pstmt		= conn.prepareStatement(query);
									rs			= pstmt.executeQuery();
									%>



									<%
									if (reply_count > 0) {
										int i		= 0;
										while (rs.next()) {
											reply_id		= rs.getInt("ID");
											reply_idx		= rs.getInt("IDX");
											m_id		= rs.getString("M_ID");
											m_name		= rs.getString("M_NAME");
											reply_content		= rs.getString("CONTENT");
											reply_content2		= (rs.getString("CONTENT2") == null)? "" : rs.getString("CONTENT2");
											reply_date		= rs.getString("INST_DATE");
											reply_date2		= rs.getString("RE_UPDT_DATE");
									%>
									
									<% if(i > 0){ %>
									<div class="lineSeparator" style="margin-bottom:10px"></div>
									<% } %>
								   <div class="commentheader">
								       <h5><%=m_id%></h5>
									   <div class="metastamp"><%=reply_date.substring(0,16)%></div>
									   <div class="myadmin">
									   <% if(m_id.equals(eslMemberId)){ %>
								      <a href="/colums/dietColumView.jsp?<%=param%>&id=<%=noticeId%>&reply_idx=<%=reply_idx%>">수정</a> ㅣ <a href="javascript:reply_del('<%=reply_idx%>');">삭제</a>
									  <% } %>
									   </div>
								   </div>
								   <p><%=ut.nl2br(reply_content)%></p>
								  

								  <% if(reply_content2 !=""){ %>
								  <div class="lineSeparator"></div>
								   <ul>
								       <li class="comment depth-2" >
									   <div class="commentheader">
										   <h5>관리자</h5>
										   <div class="metastamp"><%=reply_date2.substring(0,16)%></div>
									   </div>
									   <p><%=ut.nl2br(reply_content2)%></p>
									   <div class="lineSeparator"></div>
									   </li>
								   </ul>
								  <% } %>

									<%

											i++;
										}
									}
									%>

								</li>
							  </ul>
						  </div>
					  </div>
				   </div>
				</div>
			</div>
			<!-- End Row -->
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="sidebar four columns">
		   <div class="colums-side">
              <ul class="listNavi">
                  <li>
				  
				  
								<%								
								query		= "SELECT ID, TITLE FROM "+ table +" WHERE ID > ? ORDER BY ID ASC LIMIT 0, 1";
								pstmt		= conn.prepareStatement(query);
								pstmt.setInt(1, noticeId);
								rs			= pstmt.executeQuery();
								
								if (rs.next()) {
								%>
								<a href="?id=<%=rs.getInt("ID") + param%>"><span class="prev"></span>이전</a>
								<%} else {%>
								<a href="javascript:alert('이전글이 없습니다');"><span class="prev"></span>이전</a>
								<%
								}
								
								if (rs != null) try { rs.close(); } catch (Exception e) {}
								if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
								%>
								
				  
				  
				  
				  
				  </li>
                  <li class="active"><a href="/colums/dietColum.jsp?<%=param%>"><span class="current"></span>목록</a></li>
                  <li class="last">
				  
				  
				 
								<%
								query		= "SELECT ID, TITLE FROM "+ table +" WHERE ID < ? ORDER BY ID DESC LIMIT 0, 1";
								pstmt		= conn.prepareStatement(query);
								pstmt.setInt(1, noticeId);
								rs			= pstmt.executeQuery();
								
								if (rs.next()) {
								%>
								<a href="?id=<%=rs.getInt("ID") + param%>">다음<span class="next"></span></a>
								<%} else {%>
								<a href="javascript:alert('다음글이 없습니다');">다음<span class="next"></span>
								<%}%>
								

				  </li>
              </ul>
              <ul class="recent">
				<%
				query		= "SELECT ID, TITLE, LIST_IMG, PRESS_URL, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE,CONTENT,HIT_CNT,(select count(id) from ESL_DC_REPLY where ID="+table+".ID) as re_cnt";
				if(p_gubun.equals("")){
					query		+= " FROM "+ table + "";
				}else{
					query		+= " FROM "+ table + " where PRESS_URL='"+p_gubun+"'";
				}
				query		+= " ORDER BY RAND()";
				query		+= " LIMIT 3";

				
				pstmt		= conn.prepareStatement(query);
				rs			= pstmt.executeQuery();
				///////////////////////////

				int i		= 0;
				while (rs.next()) {
					noticeId		= rs.getInt("ID");
					title		= rs.getString("TITLE");
					listImg		= rs.getString("LIST_IMG");
					content			= rs.getString("CONTENT");

					content = ut.convertHtmlTags(content);

					if (!listImg.equals("")) {
						imgUrl		= webUploadDir +"board/"+ listImg;
					} else {
						imgUrl		= "";
					}
					pressUrl	= rs.getString("PRESS_URL");
					

				%>
                  <li>
					<% if(!imgUrl.equals("")){ %>
                     <a href="?id=<%=rs.getInt("ID") + param%>"><img alt="잇슬림컬럼" class="thumbnail" src="<%=imgUrl%>" onerror="this.width=0" width="200" ></a>
					 <% } %>
                     <p class="cate">[
								<%
									if(pressUrl.equals("1")){
										out.print("다이어트 먹거리");
									}else if(pressUrl.equals("2")){
										out.print("다이어트 생활습관");
									}else if(pressUrl.equals("3")){
										out.print("다이어트 속설과 과학");
									}
								%>						 
					 ]</p>
                    <a href="?id=<%=rs.getInt("ID") + param%>">
                     <h4><%=title%></h4>
                     </a>
                  </li>

					<%
							
							i++;
					}
		
					%>


              </ul>
           </div>
		</div>
		<!-- End sidebar four columns -->
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