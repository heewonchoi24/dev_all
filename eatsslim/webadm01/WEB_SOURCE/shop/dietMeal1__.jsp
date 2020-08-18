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

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");

	totalPrice		= (price * 10) + defaultBagPrice;
}

rs.close();
pstmt.close();
%>

	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.ext.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>�Ļ� ���̾�Ʈ</h1>
			<div class="pageDepth">
				HOME &gt; SHOP &gt; <strong>�Ļ� ���̾�Ʈ</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="eleven columns offset-by-one ">
			<div class="row">
				<h3 class="marb20">�ս��� �Ļ� ���̾�Ʈ �Ѵ��� ����</h3>
				<div class="twothird last col">
					<div class="quizindiet">
						<ul class="quizintab">
							<li class="quizinA current">
								<a href="javascript:;" onClick="cngMenu(2);"></a>
							</li>
							<li class="quizinB">
								<a href="javascript:;" onClick="cngMenu(1);"></a>
							</li>
							<li class="alaCool">
								<a href="javascript:;" onClick="cngMenu(3);"></a>
							</li>
						</ul>
						<div class="quizinlist">
							<div class="share floatright">
								<ul>
									<li>
										<a class="facebook" href="http://www.facebook.com/share.php?u=http://www.eatsslim.com/shop/dietMeal.jsp" target="_blank"></a>
									</li>
									<li>
										<a class="twitter" href="http://twitter.com/share?url=http://www.eatsslim.com/shop/dietMeal.jsp&text=eatsslim diet" target="_blank"></a>
									</li>
									<li>
										<a class="me2day" href="http://me2day.net/posts/new?new_post[body]=http://www.eatsslim.com/shop/dietMeal.jsp" target="_blank"></a>
									</li>
								</ul>
							</div>
							<div class="clear"></div>
							<h1 class="row center">
								<img src="/images/headcopy_01.png" alt="������, ����Ʈ������ �����ε� ���ִ� ���̾�Ʈ!" id="titleImg" />
							</h1>
							<div class="center">
								<p class="marb20">
									<img src="/images/quizinA_subject.png" alt="����A" id="topImg1" />
								</p>
								<p>
									<img src="/images/quizinA_feature.png" alt="����A Ư¡" id="topImg2" />
								</p>
							</div>
							<!-- ���� ����Ʈ -->
							<div class="foodlist">
								<%
								int setId			= 0;
								String thumbImg		= "";
								String imgUrl		= "";
								String setName		= "";
								String calorie		= "";

								query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 2 ORDER BY GS.ID";
								pstmt		= conn.prepareStatement(query);
								rs			= pstmt.executeQuery();

								int i			= 0;
								int divNum		= 0;
								String divClass	= "";
								while (rs.next()) {
									setId		= rs.getInt("ID");
									thumbImg	= rs.getString("THUMB_IMG");
									if (thumbImg.equals("") || thumbImg == null) {
										imgUrl		= "/images/quizin_sample.jpg";
									} else {										
										imgUrl		= webUploadDir +"goods/"+ thumbImg;
									}
									setName		= rs.getString("SET_NAME");
									calorie		= (rs.getString("CALORIE").equals(""))? "" : rs.getString("CALORIE") + "kcal";

									divNum		= i % 4;
									if (divNum == 0) {
										divClass	= " first";
									} else if (divNum == 3) {
										divClass	= " last";
									} else {
										divClass	= "";
									}
								%>
								<div class="food<%=divClass%>">
									<div>
										<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" /></a> 
										<a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>">
											<div class="food-calorie"><%=calorie%></div>
											<div class="food-title"><%=setName%></div>
										</a>
									</div>
								</div>
								<%
									i++;
								}
								%>
								<div class="clear"></div>
							</div>
							<!-- End ���� ����Ʈ -->
						</div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<!-- End eleven columns offset-by-one -->
		<form name="frm_order" id="frm_order" method="post">
			<input type="hidden" name="mode" value="addCart" />
			<input type="hidden" name="cart_type" id="cart_type" />
			<input type="hidden" name="group_id" id="group_id" value="<%=groupId%>" />
			<input type="hidden" name="gubun2" id="gubun2" />
			<input type="hidden" name="price" id="price" value="<%=price%>" />
			<div class="sidebar five columns">
				<h3 class="marb20">�ֹ��ϱ�</h3>
				<div class="sideorder">
					<div class="title">������ǰ ����</div>
					<div class="itembox">
						<ul class="badgecount">
							<li>
								<span class="badge">1</span>
								<p>��۰������� �˻�<br /><font style="font-weight:normal; color:#777;">����� ������ �������� Ȯ��</font></p>
								<div class="button small dark"> <a class="lightbox" href="/shop/popup/deliverypossi.jsp?lightbox[width]=600&lightbox[height]=600">�˻�</a></div>
							</li>
							<li>
								<span class="badge">2</span>
								<p>1�� ��޽ļ��� ����</p>
								<div class="ordernum">
									<span class="active"><a class="ordernum-one" href="javascript:;" onClick="getGroup(0);"></a>1��1��</span>
									<span><a class="ordernum-two" href="javascript:;" onClick="getGroup(1);"></a>1��2��</span>
									<span class="last"><a class="ordernum-three" href="javascript:;" onClick="getGroup(2);"></a>1��3��</span>
									<div class="clear"></div>
									<span><a class="ordernum-four" href="javascript:;" onClick="getGroup(3);"></a>2��+����</span>
									<span class="last"><a class="ordernum-five" href="javascript:;" onClick="getGroup(4);"></a>3��+����</span>
									<!--span class="last"><a class="ordernum-five" href="/shop/popup/deliveryDate.jsp?lightbox[width]=880&lightbox[height]=600"></a>3��+����</span-->
									<div class="clear"></div>
								</div>
							</li>
							<li>
								<span class="badge">3</span>
								<p>���ϳ��ϼ��� �Ļ罺Ÿ���� ����</p>
								<div id="groupSelect">
									<select name="group_code" id="group_code" onChange="selGroup();" style="width:235px;">
										<%
										query		= "SELECT ID, GROUP_NAME FROM  "+ table + where + sort;
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											groupId			= rs.getInt("ID");
											groupName		= rs.getString("GROUP_NAME");
										%>
										<option value="<%=groupId%>"><%=groupName%></option>
										<%
										}
										%>
									</select>
								</div>
							</li>
							<li>
								<span class="badge">4</span>
								<p>�Ļ� �Ⱓ�� ����</p>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="110">
											<select name="devl_day" id="devl_day" style="width:100px;">
												<option value="5" selected="selected">5��</option>
												<option value="6">6��</option>
											</select>
										</td>
										<td></td>
										<td width="110">
											<select name="devl_week" id="devl_week" style="width:100px;">
												<option value="2" selected="selected">2��</option>
												<option value="4">4��</option>
											</select>
										</td>
									</tr>
								</table>
							</li>
							<li>
								<span class="badge">5</span>
								<p class="floatleft">ù ����� ����</p>
								<div class="floatright" style="width:140px;">
									<input id="devl_date" class="dp-applied date-pick" name="devl_date" readonly />
								</div>	
								<div class="clear"></div>
							</li>
							<li>
								<span class="badge">6</span>
								<p class="floatleft">����</p>
								<div class="quantity floatright" style="width:140px;">
									<input class="minus" type="button" value="-" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly />
									<input class="plus" type="button" value="+" />
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</div>
				</div>
				<div class="divider"></div>
				<div class="addoption">
					<div class="title">���ð��� ����</div>
					<div class="itembox">
						<ul class="badgecount">
							<li>
								<span class="badge add">1</span>
								<p>
									<input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" /> ���ð��� ���� (<%=nf.format(defaultBagPrice)%>��)<br />
									<font style="font-weight:normal; color:#777;">���ð����� �ʼ��� �����ϼž� ��ǰ�� �ż��ϰ� ����� �� �ֽ��ϴ�.</font>
								</p>
							</li>
						</ul>
					</div>
				</div>
				<div class="divider"></div> 
				<div class="price-wrapper">
					<p class="price">
						�Ѱ���:
						<!--del>
							<span class="amount"><%=nf.format(totalPrice)%>��</span>
						</del-->
						<ins>
							<span class="amount" id="tprice"><%=nf.format(totalPrice)%>��</span>
						</ins>
					</p>
					<%if (eslMemberId.equals("")) {%>
					<div class="button large light"><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">��ٱ���</a></div>
					<div class="button large dark iconBtn"><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350"><span class="star"></span>�ٷα���</a></div>
					<%} else {%>
					<div class="button large light"><a href="javascript:;" onClick="addCart('C');">��ٱ���</a></div>
					<div class="button large dark iconBtn"><a href="javascript:;" onClick="addCart('L');"><span class="star"></span>�ٷα���</a></div>
					<%}%>
					<div class="clear"></div>
				</div>  
			</div>
		</form>
		<!-- End sidebar four columns -->
		<div class="clear"></div>
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
						<img src="/images/dietmeal_detail.jpg" usemap="#Map" border="0">
                        <map name="Map">
                          <area shape="circle" coords="473,2039,130" href="#" onClick="window.open('/intro/foodmonthplan.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=1013,height=600')">
                        </map>
					<div id="detail-item">
						<!--p class="marb40"><img src="/images/detail_tit.gif" alt="������" width="296" height="65" /></p>
						<p><img src="/images/detail_sample.jpg" width="999" height="472"></p-->
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
						<p><img src="/images/dietmeal_detail_02.jpg"></p>
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
						<div class="clear"></div>
					</ul>
                  <div id="detail-delivery">
						<p><img src="/images/dietMeal_detail_03.jpg"></p>
				  </div>
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
	$(".date-pick").datepick({ 
		dateFormat: "yyyy.mm.dd",
		minDate: +6,
		onDate: $.datepick.noSundays,
		showTrigger: '#calImg'
	});

	$("a").attr("onfocus", "this.blur()");

	$("#devl_day, #devl_week").change(function() {
		totalPrice	= getTprice();
		$("#tprice").text(commaSplit(totalPrice)+ "��");
	});
	$(".plus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? 7000 * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
		$("#buy_qty").val(buyQty);
		$("#tprice").text(commaSplit(totalPrice)+ "��");
	});
	$(".minus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? 7000 * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
		$("#tprice").text(commaSplit(totalPrice)+ "��");
		$("#buy_qty").val(buyQty);
	});
	$("#buy_bag").click(function() {
		totalPrice	= getTprice();
		$("#tprice").text(commaSplit(totalPrice)+ "��");
	});
});

function cngMenu(num) {
	

	$.post("dietMeal_ajax1.jsp", {
		mode: 'cngMenu',
		cate_id: num
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var menuArr		= "";
				var menuHtml	= "";
				var i			= 0;
				var divNum		= 0;
				var divClass	= "";

				$(data).find("menu").each(function() {
					divNum		= i % 4;
					if (divNum == 0) {
						divClass	= " first";
					} else if (divNum == 3) {
						divClass	= " last";
					} else {
						divClass	= "";
					}

					menuArr			= $(this).text().split("|");
					menuHtml		+= '<div class="food'+ divClass +'">';
					menuHtml		+= '<div>';
					menuHtml		+= '<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id='+ menuArr[0] +'" title="'+ menuArr[2] +'"><img src="'+ menuArr[1] +'" alt="'+ menuArr[2] +'" /></a> ';
					menuHtml		+= '<a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id='+ menuArr[0] +'">';
					menuHtml		+= '<div class="food-calorie">'+ menuArr[3] +'</div>';
					menuHtml		+= '<div class="food-title">'+ menuArr[2] +'</div>';
					menuHtml		+= '</a>';
					menuHtml		+= '</div>';
					menuHtml		+= '</div>';

					$(".quizintab li").removeClass("current");
					$("#titleImg").attr("src", "/images/"+ menuArr[5] +".png");
					$("#topImg1").attr("src", "/images/"+ menuArr[6] +".png");
					$("#topImg2").attr("src", "/images/"+ menuArr[7] +".png");
					$("."+ menuArr[4]).addClass("current");
					if (num == 3) {
						$(".quizinA").css("z-index", "1");
					} else if (num == 2) {
						$(".quizinA").css("z-index", "10");
					}
					i++;
				});

				$(".foodlist").html(menuHtml);
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

function getTprice() {
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? 7000 * buyQty : 0;
	var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);

	return totalPrice;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("dietMeal_ajax.jsp", $("#frm_order").serialize(),
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

function getGroup(num) {
	$(".ordernum span").removeClass("active");
	$(".ordernum span:eq("+ num +")").addClass("active");

	$.post("dietMeal_ajax.jsp", {
		mode: 'getGroup',
		gubun2: num + 1
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				var groupOptions	= '<select name="group_code" id="group_code" class="formsel" onchange="selGroup();" style="width:235px;">';
				var i				= 0;
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					groupOptions	+= '<option value="'+ groupArr[0] +'">'+ groupArr[1] +"</option>\n";
					if (i == 0) {
						$("#group_id").val(groupArr[0]);
						$("#price").val(groupArr[2]);
						$("#detail-item").html(groupArr[3]);
						$("#detail-notify").html(groupArr[4]);
						totalPrice	= getTprice();
						$("#tprice").text(commaSplit(totalPrice)+ "��");
					}
					i++;
				});
				groupOptions	+= "</select>"
				$("#groupSelect").html(groupOptions);
				$("#group_code").selectBox();
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$(".ordernum span").removeClass("active");
						$("#group_id").val("");
						$("#price").val(0);
						totalPrice	= getTprice();
						$("#tprice").text(commaSplit(totalPrice)+ "��");
					});
				});
			}
		});
	}, "xml");
	return false;
}

function selGroup() {
	$.post("dietMeal_ajax.jsp", {
		mode: 'selGroup',
		group_id: $("#group_code").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					$("#group_id").val(groupArr[0]);
					$("#price").val(groupArr[1]);
					$("#detail-item").html(groupArr[2]);
					$("#detail-notify").html(groupArr[3]);
					totalPrice	= getTprice();
					$("#tprice").text(commaSplit(totalPrice)+ "��");
				});
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$("#group_id").val("");
					});
				});
			}
		});
	}, "xml");
	return false;
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>