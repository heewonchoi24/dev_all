<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
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
	where		+= " AND "+ field +" LIKE ?";
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
}else if(p_gubun.equals("4")){
	where += " and press_url='4' ";
	param		+= "&amp;p_gubun=" + p_gubun;
}

//총분류수
query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	pstmt.setString(1, "%"+ keyword +"%");
}
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

//비교 잇슬림 수
query		= "SELECT COUNT(ID) FROM "+ table + " WHERE PRESS_URL='4'"; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	gubun4_cnt = rs.getInt(1); //총 레코드 수
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}


query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	pstmt.setString(1, "%"+ keyword +"%");
}
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
if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	pstmt.setString(1, "%"+ keyword +"%");
}
rs			= pstmt.executeQuery();
///////////////////////////
%>

<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/colums.css" />

</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">다이어트 칼럼</span></span></h1>
            <div class="row">
            	<div id="dietList">
            		 <div class="fluidbox">
						<div class="grid-sizer"></div>
						<%
						if (intTotalCnt > 0) {
							int i		= 0;
							while (rs.next()) {
								pressId		= rs.getInt("ID");
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
								pressUrl	= rs.getString("PRESS_URL");
								instDate	= rs.getString("WDATE");
						%>
						<div class="box">
							<div class="article">
								<a href="/mobile/colums/dietColumView.jsp?id=<%=pressId + param%>">
									<img alt="잇슬림컬럼" class="thumbnail" src="<%=imgUrl%>" onerror="this.width=0" width="220">
								</a>
								<p class="cate">
									[
									<%
									if(pressUrl.equals("1")){
										out.print("다이어트 먹거리");
									}else if(pressUrl.equals("2")){
										out.print("다이어트 생활습관");
									}else if(pressUrl.equals("3")){
										out.print("다이어트 속설과 과학");
									}else if(pressUrl.equals("4")){
										out.print("비교 잇슬림");
									}
									%>
									]
								</p>
								<a href="/mobile/colums/dietColumView.jsp?id=<%=pressId + param%>">
									<h4><%=title%></h4>
									<p><%=ut.cutString(60, content, "..")%></p>
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
					<%if (totalPage > iPage) {%>
					<div class="readmore">
						<button onclick="getList(<%=iPage+1%>);">더보기...</button>
					</div>
					<%}%>
            	</div>
            </div>
    </div>
    <!-- End Content -->
    <div class="ui-footer">
        <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
<script src="/mobile/common/js/jquery.masonry.min.js"></script>
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
            isAnimated: true,
            columnWidth: '.grid-sizer',
            percentPosition: true
        });
    });
}

function getList(page) {
	$.post("dietColum_ajax.jsp", {
		mode: 'getList',
		page: page
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var dietArr		= "";
				var dietHtml	= '';
				$(data).find("diet").each(function() {
					dietArr		= $(this).text().split("|");
					nextPage	= dietArr[8];
					dietHtml +='<div class="box">';
					dietHtml +='<div class="article">';
					dietHtml +='<a href="/mobile/colums/dietColumView.jsp?id='+ dietArr[0] +'">';
					dietHtml +='<img alt="잇슬림컬럼" class="thumbnail" src="'+ dietArr[2] +'" onerror="this.width=0" width="220">';
					dietHtml +='</a>';
					if (dietArr[5] == 1) {
						dietTxt	= "다이어트 먹거리";
					} else if (dietArr[5] == 2) {
						dietTxt	= "다이어트 생활습관";
					} else if(dietArr[5] == 3) {
						dietTxt	= "다이어트 속설과 과학";
			    	} else if(dietArr[5] == 4) {
						dietTxt	= "비교 잇슬림";
					}
					dietHtml +='<p class="cate">'+ dietTxt +'</p>';

					dietHtml +='<a href="/mobile/colums/dietColumView.jsp?id='+ dietArr[0] +'">';
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
				$('.readmore').remove();
				if (nextPage > 0) {
					var readmore = '';
					readmore +='<div class="readmore">';
					readmore +='<button onclick="getList('+ nextPage + ');">더보기...</button>';
					readmore +='</div>';
					$('#dietList').append(readmore);
				}

				//$('#dietList').append(dietHtml);
				$('.fluidbox').append(dietHtml).imagesLoaded(function() {
					$('.fluidbox').masonry( 'appended', dietHtml ).masonry('reloadItems');
					masonry();


				});
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