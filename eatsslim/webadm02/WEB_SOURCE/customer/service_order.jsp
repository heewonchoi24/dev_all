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
			<h1>
				�̿�ȳ�
			</h1>
			<div class="pageDepth">
				HOME > ������ > <strong>�̿�ȳ�</strong>
			</div>
			<div class="clear">
			</div>
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
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">1:1����</a></li>
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
                            <span class="btn01"><a class="current" href="/customer/service_order.jsp">�ֹ����μ���</a></span>
                        </li>
                        <li>
							<span class="btn02"><a href="/customer/service_order01.jsp">������°���</a></span>
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
			     <ul class="bubblelist">
                   <li>
                       <span class="bubble">01</span>
                       <h4>�ֹ��ȳ� Ȯ��</h4>
                       <p>��ǰ�� ������ ����� Ȯ���Ͻ� �� �ֹ��Ͻ� ��ǰ�� �������ּ���.</p>
                    </li>
                    <li>
                       <span class="bubble">02</span>
                       <h4>��ް������� Ȯ��</h4>
                       <p>���Ϲ�� ��ǰ(�Ļ���̾�Ʈ, ���α׷����̾�Ʈ, ��ũ������)�� ��� ������ �������� ����� �븮���� ���Ͽ� ���� ����<br /> 
                         ��޵ǰ� �ֽ��ϴ�. ���Ϲ�� ��ǰ�� �ֹ��Ͻ� ��� ��ް��� �������� �� Ȯ�� �� �ֹ����ּ���.</p>
                    </li>
                    <li>
                       <span class="bubble">03</span>
                       <h4>�Ļ�Ⱓ ����</h4>
                       <p>�����Ͻ� ��ǰ�� ���� �Ĵ�ǥ�� ������ �����Ͻ� ������ ���� �Ļ�Ⱓ(��/��)�� �������ּ���.<br /><p>
                       
                       <strong>#���̾�Ʈ �Ļ�</strong><br />
                          - ��: �� 5��(��~��) �Ǵ� ��6��(��~��) ���ð���<br />
                          - ��: 2�� �Ǵ� 4�� ���� ����<p>
                          
                       <strong>#��ũ������</strong><br />
                       - ��: ��6��(��~��) �Ǵ� ��3��(������/ ȭ����) ���ð���<br>
                       - ��: ��6�� ��ǰ( 1��, 2��, 4�� ���ð���), ��3�� ��ǰ(2��,4�� 8�� ���ð���)<br>
                       <br />
                       <p>* �Ͽ����� ����� �����ϴ�.<br />
                    </li>
                    <div class="marb20"><img src="/images/serimg_02_01.png" width="721" height="195"></div>
                    <li>
                       <span class="bubble">04</span>
                       <h4>ù ����� ����</h4>
                       <p>�Ϲ����� ��� ����� ���ź��� ��ޱ��� �� 6���� �ҿ�Ǹ�, ������ ���� 6�� ���� �������� ���� �����մϴ�.<br />
                       �ù����� ��� ����� ������ �Ұ����ϸ�, �����Ϸ� ���� 2~5���Ŀ� ��ǰ�� �����Ͻ� �� �ֽ��ϴ�.</p>
                    </li>
                    <li>
                       <span class="bubble">05</span>
                       <h4>���ð����ֹ�</h4>
                       <p>���Ϲ�� ��ǰ�� ������·� ���, �����Ǿ�� �ϹǷ� ó�� ��ǰ�� �ֹ��Ͻ� ��� �ʼ������� ���ð����� �ֹ���<br />
                       �ּž� �մϴ�.</p>
                       
                       <p>���ð����� �̹� �����Ͽ� ��ǰ�� ������ �̷��� �ִ� ���, ���������� ���Ű� �����մϴ�.</p>
                    </li>
                    <li>
                       <span class="bubble">06</span>
                       <h4>����� �Է�</h4>
                       <p>���Ϲ�� ��ǰ�� �ù��� ��ǰ�� �����Ͽ� ������� �Է��� �� �ֽ��ϴ�.<br />
                         ���Ϲ�� ��ǰ, �ù��� ��ǰ ��� ���� ������� ������ ��� �����ϰ� �Է��Ͻø� �˴ϴ�.</p>
                    </li>
                    <li>
                       <span class="bubble">07</span>
                       <h4>�ֹ�/����</h4>
                       <p>������°���, �ǽð�������ü, �ſ�ī�� ���� �� ���Ͻô� ���������� �����Ͽ� �����Ͻø� �ֹ��� �Ϸ�˴ϴ�.</p>
                    </li>
                    <div><img src="/images/serimg_02_02.png" width="721" height="370"></div>
                  </ul>
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