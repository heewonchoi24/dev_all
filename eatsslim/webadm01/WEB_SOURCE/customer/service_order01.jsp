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
				<span>Ȩ</span><span>������</span><strong>�̿�ȳ�</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="twelve columns offset-by-one ">
			<div class="row">
				<div class="threefourth last col">
					<ul class="tabNavi">
						<li>
							<a href="notice.jsp">��������</a>
						</li>
						<li>
							<a href="faq.jsp">FAQ</a>
						</li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">1:1����</a></li>
						<%} else {%>
						<li><a href="indiqna.jsp">1:1����</a></li>
						<%}%>
						<li class="active">
							<a href="service_member.jsp">�̿�ȳ�</a>
						</li>
						<li>
							<a href="presscenter.jsp">��к���</a>
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
							<span class="current">�ֹ�/����</span>
						</li>
						<li>
							<a href="/customer/service_change.jsp">�ֹ�����</a>
						</li>
						<li>
							<a href="/customer/service_recommand.jsp">���/��ȯ/ȯ��</a>
						</li>
                        <li>
							<a href="/customer/service_coupon.jsp">�������</a>
						</li>
                        <div class="clear"></div>
					</ul>
                    <div class="divider"></div>
                    <ul class="subimgSort marb20">
                        <li>
                            <span class="btn01"><a href="/customer/service_order.jsp">�ֹ����μ���</a></span>
                        </li>
                        <li>
							<span class="btn02"><a class="current" href="/customer/service_order01.jsp">������°���</a></span>
						</li>
                        <li>
							<span class="btn03"><a href="/customer/service_order02.jsp">�ǽð� ������ü</a></span>
						</li>
                        <li>
							<span class="btn04"><a href="/customer/service_order03.jsp">�ſ�ī�����</a></span>
						</li>
                        <li class="last">
							<span class="btn05"><a href="/customer/service_order04.jsp">����������</a></span>
						</li>
                        <div class="clear"></div>
                    </ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
                <dl class="regist">
                  <dt><h2>�������</h2></dt>
                  <dd>
                      <p class="marb20" style="letter-spacing:-1px;">������ ���� ���Ͽ� ������ �Ա��Ͻô� ���Բ� �����������(1�� 1����)�� �ο��� �帮�� �ֽ��ϴ�.<br />�ο��� ������·� ��ǰ�ݾ��� �Ա����ֽø� �ֹ��� �Ϸ�˴ϴ�.</p>
                      <ul class="bubblelist">
                            <li>
                               <span class="bubble">01</span>
                               <h4>������� �Ա�</h4>
                               <p>�Աݽ� �Ա��ڿ� �Աݾ��� �����ؾ� ������ �����ϸ� �����ִ� Ǯ�����ǰ���Ȱ�� �������� �Դϴ�.</p>
                            </li>
                            <li>
                               <span class="bubble">02</span>
                               <h4>�Ա�Ȯ��</h4>
                               <p>�Ա� �� 20�г��� �Ա�Ȯ���� �Ϸ���� ���� ��� ������(080-022-0085)�� �����ֽñ� �ٶ��ϴ�.</p>
                            </li>
                            <li>
                               <span class="bubble">03</span>
                               <h4>�ԱݱⰣ</h4>
                               <p>�Ϲ�(����� ���� ���) ��ǰ�� �ֹ� ����, �ù��ǰ�� �ֹ��� 7���̳� �Ա��� ������� ���� ��� �ֹ��� �ڵ���ҵ˴ϴ�. (SMS�� �뺸�帳�ϴ�.)</p>
                            </li>
                            <li>
                               <span class="bubble">04</span>
                               <h4>������ �Ա� �����߻�</h4>
                               <p>������ �Ա� �� ���� �߻��� ��κ��� ������¹�ȣ �� �Աݱݾ��� �ٸ� ��쿡 �߻��� ���� �����ϴ�.<br />�Ա� ������ ��� ���������� > �ֹ��������� �Աݰ��¹�ȣ, �Աݾ��� Ȯ�� �� ��õ� ��Ź�帳�ϴ�.</p>
                            </li>
                            <li>
                               <span class="bubble">05</span>
                               <h4>�����������ҽý���</h4>
                              <p>�ս����� �������÷��� �����������ҽý����� �̿��ϰ� ������, ���� ���� ��ο� ���� �߰� Ȯ����<br />
                               <a href="http://ecredit.uplus.co.kr" target="new">http://ecredit.uplus.co.kr</a>, �����ý��� ������ <a href="http://15446640.wo.to" target="new">http://15446640.wo.to</a> ����Ʈ�� ������ �ֽʽÿ�.</p>
                            </li>
                      </ul>
                  </dd>
                  </dl>
                  <div class="divider"></div>
                  <dl class="regist">
                      <dt><h2>�̿밡��<br />����</h2></dt>
                      <dd><img src="/images/serimg_02_03.png" width="559" height="300"></dd>
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