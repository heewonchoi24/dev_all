<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>


<%
String table		= "ESL_DC";
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
int pgsize		= 12; //�������� �Խù� ��
int pagelist	= 10; //ȭ��� ������ ��
int iPage;			  // ���������� ��ȣ
int startpage;		  // ���� ������ ��ȣ
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

//�Ѻз���
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE 1=1"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun_all_cnt = rs.getInt(1); //�� ���ڵ� ��		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


//'���̾�Ʈ �԰Ÿ� �Ļ� �� 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE PRESS_URL='1'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun1_cnt = rs.getInt(1); //�� ���ڵ� ��		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


//���̾�Ʈ ��Ȱ���� ���α׷� �� 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE PRESS_URL='2'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun2_cnt = rs.getInt(1); //�� ���ڵ� ��		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


//���̾�Ʈ �Ӽ��� ���� �� 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE PRESS_URL='3'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun3_cnt = rs.getInt(1); //�� ���ڵ� ��		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}




query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //�� ���ڵ� ��		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}











totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // �� ������ ��
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


<script type="text/javascript">  
$(document).ready(function(){
    var $container = $('.fluidbox');

    var gutter = 12;
    var min_width = 240;
    $container.imagesLoaded( function(){
        $container.masonry({
            itemSelector : '.box',
            gutterWidth: gutter,
            isAnimated: true,
              columnWidth: function( containerWidth ) {
                var box_width = (((containerWidth - 3*gutter)/4) | 0) ;

                if (box_width < min_width) {
                    box_width = (((containerWidth - gutter)/2) | 0);
                }

                if (box_width < min_width) {
                    box_width = containerWidth;
                }

                $('.box').width(box_width);

                return box_width;
              }
        });
    });
});
 
</script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				���̾�Ʈ Į��
			</h1>
			<div class="pageDepth">
				HOME > GO! ���̾�Ʈ > <strong>���̾�Ʈ Į��</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
                <div class="one last  col">
                    <div class="graytitbox">
                        <ul class="filter floatleft" style="margin-top:5px;">
                            <li <% if(p_gubun.equals("")){ %> class="current" <% } %>><a href="dietColum.jsp">ALL(<%=gubun_all_cnt%>)</a></li>
                            <li <% if(p_gubun.equals("1")){ %> class="current" <% } %>><a href="?p_gubun=1" >���̾�Ʈ �԰Ÿ�(<%=gubun1_cnt%>)</a></li>
                            <li <% if(p_gubun.equals("2")){ %> class="current" <% } %>><a href="?p_gubun=2" >���̾�Ʈ ��Ȱ����(<%=gubun2_cnt%>)</a></li>
                            <li <% if(p_gubun.equals("3")){ %> class="current" <% } %>><a href="?p_gubun=3" >���̾�Ʈ �Ӽ��� ����(<%=gubun3_cnt%>)</a></li>
                        </ul>

						<form name="frm_search" method="get" action="<%=request.getRequestURI()%>">

						<div class="searchBar floatright">
							<label>
								<select name="field" id="field" style="width:70px;" onchange="this.form.keyword.focus()">
									<option value="TITLE"<%if(field.equals("TITLE")){out.print(" selected=\"selected\"");}%>>����</option>
									<option value="CONTENT"<%if(field.equals("CONTENT")){out.print(" selected=\"selected\"");}%>>����</option>
								</select>
							</label>
							<label>
							<input type="text" name="keyword" maxlength="30" value="<%=keyword%>" onfocus="this.select()" />
							</label>
							<label>
							<input type="submit" class="button dark small" name="button" value="�˻�">
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
				   <div class="fluidbox">


						<%
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
                            <a href="/colums/dietColumView.jsp?id=<%=pressId + param%>">
                              <img alt="�ս����÷�" class="thumbnail" src="<%=imgUrl%>" onerror="this.width=0" width="220">
                              </a>
                              <p class="cate">[
								<%
									if(pressUrl.equals("1")){
										out.print("���̾�Ʈ �԰Ÿ�");
									}else if(pressUrl.equals("2")){
										out.print("���̾�Ʈ ��Ȱ����");
									}else if(pressUrl.equals("3")){
										out.print("���̾�Ʈ �Ӽ��� ����");
									}
								%>							  
							  ]</p>
                              <a href="/colums/dietColumView.jsp?id=<%=pressId + param%>">
                              <h4><%=title%></h4>
                              <p><%=ut.cutString(260, content, "..")%></p>
                              </a>
                              <ul class="meta-wrap">
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

										
				   </div>
                   <!-- End Fluidbox -->
                   <!-- <div class="readmore">
                       <button id="">Read More...</button>
                   </div> -->

					<div class="readmore">
							<%@ include file="../common/include/inc-paging.jsp"%>
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
<script src="/common/js/jquery.masonry.min.js"></script>
</body>
</html>