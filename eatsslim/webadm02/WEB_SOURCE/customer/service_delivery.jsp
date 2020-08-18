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
							<a href="/customer/service_order.jsp">�ֹ�/����</a>
						</li>
						<li>
							<span class="current">��۾ȳ�</span>
						</li>
						<li>
							<a href="/customer/service_coupon.jsp">�������</a>
						</li>
						<li>
							<a href="/customer/service_change.jsp">�ֹ�����</a>
						</li>
						<li>
							<a href="/customer/service_recommand.jsp">���/��ȯ/ȯ��</a>
						</li>
                        <div class="clear"></div>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
				   <h3 class="marb20">��ۺ� ����</h3>
                   <p>�ù� ��ǰ�� ��� 40,000�� �̻� ������ ��ۺ�� �����̸�, 40,000�� �̸��� ��ۺ� 3,000���� �ΰ��˴ϴ�.</p>
                   <div class="divider"></div>
                   
                   <h3 class="marb20">��۾ȳ� �ܰ�</h3>
                   <h4 class="font-blue marb10">�Ϲ�</h4>
                   <p>�ս����� �Ϲ� ��ǰ�� ��� �޴��� �ֹ��� ���ÿ� ����ᰡ ���ŵǰ� �����Ǿ�, �����ϰ� �ż��ϰ� ������ ����� ��޵˴ϴ�.</p>
                   <br />
                   <img src="/images/service_delivery_01.jpg" width="507" height="167" alt="�Ϲ��۴ܰ�"> 
                   <div class="divider"></div>
                   <h4 class="font-blue marb10">�ù�</h4>
                   <img src="/images/service_delivery_02.jpg" width="716" height="165" alt="�ù��۴ܰ�"> 
                   <div class="divider"></div>
                   <h4 class="font-blue marb10">�ֹ� �����ð� �� �������</h4>
                   <img src="/images/service_delivery_03.jpg" width="721" height="101" alt="�������">
                   <div class="divider"></div>
                   
                   <h3 class="marb10">�ż���۽ý���</h3>
                   <p class="marb10">�ս����� ����� ���Ű������� ��۱��� ��� �ý����� ���� ����ǰ�, ���ð��濡 ��� ���Բ� ��۵˴ϴ�.</p>
                   <img src="/images/service_delivery_04.jpg" width="624" height="115" alt="�ż���۽ý���">
                   <div class="divider"></div>
                   
                   <h5 class="font-blue marb10">1. ��޽ð�</h5>
                   <p>�������� ��ħ(00:00~06:00)���̿� �̷�� ���ϴ�. ��õ��, �����Ȳ, ��޹����� �ް��� ����, ������ ��û ���� ��Ȳ�� ���� ������ ��� �ð����� 1�ð� ������ ����, ���� ��޵� �� �ֽ��ϴ�.</p>
                   <div class="divider"></div>
                   
                   <h5 class="font-blue marb10">2. ���ð��� �ȳ�</h5>
                   <p>
                   - ó�� �����Ͻ� ������ ����� ���� ���ð����� �����ϼž� �մϴ�. (���� ���Բ����� �߰��� �ʿ��Ͻ� ��� ���Ű� �����մϴ�.)<br />
                   - ���ð����� �н��� �ս������� å������ ������, �߰��� �������ּž� �մϴ�.<br />
                   - �Ϲ� ��ǰ�� ���ð����� ���� �����Ͻ� ��� ù ����Ͽ� ���� ��۵˴ϴ�.<br />
                   </p>
                   <div class="divider"></div>
                   
                   <h5 class="font-blue marb10">3. ���ɹ��</h5>
                   <p>�ս��� ��ü ��۽ý����� ���� ����� �̷������, �����պ�ġ, ���� ��Ź���� 2���� ��� �߿��� ������ ���ǿ� ���� �����Ͽ� ����� ������ �� �ֽ��ϴ�.<br />
                   <br />
                   �ֹ��� ��� �޽����� �����Ͻ� ����� ������ ��Ȯ�ϰ� ��ü���ϼ��� ��Ȯ�ϰ� ������ ����� �̷�����ϴ�.<br />
                   ��) ���� ���Թ� ��й�ȣ, ī��Ű ������ ��� ���Թ��, ����� ���ɰ��� ����ó �ȳ�
                   </p>
                   <div class="divider"></div>
                   
                   <h5 class="font-blue marb10">4. ��ް�������</h5>
                   <p>��޾ȳ� > ��ް������� �˻��� ���� Ȯ���� �����մϴ�.</p>
                   <br />
                   <div class="deliveryarea">
                       <h5 class="font-green">��ް�������</h5>
                       <div class="positionlist">
                           <dl>
                               <dt>������</dt>
                               <dd>
                                  <ul>
                                      <li>����</li>
                                      <li>���</li>
                                  </ul>
                               </dd>
                           </dl>
                           <dl>
                               <dt>������</dt>
                               <dd>
                                  <ul>
                                      <li>��õ</li>
                                      <li>�λ�</li>
                                      <li>�뱸</li>
                                      <li>���</li>
                                      <li>����</li>
                                      <li>����</li>
                                  </ul>
                               </dd>
                           </dl>
                           <dl>
                               <dt>�ֿ䵵��</dt>
                               <dd>
                                  <ul>
                                      <li>õ��</li>
                                      <li>�ƻ�</li>
                                      <li>û��</li>
                                      <li>�ͻ�</li>
                                      <li>����</li>
                                      <li>����</li>
                                      <li>���</li>
                                      <li>���</li>
                                      <li>����</li>
                                      <li>������â��</li>
                                  </ul>
                               </dd>
                           </dl>
                       </div>
                   </div>
                
                </div>
			</div>
			<!-- End row -->
		</div>
		<!-- End twelve columns offset-by-one -->
		<div class="sidebar four columns">
		    <p><a href="#"><img src="../images/side_banner_01.jpg" alt="�ս��� �Ѵ��� �˾ƺ���" width="242" height="211" /></a></p>
			<div class="bestfaq">
			   <h3>�����ϴ� ����</h3>
			   <ul>
			       <li><a href="#">�Ĵ� ���Ž� �ս��� ���� �̿� � ���񽺸� �ްԵǳ���?</a></li>
				   <li><a href="#">���α׷� ���� �� �ñ��� ������ ������ ��� �ϸ� �ǳ���?</a></li>
				   <li><a href="#">�ս��� ������ ���� ������ �ּ���.</a></li>
				   <li><a href="#">� ������ ������ �����ǳ���?</a></li>
				   <li><a href="#">������ ������ �ʿ��Ѱ���?</a></li>
			   </ul>
			</div>
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