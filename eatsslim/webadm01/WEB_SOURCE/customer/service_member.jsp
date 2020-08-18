<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>

	<script type="text/javascript" src="/common/js/datefield.js"></script>
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
							<span class="current">
							ȸ������
							</span>
						</li>
						<li>
							<a href="/customer/service_order.jsp">�ֹ�/����</a>
						</li>
						<li>
							<a href="/customer/service_change.jsp">�ֹ�����</a>
						</li>
						<li>
							<a href="/customer/service_mobile.jsp">�˸��� �ֹ�����</a>
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
			      <div class="marb50"><img src="/images/serimg_01_01.png" width="100%"></div> -->
                  <dl class="regist">
                      <dt><h2>ȸ������<br />�� �ȳ�</h2></dt>
                      <dd>
                          <ul class="bubblelist">
                              <li>
                              <span class="bubble">1</span>
                              <h4>Ǯ���� ��ü ���� ȸ������</h4>
                              <p>Ǯ������ Ǯ���� ������� ��� ������ ������ ���Ե鲲�� �Բ� �����ϰ� ���ϰ� �̿��Ͻ� �� �ֵ��� Ǯ���� ��ü ���� ȸ�������� �̿��ϰ� �ֽ��ϴ�.</p>
                              </li>
                              <li>
                              <span class="bubble">2</span>
                              <h4>SNS ���� �α���</h4>
                              <p>���̹�, īī����, ���̽��� ���̵� �־ �ս��� �α��� ���� �̿� �����մϴ�. <br/ >
							  ��, SNS�α��� �� īī���� ����� �����͸� ���� �ֹ� ��ȸ �� ���� �̿뿡 �Ϻ� ������ ���� �� �ֽ��ϴ�.</p>
                              </li>

                              <li>
                              <span class="bubble">3</span>
                              <h4>ö���� �������� ��ȣ ��ħ</h4>
                              <p>���Ե� ������ ������ ���� ���� �������� ������, Ǯ������ �پ��� ������Ʈ�� �̿��ϴ� �������� ������ ���������� ��ȣ�ϱ� ���� �ּ��� ���ϰ� �ֽ��ϴ�.</p>
                              </li>
                          </ul>
                      </dd>
                  </dl>
                  <dl class="regist">
                      <dt><h2>ȸ������<br />���</h2></dt>
                      <dd>
                          <div class="marb10"><img src="/images/serimg_01_02.png" width="559" height="127"></div>
                          <p class="list-star">�� 14�� �̻��� ���ѹα� �����̶�� ������ Ǯ���� �ս��� ȸ������ �����Ͻ� �� �ֽ��ϴ�.</p>
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