<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>��ȯ��ǰ ����</title>
</head>
<body>
<div class="pop-wrap">
  <div class="headpop">
    <h2>��ȯ��û</h2>
    <p>��ǰ�� ��ȯ�Ͻðڽ��ϱ�? �ֹ������� Ȯ���Ͻð� ��ȯ ��û�� ���ֽʽÿ�.</p>
  </div>
  <div class="contentpop">
    <div class="popup columns offset-by-one">
      <div class="row">
        <div class="one last col">
          <div class="sectionHeader">
            <h4> �ֹ�����<span class="font-blue f14 padl50">A2013080138441</span> �� <span class="f14">2013.08.29</span> </h4>
          </div>
          <table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th class="none">����</th>
              <th class="none">�ù豸��</th>
              <th>��ǰ��</th>
              <th>����</th>
              <th>��ǰ�ݾ�</th>
              <th class="last">�ֹ�����</th>
            </tr>
            <tr>
              <td><input name="" type="checkbox" value=""></td>
              <td>�ù�</td>
              <td><div class="orderName"> <img class="thumbleft" src="/images/order_sample.jpg">
                  <h4> ��Ƽ����Ƽ </h4>
                </div></td>
              <td>1</td>
              <td><%=nf.format(defaultBagPrice)%>��</td>
              <td><div class="font-blue"> ��ۿϷ� </div></td>
            </tr>
          </table>
          <!-- End orderList --> 
        </div>
      </div>
      <!-- End row -->
      <div class="row">
        <div class="one last col">
          <div class="sectionHeader">
            <h4>��ȯ���� �Է�</h4>
          </div>
          <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th>��ȯ��������</th>
              <td>
                <select name="select" id="select" style="width:200px;">
                  <option>��ȯ��������</option>
                </select>
              </td>
            </tr>
            <tr>
              <th>��ȯ���� ��<br />��Ÿ ��û����</th>
              <td>
                <input type="text" name="textfield" id="textfield" style="width:500px;">
                <p class="font-gray">�Է±��ڴ� �ִ� �ѱ�60��, ����/���� 120�ڱ��� �����մϴ�.</p>
              </td>
            </tr>
          </table>
          <!-- End orderList --> 
        </div>
      </div>
      <!-- End row -->
      <div class="row">
        <div class="one last col center">
          <div class="button large dark"><a href="#">��ȯ��û</a></div>
        </div>
      </div>
      <!-- End row --> 
    </div>
    <!-- End popup columns offset-by-one --> 
  </div>
  <!-- End contentpop --> 
</div>
</body>
</html>