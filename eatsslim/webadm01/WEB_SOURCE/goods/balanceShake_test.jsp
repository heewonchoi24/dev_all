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
				밸런스 쉐이크
			</h1>
			<div class="pageDepth">
				HOME > 제품소개 > <strong>밸런스 쉐이크</strong>
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
					       <p class="f24 bold8 goodtt">칼로리는 낮추고<br />영양은 채웠다!</p>
						   <p>칼로리는 낮추고, 영양은 채워<br />건강하게 다이어트 할 수 있도록<br />설계된 체중조절용 식품</p>
					   </div>
					   <div class="chep_02">
					       <p class="f24 bold8 goodtt" style="text-align:right;">고소하게 맛있다!</p>
						   <p style="text-align:right;">7가지 곡물과 현미퍼핑으로<br />고소한 맛에 씹는 맛까지 더해<br />맛있는 다이어트 기능!</p>
					   </div>
					   <div class="chep_03">
					       <p class="f24 bold8 goodtt">식이섬유와<br />유산균이 Plus!</p>
						   <p>식이섬유(1포당 5.5g이 함유)와 장건강에<br />좋은 유산균(PMO 08)을 함께!</p>
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
                    <td class="suj"><img src="/images/balshake_tt01.png" width="235" height="31" alt="섭취량 및 섭취방법" /></td>
                    <td style="padding-left:40px;">
                    <p>- 한끼 식사 대체 시 1포(35g)를 저지방 우유 200ml에 넣고 잘 흔들어 섞은 후 천천히 씹어서 드십시오.</p>
                    <p>- 기호에 따라 우유의 양은 조절할 수 있습니다.</p>
                    <p>- 섭취량은 성인 기준으로 표시되어 있으며, 섭취자의 연령이나 신체 상태에 따라 제품섭취량 조절이 가능합니다.</p></td>
                  </tr>
                  <tr>
                    <td class="suj"><img src="/images/balshake_tt02.png" width="209" height="31" alt="섭취시 주의사항" /> </td>
                    <td style="padding-left:40px;">
                    <p>- 섭취자의 신체 상태에 따라 반응에 차이가 있을 수 있습니다.</p>
                    <p>- 알레르기 체질이신 경우 성분을 확인 하신 후 섭취하여 주시기 바랍니다.</p></td>
                  </tr>
                </table>
                </div>
            </div>
			<!-- End row -->
            <div class="row">
				<div class="one last col">
                    <table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="170">제품명</td>
							<td class="last">잇슬림 밸런스쉐이크</td>
					  </tr>
						<tr>
							<td>식품의 유형</td>
							<td class="last">체중조절용 조제식품</td>
						</tr>
						<tr>
						  <td>생산자 및 소재지</td>
						  <td class="last">풀무원건강생활(주) (충북 증평군 도안면 원명로35)</td>
					  </tr>
						<tr>
						  <td>원재료명 및 함량</td>
						  <td class="last">유청 단백분말(우유,미국), 팔라티노스, 팽화미분 9.69%(백미,국산), 볶은현미분말 7.23%(현미,국산), 볶은보리분말 6.17%(보리,국산),<br />볶은통밀분말 5.66%(통밀,국산), 볶은대두분말 5.43%(대두,국산), 볶은쌀가루 5.31%(백미,국산), 아가베이눌린, 볶은검은콩분말 4.00%(검은콩,국산),<br />현미퍼핑 2.57%(현미,국산), 식이섬유(밀), 가르시니아캄보지아 추출분말, 볶은검은깨분말 1.90%(검은깨, 중국산), 멀티비타민미네랄믹스<br />(비타민A혼합제제, B1, B2, B6, C, E혼합제재, 나이아신, 염산, 해조칼슘, 푸마르산제일철, 산화아연), 카테킨, 치커리뿌리분말, 분말유산균</td>
					  </tr>
					</table>

                </div>
            </div>
			<!-- End row -->
            <div class="divider"></div>
             <div class="row">
			    <div class="one last col">
                <h2>영양성분(1회 제공량 35g)</h2>
                <div class="divider"></div>
                  <table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <th>영양성분</th>
                      <th>1회 제공량당 함량</th>
                      <th class="last">%영양소 기준치</th>
                    </tr>
                    <tr>
                      <td>열량</td>
                      <td>125kcal</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>탄수화물</td>
                      <td>23kcal</td>
                      <td>7%</td>
                    </tr>
                    <tr>
                      <td>당류</td>
                      <td>3g</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>식이섬유</td>
                      <td>5.5g</td>
                      <td>22%</td>
                    </tr>
                    <tr>
                      <td>단백질</td>
                      <td>8g</td>
                      <td>15%</td>
                    </tr>
                    <tr>
                      <td>지방</td>
                      <td>1.3g</td>
                      <td>3%</td>
                    </tr>
                    <tr>
                      <td>포화지방</td>
                      <td>0.3g</td>
                      <td>2%</td>
                    </tr>
                    <tr>
                      <td>트랜스지방</td>
                      <td>0g</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>콜레스트롤</td>
                      <td>0mg</td>
                      <td>0%</td>
                    </tr>
                    <tr>
                      <td>나트륨</td>
                      <td>35mg</td>
                      <td>2%</td>
                    </tr>
                    <tr>
                      <td colspan="3" style="background:#F0F0F0;line-height:160%;">철분1.2mg(10%), 칼슘70mg(10%), 아연0.85mg(10%), 비타민A 175&micro;gRE(25%),<br />비타민E 2.8mg a -TE(25%), 비타민C 25mg(25%), 비타민B1 0.3mg(25%),<br />비타민B2 0.4mg(25%), 나이아신 3.8mgNE(25%), 비타민B6 0.4mg(25%), 염산100&micro;g(25%)</td>
                    </tr>
                  </table>
                </div>
             </div>      
             <!-- End row -->
             <div class="divider"></div>
            <div class="row">
			    <div class="one last col center">
                    <div class="button large dark">
                        <a href="/shop/balanceShake.jsp">주문하기</a></div>
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