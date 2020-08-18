<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
int groupId			= 0;
if (request.getParameter("gid") != null && request.getParameter("gid").length()>0)
	groupId		= Integer.parseInt(request.getParameter("gid"));
String nowDate	= ut.inject(request.getParameter("sdate"));
String setName	= "";
String setImg	= "";
String imgUrl	= "";
int amount		= 0;

query		= "SELECT SET_NAME, THUMB_IMG, BIG_IMG, AMOUNT";
query		+= " FROM ESL_GOODS_GROUP_EXTEND G, ESL_GOODS_SET S, ESL_GOODS_CATEGORY_SCHEDULE CS";
query		+= " WHERE G.CATEGORY_ID = S.CATEGORY_ID AND CS.SET_CODE = S.SET_CODE";
query		+= " AND CS.DEVL_DATE = '"+ nowDate +"' AND G.GROUP_ID = "+ groupId;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>식단 자세히보기</title>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>식단 자세히보기</h2>
		<p></p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col center">
					<div class="food-head-center">
						<!--span class="food-prev-arrow"></span-->
						<span class="food-header-title"><%=nowDate%> 식단</span>
						<!--span class="food-next-arrow"></span-->
						<div class="clear"></div>
					</div>
					<ul class="food-plan" style="width:520px;">
						<%
						while (rs.next()) {
							setName		= rs.getString("SET_NAME");
							//setImg		= rs.getString("THUMB_IMG");
							setImg		= rs.getString("BIG_IMG");
							if (setImg.equals("") || setImg == null) {
								imgUrl		= "/images/food-day01.jpg";
							} else {
								imgUrl		= webUploadDir +"goods/"+ setImg;
							}
							amount		= rs.getInt("AMOUNT");
							if (amount > 1) {
								for (int i = 0; i < amount; i++) {
						%>
						<li>
							<div>
								<img class="food-thumb" src="<%=imgUrl%>">
							</div>
							<div>
								<%=setName%>
							</div>
						</li>
						<%
								}
							} else {
						%>
						<li>
							<div>
								<img class="food-thumb" src="<%=imgUrl%>">
							</div>
							<div>
								<%=setName%>
							</div>
						</li>
						<%
							}
						}
						%>
					</ul>
				</div>
			</div>
			<!-- End row -->
		</div>
		<!-- End popup columns offset-by-one -->
	</div>
	<!-- End contentpop -->
</div>
</body>
</html>