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
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> �̴Ϲ� </h1>
			<div class="pageDepth">
				HOME > ��ǰ�Ұ� > <strong>�̴Ϲ�</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="mini_pr">
					   <h2><img src="/images/mini_tit.png"></h2>
					   <div class="chep_img">
					       <img src="/images/minimeal_img2.png" width="425" height="350">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">Simple! �̴��� Ÿ������<br />�Ѽ����� �����ϰ�</p>
						   <p>���� ��𼭳� �����ϰ� �ѳ� �ذ�!<br /> 
���̾���, �ٻ� ������ �� �����ε��� �ǰ���<br /> �� ���� ���� Mini- Cup Ÿ������ �Ѽտ�<br /> ��� �����ϰ� �����ϴ� One-dish meal</p>
					   </div>
					   <!--
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">Beauty&Balance</p>
						   <p style="text-align:right;">�峻 �躯Ȱ���� ��Ȱ�ϰ� �����ִ�<br />���̼����� ��Ƽ������ �ݶ���� �־�<br />���̾�Ʈ �Ⱓ�� �����ϱ� ����<br />�뷱���� ����</p>
					   </div>
					   -->
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right; margin-right:40px;">Tasty! ���̾�Ʈ �߿���<br/>���ְ� ����!</p>
						   <p style="text-align:right; margin-right:40px;">200kcal���� �������� �ִ� ����� ��������<br/> ����ϰ� ���ְ� ��� �� �ִ� �ս��� �̴Ϲ�!<br/> ���̼����� ǳ���� �������� ���ϴ�<br/> ����, �͸�, ���� ���� ���� ����� ���!</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">Healthy! ���۰,Ǫ���<br/>�ǰ��� ���̾�Ʈ��</p>
						   <p>���۰ ����ƿ� �͸��� ����� ���,<br/>�ڼ�������, ���� �� ��� �޴���<br/>�ǰ� ����� ����� ������ �ǰ�����!<br/>����Ǫ�� ���� �� ���, �κ� ��<br/>���̾�Ʈ�� ������ �ִ� ��Ḧ ���!</p>
					   </div>					 
					</div>
					<div class="mini_pr2 marb50"></div>			
				</div>
			</div>
			<!-- End Row --> 
			<!-- 
            <div class="row">
			    <div class="one last col">
                <!-- 
                <img src="/images/secret_info.jpg" width="999" height="321">        
                </div>
               <div class="clear"></div> 
            </div>
             -->			
			<div class="divider">
			</div>
			<div class="row">
				<div class="one last col">
					<dl class="quizintit">
						<dt>�ս��� �̴Ϲ�</dt>
						<dd>Į�θ� �������� ������� �����</dd>
					</dl>					
					<!-- ���� ����Ʈ -->
					<div class="foodlist">
						<%
						int setId			= 0;
						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 13 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
								<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" /></a> <a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>">
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
						<a href="/shop/minimeal.jsp">�ֹ��ϱ�</a>
					</div>
				</div>
			</div>
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