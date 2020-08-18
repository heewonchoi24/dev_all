<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
	String query			= "";
	int groupId				= 0;
	int price				= 0;
	int totalPrice			= 0;
	int realPrice			= 0;
	String groupInfo		= "";
	String offerNotice		= "";
	String groupName		= "";
	NumberFormat nf			= NumberFormat.getNumberInstance();
	String table			= " ESL_GOODS_GROUP";
	String where			= " WHERE GUBUN1 = '01' AND GUBUN2 = '11'";
	String sort				= " ORDER BY ID ASC";
%>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				�뷱�� ����ũ
			</h1>
			<div class="pageDepth">
				HOME > ��ǰ�Ұ� > <strong>�뷱�� ����ũ</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one goods">
			<div class="row">
			    <div class="one last col">
		            <div class="balanceshake_pr">
					   <h2><img src="/images/balanceshake_tit.png" width="470" height="144"></h2>
					   <div class="chep_img">
					       <img src="/images/balanceshake_img.png" width="434" height="330">
						</div>
					   <div class="chep_01">
					       <p class="f24 bold8 goodtt">Į�θ��� ���߰�<br />������ ä����!</p>
						   <p>Į�θ��� ���߰�, ������ ä��<br />�ǰ��ϰ� ���̾�Ʈ �� �� �ֵ���<br />����� ü�������� ��ǰ</p>
					   </div>
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">����ϰ� ���ִ�!</p>
						   <p style="text-align:right;">7���� ��� ������������<br />����� ���� �ô� ������ ����<br />���ִ� ���̾�Ʈ ���!</p>
					   </div>
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt">���̼�����<br />������� Plus!</p>
						   <p>���̼���(1���� 5.5g�� ����)�� ��ǰ���<br />���� �����(PMO 08)�� �Բ�!</p>
					   </div>
					</div>
					<div class="balanceshake_pr2 marb30">
					    <div class="chep_01">
						     <img src="/images/balanceshake_img2.png" width="980" height="164">
						</div>
					</div>
              </div>
			</div>
            <!-- End Row -->  
            <div class="row">
				<div class="one last col">
                <table class="centralKitchen" width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="suj"><img src="/images/balshake_tt01.png" width="235" height="31" alt="���뷮 �� ������" /></td>
                    <td style="padding-left:40px;">
                    <p>- �ѳ� �Ļ� ��ü �� 1��(35g)�� ������ ���� 200ml�� �ְ� �� ���� ���� �� õõ�� �þ ��ʽÿ�.</p>
                    <p>- ��ȣ�� ���� ������ ���� ������ �� �ֽ��ϴ�.</p>
                    <p>- ���뷮�� ���� �������� ǥ�õǾ� ������, �������� �����̳� ��ü ���¿� ���� ��ǰ���뷮 ������ �����մϴ�.</p></td>
                  </tr>
                  <tr>
                    <td class="suj"><img src="/images/balshake_tt02.png" width="209" height="31" alt="����� ���ǻ���" /> </td>
                    <td style="padding-left:40px;">
                    <p>- �������� ��ü ���¿� ���� ������ ���̰� ���� �� �ֽ��ϴ�.</p>
                    <p>- �˷����� ü���̽� ��� ������ Ȯ�� �Ͻ� �� �����Ͽ� �ֽñ� �ٶ��ϴ�.</p></td>
                  </tr>
                </table>
                </div>
            </div>
			<!-- End row -->
            <div class="row">
				<div class="one last col">
                    <table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="170">��ǰ��</td>
							<td class="last">�ս��� �뷱������ũ</td>
					  </tr>
						<tr>
							<td>��ǰ�� ����</td>
							<td class="last">ü�������� ������ǰ</td>
						</tr>
						<tr>
						  <td>������ �� ������</td>
						  <td class="last">Ǯ�����ǰ���Ȱ(��) (��� ���� ���ȸ� �����35)</td>
					  </tr>
						<tr>
						  <td>������ �� �Է�</td>
						  <td class="last">��û �ܹ�и�(����,�̱�), �ȶ�Ƽ�뽺, ��ȭ�̺� 9.69%(���,����), �������̺и� 7.23%(����,����), ���������и� 6.17%(����,����),<br />������ки� 5.66%(���,����), ������κи� 5.43%(���,����), �����Ұ��� 5.31%(���,����), �ư����̴���, ����������и� 4.00%(������,����),<br />�������� 2.57%(����,����), ���̼���(��), �����ôϾ�į������ ����и�, �����������и� 1.90%(������, �߱���), ��Ƽ��Ÿ�ι̳׶��ͽ�<br />(��Ÿ��Aȥ������, B1, B2, B6, C, Eȥ������, ���̾ƽ�, ����, ����Į��, Ǫ����������ö, ��ȭ�ƿ�), ī��Ų, ġĿ���Ѹ��и�, �и������</td>
					  </tr>
					</table>

                </div>
            </div>
			<!-- End row -->
            <div class="divider"></div>
             <div class="row">
			    <div class="one last col">
                <h2>���缺��(1ȸ ������ 35g)</h2>
                <div class="divider"></div>
                  <table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <th>���缺��</th>
                      <th>1ȸ �������� �Է�</th>
                      <th class="last">%����� ����ġ</th>
                    </tr>
                    <tr>
                      <td>����</td>
                      <td>125kcal</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>ź��ȭ��</td>
                      <td>23kcal</td>
                      <td>7%</td>
                    </tr>
                    <tr>
                      <td>���</td>
                      <td>3g</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>���̼���</td>
                      <td>5.5g</td>
                      <td>22%</td>
                    </tr>
                    <tr>
                      <td>�ܹ���</td>
                      <td>8g</td>
                      <td>15%</td>
                    </tr>
                    <tr>
                      <td>����</td>
                      <td>1.3g</td>
                      <td>3%</td>
                    </tr>
                    <tr>
                      <td>��ȭ����</td>
                      <td>0.3g</td>
                      <td>2%</td>
                    </tr>
                    <tr>
                      <td>Ʈ��������</td>
                      <td>0g</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>�ݷ���Ʈ��</td>
                      <td>0mg</td>
                      <td>0%</td>
                    </tr>
                    <tr>
                      <td>��Ʈ��</td>
                      <td>35mg</td>
                      <td>2%</td>
                    </tr>
                    <tr>
                      <td colspan="3" style="background:#F0F0F0;line-height:160%;">ö��1.2mg(10%), Į��70mg(10%), �ƿ�0.85mg(10%), ��Ÿ��A 175&micro;gRE(25%),<br />��Ÿ��E 2.8mg a -TE(25%), ��Ÿ��C 25mg(25%), ��Ÿ��B1 0.3mg(25%),<br />��Ÿ��B2 0.4mg(25%), ���̾ƽ� 3.8mgNE(25%), ��Ÿ��B6 0.4mg(25%), ����100&micro;g(25%)</td>
                    </tr>
                  </table>
                </div>
             </div>      
             <!-- End row -->
             <div class="divider"></div>
            <div class="row">
			    <div class="one last col center">
                    <div class="button large dark">
                        <a href="/shop/balanceShake.jsp">�ֹ��ϱ�</a></div>
              </div>
            </div>

		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
	<div id="footer">		
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div> <!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
</body>
</html>