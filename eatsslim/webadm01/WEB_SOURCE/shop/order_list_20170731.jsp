<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String temp_no = (String)session.getAttribute("esl_customer_num");
if(temp_no!=null){
	if(temp_no.equals("1")){//����ȸ�� sso���� ������� ���� ����� ȸ�����ǼҸ�
		session.setAttribute("esl_member_idx","");
		session.setAttribute("esl_member_id",null);
		session.setAttribute("esl_member_name","");
		session.setAttribute("esl_customer_num","");
		session.setAttribute("esl_member_code",""); //����ȸ�� ����
		response.sendRedirect("https://www.eatsslim.co.kr/sso/logout.jsp");if(true)return;
	}
}

String menuF		= ut.inject(request.getParameter("menuF"));
String menuS		= ut.inject(request.getParameter("menuS"));
String eatCoun      = ut.inject(request.getParameter("eatCoun"));
String tg			= ut.inject(request.getParameter("tg"));
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
							// 05:��õ,06:����Ʈ
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
										<h2>���̾�Ʈ��</h2>
										<p>������, ����, ���� ���� �� �پ��� ��Ÿ�ϰ�<br>�پ��� �޴��� ������ ���ִ� ���̾�Ʈ��</p>
										<%
									}else if(menuF.equals("2")){
										%>
										<h2>���̾�Ʈ ���α׷�</h2>
										<p>���ϴ� ���� ��ǥ�� ���� ���� ������<br>ü�����̰� �������� ���̾�Ʈ ���α׷�</p>
										<%
									}else if(menuF.equals("3")){
										%>
										<h2>�ǰ���</h2>
										<p>��Ʈ��, Į�θ� ����, Low GL�� ������<br>�ǰ� ������ ü�� ������ ���� �ǰ���</p>
										<%
									}else if(menuF.equals("4")){
										%>
										<h2>�ǰ���ǰ</h2>
										<p>Ǯ������ �ǰ���ǰ �����귣�� Ǯ��Ÿ,<br>Ǯ������ ����� ���� �� �ִ� �ǰ��� �� Ǯ������ �پ��� �ǰ���ǰ</p>
										<%
									}
									else if(!"".equals(tg)){
										// 05:��õ,06:����Ʈ
										if("05".equals(tg) ){
											out.println("<h2>��õ��ǰ</h2><p>�ǰ��ϰ� ���ִ� ���̾�Ʈ,<br>�ս������� ��õ�ϴ� ��ǰ�� �Ұ��մϴ�.</p>");
										}
										else if("06".equals(tg) ){
											out.println("<h2>����Ʈ��ǰ</h2><p>�ǰ��ϰ� ���ִ� ���̾�Ʈ,<br>�ս������� ���� ����޴� ����Ʈ��ǰ�� �Ұ��մϴ�.</p>");
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
									&gt; <span>���̾�Ʈ��</span>
									<%
									if(menuS.equals("1")){
									%>
										&gt; <span>����</span>
									<%
									}else if(menuS.equals("2")){
									%>
										&gt; <span>�˶��� ����</span>
									<%
									}else if(menuS.equals("3")){
									%>
										&gt; <span>�˶��� �ﾾ</span>
									<%
									}else if(menuS.equals("4")){
									%>
										&gt; <span>�̴Ϲ�</span>
									<%
									}
								}else if(menuF.equals("2")){
									%>
									&gt; <span>���̾�Ʈ ���α׷�</span>
									<%
									if(menuS.equals("1")){
									%>
										&gt; <span>�ܱ����α׷�</span>
									<%
									}else if(menuS.equals("2")){
									%>
										&gt; <span>�������α׷�</span>
									<%
									}else if(menuS.equals("3")){
									%>
										&gt; <span>Ŭ�������α׷�</span>
									<%
									}else if(menuS.equals("4")){
									%>
										&gt; <span>����Ʈ�׷�</span>
									<%
									}
								}else if(menuF.equals("3")){
									%>
									&gt; <span>�ǰ���</span>
									<%
									if(menuS.equals("1")){
									%>
										&gt; <span>�ﾾ����</span>
									<%
									}
								}else if(menuF.equals("4")){
									%>
									&gt; <span>�ǰ���ǰ</span>
									<%
									if(menuS.equals("1")){
									%>
										&gt; <span>�����</span>
									<%
									}else if(menuS.equals("2")){
									%>
										&gt; <span>��ɽ�ǰ</span>
									<%
									}else if(menuS.equals("3")){
									%>
										&gt; <span>�ǰ���</span>
									<%
									}
								}
								else if(!"".equals(tg)){
									// 05:��õ,06:����Ʈ
									if("05".equals(tg) ){
										out.println("&gt; <span>��õ��ǰ</span>");
									}
									else if("06".equals(tg) ){
										out.println("&gt; <span>����Ʈ��ǰ</span>");
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
								<dt><img src="/dist/images/order/ico_goods_filter.png" alt="" /></dt>
								<dd>
									<!-- <div class="bx_select_filter bx_filter">
										<span onclick="$('.bx_filter').toggleClass('on');">��ǰ���κ� ����</span>
										<ul>
										<%
											if(menuF.equals("1")){
												%>
												<li><button type="button" id="btn1" data-line-opts="quisine" onclick="btn(11);"><span>����</span></button></li>
												<li><button type="button" id="btn2" data-line-opts="slim" onclick="btn(12);"><span>�˶��� ����</span></button></li>
												<li><button type="button" id="btn3" data-line-opts="healthy" onclick="btn(13);"><span>�˶��� �ﾾ</span></button></li>
												<li><button type="button" id="btn4" data-line-opts="minimeal" onclick="btn(14);"><span>�̴Ϲ�</span></button></li>
												<%
											}else if(menuF.equals("2")){
												%>
												<li><button type="button" id="btn1" data-line-opts="dangi" onclick="btn(21);"><span>�ܱ����α׷�</span></button></li>
												<li><button type="button" id="btn2" data-line-opts="gamlyang" onclick="btn(22);"><span>�������α׷�</span></button></li>
												<li><button type="button" id="btn3" data-line-opts="clringe" onclick="btn(23);"><span>Ŭ�������α׷�</span></button></li>
												<li><button type="button" id="btn4" data-line-opts="smart" onclick="btn(24);"><span>����Ʈ�׷�</span></button></li>
												<%
											}else if(menuF.equals("3")){
												%>
												<li><button type="button" id="btn1" data-line-opts="healthy" onclick="btn(31);"><span>�ﾾ����</span></button></li>
												<%
											}else if(menuF.equals("4")){
												%>
												<li><button type="button" id="btn1" data-line-opts="ganpyeonsig" onclick="btn(41);"><span>�����</span></button></li>
												<li><button type="button" id="btn2" data-line-opts="gineung" onclick="btn(42);"><span>��ɽ�ǰ</span></button></li>
												<li><button type="button" id="btn3" data-line-opts="geongangjeub" onclick="btn(43);"><span>�ǰ���</span></button></li>
												<%
											}
										%>
										</ul>
									</div> -->
									<div class="bx_select_filter bx_select">
										<div class="selectWrap">
											<select name="prdLine" id="prdLine" class="notCustom">
											<%
												if(menuF.equals("1")){
											%>
												<option <%if(menuS.equals("1")) out.println(" selected=\"selected\""); %> value="11">����</option>
												<option <%if(menuS.equals("2")) out.println(" selected=\"selected\""); %> value="12">�˶��� ����</option>
												<option <%if(menuS.equals("3")) out.println(" selected=\"selected\""); %> value="13">�˶��� �ﾾ</option>
												<option <%if(menuS.equals("4")) out.println(" selected=\"selected\""); %> value="14">�̴Ϲ�</option>
											<%
												}else if(menuF.equals("2")){
											%>
												<option <%if(menuS.equals("1")) out.println(" selected=\"selected\""); %> value="21">�ܱ����α׷�</option>
												<option <%if(menuS.equals("2")) out.println(" selected=\"selected\""); %> value="22">�������α׷�</option>
												<option <%if(menuS.equals("3")) out.println(" selected=\"selected\""); %> value="23">Ŭ�������α׷�</option>
												<option <%if(menuS.equals("4")) out.println(" selected=\"selected\""); %> value="24">����Ʈ�׷�</option>
											<%
												}else if(menuF.equals("3")){
											%>
												<option <%if(menuS.equals("1")) out.println(" selected=\"selected\""); %> value="31">�ﾾ����</option>
											<%
												}else if(menuF.equals("4")){
											%>
												<option <%if(menuS.equals("1")) out.println(" selected=\"selected\""); %> value="41">�����</option>
												<option <%if(menuS.equals("2")) out.println(" selected=\"selected\""); %> value="42">��ɽ�ǰ</option>
												<option <%if(menuS.equals("3")) out.println(" selected=\"selected\""); %> value="43">�ǰ���</option>
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
													if(menuS.equals("4")){
														%>

														<%
													}else{
														%>
														<span>�ļ�</span>
														<select name="eatCoun" id="eatCoun" class="notCustom">
															<option <%if(eatCoun.equals("")) out.println(" selected=\"selected\""); %> value="">��ü</option>
															<option <%if(eatCoun.equals("1")) out.println(" selected=\"selected\""); %> value="1">1��</option>
															<option <%if(eatCoun.equals("2")) out.println(" selected=\"selected\""); %> value="2">2��</option>
															<option <%if(eatCoun.equals("3")) out.println(" selected=\"selected\""); %> value="3">3��</option>
															<option <%if(eatCoun.equals("6")) out.println(" selected=\"selected\""); %> value="6">1�� + �����</option>
														</select>
														<%
													}
												}else if(menuF.equals("2") || menuF.equals("4")){
													%>

													<%
												}else if(menuF.equals("3")){
													%>
													<span>�ļ�</span>
													<select name="eatCoun" id="eatCoun" class="notCustom">
														<option <%if(eatCoun.equals("")) out.println(" selected=\"selected\""); %> value="">��ü</option>
														<option <%if(eatCoun.equals("1")) out.println(" selected=\"selected\""); %> value="1">1��</option>
														<option <%if(eatCoun.equals("2")) out.println(" selected=\"selected\""); %> value="2">2��</option>
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
								<dd><div class="bx_select_filter bx_return"><a href="javascript:void(0);">���̾�Ʈ������ ���ư���</a></div></dd>
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
       	 	//�ļ� selectBox
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
      //�޴� btn
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