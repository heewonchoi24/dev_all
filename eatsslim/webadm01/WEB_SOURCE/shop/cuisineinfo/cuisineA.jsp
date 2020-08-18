<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
request.setCharacterEncoding("euc-kr");
String query 	= "";
String setId	= ut.inject(request.getParameter("set_id") );
String caregoryCode		= ut.inject(request.getParameter("caregoryCode") );
//System.out.println(caregoryCode);
query		= "SELECT ";
query		+= " 		(SELECT CATE_NAME FROM ESL_GOODS_CATEGORY WHERE ID = a.CATEGORY_ID) CATE_NAME, ";
query		+= " 		a.SET_NAME, a.BIG_IMG, b.PORTION_SIZE, c.PRDT_NAME, a.SET_INFO, c.PRDT_TYPE, c.PRODUCER, c.RAW_MATERIALS, b.CALORIE, ";
query		+= " 		b.CARBOHYDRATE_G, b.CARBOHYDRATE_P, b.SUGAR_G, b.SUGAR_P, b.PROTEIN_G, b.PROTEIN_P, ";
query		+= " 		b.FAT_G, b.FAT_P, b.SATURATED_FAT_G, b.SATURATED_FAT_P, b.TRANS_FAT_G, b.TRANS_FAT_P, b.CHOLESTEROL_G, b.CHOLESTEROL_P, b.NATRIUM_G, b.NATRIUM_P ";
query		+= " FROM ESL_GOODS_SET a ,ESL_GOODS_SET_CONTENT b, ESL_GOODS_SET_ORIGIN c";
query		+= " WHERE a.ID = b.SET_ID";
query		+= " AND a.ID = c.SET_ID";
query		+= " AND a.USE_YN = 'Y'";
query		+= " AND a.ID = '"+setId+"'";

System.out.println(query);

pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

String cateName			= "";
String setName 			= "";
String portionSize 		= "";
String setInfo			= "";
String prdtType			= "";
String producer			= "";
String rawMaterials		= "";
String calorie			= "";
String carbohydrateG	= "";
String carbohydrateP	= "";
String sugarG			= "";
String sugarP  	        = "";
String proteinG	        = "";
String proteinP         = "";
String fatG	            = "";
String fatP	            = "";
String saturatedFatG	= "";
String saturatedFatP    = "";
String transFatG	    = "";
String transFatP        = "";
String cholesterolG     = "";
String cholesterolP     = "";
String natriumG         = "";
String natriumP         = "";
String prdtName			= "";
String bigImg			= "";
if(rs.next()){
	cateName = ut.isnull(rs.getString("CATE_NAME") );
	setName = rs.getString("SET_NAME");
	portionSize = rs.getString("PORTION_SIZE");
	setInfo = rs.getString("SET_INFO");
	prdtType = rs.getString("PRDT_TYPE");
	producer = rs.getString("PRODUCER");
	rawMaterials = rs.getString("RAW_MATERIALS");
	calorie = rs.getString("CALORIE");
	carbohydrateG = rs.getString("CARBOHYDRATE_G");
	carbohydrateP = rs.getString("CARBOHYDRATE_P");
	sugarG = rs.getString("SUGAR_G");
	sugarP = rs.getString("SUGAR_P");
	proteinG = rs.getString("PROTEIN_G");
	proteinP = rs.getString("PROTEIN_P");
	fatG = rs.getString("FAT_G");
	fatP = rs.getString("FAT_P");
	saturatedFatG = rs.getString("SATURATED_FAT_G");
	saturatedFatP = rs.getString("SATURATED_FAT_P");
	transFatG = rs.getString("TRANS_FAT_G");
	transFatP = rs.getString("TRANS_FAT_P");
	cholesterolG = rs.getString("CHOLESTEROL_G");
	cholesterolP = rs.getString("CHOLESTEROL_P");
	natriumG = rs.getString("NATRIUM_G");
	natriumP = rs.getString("NATRIUM_P");
	prdtName = rs.getString("PRDT_NAME");
	bigImg = rs.getString("BIG_IMG");
}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>상품 상세정보</title>
</head>
<body>
<div class="pop-wrap-info">
	<div class="headerpop">
		<h2><%=cateName%></h2>
	</div>
	<div class="contentpop">
		<div class="info_summary">
			<div class="info_thumbnail">
				<img src="/data/goods/<%=bigImg %>" alt="메뉴설명" width="450" height="450" />
				<p>* 이해를 돕기위한 사진으로 실 제품과 차이가 있을 수 있습니다.</p>
			</div>
			<div class="info_txt">
				<div class="info_summary_header">
					<h3><%=setName %><span class="title_bg"></span></h3>

					<p>총1회 제공량 <%=portionSize %>g</p>
				</div>
				<div class="info_summary_cont">
					<%=setInfo %>
				</div>
			</div>
		</div>
		<div class="info_detail">
			<div class="info_detail_header">
				<h4>영양정보</h4>
				<p>총 내용량 <%=portionSize %>g, <%=calorie %>kcal</p>
			</div>
			<div class="info_detail_cont">
				<div class="info_detail_spec1">
					<table class="spectable">
						<thead>
							<tr>
								<th></th>
								<th>탄수화물</th>
								<th>당류</th>
								<th>단백질</th>
								<th>지방</th>
								<th>포화지방</th>
								<th>트랜스지방</th>
								<th>콜레스테롤</th>
								<th>나트륨</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>총 함량</th>
								<td><span class="mg01"><%=carbohydrateG %><sub>g</sub></span></td>
								<td><span class="mg02"><%=sugarG %><sub>g</sub></span></td>
								<td><span class="mg03"><%=proteinG %><sub>g</sub></span></td>
								<td><span class="mg04"><%=fatG %><sub>g</sub></span></td>
								<td><span class="mg05"><%=saturatedFatG %><sub>g</sub></span></td>
								<td><span class="mg06"><%=transFatG %><sub>g</sub></span></td>
								<td><span class="mg07"><%=cholesterolG %><sub>mg</sub></span></td>
								<td><span class="mg08"><%=natriumG %><sub>mg</sub></span></td>
							</tr>
							<tr>
								<th>%영양성분 기준치</th>
								<td><span class="mg01"><%=carbohydrateP %><sub>%</sub></span></td>
								<td><span class="mg02"><%=sugarP %></span></td>
								<td><span class="mg03"><%=proteinP %><sub>%</sub></span></td>
								<td><span class="mg04"><%=fatP %><sub>%</sub></span></td>
								<td><span class="mg05"><%=saturatedFatP %><sub>%</sub></span></td>
								<td><span class="mg06"><%=transFatP %></span></td>
								<td><span class="mg07"><%=cholesterolP %><sub>%</sub></span></td>
								<td><span class="mg08"><%=natriumP %><sub>%</sub></span></td>
							</tr>
						</tbody>
					</table>
					<p>1일 영양성분 기준치에 대한 비율(%)은 2,000 kcal 기준이므로 개인의 필요 열량에 따라 다를 수 있습니다.</p>
				</div>
				<div class="info_detail_spec2">
					<table class="spectable2">
						<tbody>
							<tr>
								<th>제품명</th>
								<td><%=setName %></td>
							</tr>
							<tr>
								<th>식품의 유형</th>
								<td><%=prdtType %></td>
							</tr>
							<tr>
								<th>생산자 및 소재지</th>
								<td><%=producer %></td>
							</tr>
							<tr>
								<th>원재료명 및 함량</th>
								<td><%=rawMaterials %></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="info_detail_footer">
				<div class="info_detail_tip">
					<ul>
						<li>잇슬림은 고객분들께 더 좋은 제품을 제공해드리고자 샐러드, 곁들이찬 등의 세부 메뉴를 지속적으로 개선하고 있습니다.</li>
						<li>사진과 실 제품의 차이가 있을 수 있는 점 양해 부탁드립니다.</li>
						<li>잇슬림에서는 불필요한 일회용품 사용을 줄이고, 다이어트 식습관을 길들이기 위해서 일부 메뉴는 젓가락만 제공됩니다.</li>
						<li>500 차림:젓가락만 포함 / 400슬림식:일부 메뉴 숟가락 제공 / 300샐러드:포크 / 300덮밥:스포키 / 400슬림식:일부 메뉴 숟가락 제공</li>
					</ul>
				</div>
				<div class="info_detail_caption">
					<p>상품제공일 : 27시간 이내 제조 / 유통기한 : 제조일로부터 52시간 이내(수령일까지)<br>잇슬림에 대한 문의는 마이페이지 1:1 문의 또는 ☎ 080-800-0434로 문의주세요.</p>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>