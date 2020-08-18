<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>


<%@ include file="/lib/config.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
int setId				= 0;
String cateName			= "";
String setName			= "";
String setInfo			= "";
String bigImg			= "";
String imgUrl			= "";
String portionSize		= "";
String calorie			= "";
String carbohydrateG	= "";
String carbohydrateP	= "";
String sugarG			= "";
String sugarP			= "";
String proteinG			= "";
String proteinP			= "";
String fatG				= "";
String fatP				= "";
String saturatedFatG	= "";
String saturatedFatP	= "";
String transFatG		= "";
String transFatP		= "";
String cholesterolG		= "";
String cholesterolP		= "";
String natriumG			= "";
String natriumP			= "";
String makeDate			= "";
int tcnt				= 0;
String caregoryCode		= request.getParameter("caregoryCode");
if (request.getParameter("set_id") != null && request.getParameter("set_id").length() > 0) {
	setId	= Integer.parseInt(request.getParameter("set_id"));

	query		= "SELECT SET_NAME, SET_INFO, BIG_IMG, PORTION_SIZE, CALORIE, CARBOHYDRATE_G, CARBOHYDRATE_P,";
	query		+= "	SUGAR_G, SUGAR_P, PROTEIN_G, PROTEIN_P, FAT_G, FAT_P, SATURATED_FAT_G, SATURATED_FAT_P,";
	query		+= "	TRANS_FAT_G, TRANS_FAT_P, CHOLESTEROL_G, CHOLESTEROL_P, NATRIUM_G, NATRIUM_P, MAKE_DATE,";
	query		+= "	(SELECT CATE_NAME FROM ESL_GOODS_CATEGORY WHERE ID = CATEGORY_ID) CATE_NAME";
	query		+= " FROM ESL_GOODS_SET S, ESL_GOODS_SET_CONTENT SC ";
	query		+= " WHERE S.ID = SC.SET_ID AND S.ID = "+ setId;
	System.out.println(query);
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}

	if (rs.next()) {
		cateName		= rs.getString("CATE_NAME");
		setName			= rs.getString("SET_NAME");
		setInfo			= rs.getString("SET_INFO");
		bigImg			= rs.getString("BIG_IMG");
		if (bigImg.equals("") || bigImg == null) {
			imgUrl		= "/images/popup_quizin_sample.jpg";
		} else {
			imgUrl		= webUploadDir +"goods/"+ bigImg;
		}
		portionSize		= rs.getString("PORTION_SIZE");
		calorie			= rs.getString("CALORIE");
		carbohydrateG	= (rs.getString("CARBOHYDRATE_G").equals(""))? "" : rs.getString("CARBOHYDRATE_G") + "<sub>g</sub>";
		carbohydrateP	= (rs.getString("CARBOHYDRATE_P").equals(""))? "" : rs.getString("CARBOHYDRATE_P") + "<sub>%</sub>";
		sugarG			= (rs.getString("SUGAR_G").equals(""))? "" : rs.getString("SUGAR_G") + "<sub>g</sub>";
		sugarP			= (rs.getString("SUGAR_P").equals(""))? "" : rs.getString("SUGAR_P") + "<sub>%</sub>";
		proteinG		= (rs.getString("PROTEIN_G").equals(""))? "" : rs.getString("PROTEIN_G") + "<sub>g</sub>";
		proteinP		= (rs.getString("PROTEIN_P").equals(""))? "" : rs.getString("PROTEIN_P") + "<sub>%</sub>";
		fatG			= (rs.getString("FAT_G").equals(""))? "" : rs.getString("FAT_G") + "<sub>g</sub>";
		fatP			= (rs.getString("FAT_P").equals(""))? "" : rs.getString("FAT_P") + "<sub>%</sub>";
		saturatedFatG	= (rs.getString("SATURATED_FAT_G").equals(""))? "" : rs.getString("SATURATED_FAT_G") + "<sub>g</sub>";
		saturatedFatP	= (rs.getString("SATURATED_FAT_P").equals(""))? "" : rs.getString("SATURATED_FAT_P") + "<sub>%</sub>";
		transFatG		= (rs.getString("TRANS_FAT_G").equals(""))? "" : rs.getString("TRANS_FAT_G") + "<sub>g</sub>";
		transFatP		= (rs.getString("TRANS_FAT_P").equals(""))? "" : rs.getString("TRANS_FAT_P") + "<sub>%</sub>";
		cholesterolG	= (rs.getString("CHOLESTEROL_G").equals(""))? "" : rs.getString("CHOLESTEROL_G") + "<sub>mg</sub>";
		cholesterolP	= (rs.getString("CHOLESTEROL_P").equals(""))? "" : rs.getString("CHOLESTEROL_P") + "<sub>%</sub>";
		natriumG		= (rs.getString("NATRIUM_G").equals(""))? "" : rs.getString("NATRIUM_G") + "<sub>mg</sub>";
		natriumP		= (rs.getString("NATRIUM_P").equals(""))? "" : rs.getString("NATRIUM_P") + "<sub>%</sub>";
		makeDate		= rs.getString("MAKE_DATE");
	}

	rs.close();
} else {
%>

<%
}
%>
</head>
<body>
	<div class="pop-wrap-info">
		<div class="headerpop">
			<%
	if (caregoryCode != null && caregoryCode.length() > 0) {		
		if(caregoryCode.equals("0301368") || caregoryCode.equals("0301368")){
			%>
			<h2>500 차림</h2>
			<%
		}else if(caregoryCode.equals("0300584") || caregoryCode.equals("0300700")){
			%>
			<h2>400 슬림식</h2>
			<%
		}else if(caregoryCode.equals("0300586") || caregoryCode.equals("0300702")){
			%>
			<h2>300 샐러드</h2>
			<%
		}else if(caregoryCode.equals("0300965")){
			%>
			<h2>300 덮밥</h2>
			<%
		}
	}
	%>
		</div>
		<div class="contentpop">
			<div class="info_summary">
				<div class="info_txt">
					<div class="info_summary_header">
						<h3><%=setName %><span class="title_bg"></span></h3>
						<p>총1회 제공량 <%=portionSize %>g</p>
					</div>
					<div class="info_thumbnail">
						<img src="<%=imgUrl %>" alt="메뉴설명" />
						<p>* 이해를 돕기위한 사진으로 실 제품과 차이가 있을 수 있습니다.</p>
					</div>
					<div class="info_summary_cont">
						<%=setInfo %>
					</div>
				</div>
			</div>
			<div class="info_detail">
				<div class="info_detail_header">
					<h4>영양성분표</h4>
				</div>
				<div class="info_detail_cont">
					<div class="info_detail_spec">
						<table>
							<thead>
								<tr>
									<th>영양성분</th>
									<th>1회 제공량당 함량</th>
									<th>%영양소 기준치</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>열량</th>
									<td><%=calorie %>kcal</td>
									<td></td>
								</tr>
								<tr>
									<th>탄수화물</th>
									<td><%=carbohydrateG %></td>
									<td><%=carbohydrateP %></td>
								</tr>
								<tr>
									<th class="d2">당류</th>
									<td><%=sugarG %></td>
									<td><%=sugarP %></td>
								</tr>
								<tr>
									<th>단백질</th>
									<td><%=proteinG %></td>
									<td><%=proteinP %></td>
								</tr>
								<tr>
									<th>지방</th>
									<td><%=fatG %></td>
									<td><%=fatP %></td>
								</tr>
								<tr>
									<th class="d2">포화지방</th>
									<td><%=saturatedFatG %></td>
									<td><%=saturatedFatP %></td>
								</tr>
								<tr>
									<th class="d2">트랜스지방</th>
									<td><%=transFatG %></td>
									<td><%=transFatP %></td>
								</tr>
								<tr>
									<th>콜레스테롤</th>
									<td><%=cholesterolG %></td>
									<td><%=cholesterolP %></td>
								</tr>
								<tr>
									<th>나트륨</th>
									<td><%=natriumG %></td>
									<td><%=natriumP %></td>
								</tr>
							</tbody>
						</table>
						<p>%영양소 기준치 : 1일 영양소 기준치에 대한 비율</p>
					</div>
				</div>
				<div class="info_detail_footer">
					<div class="info_detail_caption">
						<p>상품제공일 27시간 이내 제조 </p>
						<p>유통기한 : 제조일로부터 52시간 이내</p>
					</div>
				</div>
			</div>
		</div>
	</div>
		<!-- End contentpop -->
	</div>
</body>
</html>