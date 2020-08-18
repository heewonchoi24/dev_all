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
							<span class="btn02"><a href="/customer/service_order01.jsp">������°���</a></span>
						</li>
                        <li>
							<span class="btn03"><a href="/customer/service_order02.jsp">�ǽð� ������ü</a></span>
						</li>
                        <li>
							<span class="btn04"><a href="/customer/service_order03.jsp">�ſ�ī�����</a></span>
						</li>
                        <li class="last">
							<span class="btn05"><a class="current" href="/customer/service_order04.jsp">����������</a></span>
						</li>
                        <div class="clear"></div>
                    </ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
                <dl class="regist">
                  <dt><h2>����������<br />�ǹ����</h2></dt>
                     <dd>
                      <ul class="bubblelist">
                            <li>
                               <span class="bubble">01</span>
                               <h4>30���� �̻� ������ �������� �ǹ����</h4>
                               <p>2005�� 11�� 1�Ϻ��� ������������ ���ڱ����ŷ� ������ ��ȭ�� ���� 30���� �̻��� ��� ��� ���ͳ� ������ �ſ�ī�� ���� �� ������������ �ݵ�� ����ϵ��� ���ϰ� �ֽ��ϴ�. ������ ī�带 Ȯ���Ͻ� �� �ش��ϴ� ������ �����ñ� �ٶ��ϴ�.</p>
                               <div class="marb10 mart10">
                                  <table class="termstable" width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <th>�ſ�ī��</th>
                                        <th>30���� �̸� ����</th>
                                        <th>30���� �̻� ����</th>
                                      </tr>
                                      <tr>
                                        <td>����, ��, �츮(�� ��ȭī��)</td>
                                        <td>ISP����<br />(��������)</td>
                                        <td class="last">ISP����(��������)<br />+ ��������</td>
                                      </tr>
                                      <tr>
                                        <td>�Ｚ, ����, ��ȯ, ����, �ϳ�, �ѹ�, ��Ƽ, �Ե�,<br />�ż���, ����, ����, ����, ����, ���� (�� ����)</td>
                                        <td>�Ƚ�Ŭ������</td>
                                        <td class="last">��������</td>
                                      </tr>
                                      <tr>
                                        <td>����</td>
                                        <td>��������</td>
                                        <td class="last">��������</td>
                                      </tr>
                                    </table>
                               </div>
                            </li>
                      </ul>
                  </dd>
                  </dl>
                  <div class="divider"></div>
                  <dl class="regist">
                      <dt><h2>����������<br />�߱޾ȳ�</h2></dt>
                      <dd>
                          <ul class="bubblelist">
                            <li>
                                <span class="bubble">02</span>
                                <h4>������������ �ִ� ��� </h4>
                                <ul class="colorchart">
                                    <li>STEP 01. �ŷ����� �Ǵ� ���ǻ翡 �湮�Ͽ� ����Ȯ�� �� ���ͳݹ�ŷ/ ���̹�Ʈ���̵� ��û</li>
                                    <li>STEP 02. ����/���ǻ� Ȩ���������� ����/���� ���������� �߱�(����/���� �ŷ���)</li>
                                    <li>STEP 03. ����������/�ѱ���������/�ѱ��������� Ȩ���������� ���������� �߱�</li>
                                </ul>
                            </li>
                            <li>
                                <span class="bubble">02</span>
                                <h4>������������ ���� ��� </h4>
                                <ul class="colorchart marb20">
                                    <li>STEP 01. ����/���ǻ�� ���������� �Ǵ� ���ι��� ����������</li>
                                    <li>STEP 02. ����������/�ѱ���������/�ѱ��������� Ȩ���������� ���������� �߱�</li>
                                </ul>
                                <p class="list-star">�������������� ���������� �߱� <span class="button small dark"><a href="http://www.yessign.or.kr/" target="new">�߱�</a></span></p>
                                <p class="list-star">�ѱ������������� ���������� �߱�(��ü�� ���������� �߱� ����) <span class="button small dark"><a href="http://renew.signgate.com/certificate/cert.sg" target="new">�߱�</a></span></p>
                            </li>
                      </dd>
                  </dl>
                  <dl class="regist">
                      <dt><h2>���ݿ�����<br />�����߱���</h2></dt>
                      <dd>
                      <p class="marb20">���ݿ����� ��볻���� �������� ���ϵǾ� ���ݿ����� Ȩ���������� 3�������� ��볻�� (����,��ȣ, �ݾ� ��)�� 1�Ⱓ�� ���� ��볻���� Ȯ���� �� �����Ƿ� ����Ȯ���� �Ǹ� �����Ͻ� �ʿ�� �����ϴ�. ���ݿ����� ��û��, ����Ͻô� ��� �ν� ��ü�� ���ݿ����� Ȩ�������� ȸ������ ��  ������� �Ǿ� �־�� ������ ������ �� �ֽ��ϴ�.</p>
                      <table class="termstable" width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr>
                           <th>���ݿ�������㼾��</th>
                           <th>����û Ȩ������</th>
                            <th>���ݿ����� Ȩ������</th>
                         </tr>
                         <tr>
                            <td>�� 1544-2020</td>
                            <td><a href="http://www.nts.go.kr" target="new">http://www.nts.go.kr</a></td>
                            <td class="last"><a href="http://www.texsave.co.kr" target="new">http://www.texsave.co.kr</a></td>
                         </tr>
                        </table>
                    </dd>
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