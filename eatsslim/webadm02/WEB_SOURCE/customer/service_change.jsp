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
							<a href="/customer/notice.jsp">��������</a>
						</li>
						<li>
							<a href="/customer/faq.jsp">FAQ</a>
						</li>
						<%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">1:1����</a></li>
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
							<span class="current">�ֹ�����</span>
						</li>
						<li>
							<a href="/customer/service_recommand.jsp">���/��ȯ/ȯ��</a>
						</li>
                        <li>
							<a href="/customer/service_coupon.jsp">�������</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
			  <div class="marb50"><img src="/images/serimg_03_01.png" width="721" height="160"></div>
              <dl class="regist">
                  <dt><h2>���氡��<br />����</h2></dt>
                  <dd>
                      <ul class="bubblelist">
                          <li>
                          <span class="bubble">01</span>
                          <h4>����� ����</h4>
                          <p>�ù� ��ǰ�� ��쿡�� ��ǰ�� �߼۵Ǳ� �� �����Ϸ� �ܰ迡���� ������ �����մϴ�.<br />�Ϲ� ��ǰ�� ��� ��ۺ��� ����Ϸ� ���� �ּ� 3��(�ָ� �� �������� ���ԵȰ��� 5������)������<br />������ �����մϴ�.</p>
                          </li>
                          <li>
                              <span class="bubble">02</span>
                              <h4>������� ����</h4>
                              <p>����ϰ��� �ϴ� ��¥�κ��� �ּ� 3�� ������ ���, ���� ������ ���� �����մϴ�. <br />�ս����� �ֹ��� ���ÿ� ����ᰡ ���ŵǰ� �����Ǿ�, �ż��ϰ� ��۵Ǵ� �ý�������, ������ ���� 3�� �ĺ��� ����� ��� �� ���Ⱑ �����Ͻø�, 
							  �� �� ������ ���� 1~2�� �� ��ǰ�� �̹� �ֹ� �� ���� �۾��� ����ǰ� �־�, ���� ���/ȯ�� ���� �Ұ��� �� ���غ�Ź�帳�ϴ�.  ����, �ֹ����� �ý������� ���� ������� �մ��� �κ��� ���� �����Ϸκ��� 6�� ���ĺ��� �����Ͻʴϴ�. <br />�ս��� Ȩ������ '�����ս���' ����Ϻ����� ���� ���� �����Ͻðų� 1:1 �Խ����� ���� �����ϼ���.</p>
                              <div class="bg-gray mart10 marb10" style="padding:15px;">
                                  <h5>�ս��� Ȩ���������� �ֹ��� ���</h5>
                                  <p>
                                  1) �����ս��� > �ֹ������ȸ > ������ں��� ��ư�� Ŭ���Ͽ� ���� �������ּ���.<br />
                                  2) ����ݼ���(080-022-0085) �Ǵ� 1:1��� �Խ����� ���� �������ּ���.
                                  </p>
                                  <div class="divider"></div>
                                  <h5>�ܺθ����� �ֹ��� ���</h5>
                                  <p>
                                  ����ݼ���(080-022-0085) �Ǵ� 1:1��� �Խ����� ���� �������ּ���. 
                                  </p>
                              </div>
                          </li>
                      </ul>
                  </dd> 
              </dl>
              <dl class="regist">
                  <dt><h2>�ֹ�����<br />���μ���</h2></dt>
                  <dd><div class="marb10"><img src="/images/serimg_03_02.png" width="558" height="160"></div></dd>
              </dl>
              <div class="divider"></div>
              <dl class="regist">
                  <dt><h2>�����Ϲ��</h2></dt>
                  <dd><p>�ָ� �� �������� ���� ����� �����ϴ�.<br/>������ ��� ���� ������ �������� ������ ����� �� ��¥�� +1�� �ڵ� �����˴ϴ�.</p></dd>
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