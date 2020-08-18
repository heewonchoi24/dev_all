<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
	String query			= "";
	int groupId				= 0;
	int price				= 0;
	int totalPrice			= 0;
	int realPrice			= 0;
	String groupInfo		= "";
	String offerNotice		= "";
	String groupName		= "";
	NumberFormat nf			= NumberFormat.getNumberInstance();
	String table			= " ESL_GOODS_GROUP";
	String where			= " WHERE GUBUN1 = '01' AND GUBUN2 = '11'";
	String sort				= " ORDER BY ID ASC";
%>
</head>

<SCRIPT type="text/javascript">
var _TRK_PI = "PDV";
var _TRK_PNG = "�Ļ���̾�Ʈ";
var _TRK_PNG_NM = "01";
var _TRK_PNC = "0300719";
var _TRK_PNC_NM = "�˶���";
</SCRIPT>

<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> �˶��� </h1>
			<div class="pageDepth">
				HOME > ��ǰ�Ұ� > <strong>�˶���</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="alacarte_pr">
					   <h2><img src="/images/alacarte_tit.png" width="507" height="147"></h2>
					   <div class="chep_img">
					       <img src="/images/alacarte_img_1.png" width="463" height="341">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">�������� ���缳��</p>
						   <p>GI/GL�� ������ ���̾�Ʈ �Ļ翡 �����Ͽ�,<br />ź��ȭ�� Ư���� ���� ������ ü�� �������<br />����ϰ�, �׿� ���� ������ �Ĵ��� ����</p>
					   </div>
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">���� ������ �Ļ�</p>
						   <p style="text-align:right;">�Ļ��غ� �ʿ���� ����(�繫��)����<br />�ٷ� or ����⸸ �ϸ� OK!<br />��� 265kcal�� ���̾�Ʈ ���� �Ĵ�</p>
					   </div>
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right;">������ ����µ� ����</p>
						   <p style="text-align:right;">����� ���� ��޹ޱ���� ����0~10&deg;C��<br />������ �� �ֵ��� Ǯ���� �ؽż���۽ý�������<br />���������µ� ���� �� ������Ű�� ����</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">ȣ����� ��������<br />��ġ�� ���� ��ǥ�丮</p>
						   <p>���� ������ ��ǥ�丮�� ȣ����� �ս��� ��������<br />���� ���� �������� ���̾�Ʈ������ ��ź��</p>
					   </div>
					   <div class="chep_05">
					       <p class="f24 bold8 goodtt">�ǰ������Ƿ� ����</p>
						   <p>���̼����� �ܹ����� ǳ���� �Ļ籸����<br />�����ϸ�, Ƣ���� �ʰ� ������ �ּ�ȭ</p>
					   </div>
					</div>
				</div>
			</div>
			<!-- End Row -->
			
			<div class="divider">
			</div>
			<div class="row">
				<div class="one last col">
					<dl class="quizintit">
						<dt>�˶��� ����</dt>
						<dd>������ One-dish Meal ���·� ���� Į�θ��� �ż��� Designed Diet Meal</dd>
					</dl>
					
					<!-- ���� ����Ʈ -->
					<div class="foodlist">
						<%
						int setId			= 0;
						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 9 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();

						int i			= 0;
						int divNum		= 0;
						String divClass	= "";
						while (rs.next()) {
							setId		= rs.getInt("ID");
							thumbImg	= rs.getString("THUMB_IMG");
							if (thumbImg.equals("") || thumbImg == null) {
								imgUrl		= "/images/quizin_sample.jpg";
							} else {										
								imgUrl		= webUploadDir +"goods/"+ thumbImg;
							}
							setName		= rs.getString("SET_NAME");
							calorie		= (rs.getString("CALORIE").equals(""))? "" : rs.getString("CALORIE") + "kcal";

							divNum		= i % 8;
							if (divNum == 0) {
								divClass	= " first";
							} else if (divNum == 8) {
								divClass	= " last";
							} else {
								divClass	= "";
							}
						%>
						<div class="food<%=divClass%>">
							<div>
								<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" />
								<div class="food-link">
								<div class="food-calorie">
									<%=calorie%>
								</div>
								<div class="food-title">
									<%=setName%>
								</div>
								</div>
								</a>
							</div>
						</div>
						<%
							i++;
						}
						%>
						<div class="clear">
						</div>
					</div>
					<!-- End ���� ����Ʈ -->
				</div>
				<div class="one last col">
					<dl class="quizintit">
						<dt>�˶��� �ﾾ</dt>
						<dd>������ One-dish Meal ���·�  �����Դ� ���� Į�θ��� ����� Designed Diet Meal</dd>
					</dl>
					
					<!-- ���� ����Ʈ -->
					<div class="foodlist">
						<%
						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 10 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();

						i			= 0;
						divNum		= 0;
						while (rs.next()) {
							setId		= rs.getInt("ID");
							thumbImg	= rs.getString("THUMB_IMG");
							if (thumbImg.equals("") || thumbImg == null) {
								imgUrl		= "/images/quizin_sample.jpg";
							} else {										
								imgUrl		= webUploadDir +"goods/"+ thumbImg;
							}
							setName		= rs.getString("SET_NAME");
							calorie		= (rs.getString("CALORIE").equals(""))? "" : rs.getString("CALORIE") + "kcal";

							divNum		= i % 8;
							if (divNum == 0) {
								divClass	= " first";
							} else if (divNum == 8) {
								divClass	= " last";
							} else {
								divClass	= "";
							}
						%>
						<div class="food<%=divClass%>">
							<div>
								<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" />
								<div class="food-link">
								<div class="food-calorie">
									<%=calorie%>
								</div>
								<div class="food-title">
									<%=setName%>
								</div>
								</div>
								</a>
							</div>
						</div>
						<%
							i++;
						}
						%>
						<div class="clear">
						</div>
					</div>
					<!-- End ���� ����Ʈ -->
					<p class="mart10 marb10">* �˶��� ������ ��ũ�� �����ǰ�, �˶��� �ﾾ�� ����Ű�� �����˴ϴ�.	</p>
				</div>
			</div>
			<!-- End Row -->
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="/shop/dietMeal.jsp?tab=9">�ֹ��ϱ�</a>
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
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
</body>
</html>