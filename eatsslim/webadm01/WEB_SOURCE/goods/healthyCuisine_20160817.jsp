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
	String where			= " WHERE GUBUN1 = '01' AND GUBUN2 = '21'";
	String sort				= " ORDER BY ID ASC";
%>
</head>

<SCRIPT type="text/javascript">
var _TRK_PI = "PDV";
var _TRK_PNG = "�ǰ����ö�";
var _TRK_PNG_NM = "00";
var _TRK_PNC = "0301368";
var _TRK_PNC_NM = "�ﾾ����";
</SCRIPT>

<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> �ﾾ���� </h1>
			<div class="pageDepth">
				HOME > ��ǰ�Ұ� > <strong>�ﾾ����</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="healthyCuisine_pr">
					<h2><span class=".font-maple">����� �ż��� �ڿ� ����Ḧ ����</span>�Ͽ� ���缳��� �ǰ� ���ö�</h2>
					<h3>��Ʈ��, Į�θ� ����, Low GL�����<br />������ �� ���ִ� �Ļ�, <strong>�ﾾ����</strong></h3>
					<!--<h2><img src="/images/healthyCuisine_tit.png" width="681" height="145"></h2> -->
					   <div class="chep_img">
					       <img src="/images/healthyCuisine_img.png" width="406" height="280">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">�ڿ��� ����<br />�ǰ� ���ö�</p>
						   <p>����� �ż��� ��ö �ڿ�����Ḧ �����Ͽ�<br />����, ������ ���� ä�� 2����, ����,<br />Ƣ���� �ʴ� �������� ������<br />�ǰ� ���ö� </p>
					   </div>
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">ü�� ���� ��<br />�ǰ� ����</p>
						   <p style="text-align:right;">������ ���� �ǰ� ������ ü�� ������<br />�����ϵ��� ����� ��ǰ</p>
					   </div>
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right;">1�� 40eGL����<br />�ս��� Low GL</p>
						   <p style="text-align:right;">�ѱ����� High GL���� �����ϰ� �־�<br />���κ񸸰� ������ı� ������ ������<br />Low GL�Ļ�� ������ ��ȭ���� ũ�� �ʰ�<br />���������� ������ �� �־�<br /> ������ ������ �Ŀ� ������ ����</p>
						   <p style="text-align:right;">* eGL(estimated Glycemic Load)�� GL��<br />�����ϱ� ���Ͽ� Ǯ�������� �ӻ󿬱��� ����<br />������ GL�������� �ѱ��� ��� ���� eGL��<br />1�� 162eGL, �ﾾ������ 1�� 120eGL��Ģ ����!</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">�������� ���缳��</p>
						   <p>����������ȸ������ȸ �����ڹ�,<br />1�� ���� kcal ��� 500kcal����,<br />��Ʈ�� ��� 950mg����,<br />40eGL�� ���缳�� ����</p>
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
						<dt>�ﾾ���� STYLE</dt>
						<dd>����� �ż��� �ڿ� ����Ḧ �����Ͽ� ���� ����� <strong>Designed Healthy Meal</strong></dd>
					</dl>
					<!-- ���� ����Ʈ -->
					<div class="foodlist">
						<%
						int setId			= 0;

						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 16 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
								<a class="food-thumb2 lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" /></a> <a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>">
								<div class="food-calorie">
									<%=calorie%>
								</div>
								<div class="food-title">
									<%=setName%>
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
			</div>
			<!-- End Row -->
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="/shop/healthyMeal.jsp">�ֹ��ϱ�</a>
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

<!-- �̵��ť�� ��ũ��Ʈ 2016-06-24 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=1035515&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>

</body>
</html>