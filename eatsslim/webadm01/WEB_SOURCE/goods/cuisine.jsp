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
var _TRK_PNC = "0300717";
var _TRK_PNC_NM = "����";
</SCRIPT>

<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> ���� </h1>
			<div class="pageDepth">
				HOME > ��ǰ�Ұ� > <strong>����</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="cuisine_pr">
					   <h2><img src="/images/cuisine_tit.png" width="712" height="149"></h2>
					   <div class="chep_img">
					       <img src="/images/cuisine_img.png" width="431" height="275">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">���� �ٸ� �޴��� ��޵Ǵ�<br />Į�θ��� ���� ���ö�</p>
						   <p>�ѽ� or ������� ���ϸ��� ���ٸ� �޴��� ��޵Ǿ�<br />���ڷ������� ���� �ٷ� �����ϴ� ������ ��Į�θ� ���ö�<br />(�� 5ȸ, 2��/4�� �ֹ�, ��20������ �޴�)</p>
					   </div>
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">���� ����<br />�ΰ��� ��θ�<br />�츰 �丮!</p>
						   <p style="text-align:right;">������ ǳ���� ����Ǫ��, ���<br />ȣ����� Ǯ���� �������� �����Ƿ� ����<br />���� ������ ��� �츰 �丮!</p>
					   </div>
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right;">������ ����µ� ����</p>
						   <p style="text-align:right;">����� ���� ��޹ޱ���� ����0~10&deg;C��<br />������ �� �ֵ��� Ǯ���� �ؽż���۽ý�������<br />���������µ� ���� �� ������Ű�� ����</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">���̾�Ʈ�� ����<br />�������� ���缳��</p>
						   <p>ź��ȭ��:����:�ܹ����� Ȳ�ݺ����� ���缳�迡<br />Ƣ���� �ʴ� �������������� ����<br />��� 367Kcal�� Į�θ� Down �Ļ�</p>
						   <p>���� ������差 2,000mg ��Ʈ�� ���ؿ� ����<br />��Ʈ�� Down �Ļ�</p>
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
						<dt>���� STYLE</dt>
						<dd>�ѽ�/��� �پ��� �޴��� Į�θ� & ��Ʈ�� Down�� �ǰ��Ĵ����� �������� <strong>Designed Diet Meal</strong></dd>
					</dl>
					<!-- ���� ����Ʈ -->
					<div class="foodlist">
						<%
						int setId			= 0;
						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 7 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
					<p class="mart10 marb10">* �ս��������� ���ʿ��� ��ȸ��ǰ ����� ���̰�, ���̾�Ʈ �Ľ����� ����̱� ���ؼ� <strong>�Ϻ� �޴��� �������� ����</strong>�˴ϴ�. <br />
					* �������� �����Ǵ� ���� �޴� : ��ġ���챸�̼�Ʈ, �κε����ļ�Ʈ, �ſ��������Ʈ, �߰�Ⱓ����Ʈ, ġŲ�س����ͽ���Ʈ, ���̹��������Ұ�⼼Ʈ, ������߲�����Ʈ
					</p>
				</div>
			</div>
			<!-- End Row -->
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="/shop/dietMeal.jsp">�ֹ��ϱ�</a>
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