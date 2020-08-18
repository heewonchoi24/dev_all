<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
</head>
<body>
<div id="wrap">
  <div id="header">
    <%@ include file="/common/include/inc-header.jsp"%>
  </div>
  <!-- End header -->
  <div class="container">
    <div class="maintitle">
      <h1> �̿�ȳ� </h1>
      <div class="pageDepth"> HOME > ������ > <strong>�̿�ȳ�</strong> </div>
      <div class="clear"> </div>
    </div>
    <div class="twelve columns offset-by-one ">
      <div class="row">
        <div class="threefourth last col">
          <ul class="tabNavi">
            <li> <a href="/customer/notice.jsp">��������</a> </li>
            <li> <a href="/customer/faq.jsp">FAQ</a> </li>
            <%if (eslMemberId.equals("")) {%>
						<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">1:1����</a></li>
						<%} else {%>
						<li><a href="indiqna.jsp">1:1����</a></li>
						<%}%>
            <li class="active"> <a href="/customer/service_member.jsp">�̿�ȳ�</a> </li>
            <li> <a href="/customer/presscenter.jsp">��к���</a> </li>
          </ul>
          <div class="clear"> </div>
        </div>
      </div>
      <div class="row" style="margin-bottom:40px;">
        <div class="threefourth last col">
          <ul class="listSort">
            <li> <a href="/customer/service_member.jsp">ȸ������</a> </li>
            <li> <a href="/customer/service_order.jsp">�ֹ�/����</a> </li>
            <li> <a href="/customer/service_change.jsp">�ֹ�����</a> </li>
            <li> <span class="current">���/��ȯ/ȯ��</span> </li>
            <li> <a href="/customer/service_coupon.jsp">�������</a> </li>
          </ul>
        </div>
      </div>
      <!-- End row -->
      <div class="row">
        <div class="threefourth last col">
          <div class="marb50"><img src="/images/serimg_04_01.png" width="721" height="160"></div>
          <dl class="regist">
            <dt>
              <h2>�ֹ����</h2>
            </dt>
            <dd>
              <ul class="bubblelist">
                <li> <span class="bubble">01</span>
                  <h4>�Ϲ�</h4>
                  <p> 1. �ֹ� ��ǰ�� �����Ϸ� ������ ��쿡�� ��ҽ� ���� ȯ���� �����մϴ�.<br />
                    2. �ֹ��Ϸ� �Ŀ��� ��ҽ����� ���� �κ������� ȯ���� �����մϴ�. �ս����� �ֹ��������̹Ƿ�,<br />
					��Ҹ� ���Ͻô� ��������� �ִ� D-3�� ������ ��� ó���� �����Ͻʴϴ�.<br/>
					��) ������ڰ� 1�� 10���� ��� -> 1�� 7�ϱ��� ��� ��û�� ���ּž� ��� ����) </p>
                  <div class="mart10 marb10"><img src="/images/serimg_04_02.png" width="561" height="50"></div>
                </li>
                <li> <span class="bubble">02</span>
                  <h4>�ù�</h4>
                  <p> �ֹ���Ҵ� '�ֹ�����','�����Ϸ�'������ �ֹ���Ұ� �����մϴ�.<br />
                    ���� ��Ҹ� ��û�Ͻ� ��쿡�� �����ͷ� ������ �ֽñ� �ٸ��ϴ�. </p>
                  <div class="mart10 marb10"><img src="/images/serimg_04_03.png" width="561" height="150"></div>
                  <p>�ֹ���Ҵ� <span class="txtline">�����ս��� > �ֹ���� > �ֹ������ȸ</span>���� ��û�Ͻðų�  ������ 1:1��� �Ǵ� ����ݼ��� 080-022-0085�� ������ �˷��ֽø� �ż��ϰ� ó���� �帮�ڽ��ϴ�.</p>
                </li>
                <li> <span class="bubble">03</span>
                  <h4>����</h4>
                  <p> �ֹ��� ������ ����Ͻ� ��� �ֹ� ��ҽ� ������ �������� �ʽ��ϴ�. </p>
                </li>
              </ul>
            </dd>
          </dl>
          <div class="divider"></div>
          <dl class="regist">
            <dt>
              <h2>��ȯ��ǰ<br />
                ȯ�ұ���</h2>
            </dt>
            <dd>
              <ul class="bubblelist">
                <li> <span class="bubble">01</span>
                  <h4>�ù�</h4>
                  <p> 1. ��ȯ/��ǰ ��û�� �ù��ǰ�� �����մϴ�.<br />
                    2. ��ȯ/��ǰ��û�� ��ǰ ���� �� 7�� �̳����� �����մϴ�. <br />
                    (�ֹ��Ϸ� �������� ��ȯ/��ǰ ��û�� �Ұ��մϴ�.)<br />
                    3. ������ ���ɿ� ���� ��ȯ/��ǰ�� ��� �ݼ۽� �ΰ��Ǵ� ��޷�� ���Բ��� �δ��ϼž� �մϴ�.<br />
                    4. ���Ƿ� �ݼ��Ͻ� ��� ȯ�� ���� ó���� ������ �� �����Ƿ� �ݼ� �� �� �����ͷ� �������ֽñ� �ٶ��ϴ�.<br />
                    5. �ֹ��� ������ ����Ͻ� ��� �ֹ� ��ǰ�� ������ �������� �ʽ��ϴ�.<br />
                  </p>
                </li>
              </ul>
            </dd>
          </dl>
          <div class="divider"></div>
          <dl class="regist">
            <dt>
              <h2>��ȯ��ǰ<br />
                ȯ�ұ���</h2>
            </dt>
            <dd>
              <table class="termstable" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <th width="33%">����</th>
                  <th width="33%">��ȯ/��ǰ ����</th>
                  <th>�����Ⱓ</th>
                </tr>
                <tr>
                  <td>�ҷ� �� ���������<br />
                    ���� ��ȯ��ǰ<br />
                    (��ǰ/��ȯ �� �߻��ϴ�<br />
                    ����� �ս��� �δ�) </td>
                  <td>
                    1. ��ǰ�� ���ڰ� �ְų� �ҷ���<br />
                    ��� (����,�ҷ�,�ļ�,ǥ�����<br />,�̹�ȥ��, �߷��̴� ��)<br />
                  2. �ֹ��� ������ �ٸ� ��ǰ��<br />��޵� ���</td>
                  <td class="last">1. ��ǰ �����Ϸκ��� 7���̳�<br />
                    2. ��ǰ�� ������ ǥ��,���� ���� <br />
                    �� �����ϰų� ��೻��� �ٸ���<br />
                    ����� ��쿡�� ��ǰ�� ���޹���<br />
                    ���κ��� 3���� �̳�, �� �����<br />
                    ������ ���� �Ǵ� ������ �� �־�<br />
                    �� �������κ��� 30�� �̳���<br />
                    ��ȯ �� ��ǰ�� �����մϴ�.</td>
                </tr>
                <tr>
                  <td>�� �ܼ��������� ���� 
                    ��ǰ
                    (��ǰ/��ȯ �� �߻��ϴ�
                    ����� ���δ��̸�,
                    �������� ��� �պ���
                    ��� �δ�)
                    
                    *�����Ͻ� �ݾ׿���
                    �ù����� ������ �ݾ�
                    �� ȯ�ҵ˴ϴ�.</td>
                  <td>1. ���� �� ����ǰ��<br />�Ѽյ��� �ʴ� ��� </td>
                  <td class="last">
                  1. ��ǰ �����Ϸκ��� 7���̳���
                    ��ǰ�� �����ϸ�, �ù��� �̿�
                    �ڰ� �δ��ؾ� �մϴ�.
                    (�������ǰ�� �պ��ù��
                  �δ��ؾ��մϴ�.) </td>
                </tr>
                <tr>
                  <td>��� �� ��ǰ�� �Ұ���
                    ���</td>
                  <td>
                    1. �̿����� å������ ��ǰ�� �Ѽյ� ���
                    (���� �Ѽ����� ���� ��ǰ��ġ�� ��� �� ��쵵 ����)<br />
                    2. �̿����� �Ϻ� �Һ�λ�ǰ�� ��ġ�� ������ ������ ���<br />
                  3. �ð��� ����� ���Ͽ� ��ǰ�� ���ǸŰ� ����� ������ ��ǰ�� ��ġ�� ������ �����Ѱ��)</td>
                  <td class="last"></td>
                </tr>
              </table>
              <p class="mart10">�ֹ���ȯ �� ��ǰ�� <span class="txtline">�����ս��� > �ֹ���� > �ֹ������ȸ</span> ���� ��û�Ͻðų� ������ 1:1���<br />
                �Ǵ� ��ȭ 080-022-0085�� ������ �˷��ֽø� �ż��ϰ� ó���� �帮�ڽ��ϴ�.</p>
            </dd>
          </dl>
          <div class="divider"></div>
          <dl class="regist">
            <dt>
              <h2>ȯ�Ҿȳ�</h2>
            </dt>
            <dd>
              <ul class="bubblelist">
                <li> 
                <span class="bubble">01</span>
                  <h4>�ֹ���� �� ���� ����� ���� ȯ��</h4>
                  <h5>- �ս��� Ȩ���������� �ֹ��� ���</h5>
                   <dl class="bluepoint">
                     <dt>�������</dt><dd><span>ȯ�Ұ����Ա�</span></dd>
                     <div class="clear"></div>
                     <dt>�ǽð�������ü</dt><dd><span>ȯ�Ұ����Ա�</span></dd>
                     <div class="clear"></div>
                     <dt>ī�����</dt><dd><span>ī��� ������ ���� �뷫 3~5������ ��ұⰣ �ʿ�</span></dd>
                   </dl>
                   <br />
                   <h5>- �ܺθ����� �ֹ��� ���</h5>
                    <p>���� ����� ������� ����ȯ�� �˴ϴ�. ��, �ֹ� �� ù ����� ȯ�ҽ�(��üȯ��) Ȩ������ �ֹ��� ȯ�ҹ���� �����ϴ�.</p>
                </li>
                <li>
                  <span class="bubble">02</span>
                  <h4>��������Ϸκ��� ȯ���� �Ϸ�ɶ����� 5~7�������� �ð��� �ҿ�˴ϴ�.</h4>
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
  </div>
  <!-- End footer -->
  <div id="floatMenu">
    <%@ include file="/common/include/inc-floating.jsp"%>
  </div>
  <%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
</body>
</html>