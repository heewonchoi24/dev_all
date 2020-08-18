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
							<a href="/customer/service_change.jsp">�ֹ�����</a>
						</li>
						<li>
							<a href="/customer/service_recommand.jsp">���/��ȯ/ȯ��</a>
						</li>
                        <li>
							<span class="current">�������</span>
						</li>
                        <div class="clear"></div>
					</ul>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
			  <div class="threefourth last col">
				   <!--div class="marb20"><img src="/images/serimg_05_01.png" width="721" height="248"></div-->
                <h3 class="marb20">�����ȳ�</h3>
                    </p>
                    1. ���Բ� ����帮�� �������� �ս����� �پ��� Event�� ���Ͽ� ���Բ� ���� ���ð� ���Ǹ�  �帮�� ���� ������ ������ �帳�ϴ�.<br />
                    <br />
                    2. ������ �ս��� ����Ʈ���� �ǸŵǴ� ��ǰ���� ����Ǹ�, ����ȸ�� �� �ս������� ���� ����ڿ� ���Ͽ� ���޹��� �� �ֽ��ϴ�.<br />
                    <br />
                    3. ������ ���Ž� ������ �帮�� ������ �����ÿ� ����� �� ������, �ֹ��ÿ� ���� �� �ܾ��� ���Ҵ��� 1ȸ ������� �ڵ� �Ҹ�˴ϴ�.<br />
                    <br />
                    4. �߱޵Ǵ� ������ ������ѿ� ���� ���� ���� ������ ��ǰ�� �������� �� ������, �̷� ��� �ֹ��ܰ����� ������ ��������Ʈ����<br /> 
                    ������ ���� �� �ֽ��ϴ�.������ ���Ⱓ�� ������, �Ⱓ ��� �� �ڵ� �Ҹ�˴ϴ�.<br />
                    <br />
        
                    5. �ֹ���� �� ��ǰ�� �� ��� ����ߴ� ������ �Ҹ�Ǹ�, ����� ���� �ʽ��ϴ�.<br />
                    ��, �ֹ� �� ��� �Ǽ��� ���� �Ҹ�Ǿ��ų�, �ý��ۻ� ������ ���� �Ҹ�� ��쿡��
                       ����ݼ���(080-022-0085)�� �����ֽø�,<br /> Ȯ�� �� ��߱� �����մϴ�.<br />
                       <br />
                    6. ��밡���� ������ �����̽��� > ������������ Ȯ���Ͻ� �� �ֽ��ϴ�.<br />
                    <br />
                    7. ������������(������ȣ)�� �����ս��� > ������������ ���� �� ����Ͻ� �� �ֽ��ϴ�.<br />
                    <br />
                    </p>
                   <div class="divider"></div>
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