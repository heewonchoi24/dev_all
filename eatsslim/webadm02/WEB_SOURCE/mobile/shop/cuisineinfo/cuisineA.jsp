<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
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

if (request.getParameter("set_id") != null && request.getParameter("set_id").length() > 0) {
	setId	= Integer.parseInt(request.getParameter("set_id"));

	query		= "SELECT SET_NAME, SET_INFO, BIG_IMG, PORTION_SIZE, CALORIE, CARBOHYDRATE_G, CARBOHYDRATE_P,";
	query		+= "	SUGAR_G, SUGAR_P, PROTEIN_G, PROTEIN_P, FAT_G, FAT_P, SATURATED_FAT_G, SATURATED_FAT_P,";
	query		+= "	TRANS_FAT_G, TRANS_FAT_P, CHOLESTEROL_G, CHOLESTEROL_P, NATRIUM_G, NATRIUM_P, MAKE_DATE,";
	query		+= "	(SELECT CATE_NAME FROM ESL_GOODS_CATEGORY WHERE ID = CATEGORY_ID) CATE_NAME";
	query		+= " FROM ESL_GOODS_SET S, ESL_GOODS_SET_CONTENT SC ";
	query		+= " WHERE S.ID = SC.SET_ID AND S.ID = "+ setId;
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
	<div class="pop-wrap">
		<div class="headpop">
		    <h2><%=cateName%></h2>
            <button id="cboxClose" type="button">close</button>
            <div class="clear"></div>
		</div>
	    <div class="contentpop">
		    <div class="food-info bg-gray">
                <img class="detail-thumb" src="<%=imgUrl%>" width="131" height="80">
                <h3><%=setName%></h3>
                <p class="subject">총1회 제공량 <%=portionSize%>g</p>
                <p><%=setInfo%></p>
            </div>
          <div class="row">
            <h3>영양성분표</h3>
            <table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <th>영양성분</th>
                    <th>1회 제공량당 함량</th>
                    <th>% 영양소 기준치</th>
                  </tr>
                  <tr>
                    <td class="subj">열량</td>
                    <td><%=calorie%>kcal</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="subj none">탄수화물</td>
                    <td class="none"><%=carbohydrateG%></td>
                    <td class="none"><%=carbohydrateP%></td>
                  </tr>
                  <tr>
                    <td class="part">당류</td>
                    <td><%=sugarG%></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="subj">단백질</td>
                    <td><%=proteinG%></td>
                    <td><%=proteinP%></td>
                  </tr>
                  <tr>
                    <td class="subj none">지방</td>
                    <td class="none"><%=fatG%></td>
                    <td class="none"><%=fatP%></td>
                  </tr>
                  <tr>
                    <td class="part none">포화지방</td>
                    <td class="none"><%=saturatedFatG%></td>
                    <td class="none"><%=saturatedFatP%></td>
                  </tr>
                  <tr>
                    <td class="part">트랜스지방</td>
                    <td><%=transFatG%></td>
                    <td><%=transFatP%></td>
                  </tr>
                  <tr>
                    <td class="subj">콜레스트롤</td>
                    <td><%=cholesterolG%></td>
                    <td><%=cholesterolP%></td>
                  </tr>
                  <tr>
                    <td class="subj">나트륨</td>
                    <td><%=natriumG%></td>
                    <td><%=natriumP%></td>
                  </tr>
            </table>
            <p class="guide">%영양소 기준치:1일 영양소 기준치에 대한 비율</p>
            </div>
	  </div>
		<!-- End contentpop -->
	</div>
</body>
</html>