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


</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				���̾�Ʈ ü���ı�
			</h1>
			<div class="pageDepth">
				HOME > GO! ���̾�Ʈ > <strong>���̾�Ʈ ü���ı�</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
            <div class="row">
                <div class="one last  col">
                    <div class="graytitbox">
                        <h4 class="floatleft">8���� ����Ʈ ü���ı�</h4>
                        <div class="button dark small floatright"><a href="/colums/postWrite.jsp">ü���ı� �ۼ�</a></div>
                    </div>
                </div>
            </div>
            <div class="row">
			    <div class="one last  col">
				   <div class="fluidbox best">
				      <div class="box">
                        <div class="article">
                              <a href="/colums/dietColumView.jsp">
                              <img alt="�ս����÷�" class="thumbnail" src="/images/postscript_sample01.jpg">
                              </a>
                              <p class="cate">[��Ȱ����]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>�ｺƮ���� ����</h4>
                              <p>���� �α�ɱ׷� "�����ͽ���"�� ������ �ȹ��� ȭ���Դϴ�.
                              ������ ��ġ ���� �Ǹ����� ��տ� �Ŵ޷� ���⿡ ����� �����ս��� �������� 
                              �����ε���. �ȹ��� ���� źź���� ������� ���ŵ� �ü��� ��ҽ��ϴ�.</p>
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
                              <img alt="�ս����÷�" class="thumbnail" src="/images/postscript_sample01.jpg">
                              </a>
                              <p class="cate">[���̾�Ʈ �Ӽ��� ����]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>�� �� �ٳ�� ���, �ǰ����� ì�ܶ�!</h4>
                              <p>���źҸ� ��ٷ��� �ܰ��� �����ް�! ������ ���� �������, �ٴٷ� ���� �޷�������
                              ������ ���� ���࿡�� ������ ���� ���� �� �ִٴ� ���!
                              �����ð� ���� �ڼ��� �ɾ� �ְų� ��Ÿ� �������� ���� ����� �������� ��ġ�� ��� �ͱ�￩����!</p>
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
                              <img alt="�ս����÷�" class="thumbnail" src="/images/postscript_sample01.jpg">
                              </a>
                              <p class="cate">[��Ȱ����]</p>
                              <a href="/colums/dietColumView.jsp">
                              <h4>���޴��� ���� ���̽���</h4>
                              <p>�̷��� ������? ������ ���� ���� ���� ���̽��� �����. </p>
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
                            <li <% if(p_gubun.equals("1")){ %> class="current" <% } %>><a href="?p_gubun=1" >�Ļ���̾�Ʈ(<%=gubun1_cnt%>)</a></li>
                            <li <% if(p_gubun.equals("2")){ %> class="current" <% } %>><a href="?p_gubun=2" >���α׷����̾�Ʈ(<%=gubun2_cnt%>)</a></li>
                            <li <% if(p_gubun.equals("3")){ %> class="current" <% } %>><a href="?p_gubun=3" >Ÿ�Ժ����̾�Ʈ(<%=gubun3_cnt%>)</a></li>

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
				   <div class="post-wrapper">
                        <div class="box">
                             <div class="article">
                                  <a href="/colums/dietColumView.jsp">
                                   <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-1.jpg">
                                   </a>
                                   <p class="cate">[��Ȱ����]</p>
                                   <a href="/colums/dietColumView.jsp">
                                   <h4>�ｺƮ���� ����</h4>
                                   <p>���� �α�ɱ׷� "�����ͽ���"�� ������ �ȹ��� ȭ���Դϴ�.
                                   ������ ��ġ ���� �Ǹ����� ��տ� �Ŵ޷� ���⿡ ����� �����ս��� �������� 
                                   �����ε���. �ȹ��� ���� źź���� ������� ���ŵ� �ü��� ��ҽ��ϴ�.</p>
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
                                   <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-1.jpg">
                                   </a>
                                   <p class="cate">[��Ȱ����]</p>
                                   <a href="/colums/dietColumView.jsp">
                                   <h4>�ｺƮ���� ����</h4>
                                   <p>���� �α�ɱ׷� "�����ͽ���"�� ������ �ȹ��� ȭ���Դϴ�.
                                   ������ ��ġ ���� �Ǹ����� ��տ� �Ŵ޷� ���⿡ ����� �����ս��� �������� 
                                   �����ε���. �ȹ��� ���� źź���� ������� ���ŵ� �ü��� ��ҽ��ϴ�.</p>
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
                                   <img alt="�ս����÷�" class="thumbnail" src="/images/Jaipur-1.jpg">
                                   </a>
                                   <p class="cate">[��Ȱ����]</p>
                                   <a href="/colums/dietColumView.jsp">
                                   <h4>�ｺƮ���� ����</h4>
                                   <p>���� �α�ɱ׷� "�����ͽ���"�� ������ �ȹ��� ȭ���Դϴ�.
                                   ������ ��ġ ���� �Ǹ����� ��տ� �Ŵ޷� ���⿡ ����� �����ս��� �������� 
                                   �����ε���. �ȹ��� ���� źź���� ������� ���ŵ� �ü��� ��ҽ��ϴ�.</p>
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
                <div class="button small dark floatright"><a href="/colums/postWrite.jsp">ü���ı� �ۼ�</a></div>
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