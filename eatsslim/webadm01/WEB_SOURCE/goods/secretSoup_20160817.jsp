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
var _TRK_PNG = "�����";
var _TRK_PNG_NM = "03";
var _TRK_PNC = "0331";
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
			<h1> ��ũ������ </h1>
			<div class="pageDepth">
				HOME > ��ǰ�Ұ� > <strong>��ũ������</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
				<div class="one last col">
					<div class="secret_pr">
					   <h2><img src="/images/secret_tit.png" width="442" height="152"></h2>
					   <div class="chep_img">
					       <img src="/images/secret_img2.png" width="456" height="347">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">Į�θ� DOWN</p>
						   <p>ź��ȭ�� Ư���� ����� ����Ḧ<br />�������� ������ ���� ��� ü������<br />����Ǵ� ������ ���ߵ��� ����</p>
					   </div>
					   <!--
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">Beauty&Balance</p>
						   <p style="text-align:right;">�峻 �躯Ȱ���� ��Ȱ�ϰ� �����ִ�<br />���̼����� ��Ƽ������ �ݶ���� �־�<br />���̾�Ʈ �Ⱓ�� �����ϱ� ����<br />�뷱���� ����</p>
					   </div>
					   -->
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt" style="text-align:right;">���ִ� ��ũ�� ����</p>
						   <p style="text-align:right;">�丶�� �Ľ�Ÿ, ����, �̿��� ��������<br />������ ���� ���ִ� ��ũ�� ����</p>
					   </div>
					   <div class="chep_04">
					       <p class="f24 bold8 goodtt">��� ���� ������</p>
						   <p>6���� ��� ���� ����<br />Ȩ���̵�Ÿ�� �����Դϴ�.<br />������ ���� ������ ǳ���� �����(��)��<br />����, ���, �߰�����, ����Ʈ�����<br />������ �ս������� ��� ������!</p>
					   </div>
					   <div class="chep_05">
					       <img src="../images/secret_img2dec.png" width="445" height="129">
						</div>
					</div>
					<div class="secret_pr2 marb50">
					    <div class="chep_01">
						     <img src="/images/secret_img3.png" width="1000" height="139">
						</div>
					</div>
					<div class="secret_pr3 marb50">
					    <div class="chep_01">
					       <img src="/images/secret_img4.png" width="863" height="140">
						</div>
					</div>
					<h2>��ũ������ ������</h2>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>��</th>
							<th>ȭ</th>
							<th>��</th>
							<th>��</th>
					<!--		<th>��</th>
							<th class="last">��</th> -->
							<th class="last">��</th>
						</tr>
						<tr>
							<td><p class="secr_soup bbl">����D</p>����Ʈ ���丶�� ǳ���<br />+<br />���������</td>
							<td><p class="secr_soup ggr">����E</p>���������<br />+<br />�߰����� �̿����</td>
							<td><p class="secr_soup bbr">����F</p>�߰����� �̿����<br />+<br />����Ʈ ���丶�� ǳ���</td>
							<td><p class="secr_soup bbl">����D</p>����Ʈ ���丶�� ǳ���<br />+<br />���������</td>
							<td><p class="secr_soup ggr">����E</p>���������<br />+<br />�߰����� �̿����</td>
	<!--						<td><p class="secr_soup bbr">����F</p>�߰����� �̿����<br />+<br />����Ʈ ���丶�� ǳ���</td> -->
						</tr>
					</table>
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
						<dt>��ũ������</dt>
						<dd>6���� ������� ���̼���/�ݶ������ ������� Ȩ���̵� Ÿ�� 3�� ��ũ�� ����</dd>
					</dl>
					
					<!-- ���� ����Ʈ -->
					<div class="foodlist">
						<%
						int setId			= 0;
						String thumbImg		= "";
						String imgUrl		= "";
						String setName		= "";
						String calorie		= "";

						query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 6 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
						<a href="/shop/secretSoup.jsp">�ֹ��ϱ�</a>
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