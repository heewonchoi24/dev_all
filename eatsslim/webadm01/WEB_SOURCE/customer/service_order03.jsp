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
							<span class="btn04"><a class="current" href="/customer/service_order03.jsp">�ſ�ī�����</a></span>
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
                  <dt><h2>ī�����</h2></dt>
                  <dd>
                      <p class="marb20">ī������� ���ͳ� ����� �����ϵ��� �Ƚ�Ŭ��, �Ƚɰ����� �ʼ��� ����ϼž� �մϴ�.<br />�Ƚ�Ŭ���� ���� ī������� �Ͻø� �Ƚ��ϰ� ���ϰ� ������ ��� �� �ֽ��ϴ�.</p>
                  </dd>
                </dl>
                <dl class="regist">
                  <dt><h2>�Ƚ�Ŭ��<br />���񽺵��</h2></dt>
                     <dd>
                      <ul class="bubblelist">
                            <li>
                               <span class="bubble">01</span>
                               <h4>�Ƚ�Ŭ�� ���񽺶�?</h4>
                               <p>���ͳݼ��� ī����� �� �ſ�ī���ȣ, ��й�ȣ ���� �Է������ν� �߻��� �� �ִ� �������� ������ �������� �����ϱ� ���� �Ｚ, LG, ��ȯ, ����, ����, �Ե�, �ϳ�, �ѹ�, ��Ƽ, �ż���, ����, ����, ����, ����, ����ī��, ����(�� ����ī��)�� �����ϴ� ���ڻ�ŷ��� �缳���� ���� �Դϴ�.<br />ī��� �� ��Ϲ���� �Ʒ� ���μ����� ������ �ֽñ� �ٶ��ϴ�.</p>
                               <div class="marb10 mart10"><img src="/images/serimg_02_05.png" width="561" height="93"></div>
                               <p class="list-star">�� 14�� �̻��� ���ѹα� �����̶�� ������ Ǯ���� �ս��� ȸ������ �����Ͻ� �� �ֽ��ϴ�.</p>
                            </li>
                            <li>
                               <span class="bubble">02</span>
                               <h4>�Ƚ�Ŭ�� ���� �ű԰��� ����</h4>
                               <p>�Ƚ�Ŭ�� ���� ����(���)�� ���ǻ��� �Ƚ�Ŭ�� ���� ������ �Ƚ�Ŭ�� �������񽺸� �����ϴ� ������ �ſ�ī�带 �����ϰ� ��� ��� �� �ſ�ī��縶�� �Ƚ�Ŭ�� ���񽺸� �����ϼž� �մϴ�.</p>
                               <div class="mart10"><img src="/images/serimg_02_06.png" width="561" height="250"></div>
                            </li>
                            <li>
                               <span class="bubble">03</span>
                               <h4>�Ƚ�Ŭ������ ���� ����ϱ�</h4>
                               <ul class="cardRegister">
                                   <li class="first"><span class="lg"></span><p class="button small dark"><a href="https://www.shinhancard.com/conts/person/main.jsp" target="new">���</a></p></li>
                                   <li><span class="hn"></span><p class="button small dark"><a href="http://www.hanaskcard.com/" target="new">���</a></p></li>
                                   <li><span class="ss"></span><p class="button small dark"><a href="https://www.samsungcard.com/index.do" target="new">���</a></p></li>
                                   <li class="last"><span class="cb"></span><p class="button small dark"><a href="http://www.citibank.co.kr/" target="new">���</a></p></li>
                                   <li class="first"><span class="keb"></span><p class="button small dark"><a href="http://card.keb.co.kr/veraport/install/install.html" target="new">���</a></p></li>
                                   <li><span class="sh"></span><p class="button small dark"><a href="https://www.shinhancard.com/conts/person/main.jsp" target="new">���</a></p></li>
                                   <li><span class="hd"></span><p class="button small dark"><a href="https://www.hyundaicard.com/index.jsp" target="new">���</a></p></li>
                                   <li class="last"><span class="lt"></span><p class="button small dark"><a href="http://www.lottecard.co.kr/app/index.jsp" target="new">���</a></p></li>
                                   <li class="first"><span class="suh"></span><p class="button small dark"><a href="https://www.suhyup-bank.com/" target="new">���</a></p></li>
                                   <li><span class="jb"></span><p class="button small dark"><a href="http://www.jbbank.co.kr/" target="new">���</a></p></li>
                                   <li><span class="kj"></span><p class="button small dark"><a href="http://www.kjbank.com/banking/index.jsp" target="new">���</a></p></li>
                                   <li class="last"><span class="jj"></span><p class="button small dark"><a href="https://www.e-jejubank.com/JeJuBankInfo.do" target="new">���</a></p></li>
                                  <div class="clear"></div>
						       </ul>
                            </li>
                      </ul>
                  </dd>
                  </dl>
                  <div class="divider"></div>
                  <dl class="regist">
                      <dt><h2>ISP����<br />ī�����</h2></dt>
                      <dd>
                          <ul class="bubblelist">
                            <li>
                                <span class="bubble">01</span>
                                <h4>ISP���� ����������?</h4>
                                <p>�Ｚ, LG, ��ȯ, ����, ����, �ѹ�, �ϳ�, ����, �Ե�, ����, ����, ����, ��, ����ī��� ī������� �Ƚ�Ŭ���� �����Ͻø� �˴ϴ�. 30���� �̸� ���� �� �Ƚ�Ŭ�� ���� â���� ���������� �Ǵ� �н����� ����� �����Ͻø� �ǰ� 30���� �̻� ���� �� ���������� ������� ���� �ϼž� �մϴ�.</p>
                            </li>
                            <li>
                                <span class="bubble">02</span>
                                <h4>ISP������ ���� ī�� �������� ���</h4>
                                <ul class="colorchart">
                                    <li>STEP 01. �ֹ��� �ۼ��� �������� ����</li>
                                    <li>STEP 02. ISP ���� ���Ȯ��</li>
                                    <li>STEP 03. �Ƚ�Ŭ�� ���Ȯ��</li>
                                    <li>STEP 04. ISP���� ��й�ȣ �Է�(30���� �̸� ���Ž�)</li>
                                    <li>STEP 05. ISP��й�ȣ �Է� +���������� ��й�ȣ �Է�</li>
                                    <li>STEP 06. �ֹ��Ϸ�</li>
                                </ul>
                            </li>
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