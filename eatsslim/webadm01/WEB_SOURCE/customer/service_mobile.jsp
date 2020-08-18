<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<div class="pageDepth">
				<span>HOME</span><span>������</span><strong>�̿�ȳ�</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li>
							<a href="/customer/notice.jsp">��������</a>
						</li>
						<li>
							<a href="/customer/faq.jsp">FAQ</a>
						</li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">1:1����</a></li>
						<%} else {%>
						<li><a href="indiqna.jsp">1:1����</a></li>
						<%}%>
						<li class="active">
							<a href="/customer/service_member.jsp">�̿�ȳ�</a>
						</li>
						<li>
							<a href="/customer/presscenter.jsp">��к���</a>
						</li>
					</ul>
					<div class="clear">
					</div>
				</div>
			</div>

			<div class="row" style="margin-bottom:40px;">
				<div class="threefourth last col">
					<ul class="listSort">
						<li>
							<a href="/customer/service_member.jsp">ȸ������</a>
						</li>
						<li>
							<a href="/customer/service_order.jsp">�ֹ�/����</a>
						</li>
						<li>
							<a href="/customer/service_change.jsp">�ֹ�����</a>
						</li>
						<li>
							<span class="current">�˸��� �ֹ�����</span>
						</li>
						<li>
							<a href="/customer/service_recommand.jsp">���/��ȯ/ȯ��</a>
						</li>
                        <li>
							<a href="/customer/service_coupon.jsp">�����ȳ�</a>
						</li>
                        <li>
							<a href="/customer/service_partnership.jsp">���޾ȳ�</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
			  <!--
			  <div class="marb50"><img src="/images/serimg_03_01.png" width="100%"></div>-->
              <dl class="regist">
                  <dt><h2>īī�� �˸���<br/> �ֹ����� ���</h2></dt>
                  <dd>
                      <ul class="bubblelist">
                          <li>
                          <span class="bubble">01</span>
                          <h4>�ս��� īī����</h4>
                          <p>'Ǯ���� �ս���' īī���� �÷���ģ�� �߰� ��, �ս������� 1:1 ��ȭâ �ϴ� �޴����� �������, ���������, �Ĵ�ǥ�� ���� ���÷� ����Ǵ� �پ��� �̺�Ʈ ������ �޾ƺ�����.<br/ >
						  (Ǯ���� �� ��ݼ��� īī����� �����Ͽ�, īī���� �� ������ ���ϰ� �����Ͻ� �� �ֽ��ϴ�)</p>
						    <div class="mart10 marb10"><img src="/images/serimg_mobile_01.jpg" width="600" height="603"></div>
                          </li>
                          <li>
                              <span class="bubble">02</span>
                              <h4>Ǯ���� ����ݼ��� īī����</h4>
                              <p>īī���� Ǯ���� �����Ϳ����� ��� ����, ����� ������ �����մϴ�. �����޴� �Ĵ� �ս��� �ܿ��� Ǯ���� ����, Ǯ���� ���̺���� ���Ϲ�� ��ǰ ���� �ֹ� Ȯ�ΰ� ������ �����մϴ�. </p>
                            <div class="mart10 marb10"><img src="/images/serimg_mobile_02.jpg" width="600" height="603"></div>
                          </li>
                          <li>
                              <span class="bubble">03</span>
                              <h4>�ֹ� ���� ��, üũ!</h4>
                              <p>�ս����� �ֹ� ���� �������� ���Ͻô� ��¥ 3�� ������ ������ �����մϴ�.  �߰� ���ǻ����� ������ ���,  ����ݼ���(080-800-0434) �Ǵ� 1:1��� �Խ����� ���� �������ּ���.</p>
                          </li>
                      </ul>
                  </dd>
              </dl>
			</div>
						</div>
			<!-- End row -->
		</div>
		<!-- End twelve columns offset-by-one -->
		<div class="sidebar four columns">
		   <%@ include file="/common/include/inc-sidecustomer.jsp"%>
		</div>
		<!-- End sidebar four columns -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div> <!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
</body>
</html>