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
String groupCode	= "";
String offerNotice		= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
String saleTitle = 	"";
String saleType = 	"";
int salePrice = 	0;
String useGoods = 	"";
int categoryId			= 0;
String categoryName		= "";
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT ID, GROUP_NAME, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE, GROUP_CODE FROM ESL_GOODS_GROUP WHERE GUBUN1 = '50' AND GUBUN2 = '02' AND GROUP_CODE = '0130134' ";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	groupName		= rs.getString("GROUP_NAME");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");
	groupCode		= rs.getString("GROUP_CODE");

	//tSalePrice		= (int)Math.round((double)(price) * (double)(100 - 10) / 100);
	
	String where1			= " WHERE  ('"+today+"' BETWEEN STDATE AND LTDATE) AND (GROUP_CODE = '"+groupCode+"'  or GROUP_CODE is null) ";
	String sort1			=  " ORDER BY ES.ID DESC";
	query		= "SELECT TITLE, SALE_TYPE, SALE_PRICE, USE_GOODS FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID " + where1 + sort1 + " LIMIT 0, 1";
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();

	if (rs.next()) {		
		saleTitle			= rs.getString("TITLE");
		saleType			= rs.getString("SALE_TYPE");
		salePrice		= rs.getInt("SALE_PRICE");
		useGoods		= rs.getString("USE_GOODS");
		
		if (saleType.equals("P")) {
			tSalePrice		= (int)Math.round((double)(price * 10) * (double)(100 - salePrice) / 100) + defaultBagPrice;
		} else {
			tSalePrice		= (int)Math.round((double)( (price - salePrice) * 10)) + defaultBagPrice;
		}
		
	}	
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
			<h1>Ǯ��Ÿ</h1>
			<div class="pageDepth">
				HOME > SHOP > Ǯ��Ÿ > <strong>�׸���Ƽ ��չ뷱��</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="eleven columns offset-by-one ">
			<div class="row">
				<h3 class="marb20">�׸���Ƽ ��չ뷱��</h3>
				<div class="twothird last col">
					<div class="dietcontent">
						<div class="head">
							<p class="f18 bold8">�Ĺ��� õ�� ���� ���� ��Ƽ ��Ÿ��!</p>
							<p class="f24 bold8">�׸���Ƽ ��չ뷱��</p>
						</div>
						<div class="center">
                          <p class="mart20"><img src="/images/womanBalance.jpg" width="638" height="180" /></p>
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
			<input type="hidden" name="sale_type" id="sale_type" value="<%=saleType%>" />
			<input type="hidden" name="sale_price" id="sale_price" value="<%=salePrice%>" />
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
					<font style="font-weight:bold; color:blue;"><%=saleTitle%></font>
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
						<p class="marb40">
          <!--p><img src="/images/detail_sample.jpg" width="999" height="472"></p-->
						<%=groupInfo%>
						</p>
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
						<%=offerNotice%>
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
	$.post("balanceShake_ajax.jsp", $("#frm_order").serialize(),
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
			salePrice	= totalPrice - salePrice * buyQty;
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