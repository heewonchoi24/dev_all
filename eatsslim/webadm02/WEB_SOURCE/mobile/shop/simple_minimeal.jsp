<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
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
	String portionSize = "";
%>
</head>
<body>
<div id="wrap">
  <div class="ui-header-fixed" style="overflow:hidden;">
    <%@ include file="/mobile/common/include/inc-header.jsp"%>
    <ul class="subnavi">
      <li><a href="/mobile/shop/dietMeal.jsp">�Ļ���̾�Ʈ</a></li>
      <li><a href="/mobile/shop/fullStep.jsp">���α׷����̾�Ʈ</a></li>
      <li class="current"><a href="/mobile/shop/secretSoup.jsp">Ÿ�Ժ����̾�Ʈ</a></li>
    </ul>
  </div>
  <!-- End ui-header -->
  <!-- Start Content -->
  <div id="content" style="margin-top:135px;">
    
	<div class="grid-navi">
      <table class="navi" border="0" cellspacing="10" cellpadding="0">
        <tr>
          <td><a href="/mobile/shop/popup/ssoup_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
          <td><a href="/mobile/shop/typeDiet_order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">Ÿ�Ժ� ���̾�Ʈ �����ϱ�</span></span></a></td>
        </tr>
      </table>
    </div>
	<div class="grid-navi">
      <table class="navi" cellspacing="10" cellpadding="0">
        <tr>
          <td>
			 <a href="#" class="ui-btn ui-btn-inline ui-btn-up-a">
				<span class="ui-btn-inner">
					<span class="ui-btn-text">�����</span></span><span class="active">
				</span>
			</a>
		  </td>
          <td><a href="/mobile/shop/balanceShake.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner"><span class="ui-btn-text">�뷱�� ����ũ</span></span></a></td>
        </tr>
		<tr class="easyMeal">
			<td colspan="2">
				<span><a class="here" href="#">�ս��� �̴Ϲ�</a></span>
				<span><a href="/mobile/shop/simple_rice.jsp">�ս��� ���̽�</a></span>
				<span><a href="/mobile/shop/simple_secretsoup.jsp">��ũ������</a></span>
			</td>
	    </tr>
      </table>
    </div>
    
    <div class="divider"></div>
    <div class="row">
      <div class="bg-gray font-brown">
        <p>�Ѽտ� ��, �����ϰ� ���� �̴��Ź� Į�θ� �������� ��� ���� �����, �ս��� �̴Ϲ�</p>
        <div class="mart20 marb30"><img src="/mobile/images/shop_minimeal_01.jpg" width="100%" alt="" /></div>
        <div class="memo">
          <div class="ribbon-tit"></div>
          <ul>
            <li class="memo05">���۰, Ǫ�带 ����� ������ �ǰ��� ���̾�Ʈ</li>
            <li class="memo04">�̴��� Ÿ������ ���� ��𼭳� �����ϰ�!</li>
            <li class="memo02">���̾�Ʈ �߿��� ���ְ�</li>
            <li class="memo01">���� ���Ӱ� ��ſ� ���̾�Ʈ</li>
            <li class="memo03">���̼����� ǳ���� �������� ���ϴ� ����� ���</li>
            <li class="memo07">��� 200kcal</li>
          </ul>
        </div>
      </div>
    </div>
    <div class="row">
      <ul class="ui-listview">
        <%
					int setId			= 0;
					String thumbImg		= "";
					String imgUrl		= "";
					String setName		= "";
					String calorie		= "";

					query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG,PORTION_SIZE FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 6 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
						calorie		= (rs.getString("CALORIE").equals(""))? "" : rs.getString("CALORIE");

						portionSize = rs.getString("PORTION_SIZE");

						divNum		= i % 3;
						if (divNum == 0) {
							divClass	= " ui-first-child";
						} else if (divNum == 8) {
							divClass	= " ui-last-child";
						} else {
							divClass	= "";
						}



						

					%>
        <li class="ui-btn ui-btn-up-e ui-li ui-li-has-thumb<%=divClass%>">
          <div class="ui-btn-inner ui-li"> <a class="ui-link-inherit iframe" href="/mobile/shop/cuisineinfo/cuisineA.jsp?set_id=<%=setId%>"> <img class="ui-li-thumb" src="<%=imgUrl%>" width="116" height="70">
            <h3 class="ui-li-heading"><%=setName%></h3>
            <p class="ui-li-desc">��1ȸ ������ <%=portionSize%>g</p>
            </a> <span class="cal_banner"><%=calorie%><br />
            kcal</span> </div>
        </li>
        <%
						i++;
					}
					%>
      </ul>
    </div>
    <div class="divider"></div>
    <div class="row">
      <h2 class="font-brown">01. �ս��� �̴Ϲ� ��ǰ ����</h2>
      <div class="mart10 marb20"> 
		<p>�ս��� �̴Ϲ��� �ѽ� ��Ÿ�� / ��� ��Ÿ�Ϸ� �����Ǿ� �ֽ��ϴ�. �� ��Ÿ�� ���� 3���� �̴Ϲ� ��ǰ�� �����Ǿ� ������ �ּ� 2set���� �ֹ������մϴ�.</p>
		<img src="/mobile/images/shop_minimeal_02.jpg" width="100%" alt="" />        
      </div>
      <div class="divider"></div>
      <h2 class="font-brown">02. �ս��� �̴Ϲи��� Ư����</h2>
      <div style="margin:15px auto;width:235px;"><img src="/mobile/images/esMinimeal01.png" width="235" height="160" alt="��ũ������"></div>
      <h3 class="font-wbrown">Simple! �̴��� Ÿ������ �Ѽ����� �����ϰ�</h3>
      <p>���� ��𼭳� �����ϰ� �ѳ� �ذ�! ���̾���, �ٻ� ������ �� �����ε��� �ǰ��� �� ���� ���� Mini- Cup Ÿ������ �Ѽտ� ���, �����ϰ� �����ϴ� One-dish meal</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">Healthy! ���۰, Ǫ��� �ǰ��� ���̾�Ʈ��</h3>
      <p>���۰ ����ƿ� �͸��� ����� ���, �ڼ�������, ���� �� ��� �޴��� �ǰ� ����� ����� ������ �ǰ�����! ����Ǫ�� ���� �� ���, �κ� �� ���̾�Ʈ�� ������ �ִ� ��Ḧ ���!</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">Tasty! ���̾�Ʈ�߿��� ���ְ� ����!</h3>
      <p>200kcal���� �������� �ִ� ����� �������� ����ϰ� ���ְ� ��� �� �ִ� �ս��� �̴Ϲ�! ���̼����� ǳ���� �������� ���ϴ� ����, �͸�, ���� ���� ���� ����� ���!</p>
      <div class="divider"></div>
      <h3 class="font-wbrown">Beauty&Balance</h3>
      <p>�峻 �躯Ȱ���� ��Ȱ�ϰ� �����ִ� ���̼����� ��Ƽ������ �ݶ���� �־� ���̾�Ʈ �Ⱓ�� �����ϱ� ���� �뷱�� ����</p>
      <div class="divider"></div><br/>
	  <h2 class="font-brown">03. �ս��� �̴Ϲ� �޴� �Ұ�</h2>
	  <table width="100%" class="tblMinimeal">
		<tr>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_03.jpg" width="100%" alt="�ſ��ѵ������">
				<p class="menuTit">�ſ��ѵ������</p>
				<p class="menuTxt">�ǰ� ����� ������̿� ���̼����� ������ �信 ������ �������� �Ѹ�ä���� ���, ������ī�� ��췯�� �ſ��ѵ���������Դϴ�.</p>
			</td>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_04.jpg" width="100%" alt="���������̹�">
				<p class="menuTit">���������̹�</p>
				<p class="menuTxt">�ǰ� ����� ������̿� GI������ ���� ������ ��췯�� �信 ���� ������ ��������� ��췯�� ���ִ� ���������̵����Դϴ�.</p>
			</td>
		</tr>
		<tr>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_05.jpg" width="100%" alt="�ſ��ѵ������">
				<p class="menuTit">�Ұ�⸶�ĵκκ�����</p>
				<p class="menuTxt">�ǰ� ����� �ڼ����������Ұ� �κ�, ���� �� ���̾�Ʈ�� ������ �ִ� ��Ḧ ����� ��ȭ ǳ�� ���ĵκε����Դϴ�.</p>
			</td>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_06.jpg" width="100%" alt="���������̹�">
				<p class="menuTit">�������̻�踮����</p>
				<p class="menuTxt">ī��Ų�� ����ִ� ����Ǫ�� �������� �����԰� ���̼���, ���̿�  ����ϰ� ���� ����� ���� ��췯�� ���ְ� ��� �� �ִ� ���������̻�踮�����Դϴ�. </p>
			</td>
		</tr>
		<tr>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_07.jpg" width="100%" alt="��������ƿ��κΰԻ츮����">
				<p class="menuTit">��������ƿ��κΰԻ츮����</p>
				<p class="menuTxt">���۰�� ����ƿ� ���̾�Ʈ�� ������ �ִ� ���κ�, �Ի쿡 û����߸� �־� ĮĮ�ϰ� �ε巴�� �Դ� �߽�ǳ �������Դϴ�..</p>
			</td>
			<td width="50%">
				<img src="/mobile/images/shop_minimeal_08.jpg" width="100%" alt="����̹����͸�������">
				<p class="menuTit">����̹����͸�����</p>
				<p class="menuTxt">����Ǫ�� ���� �͸��� ���̰� �丶�� �ҽ��� �߰�����, ä�ҿ� �� ��췯�� �ε巯�� ����̹�����͸��������Դϴ�.</p>
			</td>
		</tr>
	  </table><br/><br/>
	  <h2 class="font-brown">04. ���� & ���</h2>
	  <ul class="step04">
		<li class="tit"><p>[�ù� ��� ���μ���]</p></li>
		<li>�ս����� �ù� ����� Ǯ������ <span>ö���� �ż� ��ǰ ���� �����</span>�� ���� �ù� �߼ۺ��� ���� ���� ���ɱ��� �����ϰ� �����մϴ�.</li>
		<li>�ս����� �ù� ����� <span>35�ɿ����� 30�ð����� 5�ɸ� ����</span>�ϵ��� ���̽����� ����̾��̽��� ����մϴ�.</li>
		<li>�ս����� �ù� ��Ű���� 0��-5�ɸ� �����ϸ� ��ǰ�� ����� �������� ���� <span>������ ���ϸ� ���� �� �ֵ��� �����ϰ� ����</span>�Ǿ����ϴ�.</li>
		<img src="/mobile/images/shop_minimeal_09.jpg" width="100%" alt="�ù� ��� ���μ���">
	  </ul><br/>
	  <ul class="step04">
		<li class="tit"><p>[�ù� ������ �ȳ�]</p></li>
		<li>���� �� �Ϲ� ��� ������ �ֹ� ��, ���� �߼��� ������ ������ <span>ȭ, ��, ��, ��, ����ϸ�</span> ���� ���� �����մϴ�.  �ù��(CJ�ù�)�� �Ͽ��� �޹��� ���Ͽ�, ���� ����� �Ұ����� <span>�Ͽ���, �������� �ù� ����� ������, �������� �ù� �߼� �� ������ �Ұ���</span>�մϴ�.</li>
		<li>�ϴ� ǥ�� ���� <span>�������� �������� ���,</span> �ù�� �޹��� ���Ͽ� ��۰� ��� ���� ������, ������, ����� ��Ʋ�� ��ǰ�� �����Ͻ� �� �����ϴ�.</li><br/>
		<img src="/mobile/images/shop_minimeal_10.jpg" width="100%" alt="�ù� ������ �ȳ�"><br/><br/>
		<img src="/mobile/images/shop_minimeal_11.jpg" width="100%" alt="�ù� ������ �ȳ�">
	  </ul><br/>
    </div>
    <div class="grid-navi">
      <table class="navi" border="0" cellspacing="10" cellpadding="0">
        <tr>
          <td><a href="/mobile/shop/popup/ssoup_term.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
          <td><a href="/mobile/shop/typeDiet_order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">Ÿ�Ժ� ���̾�Ʈ �����ϱ�</span></span></a></td>
        </tr>
      </table>
    </div>
  </div>
  <!-- End Content -->
  <div class="ui-footer">
    <%@ include file="/mobile/common/include/inc-footer.jsp"%>
  </div>
</div>
</body>
</html>