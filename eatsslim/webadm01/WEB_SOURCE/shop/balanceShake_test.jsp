<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String query			= "";
int groupId				= 0;
String groupName		= "";
int price				= 0;
int tSalePrice			= 0;
String groupInfo		= "";
String offerNotice		= "";
int categoryId			= 0;
String categoryName		= "";
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT ID, GROUP_NAME, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE FROM ESL_GOODS_GROUP WHERE GUBUN1 = '03' AND GUBUN2 = '32'";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	groupName		= rs.getString("GROUP_NAME");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");

	//tSalePrice		= (int)Math.round((double)(price) * (double)(100 - 10) / 100);
}

rs.close();
pstmt.close();
%>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>�뷱�� ����ũ</h1>
			<div class="pageDepth">
				HOME > SHOP > Ÿ�Ժ� ���̾�Ʈ > <strong>�뷱�� ����ũ</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="eleven columns offset-by-one ">
			<div class="row">
				<h3 class="marb20">�ս��� �뷱������ũ</h3>
				<div class="twothird last col">
					<div class="dietcontent">
						<div class="head">
							<p class="f18 bold8">Į�θ��� ���߰� ������ ä�� ü�������� ��ǰ</p>
							<p class="f24 bold8">�뷱�� ����ũ</p>
                        <div class="balloon"><img src="/images/balloon-125cal.png" width="67" height="83"></div>    
						</div>
						<div class="center">
                          <p class="mart20"><img src="/images/balanceshake.jpg" width="638" height="207" /></p>
                        </div>
						<div class="clear"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- End eleven columns offset-by-one -->
		<form name="frm_order" id="frm_order" method="post">
			<input type="hidden" name="mode" value="addCart" />
			<input type="hidden" name="cart_type" id="cart_type" />
			<input type="hidden" name="group_id" id="group_id" value="<%=groupId%>" />
			<input type="hidden" name="price" id="price" value="<%=price%>" />
			<input type="hidden" name="sale_type" id="sale_type" value="P" />
			<input type="hidden" name="sale_price" id="sale_price" value="20" />
			<div class="sidebar five columns">
				<h3 class="marb20">�ֹ��ϱ�</h3>
				<div class="sideorder">
					<div class="title">������ǰ ����</div>
					<div class="itembox">
						<ul class="badgecount">
							<li>
								<span class="badge">1</span>
								<p>��ǰ����</p>
                                <div id="groupSelect">
									<select name="select" id="select" style="width:230px;">
										<option value="<%=groupId%>"><%=groupName%></option>
									</select>
                                </div>    
							</li>
							<li>
								<span class="badge">2</span>
								<p class="floatleft">����</p>
								<div class="quantity floatright" style="width:140px;">
									<input class="minus" type="button" value="-" />
									<input class="input-text qty text" maxlength="2" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly />
									<input class="plus" type="button" value="+" />
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</div>
				</div>
				<div class="divider"></div> 
				<div class="price-wrapper">
					<font style="font-weight:bold; color:blue;">�߼��� ǳ��Ӱ�, ���� �ֹ��ϰ� �߼��ں��ʹ� ���̾�Ʈ ����! Ư������(~9/5)</font>
					<p class="price">
						�Ѱ���:
						<span id="saleDiv" class="hidden">
							<del>
								<span class="amount tprice"><%=nf.format(price)%>��</span>
							</del>
							<ins>
								<span class="amount" id="sprice"><%=nf.format(tSalePrice)%>��</span>
							</ins>
						</span>
						<span id="nosaleDiv">
							<ins>
								<span class="amount tprice"><%=nf.format(price)%>��</span>
							</ins>
						</span>
					</p>
					<%if (eslMemberId.equals("")) {%>
					<div class="button large light"><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">��ٱ���</a></div>
					<div class="button large dark iconBtn"><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350"><span class="star"></span>�ٷα���</a></div>
					<%} else {%>
					<div class="button large light"><a href="javascript:;" onclick="addCart('C');">��ٱ���</a></div>
					<div class="button large dark iconBtn"><a href="javascript:;" onclick="addCart('L');"><span class="star"></span>�ٷα���</a></div>
					<%}%>
					<div class="clear"></div>
				</div>  
			</div>
		</form>
		<!-- End sidebar four columns -->
		<div class="divider"></div>
		<div class="sixteen columns offset-by-one">
			<!--div class="row col grayhalf">
				<h4 class="font-blue marb10">��ǰ����</h4>
				<div class="oneinhalf">
					<a href="#" title="�ս������� ���̾�Ʈ ����">
						<img class="thumbleft" src="/images/notice_sample.jpg" width="160" height="108" title="[����]�ս��� ���� ����ȳ� (�Ұ�� �����)" />
						<span class="meta"><strong>POST BY</strong> hong1004</span>
						<span class="post-title">
							<h3>�ս������� ���̾�Ʈ ����</h3>
							<p>�ȳ��ϼ���. �ս����Դϴ�. �ս����� ���ɸ޴��� "�Ұ������"�� 5�� 30��(��) �����к��� "�����"���� ���� ������ �����Դϴ�. �ż��� �޴� ������ ���� ���� �����ǿ���...</p>
						</span>
					</a>
				</div>
				<div class="oneinhalf last">
					<a href="#" title="�ս������� ���̾�Ʈ ����">
						<img class="thumbleft" src="/images/notice_sample.jpg" width="160" height="108" title="[����]�ս��� ���� ����ȳ� (�Ұ�� �����)" />
						<span class="meta"><strong>POST BY</strong> hong1004</span>
						<span class="post-title">
							<h3>�ս������� ���̾�Ʈ ����</h3>
							<p>�ȳ��ϼ���. �ս����Դϴ�. �ս����� ���ɸ޴��� "�Ұ������"�� 5�� 30��(��) �����к��� "�����"���� ���� ������ �����Դϴ�. �ż��� �޴� ������ ���� ���� �����ǿ���...</p>
						</span>
					</a>
				</div>
				<div class="clear"></div>
			</div-->	
			<div class="divider"></div> 
			<div class="row col">
				<div class="one last col">
					<ul class="tabNavi marb30">
						<li class="active">
							<a href="#detail-item">�� ��ǰ����</a>
						</li>
						<li>
							<a href="#detail-delivery">��۾ȳ�</a>
						</li>
						<li>
							<a href="#detail-notify">��ǰ���� �������</a>
						</li>
						<div class="clear"></div>
					</ul>
					<div id="detail-item">
						<p class="marb40"><img src="/images/detail_sample_shake.jpg" alt="������"></p>
          <!--p><img src="/images/detail_sample.jpg" width="999" height="472"></p-->
						<%=groupInfo%>
					</div>
					<div class="divider"></div> 
					<ul class="tabNavi marb30">
						<li>
							<a href="#detail-item">�� ��ǰ����</a>
						</li>
						<li class="active">
							<a href="#detail-delivery">��۾ȳ�</a>
						</li>
						<li>
							<a href="#detail-notify">��ǰ���� �������</a>
						</li>
						<div class="clear"></div>
					</ul>
					<div id="detail-delivery">
						<p><img src="/images/dietmeal_detail_02_2.jpg"></p>
					</div>
					<div class="divider"></div>
					<ul class="tabNavi marb30">
						<li>
							<a href="#detail-item">�� ��ǰ����</a>
						</li>
						<li>
							<a href="#detail-delivery">��۾ȳ�</a>
						</li>
						<li class="active">
							<a href="#detail-notify">��ǰ���� �������</a>
						</li>
                      </ul>
					<div id="detail-notify">
						<table class="orderList clear" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>����</th>
							<th class="last">����</th>
						</tr>
						<tr>
							<td>��ǰ�� ����</td>
							<td style="text-align:left;">ü��������������ǰ</td>
						</tr>
						<tr>
						  <td>������ �� ������</td>
						  <td style="text-align:left;">Ǯ�����ǰ���Ȱ(��)</td>
						  </tr>
						<tr>
						  <td>������</td>
						  <td style="text-align:left;">��� ���� ���ȸ� ����� 35</td>
						  </tr>
						<tr>
						  <td>����ǰ�� ��� ������</td>
						  <td style="text-align:left;">�ش���� ����</td>
						  </tr>
						<tr>
						  <td>��������</td>
						  <td style="text-align:left;"><span class="font-maple">�� �ֹ����� �� ������忡�� ���� �ֱٿ� ����� ��ǰ�� �غ��Ͽ��ż��� ����ϹǷ�,<br />��Ȯ�� ��������� �ȳ��� ��ƽ��ϴ�.</span></td>
						  <!--<td style="text-align:left;">������ ����, 2���� ����� ��ǰ�� ��޵˴ϴ�.<br /><span class="font-maple">�� �ֹ����� �� ������忡�� ���� �ֱٿ� ����� ��ǰ�� �غ��Ͽ�<br />�ż��� ����ϹǷ�, ��Ȯ�� ��������� �ȳ��� ��ƽ��ϴ�.</span></td>-->
						  </tr>
						<tr>
						  <td>�������</td>
						  <td style="text-align:left;">365��</td>
						  </tr>
                         <tr>
						  <td>�߷� �� ����</td>
						  <td style="text-align:left;">35g*14����</td>
						  </tr> 
						<tr>
						  <td>����� �� �Է�</td>
						  <td style="text-align:left;">��û�ܹ�и�(����, �̱�), �ȶ�Ƽ�뽺, ��ȭ�̺� 9.69%(���, ����), �������̺и� 7.23%(����, ����),<br />
                          ���������и� 6.17%(����, ����), ������ки� 5.66%(���, ����), ������κи� 5.43%(���, ����),<br />
                          �����Ұ��� 5.31%(���, ����), �ư����̴���, ����������и� 4.00%(������, ����), �������� 2.57%(����, ����),<br />
                          ���̼���(��), �����ôϾ�į����������и�, �����������и� 1.90%(������, �߱���), ��Ƽ��Ÿ�ι̳׶��ͽ�<br />
                          (��Ÿ��Aȥ������, B1, B2, B6, C, Eȥ������, ���̾ƽ�, ����, ����Į��, Ǫ����������ö, ��ȭ�ƿ�), ī��Ų,<br />ġĿ���Ѹ��и�, �и������</td>
						  </tr>
						<tr>
						  <td>���뷮, ������,<br />����� ���ǻ���</td>
						  <td style="text-align:left;">* �� ��ǰ�� �������� ��ü ���¿� ���� ������ ���̰� ���� �� �ֽ��ϴ�.<br />* �˷����� ü���̽� ��� ������ Ȯ���Ͻ� �� �����Ͽ� �ֽñ� �ٶ��ϴ�.</td>
						  </tr>
						<tr>
						  <td>�����������ս�ǰ ����</td>
						  <td style="text-align:left;">�ش���� ����</td>
						  </tr>
						<tr>
                        <tr>
						  <td>ǥ�ñ��� �������ǿ���</td>
						  <td style="text-align:left;">ǥ�ñ��� �������� ����</td>
						  </tr>
						<tr>
						  <td>���Խ�ǰ:<br /><span class="font-maple">��ǰ�������� ���� ���ԽŰ� ����</span></td>
						  <td style="text-align:left;">�ش���� ����</td>
						  </tr>
						<tr>
						  <td>������ ����ó</td>
						  <td style="text-align:left;">Ǯ���� ����ݼ��� 080-022-0085(�����ںδ�)</td>
						  </tr>
				    </table>
					</div>
				</div>
			</div>	
		</div>
		<!-- End sixteen columns offset-by-one -->
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
<script type="text/javascript">
$(document).ready(function() {
	getSalePrice();

	$(".plus").click(function() {
		var totalPrice	= 0;
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		totalPrice	= parseInt($("#price").val()) * buyQty;
		$("#buy_qty").val(buyQty);
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		getSalePrice();
	});
	$(".minus").click(function() {
		var totalPrice	= 0;
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		totalPrice	= parseInt($("#price").val()) * buyQty;		
		$(".tprice").text(commaSplit(totalPrice)+ "��");
		$("#buy_qty").val(buyQty);
		getSalePrice();
	});
});

function addCart(t) {
	$("#cart_type").val(t);
	$.post("balanceShake_ajax_test.jsp", $("#frm_order").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				if (t == 'C') {
					$.lightbox("/shop/cartConfirm.jsp?lightbox[width]=960&lightbox[height]=500");
				} else {
					location.href = "order.jsp?mode=L";
				}
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
					});
				});
			}
		});
	}, "xml");
	return false;
}

function getSalePrice() {
	var buyQty		= parseInt($("#buy_qty").val());
	var salePrice	= $("#sale_price").val();
	var saleType	= $("#sale_type").val();
	var totalPrice	= parseInt($("#price").val()) * buyQty;
	if (parseInt(salePrice) > 0 && saleType) {
		$("#saleDiv").removeClass("hidden");
		$("#nosaleDiv").addClass("hidden");
		if (saleType == "W") {
			salePrice	= totalPrice - salePrice;
		} else {
			salePrice	= Math.round(parseFloat(totalPrice) * (100 - parseFloat(salePrice)) / 100);
		}
		$("#sprice").text(commaSplit(salePrice)+ "��");
	} else {
		$("#saleDiv").addClass("hidden");
		$("#nosaleDiv").removeClass("hidden");
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>