<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%-- <%@ include file="/mobile/common/include/inc-login-check.jsp"%> --%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_ORDER";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
String minDate		= "";
String maxDate		= "";
String devlDates	= "";
stmt1				= conn.createStatement();
String stdate		= ut.inject(request.getParameter("stdate"));
stdate = stdate.replaceAll("<","&lt;");
stdate = stdate.replaceAll(">","&gt;");
String ltdate		= ut.inject(request.getParameter("ltdate"));
ltdate = ltdate.replaceAll("<","&lt;");
ltdate = ltdate.replaceAll(">","&gt;");
String stateType	= ut.inject(request.getParameter("state_type"));
stateType = stateType.replaceAll("<","&lt;");
stateType = stateType.replaceAll(">","&gt;");
String where		= "";
String param		= "";
String orderNum		= "";
String orderDate	= "";
/* int payPrice		= 0; */
String payType		= "";
String orderState	= "";
int cnt				= 0;
String goodsList	= "";
int listSize		= 0;
String gId			= "";
String groupCode	= "";
String menuF		= ut.inject(request.getParameter("menuF"));
menuF = menuF.replaceAll("<","&lt;");
menuF = menuF.replaceAll(">","&gt;");
String menuS		= ut.inject(request.getParameter("menuS"));
menuS = menuS.replaceAll("<","&lt;");
menuS = menuS.replaceAll(">","&gt;");
String eatCoun      = ut.inject(request.getParameter("eatCoun"));
eatCoun = eatCoun.replaceAll("<","&lt;");
eatCoun = eatCoun.replaceAll(">","&gt;");
String tg			= ut.inject(request.getParameter("tg"));
tg = tg.replaceAll("<","&lt;");
tg = tg.replaceAll(">","&gt;");
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
NumberFormat nf		= NumberFormat.getNumberInstance();
Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
/* cal.add ( Calendar.MONTH, -1 ); */ //1개월전
cal.add ( Calendar.MONTH, -5 ); //10개월전
String preMonth3=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
where			= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND ORDER_STATE > 0 AND ORDER_STATE < 90";
where			+= " AND DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') BETWEEN '"+ preMonth3 +"' AND '"+ cDate +"'";
query		= "SELECT COUNT(*)";
query		+= " FROM "+ table + where; //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	cnt		= rs.getInt(1);
}
rs.close();

query		= "SELECT ORDER_NUM, DATE_FORMAT(ORDER_DATE, '%Y.%m.%d') ORDER_DATE, ORDER_NAME, PAY_TYPE, PAY_PRICE,";
query		+= "	ORDER_STATE, ORDER_ENV";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ORDER_NUM DESC"; //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}



///////////////////////////
%>
<div id="wrap" class="expansioncss">
	<%@ include file="/mobile/common/include/inc-header.jsp"%>
	<!-- End header -->
	<div id="container">
		<section id="shop_content">
			<div class="shop_visual">
				<%
				if(menuF.equals("1")){
					%>
					<img src="/mobile/common/images/common/shop_visual1.jpg" alt="">
					<div class="slogan">
						<p>칼로리 조절을 위한 과학적 식단</p>
						<h2>칼로리 조절식</h2>
					</div>
					<div class="path">
						HOME<span></span>SHOP<span></span><strong>칼로리 조절식</strong><!-- <i>1</i> -->
					</div>
					<%
				}else if(menuF.equals("2")){
					%>
					<img src="/mobile/common/images/common/shop_visual2.jpg" alt="">
					<div class="slogan">
						<p>칼로리 조절을 위한 과학적 식단</p>
						<h2>칼로리 조절 프로그램</h2>
					</div>
					<div class="path">
						HOME<span></span>SHOP<span></span><strong>칼로리 조절 프로그램</strong><!--  <i>2</i> -->
					</div>
					<%
				}else if(menuF.equals("3")){
					%>
					<img src="/mobile/common/images/common/shop_visual3.jpg" alt="">
					<div class="slogan">
						<p>칼로리 조절을 위한 과학적 식단</p>
						<h2>건강식</h2>
					</div>
					<div class="path">
						HOME<span></span> SHOP<span></span><strong>건강식</strong><!--  <i>3</i> -->
					</div>
					<%
				}else if(menuF.equals("4")){
					%>
					<img src="/mobile/common/images/common/shop_visual4.jpg" alt="">
					<div class="slogan">
						<p>칼로리 조절을 위한 과학적 식단</p>
						<h2>기능식</h2>
					</div>
					<div class="path">
						HOME<span></span>SHOP<span></span><strong>기능식</strong><!--  <i>4</i> -->
					</div>
					<%
				}
				else if(!"".equals(tg)){
					// 05:추천,06:베스트
					if("05".equals(tg) ){
						%>
						<img src="/mobile/common/images/common/shop_visual6.jpg" alt="">
						<div class="slogan">
							<p>칼로리 조절을 위한 과학적 식단</p>
							<h2>추천상품</h2>
						</div>
						<div class="path">
							HOME<span></span><strong >추천상품</strong>
						</div>
						<%
					}
					else if("06".equals(tg) ){
						%>
						<img src="/mobile/common/images/common/shop_visual5.jpg" alt="">
						<div class="slogan">
							<p>칼로리 조절을 위한 과학적 식단</p>
							<h2>베스트상품</h2>
						</div>
						<div class="path">
							HOME<span></span><strong>베스트상품</strong>
						</div>
						<%
					}
				}
				%>
			</div>
			<% if("".equals(tg)){ %>
			<div class="goods_select lt_1depth clearfix">
				<div class="goods_filter">
				<span>구분</span>
					<select name="menuSel" id="menuSel" class="inp_st">
				<%
					if(menuF.equals("1")){
						%>
						<option <%if(menuS.equals("6")) out.println(" selected=\"selected\""); %> value="16">테이스티 세트</option>
						<option <%if(menuS.equals("1")) out.println(" selected=\"selected\""); %> value="11">400 슬림식</option>
						<option <%if(menuS.equals("2")) out.println(" selected=\"selected\""); %> value="12">300 샐러드</option>
						<option <%if(menuS.equals("3")) out.println(" selected=\"selected\""); %> value="13">300 덮밥</option>
						<option <%if(menuS.equals("5")) out.println(" selected=\"selected\""); %> value="15">200 스팀샐러드</option>
						<option <%if(menuS.equals("4")) out.println(" selected=\"selected\""); %> value="14">미니밀</option>
						<%
					}else if(menuF.equals("2")){
						%>
						<option <%if(menuS.equals("1")) out.println(" selected=\"selected\""); %> value="21">퍼스널 코칭 프로그램</option>
						<option <%if(menuS.equals("2")) out.println(" selected=\"selected\""); %> value="22">칼로리 조절 프로그램</option>
						<option <%if(menuS.equals("3")) out.println(" selected=\"selected\""); %> value="23">클렌즈프로그램</option>
						<!--option <%if(menuS.equals("4")) out.println(" selected=\"selected\""); %> value="24">스마트그램</option-->
						<%
					}else if(menuF.equals("3")){
						%>
						<option <%if(menuS.equals("1")) out.println(" selected=\"selected\""); %> value="31">500 차림</option>
						<%
					}else if(menuF.equals("4")){
						%>
						<option <%if(menuS.equals("4")) out.println(" selected=\"selected\""); %> value="44">150 프로틴밀</option>
						<option <%if(menuS.equals("1")) out.println(" selected=\"selected\""); %> value="41">밸런스쉐이크</option>
						<option <%if(menuS.equals("2")) out.println(" selected=\"selected\""); %> value="42">다이어트 기능식품</option>
						<option <%if(menuS.equals("3")) out.println(" selected=\"selected\""); %> value="43">건강즙</option>
						<%
					}
				%>

					</select>
				</div>
				<%
					if(menuF.equals("1")){
						if(menuS.equals("4") || menuS.equals("6")){
							%>
							<!-- <option value="1">식수 없음</option> -->
							<%
						}else{
							%>
							<div class="goods_sort n2">
								<span>식수</span>
								<select name="eatCoun" id="eatCoun" class="inp_st">
									<option <%if(eatCoun.equals("")) out.println(" selected=\"selected\""); %> value="">전체</option>
									<option <%if(eatCoun.equals("1")) out.println(" selected=\"selected\""); %> value="1">1식</option>
									<option <%if(eatCoun.equals("2")) out.println(" selected=\"selected\""); %> value="2">2식</option>
									<option <%if(eatCoun.equals("3")) out.println(" selected=\"selected\""); %> value="3">3식</option>
									<option <%if(eatCoun.equals("6")) out.println(" selected=\"selected\""); %> value="6">1식 + 간편식</option>
								</select>
							</div>
							<%
						}
					}else if(menuF.equals("2") || menuF.equals("4")){
						%>
						<!-- <option value="1">식수 없음</option> -->
						<%
					}else if(menuF.equals("3")){
						%>
						<div class="goods_sort n2">
							<span>식수</span>
							<select name="eatCoun" id="eatCoun" class="inp_st">
								<option <%if(eatCoun.equals("")) out.println(" selected=\"selected\""); %> value="">전체</option>
								<option <%if(eatCoun.equals("1")) out.println(" selected=\"selected\""); %> value="1">1식</option>
								<option <%if(eatCoun.equals("2")) out.println(" selected=\"selected\""); %> value="2">2식</option>
							</select>
						</div>
						<%
					}
				%>
			</div>
			<!-- <div class="goods_select gt_1depth clearfix">
				<div class="goods_return"><a href="javascript:void(0);">다이어트식으로 돌아가기</a></div>
			</div> -->
			<% } %>
			<div class="goods_list">
				<ul class="lazy lazy-loaded">
				</ul>
			</div>
			<div class="loading-spinner ff_noto">
				<p><img src="/dist/images/common/loading-spinner.png" alt=""><span>loading now</span></p>
			</div>
		</section>
	</div>
	<!-- End container -->

		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	<!-- End footer -->
</div>
</body>
<script>
        $( document ).ready(function() {
		 	var url = "__ajax_orderlist_items.jsp?menuF=<%=menuF%>&menuS=<%=menuS%>&eatCoun=<%=eatCoun%>&tg=<%=tg%>";

       	 	$.ajax({
				type : "POST",
				url : url,
				success : function(args){
					$('.loading-spinner').css('display', 'none');
					$(".goods_list ul").append(args);

				},
				beforeSend: function(){
					$('.loading-spinner').css('display', 'block');

				},
				error: function(a,b,c){
					console.log(a,b,c);
				},
				complete : function(){
					console.log("complete");

						$(".goods_list li img").lazyload({
							effect : "fadeIn"
		          	});
				}
			});
       	 	//메뉴 selectBox
       	 	$("#menuSel").change(function(){
       	 		var menuSel = $('#menuSel option:selected').val();
       	 		menuF = menuSel.substring(0,1);
       	 		menuS = menuSel.substring(1,2);
       	 		var url = "__ajax_orderlist_items.jsp?menuF="+menuF+"&menuS="+menuS+"&eatCoun=<%=eatCoun%>";

       	 		$.ajax({
   					type : "POST",
   					url : url,
   					success : function(args){
   						$('.loading-spinner').css('display', 'none');
   						$(".goods_list ul").append(args);
   						location.href = "/mobile/shop/order_list.jsp?menuF="+menuF+"&menuS="+menuS+"&eatCoun=<%=eatCoun%>";

   					},
   					beforeSend: function(){
   						$('.loading-spinner').css('display', 'block');

   					},
   					error: function(a,b,c){
   						console.log(a,b,c);
   					},
   					complete : function(){
   						console.log("complete");

    						$(".goods_list li img").lazyload({
    							effect : "fadeIn"
   			          	});
   					}
   				});

       	 	});
       	 	//식수 selectBox
       	 	$("#eatCoun").change(function(){
       	 		var eatCoun = $('#eatCoun option:selected').val();

       	 		var url = "__ajax_orderlist_items.jsp?menuF=<%=menuF%>&menuS=<%=menuS%>&eatCoun="+eatCoun+"";

       	 		$.ajax({
   					type : "POST",
   					url : url,
   					success : function(args){
   						$('.loading-spinner').css('display', 'none');
   						$(".goods_list ul").append(args);
   						location.href = "/mobile/shop/order_list.jsp?menuF=<%=menuF%>&menuS=<%=menuS%>&eatCoun="+eatCoun+"";

   					},
   					beforeSend: function(){
   						$('.loading-spinner').css('display', 'block');

   					},
   					error: function(a,b,c){
   						console.log(a,b,c);
   					},
   					complete : function(){
   						console.log("complete");

    						$(".goods_list li img").lazyload({
    							effect : "fadeIn"
   			          	});
   					}
   				});

       	 	});

       	});

</script>
</html>