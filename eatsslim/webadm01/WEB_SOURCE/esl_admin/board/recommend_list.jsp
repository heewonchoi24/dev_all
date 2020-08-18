<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");


String query		= "";

String banner1 = "";
String banner2 = "";
String banner3 = "";
String banner4 = "";
String banner5 = "";
String banner6 = "";
String banner7 = "";
String banner1_link = "";
String banner2_link = "";
String banner3_link = "";
String banner4_link = "";
String banner5_link = "";
String banner6_link = "";
String banner7_link = "";
String banner1_title = "";
String banner2_title = "";
String banner3_title = "";
String banner4_title = "";

query = "SELECT * FROM ESL_BANNER_TEMP where no=2";
try{rs = stmt.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
if(rs.next()){
	banner1=rs.getString("banner1");
	banner2=rs.getString("banner2");
	banner3=rs.getString("banner3");
	banner4=rs.getString("banner4");
	banner5=rs.getString("banner5");
	banner6=rs.getString("banner6");
	banner7=rs.getString("banner7");
	banner1_link=rs.getString("banner1_link");
	banner2_link=rs.getString("banner2_link");
	banner3_link=rs.getString("banner3_link");
	banner4_link=rs.getString("banner4_link");
	banner5_link=rs.getString("banner5_link");
	banner6_link=rs.getString("banner6_link");
	banner7_link=rs.getString("banner7_link");
	banner1_title=rs.getString("banner1_title");
	banner2_title=rs.getString("banner2_title");
	banner3_title=rs.getString("banner3_title");
	banner4_title=rs.getString("banner4_title");
}
%>
<script type="text/javascript" src="../js/sub.js"></script>
<script type="text/javascript" src="../js/left.js"></script>
<script type="text/javascript">
//<![CDATA[
$(function(){
	$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
	$('#lnb').menuModel2({hightLight:{level_1:5,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
})
//]]>
</script>
<script type="text/javascript">
	function fnSave(){
		if(confirm("배너정보를 변경하시겠습니까?")){
			document.fm.submit();
		}
	}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-board.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 컨텐츠관리 &gt; <strong>잇슬림 추천제품</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<div class="section_rec_list">
					<ul>
						<li>
							<div class="img_tray"></div>
							<button type="button" class="chooseItems" onclick="tomatoPopup.getProductRelated(this);"><span></span></button>
						</li>
						<li>
							<div class="img_tray"></div>
							<button type="button" class="chooseItems" onclick="tomatoPopup.getProductRelated(this);"><span></span></button>
						</li>
						<li>
							<div class="img_tray"></div>
							<button type="button" class="chooseItems" onclick="tomatoPopup.getProductRelated(this);"><span></span></button>
						</li>
						<li>
							<div class="img_tray"></div>
							<button type="button" class="chooseItems" onclick="tomatoPopup.getProductRelated(this);"><span></span></button>
						</li>
						<li>
							<div class="img_tray"></div>
							<button type="button" class="chooseItems" onclick="tomatoPopup.getProductRelated(this);"><span></span></button>
						</li>
						<li>
							<div class="img_tray"></div>
							<button type="button" class="chooseItems" onclick="tomatoPopup.getProductRelated(this);"><span></span></button>
						</li>
						<li>
							<div class="img_tray"></div>
							<button type="button" class="chooseItems" onclick="tomatoPopup.getProductRelated(this);"><span></span></button>
						</li>
						<li>
							<div class="img_tray"></div>
							<button type="button" class="chooseItems" onclick="tomatoPopup.getProductRelated(this);"><span></span></button>
						</li>
					</ul>
				</div>
			</div>
			<!-- //contents -->
			<div id="search_popup" class="popup_type01">
				<div class="inner">
			        <form name="searchForm" id="searchForm" onsubmit="tomatoPopup.searchProductRelated(this);return false;">
					<h1>제품 검색</h1>
					<div id="searchBox2">
			 			<span class="p_holder">
			                <input type="text" name="sw" value="" class="input_txt" id="search_product" onblur="showLabel(this);" onfocus="hideLabel(this);">
			 				<label for="search_product" onclick="focusInput(this);" style="display: inline;">키워드를 입력하세요.</label>
			 				<button id="search_img" class="btn" onmouseenter="imgOn(this);" onmouseleave="imgOff(this);"><img src="images/common/btn_search_off.png"></button>
			 			</span>
			 		</div>
			        </form>
					<h2>검색 결과</h2>
			 		<section class="seach_result">
						<div class="inner">
			 				<ul class="clearfix">
			                	<li><div>검색하세요</div></li>
			 				</ul>
			 			</div>
			 		</section>
			 		<div class="bot_btns">
						<button class="btn_pack blue" onclick="s_pop.close_pop();">Close</button>
					</div>
				</div>
			</div>
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
</body>
<script>

function prdEditpop(obj){
	var url = '/oktomato/commerce/write_mall_product.do?pdtype='+$(obj).data("pdtype")+'&cacode=' + $(obj).data("cacode")+'&pdcode=' + $(obj).data("pdcode") + '&ca=&col=&sw=&page=1';
	get_write_pop(url,'edit');
}

</script>
</html>
<%@ include file="../lib/dbclose.jsp" %>