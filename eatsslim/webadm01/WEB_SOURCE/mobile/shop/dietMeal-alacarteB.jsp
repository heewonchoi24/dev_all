<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
        <%@ include file="/mobile/common/include/inc-header.jsp"%> <!--  -->
        <ul class="subnavi">
			<li><a href="/mobile/shop/healthyMeal.jsp">�ﾾ����</a></li>
            <li class="current"><a href="/mobile/shop/dietMeal.jsp">�Ļ���̾�Ʈ</a></li>
            <li><a href="/mobile/shop/fullStep.jsp">���α׷�</a></li> <!--  -->
            <li><a href="/mobile/shop/minimeal.jsp">�����</a></li> <!--  -->
			<li><a href="/mobile/shop/dietCLA.jsp">��ɽ�ǰ</a></li>	<!--  -->
			<li><a href="/mobile/shop/onion.jsp">�ǰ���</a></li> <!--  -->
        </ul>
    </div>
    <!-- End ui-header -->
    
    <!-- Start Content -->
    <div id="content">
	<!--
           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
                 <td><a href="/mobile/shop/popup/alacarte_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
                 <td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�Ļ� ���̾�Ʈ �����ϱ�</span></span></a></td>
               </tr>
           </table>
           </div>
		   -->
           <div class="grid-navi">
            <table class="navi" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/dietMeal.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />&nbsp;</span></span></a></td>
					<td><a href="/mobile/shop/dietMeal-alacarteA.jsp" class="ui-btn ui-btn-inline ui-btn-up-a-line"><span class="ui-btn-inner1"><span class="ui-btn-text">�˶���<br />����</span></span></a></td>  
				    <td><a href="/mobile/shop/dietMeal-alacarteB.jsp" class="ui-btn ui-btn-inline ui-btn-up-a"><span class="ui-btn-inner1"><span class="ui-btn-text">�˶���<br />�ﾾ</span></span><span class="active"></span></a></td>
                </tr>
			</table>
           </div>
           <div class="row">
           <div class="bg-gray font-brown">
               <p>����/������ ���� ���·� ���ڷ������� ���� �����ϰ� ���� �� �ִ� <strong>"�˶��� �ﾾ"</strong>(�� 10�� �޴�)</p>
               <div style="margin:10px 0 5px 0;"><img src="/mobile/images/img_top_goods04.jpg" width="100%" alt="" /></div>

		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/shop/popup/dietmeal_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
					<td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�Ļ� ���̾�Ʈ �����ϱ�</span></span></a></td>
				</tr>
			</table>
		</div>
         <div class="divider"></div>

                  <div class="memo">
                      <div class="ribbon-tit"></div>
                      <ul>
                          <li class="memo01">�� 10���� �پ��� �޴��� ������ �ʴ� ��ſ� �Ļ�</li>
                          <li class="memo02">������ �����ϰ� ���� ��𼭳� ���� ����</li>
                          <li class="memo03">Ǯ���� �Ĺ�ȭ������ �ڹ����� �������� ���缳��</li>
                          <li class="memo04">Ǯ���� �ؽż���۽ý������� �ż��� ����</li>
                      </ul>
                  </div>
           </div>
           </div>

           <div class="divider"></div>
           <div class="row">
				<h2 class="font-brown">01. �޴��� ��ǰ ����</h2>
               <div class="guide">* �Ʒ� �޴��� �������� ��ȯ�˴ϴ�. Ŭ���Ͻø� �ڼ��� �� �� �ֽ��ϴ�. <br />
			   * �˶��� �ﾾ�� ����Ű�� �Բ� �����˴ϴ�.
			   </div>
               <ul class="ui-listview">
					<%
					int setId			= 0;
					String thumbImg		= "";
					String imgUrl		= "";
					String setName		= "";
					String calorie		= "";

					query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG,PORTION_SIZE FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 10 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
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
                       <div class="ui-btn-inner ui-li">
                           <a class="ui-link-inherit iframe" href="/mobile/shop/cuisineinfo/cuisineA.jsp?set_id=<%=setId%>">
                           <img class="ui-li-thumb" src="<%=imgUrl%>" width="116" height="70">
                           <h3 class="ui-li-heading"><%=setName%></h3>
                           <p class="ui-li-desc">��1ȸ ������ <%=portionSize%>g</p>
                           </a>
                           <span class="cal_banner"><%=calorie%><br />kcal</span>
                       </div>
                   </li>
					<%
						i++;
					}
					%>
               </ul>
           </div>

	<div class="row">
                <h2 class="font-brown">02. �Ļ���̾�Ʈ���� Ư����</h2> 
                   <h2 class="font-wbrown">�������� ���缳��</h2>
                   <p>GI/GL�� ������ ���̾�Ʈ �Ļ翡 ���� �Ͽ�, ź��ȭ�� Ư���� ���� ������ ü�� ������� ����ϰ�, �׿� ���� ������ �Ĵ��� ����</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">������ ����µ� ����</h2>
                   <p>��� �� ���� ��޹ޱ���� ���� 0~10��C�� ������ �� �ֵ��� Ǯ���� �ؽż���޽ý������� ���������µ� ���� �� ������Ű�� ����</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">���� ������ �Ļ�</h2>
                   <p>�Ļ��غ� �ʿ���� ����(�繫��)���� ����⸸ �ϸ� OK! ��� 367Kcal�� ���̾�Ʈ ���� �Ĵ�</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">��Ʈ������ ����</h2>
                   <p>���̼����� �ܹ����� ǳ���� �Ļ籸���� �����ϸ�, ���� 2,000mg��Ʈ�������� �����Ͽ� ����</p>
                   <div class="divider"></div>
                   <h2 class="font-wbrown">ȣ����� �������� ��ġ�� ���� ��ǥ�丮</h2>
                   <p>���� ������ ��ǥ�丮�� ȣ�� ��� �ս��� �������� ���� ���� �������� ���̾�Ʈ������ ��ź�� </p>

               <div class="divider"></div>
               <h2 class="font-brown">03. ���ִ� ���̾�Ʈ</h2>
                <ul class="dot">
                    <li class="f14">�ѽ�/���/�Ͻ�/�߽�ȣ����� ���� ������</li>
                    <li class="f14">����� �ε巴�� ���� �����Ǵ� ����� �������� ������ ����</li>
                    <li class="f14">õ�� ���� �� ���а� �ҽ��� ��ȭ�� ���� </li>
                </ul>
              <div class="divider"></div>
              <h2 class="font-brown">04. �������� ���缳��</h2>
              <h3 class="font-blue"><strong>Low GL diet point !</strong></h3>
              <p class="f16"><strong>1�� ���� ������ ź��ȭ�� ����</strong></p>
              <p class="f14">�ܹ����� ���мս� �� ����ұ����� �ּ�ȭ �մϴ�.</p>
              <div class="divider"></div>
              <p class="f16"><strong>Low GI (�� ����)�� ����� ��� ���� �� ���� ���� ����</strong></p>
              <p class="f14">ź��ȭ���� ���� ü�� ����ӵ��� �����ϱ� ���Ͽ� ����� ������ �����ϰ�, ��ü ź��ȭ�� ���޿� �� Ǯ�������ؿ� ���� Low GI�� �з��Ǵ� ź��ȭ�� �޿� ������ �����մϴ�.</p>
              <div class="divider"></div>
              <p class="f16"><strong>Low GL (����� ����)�� ����� ź��ȭ�� �Է� ����</strong></p>
              <p class="f14">�ٸ� ź��ȭ���� ����/���� �������� ��ǰ�� 1ȸ ����� GL������ �����Ͽ� ��ü �Ĵ��� �����մϴ�.</p>
              <div class="divider"></div>
              <h2 class="font-brown">05. �پ��� �޴�����</h2>
              <p class="f14">��� 295kcal, ������, �ʶ���, ũ�� ��Ʃ �� ��� ���̾�Ʈ���� ��Į�θ� �������� ���� ���ߴ� �޴���, ��Į�θ� �����Ƿ� ����� ���ְ� �����Ͽ����ϴ�.</p>
              <div class="divider"></div>
              <h2 class="font-brown">06. �ٸ����� ö���� ��������</h2>
              <img class="floatleft" src="/mobile/images/reductionProgram05.png" width="113" height="37" style="margin-right:10px;">
              <p class="f14" style="display:inline-block;width:55%;">Ǯ���� ��ǰ�������͸� ���� ���� ������ �˻� �� ����ǰ ������ ��Ʈ��</p>
              <div class="divider"></div>
              <img class="floatleft" src="/mobile/images/reductionProgram06.png" width="113" height="37" style="margin-right:10px;">
              <p class="f14">��Ʈ��Űģ�� ���� ǰ���� ǥ��ȭ �� ����ȭ</p>
              <div class="divider"></div>
              <h2 class="font-brown">07. ���� & ���</h2>
              <div style="margin:5px auto;"><img src="/mobile/images/reductionProgram07.png" width="100%"></div>
              <h3>�����ϰ� �ż��� ������</h3>
              <p class="f14">�ս��� ��ü �ؽż� ��޽ý������� ���Ǵ� �ĺ��� ������ ��޹޴� �������� ����0~10�ɷ� ������ �� �ֵ��� ���������µ� ���� �� ������Ű�� ���谡 �Ǿ��ֽ��ϴ�.</p>
              <div style="margin:5px auto;"><img src="/mobile/images/reductionProgram08.png" width="100%"></div>
              <h3>��������! �Ϻ�����! �������!</h3>
              <p class="f14">���ڷ������� ������ ���ع����� ������ �ʴ� ��⸦ ����մϴ�.</p>
              <div class="divider"></div>
              <h3>��ǰ����</h3>
              <p class="f14">�ս��� ��ü ��޽ý����� ���� ����� �̷������, �����պ�ġ, ���� ��Ź���� 2���� ��� �߿��� ������ ���ǿ� ���� �����Ͽ� ��޹����� �� �ֽ��ϴ�.</p>
             </div>

           <div class="grid-navi">
            <table class="navi" border="0" cellspacing="10" cellpadding="0">
               <tr>
			   <td><a href="/mobile/shop/popup/dietmeal_info.jsp" class="ui-btn ui-btn-inline ui-btn-up-d iframe"><span class="ui-btn-inner"><span class="ui-btn-text">��ǰ����</span></span></a></td>
                 <td><a href="/mobile/shop/dietMeal-order.jsp" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">�Ļ� ���̾�Ʈ �����ϱ�</span></span></a></td>
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