<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String table		= "ESL_EVENT_HOUSEWIFE";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
int housewifeId		= 0;
String title		= "";
String listImg		= "";
String pressUrl		= "";
String viewLink		= "";
String imgUrl		= "";
String instDate		= "";
int divNum			= 0;
String content		= "";
String p_gubun		= "";

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


//��ŷ�� �� 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE PRESS_URL='1'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun1_cnt = rs.getInt(1); //�� ���ڵ� ��		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


//���績 �� 
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE PRESS_URL='2'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun2_cnt = rs.getInt(1); //�� ���ڵ� ��		
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

query		= "SELECT ID, TITLE, LIST_IMG, PRESS_URL, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE,CONTENT,HIT_CNT,(select count(id) from ESL_EVENT_HOUSEWIFE_REPLY where ID="+table+".ID) as re_cnt";
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
			<h2>��ŷ��&���績 ���̾�Ʈ ���丮</h2>
			<div class="pageDepth">
				HOME &gt; �̺�Ʈ &gt; <strong>�ֺ� ���̾�Ʈ ���</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<!--div class="one last col">
					<div class="graytitbox">
						<ul class="filter floatleft" style="margin-top:5px;">
							<li <% if(p_gubun.equals("")){ %> class="current" <% } %>><a href="housewife.jsp">ALL(<%=gubun_all_cnt%>)</a></li>
							<li <% if(p_gubun.equals("1")){ %> class="current" <% } %>><a href="?p_gubun=1" >��ŷ��(<%=gubun1_cnt%>)</a></li>
							<li <% if(p_gubun.equals("2")){ %> class="current" <% } %>><a href="?p_gubun=2" >���績(<%=gubun2_cnt%>)</a></li>
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
				</div-->
				<img src="/images/promotion/201404/housewife_top.jpg" alt="��ŷ��vs���績" usemap="#map1" />
				<map name="Map1">
					<area shape="rect" coords="620,235,976,297" href="/event/eventView.jsp?id=52&pgsize=10" target="_self" alt="���� ��� �ۼ��ϰ� �����ޱ�">
				</map>
			</div>
			<!-- End Row -->
			<div class="row">
				<div class="one last col" id="dietList">
					<div class="fluidbox">
						<%
						if (intTotalCnt > 0) {
							int i		= 0;
							while (rs.next()) {
								housewifeId	= rs.getInt("ID");
								title		= rs.getString("TITLE");
								listImg		= rs.getString("LIST_IMG");
								content		= rs.getString("CONTENT");
								hitCnt		= rs.getInt("HIT_CNT");
								content		= ut.delHtmlTag(content);

								if (!listImg.equals("")) {
									imgUrl		= webUploadDir +"promotion/"+ listImg;
								} else {
									imgUrl		= "";
								}
								pressUrl	= rs.getString("PRESS_URL");
								instDate	= rs.getString("WDATE");
						%>
						<div class="box">
							<div class="article">
								<a href="/event/housewifeView.jsp?id=<%=housewifeId + param%>">
									<img class="thumbnail" src="<%=imgUrl%>" onerror="this.width=0" width="220">
								</a>
								<!--p class="cate">
									[
									<%
									if(pressUrl.equals("1")){
										out.print("��ŷ��");
									}else if(pressUrl.equals("2")){
										out.print("���績");
									}
									%>							  
									]
								</p-->
								<a href="/event/housewifeView.jsp?id=<%=housewifeId + param%>">
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
					<div class="readmore">
						<button onclick="getList(<%=iPage+1%>);">������...</button>
					</div>
				</div>
			</div>
			<!-- End Row -->			
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
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
<script type="text/javascript">  
$(document).ready(function(){
    masonry();
});

function masonry() {
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
}

function getList(page) {
	$.post("housewife_ajax.jsp", {
		mode: 'getList',
		page: page
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var dietArr		= "";
				var dietHtml	= '<div class="fluidbox">';
				$(data).find("diet").each(function() {
					dietArr		= $(this).text().split("|");
					nextPage	= dietArr[8];
					dietHtml +='<div class="box">';
					dietHtml +='<div class="article">';
					dietHtml +='<a href="/event/housewifeView.jsp?id='+ dietArr[0] +'">';
					dietHtml +='<img class="thumbnail" src="'+ dietArr[2] +'" onerror="this.width=0" width="220">';
					dietHtml +='</a>';
					if (dietArr[5] == 1) {
						dietTxt	= "��ŷ��";
					} else if (dietArr[5] == 2) {
						dietTxt	= "���績";
					}
					dietHtml +='<p class="cate">'+ dietTxt +'</p>';
					
					dietHtml +='<a href="/event/housewifeView.jsp?id='+ dietArr[0] +'">';
					dietHtml +='<h4>'+ dietArr[1] +'</h4>';
					dietHtml +='<p>'+ dietArr[3] +'</p>';
					dietHtml +='</a>';
					dietHtml +='<ul class="meta-wrap">';
					dietHtml +='<li><span class="date"></span>'+ dietArr[6] +'</li>';
					dietHtml +='<li><span class="account"></span>'+ dietArr[4] +'</li>';
					dietHtml +='<li><span class="comment"></span>'+ dietArr[7] +'</li>';
					dietHtml +='</ul>';
					dietHtml +='</div>';
					dietHtml +='</div>';
				});
				dietHtml +='</div>';
				$('.readmore').remove();
				if (nextPage > 0) {
					dietHtml +='<div class="readmore">';
					dietHtml +='<button onclick="getList('+ nextPage + ');">������...</button>';
					dietHtml +='</div>';
				}

				$('#dietList').append(dietHtml);
				masonry();
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
<%@ include file="/lib/dbclose.jsp" %>