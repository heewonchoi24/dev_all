<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String temp_no = (String)session.getAttribute("esl_customer_num");
if(temp_no!=null){
	if(temp_no.equals("1")){//통합회원 sso에서 약관동의 안한 사람은 회원세션소멸
		session.setAttribute("esl_member_idx","");
		session.setAttribute("esl_member_id",null);
		session.setAttribute("esl_member_name","");
		session.setAttribute("esl_customer_num","");
		session.setAttribute("esl_member_code",""); //통합회원 구분
		response.sendRedirect("https://www.eatsslim.co.kr/sso/logout.jsp");if(true)return;
	}
}

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

String query	= "";
int noticeId	= 0;
String topYn	= "";
String title	= "";
String bannerImg = "";
String clickLink = "";
String content	= "";
String listImg	= "";
int maxLength	= 0;
String imgUrl	= "";
String instDate = "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
%>

</head>
<body>
<div id="wrap" class="added ol">
	<div id="header">
	<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div id="container">
		<div class="container_inner">
			<section id="shop_content" class="contents">
				<div class="shop_visual ff_noto">
					<%
						if(menuF.equals("1")){
							%>
							<img src="/dist/images/common/sub_visual1.jpg" alt="" />
							<%
						}else if(menuF.equals("2")){
							%>
							<img src="/dist/images/common/sub_visual2.jpg" alt="" />
							<%
						}else if(menuF.equals("3")){
							%>
							<img src="/dist/images/common/sub_visual3.jpg" alt="" />
							<%
						}else if(menuF.equals("4")){
							%>
							<img src="/dist/images/common/sub_visual4.jpg" alt="" />
							<%
						}
						else if(!"".equals(tg)){
							// 05:추천,06:베스트
							if("05".equals(tg) ){
								out.println("<img src='/dist/images/common/sub_visual6.jpg' alt='' />");
							}
							else if("06".equals(tg) ){
								out.println("<img src='/dist/images/common/sub_visual5.jpg' alt='' />");
							}
						}

					%>
					<div class="shopc_inner">
						<div class="text_group">
							<div class="slogan">
								<div class="slogan_group">
								<%
									if(menuF.equals("1")){
										%>
										<h2>칼로리 조절식</h2>
										<p>샐러드, 덮밥, 정찬 형태 등 다양한 스타일과<br>다양한 메뉴로 구성된 맛있는 칼로리 조절식</p>
										<%
									}else if(menuF.equals("2")){
										%>
										<h2>칼로리 조절 프로그램</h2>
										<p>원하는 칼로리 목표에 따라 선택 가능한<br>체계적이고 과학적인 칼로리 조절 프로그램</p>
										<%
									}else if(menuF.equals("3")){
										%>
										<h2>건강식</h2>
										<p>나트륨, 칼로리 조절, Low GL을 적용한<br>건강 관리 식단</p>
										<%
									}else if(menuF.equals("4")){
										%>
										<h2>기능식</h2>
										<p>풀무원의 기능식 전문브랜드 풀비타,<br>풀무원이 만들어 믿을 수 있는 건강즙 등 풀무원의 다양한 기능식</p>
										<%
									}
									else if(!"".equals(tg)){
										// 05:추천,06:베스트
										if("05".equals(tg) ){
											out.println("<h2>추천상품</h2><p>건강하고 맛있는 잇슬림이<br>추천하는 상품을 소개합니다.</p>");
										}
										else if("06".equals(tg) ){
											out.println("<h2>베스트상품</h2><p>건강하고 맛있는 잇슬림의<br>가장 사랑받는 베스트 상품을 소개합니다.</p>");
										}
									}

								%>
								</div>
							</div>
							<div class="path">
								<strong>HOME</strong>
								&gt; <span>SHOP</span>
							<%
								if(menuF.equals("1")){
									%>
									&gt; <span>칼로리 조절식</span>
									<%
									if(menuS.equals("1")){
									%>
										&gt; <span>400 슬림식</span>
									<%
									}else if(menuS.equals("2")){
									%>
										&gt; <span>300 샐러드</span>
									<%
									}else if(menuS.equals("5")){
									%>
										&gt; <span>200 스팀샐러드</span>
									<%
									}else if(menuS.equals("3")){
									%>
										&gt; <span>300 덮밥</span>
									<%
									}else if(menuS.equals("4")){
									%>
										&gt; <span>미니밀</span>
									<%
									}else if(menuS.equals("6")){
									%>
										&gt; <span>테이스티 세트</span>
									<%
									}
								}else if(menuF.equals("2")){
									%>
									&gt; <span>칼로리 조절 프로그램</span>
									<%
									if(menuS.equals("1")){
									%>
										&gt; <span>퍼스널 코칭 프로그램</span>
									<%
									}else if(menuS.equals("2")){
									%>
										&gt; <span>칼로리 조절 프로그램</span>
									<%
									}else if(menuS.equals("3")){
									%>
										&gt; <span>클렌즈프로그램</span>
									<%
									}else if(menuS.equals("4")){
									%>
										&gt; <span>스마트그램</span>
									<%
									}
								}else if(menuF.equals("3")){
									%>
									&gt; <span>건강식</span>
									<%
									if(menuS.equals("1")){
									%>
										&gt; <span>500 차림</span>
									<%
									}
								}else if(menuF.equals("4")){
									%>
									&gt; <span>기능식</span>
									<%
									if(menuS.equals("1")){
									%>
										&gt; <span>밸런스쉐이크</span>
									<%
									}else if(menuS.equals("2")){
									%>
										&gt; <span>다이어트 기능식품</span>
									<%
									}else if(menuS.equals("3")){
									%>
										&gt; <span>건강즙</span>
									<%
									}else if(menuS.equals("4")){
									%>
										&gt; <span>150 프로틴밀</span>
									<%
									}
								}
								else if(!"".equals(tg)){
									// 05:추천,06:베스트
									if("05".equals(tg) ){
										out.println("&gt; <span>추천상품</span>");
									}
									else if("06".equals(tg) ){
										out.println("&gt; <span>베스트상품</span>");
									}
								}
							%>
							</div>
						</div>
					</div>
				</div>
				<div class="goods_list">
					<% if("".equals(tg)){ %>
					<div class="goods_filter">
						<form action="">
							<dl>
							<!--	<dt><img src="/dist/images/order/ico_goods_filter.png" alt="" /></dt> -->
								<dd>
									<!-- <div class="bx_select_filter bx_filter">
										<span onclick="$('.bx_filter').toggleClass('on');">제품라인별 보기</span>
										<ul>
										<%
											if(menuF.equals("1")){
												%>
												<li><button type="button" id="btn1" data-line-opts="quisine" onclick="btn(11);"><span>400 슬림식</span></button></li>
												<li><button type="button" id="btn2" data-line-opts="slim" onclick="btn(12);"><span>알라까르떼 슬림</span></button></li>
												<li><button type="button" id="btn3" data-line-opts="healthy" onclick="btn(13);"><span>알라까르떼 헬씨</span></button></li>
												<li><button type="button" id="btn4" data-line-opts="minimeal" onclick="btn(14);"><span>미니밀</span></button></li>
												<%
											}else if(menuF.equals("2")){
												%>
												<li><button type="button" id="btn1" data-line-opts="dangi" onclick="btn(21);"><span>단기프로그램</span></button></li>
												<li><button type="button" id="btn2" data-line-opts="gamlyang" onclick="btn(22);"><span>감량프로그램</span></button></li>
												<li><button type="button" id="btn3" data-line-opts="clringe" onclick="btn(23);"><span>클렌즈프로그램</span></button></li>
												<li><button type="button" id="btn4" data-line-opts="smart" onclick="btn(24);"><span>스마트그램</span></button></li>
												<%
											}else if(menuF.equals("3")){
												%>
												<li><button type="button" id="btn1" data-line-opts="healthy" onclick="btn(31);"><span>500 차림</span></button></li>
												<%
											}else if(menuF.equals("4")){
												%>
												<li><button type="button" id="btn1" data-line-opts="ganpyeonsig" onclick="btn(41);"><span>간편식</span></button></li>
												<li><button type="button" id="btn2" data-line-opts="gineung" onclick="btn(42);"><span>기능식품</span></button></li>
												<li><button type="button" id="btn3" data-line-opts="geongangjeub" onclick="btn(43);"><span>건강즙</span></button></li>
												<%
											}
										%>
										</ul>
									</div> -->
									<div class="bx_select_filter bx_select">
										<div class="selectWrap">
										<span>구분</span>
											<select name="prdLine" id="prdLine" class="notCustom">
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
									</div>
									<div class="bx_select_filter bx_select">
										<div class="selectWrap">
											<%
												if(menuF.equals("1")){
													if(menuS.equals("4") || menuS.equals("6")){
														%>

														<%
													}else{
														%>
														<span>식수</span>
														<select name="eatCoun" id="eatCoun" class="notCustom">
															<option <%if(eatCoun.equals("")) out.println(" selected=\"selected\""); %> value="">전체</option>
															<option <%if(eatCoun.equals("1")) out.println(" selected=\"selected\""); %> value="1">1식</option>
															<option <%if(eatCoun.equals("2")) out.println(" selected=\"selected\""); %> value="2">2식</option>
															<option <%if(eatCoun.equals("3")) out.println(" selected=\"selected\""); %> value="3">3식</option>
															<option <%if(eatCoun.equals("6")) out.println(" selected=\"selected\""); %> value="6">1식 + 간편식</option>
														</select>
														<%
													}
												}else if(menuF.equals("2") || menuF.equals("4")){
													%>

													<%
												}else if(menuF.equals("3")){
													%>
													<span>식수</span>
													<select name="eatCoun" id="eatCoun" class="notCustom">
														<option <%if(eatCoun.equals("")) out.println(" selected=\"selected\""); %> value="">전체</option>
														<option <%if(eatCoun.equals("1")) out.println(" selected=\"selected\""); %> value="1">1식</option>
														<option <%if(eatCoun.equals("2")) out.println(" selected=\"selected\""); %> value="2">2식</option>
													</select>
													<%
												}
											%>

										</div>
									</div>
								</dd>
							</dl>
							<!-- <dl>
								<dt><img src="/dist/images/ico/ico_return_menu.png" alt="" /></dt>
								<dd><div class="bx_select_filter bx_return"><a href="javascript:void(0);">칼로리 조절 식사으로 돌아가기</a></div></dd>
							</dl> -->
						</form>
					</div>
					<% } %>
					<div class="goods_inventory">
						<ul>

						</ul>
					</div>
				</div>
				<div class="loading-spinner ff_noto">
					<p><img src="/dist/images/common/loading-spinner.png" alt="" /><span>loading now</span></p>
				</div>
			</section>
		</div>
	</div>
	<!-- End container -->
	<%@ include file="/common/include/inc-cart.jsp"%>
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu" class="ol">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
</body>
<script>
       	$( document ).ready(function() {
       		var $elie = $(".loading-spinner img"), degree = 0, timer;
		 	var url = "__ajax_orderlist_items.jsp?menuF=<%=menuF%>&menuS=<%=menuS%>&eatCoun=<%=eatCoun%>&tg=<%=tg%>";
		 	function rotate() {
		        $elie.css({ WebkitTransform: 'rotate(' + degree + 'deg)'});
		        $elie.css({ '-moz-transform': 'rotate(' + degree + 'deg)'});
		        $elie.css('transform','rotate('+degree+'deg)');
		        timer = setTimeout(function() {
		            ++degree; rotate();
		        },5);
		    }

       	    rotate();

       	 	$.ajax({
				type : "POST",
				url : url,
				success : function(args){
					$(".goods_inventory ul").append(args);
					//clearTimeout(timer);
					$(".loading-spinner p").hide();


				},
				error: function(a,b,c){
					console.log(a,b,c);
				},
				complete : function(){
// 					console.log("complete");

// 						$(".goods_inventory li img").lazyload({
// 							effect : "fadeIn"
// 		          	});
				}
			});
       	 	//식수 selectBox
       	 	$("#eatCoun").change(function(){
       	 		var eatCoun = $('#eatCoun option:selected').val();

       	 		var url = "__ajax_orderlist_items.jsp?menuF=<%=menuF%>&menuS=<%=menuS%>&eatCoun="+eatCoun+"";

       	 		$.ajax({
   					type : "POST",
   					url : url,
   					success : function(args){
   						//$('.loading-spinner').css('display', 'none');
   						$(".goods_inventory ul").append(args);
   						$(".loading-spinner p").hide();
   						location.href = "/shop/order_list.jsp?menuF=<%=menuF%>&menuS=<%=menuS%>&eatCoun="+eatCoun+"";

   					},
   					beforeSend: function(){
   						//$('.loading-spinner').css('display', 'block');
   			       	    rotate();

   					},
   					error: function(a,b,c){
   						console.log(a,b,c);
   					},
   					complete : function(){
//    						console.log("complete");

//     						$(".goods_inventory li img").lazyload({
//     							effect : "fadeIn"
//    			          	});
   					}
   				});

       	 	});

       	 	$("#prdLine").change(function(){
       	 		var data1  = $('#prdLine option:selected').val();
       	 		menuF = data1.substring(0,1);
   	 			menuS = data1.substring(1,2);

       	 		var url = "__ajax_orderlist_items.jsp?menuF="+menuF+"&menuS="+menuS+"&eatCoun=<%=eatCoun%>";

       	 		$.ajax({
   					type : "POST",
   					url : url,
   					success : function(args){
   						//$('.loading-spinner').css('display', 'none');
   						$(".goods_inventory ul").append(args);
   						$(".loading-spinner p").hide();
   						location.href = "/shop/order_list.jsp?menuF="+menuF+"&menuS="+menuS+"&eatCoun=<%=eatCoun%>";
   					},
   					beforeSend: function(){
   						//$('.loading-spinner').css('display', 'block');
   			       	    rotate();

   					},
   					error: function(a,b,c){
   						console.log(a,b,c);
   					},
   					complete : function(){
//    						console.log("complete");

//     						$(".goods_inventory li img").lazyload({
//     							effect : "fadeIn"
//    			          	});
   					}
   				});

       	 	});

       	});
      //메뉴 btn
       	function btn(data){
       	 	var data1  = String(data)
       		menuF = data1.substring(0,1);
   	 		menuS = data1.substring(1,2);
   	 		var url = "__ajax_orderlist_items.jsp?menuF="+menuF+"&menuS="+menuS+"&eatCoun=<%=eatCoun%>";

       	 	$.ajax({
					type : "POST",
					url : url,
					success : function(args){
						//$('.loading-spinner').css('display', 'none');
   						$(".loading-spinner p").hide();
// 						$(".goods_list ul").append(args);
						location.href = "/shop/order_list.jsp?menuF="+menuF+"&menuS="+menuS+"&eatCoun=<%=eatCoun%>";

					},
					beforeSend: function(){
						//$('.loading-spinner').css('display', 'block');
   			       	    /* rotate(); */

					},
					error: function(a,b,c){
						console.log(a,b,c);
					},
					complete : function(){
// 						console.log("complete");

						/* $(".goods_list li img").lazyload({
							effect : "fadeIn"
			          	});  */
					}
				});
   	 	}
</script>
</html>