<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
	<!-- header -->
	<div id="header">
		<h1>Pulmuone EATSSLIM 包府磊矫胶袍</h1>
		<!-- gnb -->
		<ul id="gnb" class="group">
			<li id="mNavi01"><a href="../main/index.jsp"><img src="../images/common/menu/mNavi01.png" alt="权" /></a></li>
			<%if(eslAdminMenu.indexOf("1")>=0){%><li id="mNavi02"><a href="../member/member_list.jsp"><img src="../images/common/menu/mNavi02.png" alt="雀盔包府" /></a></li><%}%>
			<%if(eslAdminMenu.indexOf("2")>=0){%><li id="mNavi03"><a href="../goods/goods_list.jsp"><img src="../images/common/menu/mNavi03.png" alt="惑前包府" /></a></li><%}%>
			<%if(eslAdminMenu.indexOf("3")>=0){%><li id="mNavi04"><a href="../order/order_list.jsp"><img src="../images/common/menu/mNavi04.png" alt="林巩包府" /></a></li><%}%>
			<%if(eslAdminMenu.indexOf("4")>=0){%><li id="mNavi05"><a href="../board/notice_list.jsp"><img src="../images/common/menu/mNavi05.png" alt="霸矫魄包府" /></a></li><%}%>
			<%if(eslAdminMenu.indexOf("5")>=0){%><li id="mNavi06"><a href="../counsel/counsel_list.jsp"><img src="../images/common/menu/mNavi06.png" alt="惑淬/巩狼包府" /></a></li><%}%>
			<%if(eslAdminMenu.indexOf("6")>=0){%><li id="mNavi07"><a href="../promotion/coupon_list.jsp"><img src="../images/common/menu/mNavi07.png" alt="橇肺葛记包府" /></a></li><%}%>
			<%if(eslAdminMenu.indexOf("7")>=0){%><li id="mNavi10"><a href="../option/admin_list.jsp"><img src="../images/common/menu/mNavi10.png" alt="汲沥" /></a></li><%}%>
			<!--
			<%if(eslAdminMenu.indexOf("8")>=0){%><li id="mNavi09"><a href="../statistic/product_statistic.jsp"><img src="../images/common/menu/mNavi09.png" alt="烹拌包府" /></a></li><%}%>
			-->
		</ul>
		<!-- //gnb -->
	</div>
	<!-- //header -->
<iframe name="ifrmHidden" id="ifrmHidden" src="about:blank" style="width:100%;height:200px;display:none"></iframe>