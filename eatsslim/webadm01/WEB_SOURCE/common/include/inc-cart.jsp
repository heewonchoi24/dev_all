<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%
int ftCartTotalPrice		= 0; //-- ��ǰ��ü �հ�
int ftDevlPrice				= 0; //-- ��ۺ�
int ftCartTotalAmount		= 0; //-- �����ݾ�
int ftCartCt				= 0; //-- ��ٱ��ϰ���

String ftQuery				= "";
PreparedStatement ftPstmt	= null;
ResultSet ftRs				= null;
if (!eslMemberId.equals("")) {
	
	//-- ��ٱ���
	ftQuery		= "SELECT COUNT(ID) AS CT,IFNULL(SUM(PRICE),0) AS TOTAL_PRICE FROM ESL_CART WHERE CART_TYPE = 'C' AND MEMBER_ID = ? ";
	ftPstmt		= conn.prepareStatement(ftQuery);
	ftPstmt.setString(1, eslMemberId);
	ftRs		= ftPstmt.executeQuery();
	if(ftRs.next()){
		ftCartCt = ftRs.getInt("CT");
		ftCartTotalPrice = ftRs.getInt("TOTAL_PRICE");
	}
	if (ftRs != null) try { ftRs.close(); } catch (Exception e) {}
	if (ftPstmt != null) try { ftPstmt.close(); } catch (Exception e) {}
	
	//-- ��ٱ��� �� �ݾ�
	if(ftCartCt > 0 && ftCartTotalPrice < 40000){
		ftDevlPrice = defaultDevlPrice;
	}
	ftCartTotalAmount = ftCartTotalPrice + ftDevlPrice;
}
%>

<% if ( !"".equals(eslMemberId) && ftCartCt > 0 ) { %>
<div id="floating_cart" class="ff_noto">
	<div class="header">
		<div class="center_inner">
			<div class="notice_area">
				<dl class="goods_count">
					<dt><img src="/dist/images/common/ico_fc.png" alt=""></dt>
					<dd><span id="ft_cartCount"><%=ut.getComma(ftCartCt)%></span> ��</dd>
				</dl>
				<dl class="pay_count">
					<dt>�� ��ǰ �ݾ�</dt>
					<dd><span class="ft_cartPrice"><%=ut.getComma(ftCartTotalPrice)%></span> ��</dd>
				</dl>
			</div>
			<div class="button_area">
				<div class="button_area_inner">
					<!-- <button type="button" class="showOrder">�ֹ��ϱ�</button> -->
					<button type="button" class="showOrder" onclick="location.href='/shop/cart.jsp';">�ֹ��ϱ�</button>
					<button type="button" class="btn_pack large transp showCart" onclick="cartFn.onFold('on');">��ٱ��� ����</button>
				</div>
			</div>
		</div>
	</div>
	<div class="section">
		<div class="fc_outer">
			<div class="fc_item_tray">
<%
if(ftCartCt > 0){
	ftQuery		= "SELECT C.ID, C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK,";
	ftQuery		+= "	DATE_FORMAT(C.DEVL_DATE, '%Y-%m-%d') WDATE, C.PRICE, C.BUY_BAG_YN,";
	ftQuery		+= "	G.GUBUN1, G.GROUP_NAME, G.CART_IMG, G.GROUP_IMGM";
	ftQuery		+= " FROM ESL_CART C, ESL_GOODS_GROUP G";
	ftQuery		+= " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = ? AND CART_TYPE = 'C'";
	ftQuery		+= " ORDER BY C.ID DESC";
	ftPstmt		= conn.prepareStatement(ftQuery);
	ftPstmt.setString(1, eslMemberId);
	ftRs		= ftPstmt.executeQuery();
	while(ftRs.next()){
		String ftCartId = ut.isnull(ftRs.getString("ID") );
		String ftGroupId = ut.isnull(ftRs.getString("GROUP_ID") );
		String ftBuyQty = ut.isnull(ftRs.getString("BUY_QTY") );
		String ftDevlType = ut.isnull(ftRs.getString("DEVL_TYPE") );
		String ftDevlDay = ut.isnull(ftRs.getString("DEVL_DAY") );
		String ftDevlWeek = ut.isnull(ftRs.getString("DEVL_WEEK") );
		String ftCartWdate = ut.isnull(ftRs.getString("WDATE") );
		String ftPrice = ut.isnull(ftRs.getString("PRICE") );
		String ftBuyBagYN = ut.isnull(ftRs.getString("BUY_BAG_YN") );
		String ftGubun1 = ut.isnull(ftRs.getString("GUBUN1") );
		String ftGroupName = ut.isnull(ftRs.getString("GROUP_NAME") );
		String ftGroupImg = ut.isnull(ftRs.getString("GROUP_IMGM") );
		if("".equals(ftGroupImg)){
			ftGroupImg = "/images/order_sample.jpg";
		}
		else{
			ftGroupImg = webUploadDir +"goods/"+ ftGroupImg;
		}
%>
				<div class="bx_item">
					<div class="goods_image">
						<img src="<%=ftGroupImg%>" alt="">
					</div>
					<div class="goods_desc">
						<div class="goods_title"><%=ftGroupName%></div>
						<div class="goods_caption">
<%
		if(!"02".equals(ftGubun1) && !"0".equals(ftDevlDay) && !"0".equals(ftDevlWeek) ){
			if("5".equals(ftDevlDay) ) out.print("��~�� / ");
			else if("3".equals(ftDevlDay) ) out.print("��/��/�� / ");
			
			out.print(ftDevlWeek + "���Ϻ�");
		}
%>
						</div>
						<div class="goods_foot">
							<div class="goods_price"><%=ut.getComma(ftPrice) %> ��</div>
							<a href="/shop/popup/__ajax_goods_set_options_select.jsp?lightbox[width]=500&lightbox[height]=530&cartId=<%=ftCartId%>&paramType=list" class="lightbox goods_options">�ɼǺ���</a>
						</div>
					</div>
					<button type="button" class="goods_del" onclick="ftCartChkDel(<%=ftCartId%>, 'G');"></button>
				</div>
<%
	}
	if (ftRs != null) try { ftRs.close(); } catch (Exception e) {}
	if (ftPstmt != null) try { ftPstmt.close(); } catch (Exception e) {}

}
%>				
			</div>
			<div class="fc_total">
				<div class="fc_total_top">
					<dl>
						<dt>�� ��ǰ �ݾ�</dt>
						<dd><span class="ft_cartPrice"><%=ut.getComma(ftCartTotalPrice)%></span>��</dd>
					</dl>
					<dl>
						<dt>��ۺ�</dt>
						<dd class="ft_devlPrice"><%=ut.getComma(ftDevlPrice)%>��</dd>
					</dl>
				</div>
				<div class="fc_total_bottom">
					<dl>
						<dt>���� ���������ݾ�</dt>
						<dd><span id="ft_cartTotalAmount"><%=ut.getComma(ftCartTotalAmount)%></span>��</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

$(window).load(function(){
	//$("#floating_cart .fc_item_tray .fc_inner").css({"width":<%=ftCartCt < 1 ? 1 : ftCartCt%> * 186});
});

$(function () {
	$("#floating_cart .fc_item_tray").slick({
		infinite: false,
		slidesToShow: 4,
		slidesToScroll: 4,
		prevArrow : '<button type="button" class="slick-prev"><img src="/dist/images/ico/ico_slider_left.png" alt=""></button>',
        nextArrow : '<button type="button" class="slick-next"><img src="/dist/images/ico/ico_slider_right.png" alt=""></button>'
	});
});

function ftCartChkDel(obj1, obj2) {
	if(!confirm("�����Ͻðڽ��ϱ�?")) return;
	$.post("/mobile/common/include/inc_cart_ajax.jsp", {
		mode: 'del',
		cartId: obj1,
		bag_yn: obj2
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				document.location.reload();
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function chkOrder(obj) {

	var cFrame = $("#cart");
	var itemLength = cFrame.find(".bx_item").length;

	if (itemLength < 1) {
		var msg		= '��ٱ��ϰ� ����ֽ��ϴ�.';
		alert(msg);
	} else {
		$("#mode").val("cartAll");
		$.post("/mobile/common/include/inc_cart_ajax.jsp", $("#frm_order").serialize(),
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					location.href = "/mobile/shop/order.jsp?mode=C";
				} else {
					alert("error");
					$(data).find("error").each(function() {
						$(data).find("error").each(function() {
							alert($(this).text());
						});
					});
				}
			});
		}, "xml");
	}
}
</script>
<% } %>