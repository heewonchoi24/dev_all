<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>
<script type="text/javascript" src="/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/smarteditor/quick_photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"> </script>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int groupId			= 0;
String gubun2		= "";
String gubun3		= "";
String groupCode	= "";
String groupName	= "";
String groupInfo	= "";
String groupInfo1	= "";
String offerNotice	= "";
String cartImg		= "";
int groupPrice		= 0;
int groupPrice1		= 0;
int groupPrice2		= 0;
int groupPrice3		= 0;
int groupPrice4		= 0;
int kalInfo 		= 0;
String pgGroupCode	= "";
String pgGroupName	= "";
String goodsCode	= "";
String goodsName	= "";
int cid				= 0;
int amount			= 0;
int cateId			= 0;
String cateName		= "";
String keyword		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String schGubun1	= ut.inject(request.getParameter("sch_gubun1"));
String schGubun2	= ut.inject(request.getParameter("sch_gubun2"));
String field		= ut.inject(request.getParameter("field"));
String groupImg     = "";
String listViewYn     = "";
String tag     = "";

String devlGoodsType			= "";
String devlFirstDay		= "";
String devlModiDay		= "";
String devlWeek3		= "";
String devlWeek5		= "";
String cateCode			= "";
String dispCateName		= "";
String dayEat			= "";
int noticeCt = 0;
List<Map> infoNoticeList = new ArrayList(); //-- 상품정보
List<Map> productNoticeList = new ArrayList(); //-- 상품고시
List<Map> deliveryNoticeList = new ArrayList(); //-- 배송고시
Map noticeMap = new HashMap(); //-- 고시에서 사용
String soldOut            = "";    // 풀절 처리

/* 상품별 추천상품 시작 */
List<String> recNameList = new ArrayList<String>(); //-- 추천 상품명
List<String> recgImgList = new ArrayList<String>(); //-- 추천 상품의 이미지
List<String> recImgNo = new ArrayList<String>(); //-- 추천 상품의 이미지 번호
List<String> recgSubCode = new ArrayList<String>(); //-- 추천 상품의 그룹코드
/* 상품별 추천상품 끝 */

if (request.getParameter("keyword") != null) {
	keyword				= ut.inject(request.getParameter("keyword"));
	keyword				= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
String param		= "page="+ iPage +"&pgsize="+ pgsize +"&sch_gubun1="+ schGubun1 +"&sch_gubun2="+ schGubun2 +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	groupId		= Integer.parseInt(request.getParameter("id"));

	/* 상품별 추천상품 시작 */
	try {
		query		 = " SELECT E.GROUP_NAME, E.GROUP_IMGM, ER.IMG_NO, ER.GROUP_SUB_CODE ";
		query	    += " FROM ESL_GOODS_GROUP_RECIMG ER ";
		query		+= " LEFT OUTER JOIN ESL_GOODS_GROUP E ON E.GROUP_CODE = ER.GROUP_SUB_CODE ";
		query		+= " WHERE ER.GROUP_SUB_ID = ? ";
		query		+= " ORDER BY ER.IMG_NO ";
		pstmt        = conn.prepareStatement(query);
		pstmt.setInt(1, groupId);
		rs    = pstmt.executeQuery();
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	while (rs.next()) {
		recNameList.add(ut.isnull(rs.getString("GROUP_NAME")));
		recgImgList.add(ut.isnull(rs.getString("GROUP_IMGM")));
		recImgNo.add(ut.isnull(rs.getString("IMG_NO")));
		recgSubCode.add(ut.isnull(rs.getString("GROUP_SUB_CODE")));
	}
	rs.close();
	/* 상품별 추천상품 끝 */

	query		= "SELECT GUBUN2, GUBUN3, GROUP_CODE, GROUP_NAME, GROUP_INFO, GROUP_INFO1, OFFER_NOTICE, CART_IMG, GROUP_PRICE, KAL_INFO, GROUP_IMGM, GROUP_IMGP, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, CATE_CODE, DISP_CATE_NAME, DAY_EAT, SOLD_OUT";
	query		+= " FROM ESL_GOODS_GROUP ";
	query		+= " WHERE ID = "+ groupId;
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		gubun2			= rs.getString("GUBUN2");
		gubun3			= rs.getString("GUBUN3");
		groupCode		= rs.getString("GROUP_CODE");
		groupName		= rs.getString("GROUP_NAME");
		groupInfo		= rs.getString("GROUP_INFO");
		groupInfo1		= rs.getString("GROUP_INFO1");
		offerNotice		= rs.getString("OFFER_NOTICE");
		cartImg			= rs.getString("CART_IMG");
		groupPrice		= rs.getInt("GROUP_PRICE");
		kalInfo			= rs.getInt("KAL_INFO");
		groupImg		= rs.getString("GROUP_IMGM");
		listViewYn		= rs.getString("LIST_VIEW_YN");
		tag				= rs.getString("TAG");
		devlGoodsType		= ut.isnull(rs.getString("DEVL_GOODS_TYPE") );
		devlFirstDay	= ut.isnull(rs.getString("DEVL_FIRST_DAY") );
		devlModiDay		= ut.isnull(rs.getString("DEVL_MODI_DAY") );
		devlWeek3		= ut.isnull(rs.getString("DEVL_WEEK3") );
		devlWeek5		= ut.isnull(rs.getString("DEVL_WEEK5") );
		cateCode		= ut.isnull(rs.getString("CATE_CODE") );
		dispCateName	= ut.isnull(rs.getString("DISP_CATE_NAME") );
		dayEat			= ut.isnull(rs.getString("DAY_EAT") );
		soldOut         = rs.getString("SOLD_OUT");
	}

	rs.close();

	//-- 상품정보
	query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
	query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
	query		+= " WHERE NOTICE_TYPE='INFO' AND GOODS_GROUP_ID = "+ groupId;
	rs	= stmt.executeQuery(query);
	while(rs.next()){
		noticeMap = new HashMap();
		noticeMap.put("id",rs.getString("ID"));
		noticeMap.put("title",rs.getString("NOTICE_TITLE"));
		noticeMap.put("content",rs.getString("NOTICE_CONTENT"));
		infoNoticeList.add(noticeMap);
	}
	rs.close();

	//-- 상품고시
	query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
	query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
	query		+= " WHERE NOTICE_TYPE='PRODUCT' AND GOODS_GROUP_ID = "+ groupId;
	rs	= stmt.executeQuery(query);
	while(rs.next()){
		noticeMap = new HashMap();
		noticeMap.put("id",rs.getString("ID"));
		noticeMap.put("title",rs.getString("NOTICE_TITLE"));
		noticeMap.put("content",rs.getString("NOTICE_CONTENT"));
		productNoticeList.add(noticeMap);
	}
	rs.close();

	//-- 배송고시
	query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
	query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
	query		+= " WHERE NOTICE_TYPE='DELIVERY' AND GOODS_GROUP_ID = "+ groupId;
	rs	= stmt.executeQuery(query);
	while(rs.next()){
		noticeMap = new HashMap();
		noticeMap.put("id",rs.getString("ID"));
		noticeMap.put("title",rs.getString("NOTICE_TITLE"));
		noticeMap.put("content",rs.getString("NOTICE_CONTENT"));
		deliveryNoticeList.add(noticeMap);
	}
	rs.close();
}

if(groupImg == null){
	groupImg = "";
}
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:4,level_2:2,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-product.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리&gt; 세트그룹관리 &gt; <strong>프로그램다이어트</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="goods_group_pg_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=groupId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="gubun1" value="02" />
					<input type="hidden" name="org_cart_img" value="<%=cartImg%>" />
					<input type="hidden" name="org_group_img" value="<%=groupImg%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>구분2</span></th>
								<td class="td_edit">
									<select name="gubun2" id="gubun2">
										<%if (gubun2.equals("21")) {%>
										<option value="21">감량프로그램</option>
										<%} else if (gubun2.equals("22")) {%>
										<option value="22">유지프로그램</option>
										<%} else if (gubun2.equals("23")) {%>
										<option value="23">FULL-STEP 프로그램</option>
										<%}%>
									</select>
								</td>
								<th scope="row"><span>주차</span></th>
								<td>
									<select name="gubun3" id="gubun3">
										<%if (gubun2.equals("2")) {%>
										<option value="2">2주차</option>
										<%} else if (gubun3.equals("4")) {%>
										<option value="4">4주차</option>
										<%}%>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>세트그룹명</span></th>
								<td><input type="text" name="group_name" id="group_name" style="width:200px;" maxlength="50" class="input1" required label="세트그룹명" value="<%=groupName%>" /></td>
								<th scope="row"><span>가격</span></th>
								<td><input type="text" class="input1" style="width:60px;" maxlength="7" name="group_price" id="group_price" value="<%=groupPrice%>" required label="가격" dir="rtl" /> 원</td>
							</tr>
							<tr>
								<th scope="row"><span>그룹명접두사</span></th>
								<td>
									<input type="text" name="disp_cate_name" id="disp_cate_name" style="width:200px;" maxlength="50" value="<%=dispCateName%>"/>(그룹명 앞에 들어갈 카테고리명)
								</td>
                                <th scope="row"><span>품절처리</span></th>
                                <td>
                                    <label><input type="radio" id="cb_sold_out" name="cb_sold_out" value="Y" <%="Y".equals(soldOut) ? " checked":""%>/> 품절 처리</label>
                                    <label><input type="radio" id="cb_sold_out" name="cb_sold_out" value="N" <%=!"Y".equals(soldOut) ? " checked":""%>/> 품절 해제</label>
                                </td>
							</tr>
							<tr>
								<th scope="row"><span>식수주차정보</span></th>
								<td colspan="3">
									<input type="text" name="day_eat" id="day_eat" style="width:200px;" maxlength="50" value="<%=dayEat%>"/>(예: 1일 3식)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>상태</span></th>
								<td colspan="3">
									<label><input type="radio" name="seen" value="N"<%=!"Y".equals(listViewYn) ? " checked":""%> /> 비노출</label>
									<label><input type="radio" name="seen" value="Y"<%="Y".equals(listViewYn) ? " checked":""%> /> 노출</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>태그</span></th>
								<td colspan="3">
									<label><input type="checkbox" name="tag" value="01"<%=tag.indexOf("01") != -1 ? " checked":""%> /> EVENT</label>
									<label><input type="checkbox" name="tag" value="02"<%=tag.indexOf("02") != -1 ? " checked":""%> /> 특가</label>
									<label><input type="checkbox" name="tag" value="03"<%=tag.indexOf("03") != -1 ? " checked":""%> /> SALE</label>
									<label><input type="checkbox" name="tag" value="04"<%=tag.indexOf("04") != -1 ? " checked":""%> /> NEW</label>
									<label><input type="checkbox" name="tag" value="05"<%=tag.indexOf("05") != -1 ? " checked":""%> /> 추천</label>
									<label><input type="checkbox" name="tag" value="06"<%=tag.indexOf("06") != -1 ? " checked":""%> /> 베스트</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>상품설명</span></th>
								<td colspan="3">
									<input type="text" name="group_info1" id="group_info1" style="width:100%;" maxlength="50" value="<%=groupInfo1%>"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>평균칼로리</span></th>
								<td colspan="3">
									<input type="text" name="kal_info" id="kal_info" class="input1" maxlength="50" value="<%=kalInfo%>"/>	Kcal	(숫자만 기입)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>대표이미지</span></th>
								<td colspan="3">
									<input type="file" name="group_img" value="" />
									<%if (!groupImg.equals("")) {%>
										<br /><input type="checkbox" name="del_group_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"goods/"+ groupImg%>"  width="200" />
									<%}%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>카테고리코드</span></th>
								<td colspan="3">
									<input type="text" name="cateCode" id="cateCode" size="20" maxlength="50" value="<%=cateCode%>"/>(식단정보 : 카테고리관리의 카테고리코드 예:000000,111111)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>배송구분</span></th>
								<td colspan="3">
									<label><input type="radio" name="devlGoodsType" value="0001"<%=!"0002".equals(devlGoodsType) ? " checked":""%> /> 일일배송</label>
									<label><input type="radio" name="devlGoodsType" value="0002"<%="0002".equals(devlGoodsType) ? " checked":""%> /> 택배배송</label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>첫 배송일</span></th>
								<td colspan="3">
									<input type="text" name="devlFirstDay" id="devlFirstDay" size="4" maxlength="2" value="<%=devlFirstDay%>"/>(숫자로 입력 하세요)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>수정가능 배송일</span></th>
								<td colspan="3">
									<input type="text" name="devlModiDay" id="devlModiDay" size="4" maxlength="2" value="<%=devlModiDay%>"/>(숫자로 입력 하세요)
								</td>
							</tr>
							<tr>
								<th scope="row"><span>요일별 주차</span></th>
								<td colspan="3">
									주3일:<input type="text" name="devlWeek3" id="devlWeek3" size="15" maxlength="50" value="<%=devlWeek3%>"/>예) 1,2,4,8<br />
									주5일:<input type="text" name="devlWeek5" id="devlWeek5" size="15" maxlength="50" value="<%=devlWeek5%>"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>상품정보</span></th>
								<td colspan="3">
									<table class="tableView" border="1" cellspacing="0">
										<colgroup>
											<col width="140px">
											<col>
										</colgroup>
										<tbody>
<%
noticeCt = 0;
for(Map nMap : infoNoticeList){
	noticeCt++;
%>
											<input type="hidden" name="info_notice_id" value="<%=nMap.get("id") %>">
											<tr>
												<th><span><input type="text" class="input4" id="info_notice_th_<%=noticeCt%>" name="info_notice_title" value="<%=nMap.get("title") %>"></span></th>
												<td><input type="text" class="input4" id="info_notice_td_<%=noticeCt%>" name="info_notice_content" value="<%=nMap.get("content") %>"></td>
											</tr>
<%
}
for(int v = noticeCt; v < 5; v++){
%>
											<input type="hidden" name="info_notice_id" value="0">
											<tr>
												<th><span><input type="text" class="input4" id="info_notice_th_<%=v%>" name="info_notice_title"></span></th>
												<td><input type="text" class="input4" id="info_notice_td_<%=v%>" name="info_notice_content"></td>
											</tr>
<%
}
%>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<br />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>상세정보</span></th>
								<td class="td_edit">
                                   <form id="f_content" name="f_content" method="post">
                                        <textarea name="group_info" id="group_info" style="height:500px;width:100%;"><%=groupInfo%></textarea>
                                    </form>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>배송안내</span></th>
								<td class="">
									<table class="tableView" border="1" cellspacing="0">
										<colgroup>
											<col width="140px">
											<col>
										</colgroup>
										<tbody>
<%
noticeCt = 0;
for(Map nMap : deliveryNoticeList){
	noticeCt++;
%>
											<input type="hidden" name="delivery_notice_id" value="<%=nMap.get("id") %>">
											<tr>
												<th><span><input type="text" class="input4" id="delivery_notice_th_<%=noticeCt%>" name="delivery_notice_title" value="<%=nMap.get("title") %>"></span></th>
												<td><input type="text" class="input4" id="delivery_notice_td_<%=noticeCt%>" name="delivery_notice_content" value="<%=nMap.get("content") %>"></td>
											</tr>
<%
}
for(int v = noticeCt; v < 10; v++){
%>
											<input type="hidden" name="delivery_notice_id" value="0">
											<tr>
												<th><span><input type="text" class="input4" id="delivery_notice_th_<%=v%>" name="delivery_notice_title"></span></th>
												<td><input type="text" class="input4" id="delivery_notice_td_<%=v%>" name="delivery_notice_content"></td>
											</tr>
<%
}
%>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>상품정보<br />제공고시</span></th>
								<td class="">
									<table class="tableView" border="1" cellspacing="0">
										<colgroup>
											<col width="140px">
											<col>
										</colgroup>
										<tbody>
<%
noticeCt = 0;
for(Map nMap : productNoticeList){
	noticeCt++;
%>
											<input type="hidden" name="product_notice_id" value="<%=nMap.get("id") %>">
											<tr>
												<th><span><input type="text" class="input4" id="offer_notice_th_<%=noticeCt%>" name="product_notice_title" value="<%=nMap.get("title") %>"></span></th>
												<td><input type="text" class="input4" id="offer_notice_th_<%=noticeCt%>" name="product_notice_content" value="<%=nMap.get("content") %>"></td>
											</tr>
<%
}
for(int v = noticeCt; v < 30; v++){
%>
											<input type="hidden" name="product_notice_id" value="0">
											<tr>
												<th><span><input type="text" class="input4" id="offer_notice_th_<%=v%>" name="product_notice_title"></span></th>
												<td><input type="text" class="input4" id="offer_notice_th_<%=v%>" name="product_notice_content"></td>
											</tr>
<%
}
%>
										</tbody>
									</table>
								</td>
							</tr>
							<!-- 상품별 추천상품 시작 -->
							<tr>
								<th scope="row"><span>추천상품</span></th>
								<td class="">
									<ul class="rec_prd_list">
									<% 
									if(recImgNo.size() > 0){
										for(int g=0; g<recImgNo.size(); g++){ 
									%>
										<li id="rec_prd_<%=recImgNo.get(g)%>">
											<input type="hidden" name="rec_prd_<%=recImgNo.get(g)%>" value="<%=recgSubCode.get(g)%>">
											<%if (!recgImgList.get(g).equals("")) {%>
												<div class="photo"><img src="<%=webUploadDir +"goods/"+ recgImgList.get(g)%>"></div>
											<%}else{%>
												<div class="photo"><img src=""></div>
											<%}%>
											<div class="title"><%=recNameList.get(g)%></div>
											<div class="btns">
											<%if (!recgImgList.get(g).equals("")) {%>
												<a href="javascript:void(0);" onclick="delRecPrd(<%=recImgNo.get(g)%>);">삭제 X</a>
											<%}else{%>
												<a href="javascript:void(0);" onclick="searchRecPrd(<%=recImgNo.get(g)%>);">검색</a>
											<%}%>
											</div>
										</li>
									<% 
										} 
									}else{
										for(int g=1; g<7; g++){ 
									%>
										<li id="rec_prd_<%=g%>">
											<input type="hidden" name="rec_prd_<%=g%>" value="">
											<div class="photo"></div>
											<div class="title"></div>
											<div class="btns">
												<a href="javascript:void(0);" onclick="searchRecPrd(<%=g%>);">검색</a>
											</div>
										</li>
									<% 
										}
									} 
									%>
									</ul>
								</td>
							</tr>
							<!-- 상품별 추천상품 끝 -->
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="submitContents()" class="function_btn"><span>수정</span></a>
						<a href="goods_group_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
					</div>
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- 상품별 추천상품 시작 -->
<section id="searchRecPrd" class="modal">
    <div class="inner">
    	<button class="modal_close" style="font-size: 15px; color: #fff;">X<!-- <img src="../images/common/btn/btn_close.gif"> --></button>
    	<div class="modal_header">
			<h1>상품검색</h1>
    	</div>
        <div class="modal_content">
        	<div class="searchArea">
				<form onsubmit="searchPrd(); return false;">
					<div class="ipt_group">
				    	<input type="text" class="ipt" name="searchPrdText" id="searchPrdText">
				    	<span class="ipt_right"><button type="submit" class="btn black">검색</button></span>
				    </div>
				</form>
        	</div>
        	<div class="searchResult">
        		<ul>
        			<!-- <li>
        				<a href="javascript:void(0);" onclick="setRecPrd(0001);">
        					<div class="photo"><img src="/dist/images/order/sample_order_list1.jpg"></div>
        					<div class="title">헬씨퀴진+알라까르떼 슬림</div>
        					<p>1일 1식</p>
        				</a>
        			</li> -->
        			<!-- <li class="none">검색한 제품이 없습니다.</li> -->
        		</ul>
        	</div>
        </div>
    </div>
</section>
<!-- 상품별 추천상품 끝 -->
<!-- //wrap -->
<script type="text/javascript">
function setContent(str){
	$("#"+str).val($("#miniEditorIframe_"+str).get(0).contentDocument.body.innerHTML);
}

$(document).ready(function() {
	$("#gubun2").change(cngWeek);
});

function cngWeek() {
	var gubun2			= $("#gubun2").val();

	if (gubun2 == "21" || gubun2 == "22") {
		newOptions	= {
			'2' : '2주차',
			'4' : '4주차'
		}
	} else if (gubun2 == "23") {
		newOptions	= {
			'4' : '4주차'
		}
	}
	selectedOption	= '';

	makeOption(newOptions, $("#gubun3"), selectedOption);
}

function getGroup(num) {
	$.post("goods_group_ajax.jsp", {
		mode: "getGroup",
		group_code: $("#item_code"+ num).val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				$(data).find("goodsName").each(function() {
					$("#item_name"+ num).val($(this).text());
				});
				$(data).find("goodsPrice").each(function() {
					$("#item_price"+ num).val($(this).text());
				});
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
					$("#item_name"+ num).val("");
					$("#item_price"+ num).val("");
				});
			}
		});
	}, "xml");
	return false;
}

function delTr(obj) {
	$(obj).parent().parent().remove();
}
</script>

<!-- 상품별 추천상품 시작 -->
<script>
var recPrdNum;
function searchRecPrd(id) {
	recPrdNum = id;
	modalFn.show($('#searchRecPrd'));
	$('.searchResult ul').html('');
	$("#searchPrdText").val('');
}

function delRecPrd(id) {
	$('input[name=rec_prd_'+id+']').val('');
	$('#rec_prd_'+id).find('.photo').html('');
	$('#rec_prd_'+id).find('.title').html('');
	$('#rec_prd_'+id).find('.btns').html('<a href="javascript:void(0);" onclick="searchRecPrd('+id+');">검색</a>');
}

function searchPrd() {
	var text = $("#searchPrdText").val();
	if(text == ""){
		alert("검색어를 입력해주세요!");
		return false;
	}else{
		var result = '';
		$.post("goods_group_search_ajax.jsp", {
			mode: "search",
			text: text
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					$(data).find("group").each(function() {
						groupInfo = $(this).text().split("|");
						var imgPath = "<%=webUploadDir%>" + "goods/" + groupInfo[1];
						result +=  "<li>";
						result +=		"<a href='javascript:void(0);' onclick='setRecPrd(this,0001,\""+groupInfo[2]+"\");'>";
						result +=			"<div class='photo'><img src='"+ imgPath + "' alt='이미지없음'></div>";
						result +=			"<div class='title'>" + groupInfo[0] + "</div>";
						result +=		"</a>";
						result +=  "</li>";
					});
					$('.searchResult ul').html(result);
					$(window).resize();
				} else {
					$(data).find("error").each(function() {
						alert("검색 결과가 없습니다.");
						$('.searchResult ul').html('');
					});
				}
			});
		}, "xml");
	}
	return false;
}

function setRecPrd(t,id, gcode) {
	//console.log(gcode);
	$('input[name=rec_prd_'+recPrdNum+']').val(gcode);
	$('#rec_prd_'+recPrdNum).find('.photo').html($(t).find('.photo').html());
	$('#rec_prd_'+recPrdNum).find('.title').html($(t).find('.title').html());
	$('#rec_prd_'+recPrdNum).find('.btns').html('<a href="javascript:void(0);" onclick="delRecPrd('+recPrdNum+');">삭제 X</a>');

	modalFn.hide($('#searchRecPrd'));
	$(window).scrollTop($('#rec_prd_'+recPrdNum).offset().top);
}
</script>
<!-- 상품별 추천상품 끝 -->

<!-- smart editor 2.0 -->
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "group_info",
    sSkinURI: "/smarteditor/SmartEditor2Skin.html",
    fCreator: "createSEditor2",
    // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
    bUseToolbar : true,           
    // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
    bUseVerticalResizer : true,   
    // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
    bUseModeChanger : true
});
// ‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
function submitContents() {
    oEditors.getById["group_info"].exec("UPDATE_CONTENTS_FIELD", []);
    if($("#group_name").val() == ""){
        alert("[세트그룹명] 필수 입력 사항입니다");
        $("#group_name").focus();
        return false;
    }
    if(confirm('수정 하시겠습니까?') ){
        document.frm_edit.submit();
        var forms = document.f_content;
        forms.submit();       
    }
}
// 2013.06.27 위지윅편집기 SmartEditor2 (program/common/se2) 사진첨부기능
function pasteHTML(filepath){
    var sHTML = '<span style="color:#FF0000;"><img src="'+filepath+'"></span>';
    oEditors.getById["group_info"].exec("PASTE_HTML", [sHTML]);
}
</script>

</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>