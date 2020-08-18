<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%
	String devlType		= request.getParameter("devlType"); 	// 배송타입
	/* String totalPrice	= request.getParameter("totalPrice");   // 상품 가격 (할인 된 상품은 할인 적용된 가격) */
	int totalPrice   = Integer.parseInt(request.getParameter("totalPrice"));
	String caId			= request.getParameter("caId");			// 상품아이디
	/* String groupPrice1  = request.getParameter("groupPrice1");  // 상품 원래 가격 */
	String cateCode		= request.getParameter("cateCode");		// 1일 몇식
	String gId 			= request.getParameter("igroupId");
	String pramType		= request.getParameter("paramType");
	int sum				= 0;
	String type			= "";
	String query		= "";

	//System.out.println(pramType);

	SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
	String today		= dt.format(new Date());
	String groupName    = request.getParameter("groupName");
	String groupInfo1   = request.getParameter("groupInfo1");
	String groupPrice   = request.getParameter("groupPrice");

	Statement stmt1		= null;
	ResultSet rs1		= null;
	stmt1				= conn.createStatement();


 String gubun1	  		= "";
 // String groupName  = "";
 String groupInfo 		= "";
 // String groupInfo1 = "";
 String aType 	  		= "";
 String bType 	  		= "";
 int kalInfo		  	= 0;
 int groupPrice1   		= 0;
 // int totalPrice	  = 0;
 int bTypeNum	  		= 0;
 String cartImg	  		= "";
 String groupImg	  	= "";
 String groupCode  		= "";
 String gubun2	  		= "";
 String sikdan	  		= "";
 int _cartId	  	  	= 0;
 String tag		  		= "";
 double dBtype;

 //-- 상품 정보
 query		= "SELECT (SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID  ";
 query		+= "WHERE  ('"+today+"' BETWEEN STDATE AND LTDATE) AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ";
 query		+= "ORDER BY ES.ID DESC ";
 query		+= " LIMIT 0, 1) AS ATYPE, ";
 query		+= "(SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID  ";
 query		+= " WHERE  ('"+today+"' BETWEEN STDATE AND LTDATE) AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ";
 query		+= " ORDER BY ES.ID DESC ";
 query		+= " LIMIT 0, 1) AS BTYPE, GUBUN1, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE1, KAL_INFO, GROUP_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG";
 query		+= " FROM ESL_GOODS_GROUP EGG ";
 query		+= "  WHERE USE_YN = 'Y' ";
 query		+= " AND LIST_VIEW_YN = 'Y' ";
 query		+= " AND ID=" + caId;
 rs1 = stmt1.executeQuery(query);
 if(rs1.next()){
 	aType		= rs1.getString("ATYPE");
 	bType		= rs1.getString("BTYPE");
 	gubun1		= rs1.getString("GUBUN1");
 	groupCode	= rs1.getString("GROUP_CODE");
 	groupName   = rs1.getString("GROUP_NAME");
 	groupPrice1 = rs1.getInt("GROUP_PRICE1");
 	groupInfo	= rs1.getString("GROUP_INFO");
 	groupInfo1  = rs1.getString("GROUP_INFO1");
 	kalInfo 	= rs1.getInt("KAL_INFO");
 	cartImg		= rs1.getString("CART_IMG");
 	groupImg	= rs1.getString("GROUP_IMGM");
 	gubun2		= rs1.getString("GUBUN2");
 	sikdan		= gubun2.substring(1);
 	_cartId		= rs1.getInt("ID");
 	tag			= rs1.getString("TAG");
 	if(_cartId == 52 || _cartId == 54 || _cartId == 15 || _cartId == 75 || _cartId == 76 || _cartId == 77 || _cartId == 79 || _cartId == 80 || _cartId == 81 || _cartId == 102 || _cartId == 103 || _cartId == 93 || _cartId == 94 || _cartId == 95 || _cartId == 96 || _cartId == 97 || _cartId == 104 || _cartId == 95){
 		devlType = "0002";
 	}else{
 		devlType = "0001";
 	}

 }

 //-- 휴무일정보
query		= "SELECT DATE_FORMAT(HOLIDAY, '%Y.%m.%d') HOLIDAY, HOLIDAY_NAME";
query		+= " FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY_TYPE = '02' ";
query		+= " ORDER BY HOLIDAY DESC, ID DESC";
pstmt		= conn.prepareStatement(query);
rs1			= pstmt.executeQuery();

ArrayList<String> holiDay = new ArrayList();
while (rs1.next()) {
	holiDay.add(rs1.getString("HOLIDAY"));
}
rs1.close();

 DecimalFormat df = new DecimalFormat("#,###");
 String totalP		= df.format(totalPrice);
 String groupPriceRe = df.format(groupPrice1);
 int original 		= 0;
 /* if(devlType.equals("0001")){
 	original = Integer.parseInt(totalPrice)/ 5 / 2 / 1;
 }else if(devlType.equals("0002")){
 	original = Integer.parseInt(totalPrice) / 1;
 }else if(caId.equals("31")){
 	original = Integer.parseInt(totalPrice) / 1;
 } */

 if(bType == null){
		if(devlType.equals("0001")){
			if(caId.equals("31")){
				/* original = groupPrice1; */
				original = groupPrice1 / (5 * 2 );
			}else{
				original = groupPrice1 / (5 * 2 );
			}
		}else if(devlType.equals("0002")){
			original = groupPrice1;//Integer.parseInt(totalPrice)/ 1 / 3 / 1;
		}
	}else{
		if(devlType.equals("0002")){
			if(caId.equals("31")){
				/* original = groupPrice1; */
				original = groupPrice1 / (5 * 2 );
			}else{
				original = groupPrice1 / (5 * 2 );
			}
		}else if(devlType.equals("0002")){
			original = groupPrice1;//Integer.parseInt(totalPrice)/ 1 / 3 / 1;
		}
	}
	System.out.println("original :::"+original);

%>
<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/expansion.css">
<div id="setOptionsCal">
    <div class="inner">
        <header class="pop_header"><h1>옵션 변경</h1></header>
        <div class="pop_content">

		<div class="title"><%=groupName%></div>

		<div class="prd_info">
    		<h2>상품정보</h2>
    		<div class="tableBox">
    			<table>
        			<colgroup>
						<col width="29.5%"/>
						<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
							<th>중량 및 구성</th>
							<td>4포(35g x 14) / 1박스</td>
						</tr>
						<tr>
							<th>특징2</th>
							<td>장 건강에 좋은 유산균(PMO 08) 포함</td>
						</tr>
						<tr>
							<th>특징3</th>
							<td>풍부한 식이섬유 [ 1포당(35g) ]</td>
						</tr>
						<tr>
							<th>특징4</th>
							<td>풍부한 식이섬유 [ 1포당(35g) ]</td>
						</tr>
						<tr>
							<th>특징5</th>
							<td>풍부한 식이섬유 [ 1포당(35g) ]</td>
						</tr>
					</tbody>
        		</table>
    		</div>
    	</div>

        <form action="" name="optionForm">
	        <input type="hidden" name="changePayPrice" id="changePayPrice" value="<%=original%>">
	        <input type="hidden" name="devlWeek" id="devlWeek" value="">
	        <input type="hidden" name="devlW" id="devlW" value="">
	        <input type="hidden" name="devlDay" id="devlDay" value="">
			<input type="hidden" name="devlWeekEnd" id="devlWeekEnd" value="">
	        <input type="hidden" name="changeDevlDay" id="changeDevlDay" value="">
	        <input type="hidden" name="buyQty" id="buyQty" value="">
	        <input type="hidden" name="type" id="type" value="">
	        <input type="hidden" name="cartId" id="cartId" value="<%=caId%>">
	        <input type="hidden" name="gId" id="gId" value="">
	        <input type="hidden" name="devlType" id="devlType" value="<%=devlType%>">
        	<input type="hidden" name="buyBagYn" id="buyBagYn" value="">
        	<input type="hidden" name="pcAndMobileType" id="pcAndMobileType" value="mobile">
        <%
        	if(devlType.equals("0001")){

				if(pramType.equals("list") ){
					if(!caId.equals("82") && !caId.equals("83") && !caId.equals("84") && !caId.equals("85") && !caId.equals("51") && !caId.equals("65") && !caId.equals("73") && !caId.equals("54") && !caId.equals("89") && !caId.equals("90") && !caId.equals("91") && !caId.equals("92")){
						%>
			        	<div class="opt_select_group  ty2" id="selectDevlDay" name="selectDevlDay">
			        		<span class="h">배송요일</span>
			        		<select class="inp_st inp_st100p" id="devl_day" name="devl_day">
			        			<option value="3">주 3회 (월/수/금)</option>
			        			<option value="5" selected>주 5회 (월~금)</option>
			        		</select>
			        	</div>
						<%
					}
				}else if(pramType.equals("main")){
					if(!caId.equals("82") && !caId.equals("83") && !caId.equals("84") && !caId.equals("85") && !caId.equals("51") && !caId.equals("65") && !caId.equals("73") && !caId.equals("54") && !caId.equals("89") && !caId.equals("90") && !caId.equals("91") && !caId.equals("92")){
						%>
			        	<div class="opt_select_group  ty2" id="selectDevlDay" name="selectDevlDay">
			        		<span class="h">배송요일</span>
			        		<select class="inp_st inp_st100p" id="devl_day" name="devl_day">
			        			<option value="5" selected>주 5회 (월~금)</option>
			        		</select>
			        	</div>
						<%
					}
				}
				if(pramType.equals("list")){
					if(!caId.equals("82") && !caId.equals("83") && !caId.equals("84") && !caId.equals("85") && !caId.equals("51") && !caId.equals("65") && !caId.equals("73") && !caId.equals("54")){
					%>
		        	<div class="opt_select_group ty2">
		        		<span class="h">배송기간</span>
		        		<select class="inp_st inp_st100p" id="selectDevlWeek" name="selectDevlWeek">
		        			<option value="1">1주</option>
		        			<option value="2" selected>2주</option>
		        			<option value="4">4주</option>
		        			<option value="8">8주</option>
		        		</select>
		        	</div>
					<%
					}
				}else{
					if(!caId.equals("82") && !caId.equals("83") && !caId.equals("84") && !caId.equals("85") && !caId.equals("51") && !caId.equals("65") && !caId.equals("73") && !caId.equals("54")){
					%>
		        	<div class="opt_select_group ty2">
		        		<span class="h">배송기간</span>
		        		<select class="inp_st inp_st100p" id="selectDevlWeek" name="selectDevlWeek">
		        			<option value="2" selected>2주</option>
		        		</select>
		        	</div>
					<%
					}
				}
				%>
        	<div class="opt_select_group ty2">
        		<span class="h">수량</span>
        		<input type="hidden" id="pSave" value="<%=original%>">
		        <input type="hidden" id="mSave" value="<%=original%>">
        		<select class="inp_st inp_st100p inp_qtt_text">
        			<option value="1">1</option>
        			<option value="2">2</option>
        			<option value="3">3</option>
        			<option value="4">4</option>
        			<option value="5">5</option>
        		</select>
        	</div>

        	<div class="opt_select_date ty2">

        		<span class="h">첫 배송일</span>
        		<span onclick="cal_on();">
	            	<input type="text" class="dayText"  id="dayText" name="" value="첫 배송일 선택" readonly>
	            	<input type="hidden" id="day" name="day" value="">
	                <button type="button" class=""></button>
                </span>
            </div>

        	<div id="option_scheduler"></div>

        	<h2>주말구매 옵션</h2>
        	<div class="opt_select_group">
        		<input name="buy_weekend" id="buy_weekend" type="checkbox" checked="checked" value="">
				<label for="buy_bag"><span></span><strong class="f16">토,일 구매</strong></label>
        	</div>
			
        	<h2>보냉가방 구매</h2>
        	<div class="opt_select_group">
        		<input name="buy_bag" id="buy_bag" type="checkbox" checked="checked" value="">
				<label for="buy_bag"><span></span><strong class="f16">보냉가방 구매 (4,000원)</strong></label>
				<p>보냉가방을 필수로 구매하셔야 상품을 신선하게 배송받으실 수 있습니다.</p>
        	</div>
        	<div class="options_total">
        		<p>TOTAL<strong id="sumPrice"><%=totalP%></strong><small>원</small></p>
        		<p><span>(3월 특별 고객할인 이벤트가)</span></p>
        	</div>
        		<%
        		type = "1";
        	}else{
        %>
        	<div class="opt_select_group">
        		<input type="hidden" id="pSave" value="<%=original%>">
	        	<input type="hidden" id="mSave" value="<%=original%>">
        		<select class="inp_st inp_st100p inp_qtt_text">
        			<option value="1">1</option>
        			<option value="2">2</option>
        			<option value="3">3</option>
        			<option value="4">4</option>
        			<option value="5">5</option>
        		</select>
        	</div>
        	<div class="options_total">
        		<p>TOTAL<strong id="sumPrice"><%=totalP%></strong><small>원</small></p>
        		<p><span>(3월 특별 고객할인 이벤트가)</span></p>
        	</div>
        	<%
        	type = "2";
        	}
        	%>
            <div class="bottom_btn_area">
                <!-- <button type="button" class="btn btn_dgray huge" onclick="$('.pop_close').trigger('click');">저장하기</button> -->
                <button type="button" class="btn btn_dgray huge">장바구니 담기</button>
            </div>
            <input type="hidden" name="sumPriceWeek" id="sumPriceWeek" value="">
            </form>
        </div>
    </div>
</div>
<script>
	var gId = '<%=caId%>';
	var totalPri = '<%=totalP%>';
	var ttp = totalPri.replace(",","");
	var bType = '<%=bType%>';
	var aType = '<%=aType%>';
	var dBtype = 0;
	if($("input:checkbox[id='buy_bag']").is(":checked") == true){
		$("#buyBagYn").val("Y");
		var ttpResult = parseInt(ttp) + 4000;
		$("#sumPrice").html(totalComma(ttpResult));
	}

	$("#buy_bag").click(function(){

		if($("input:checkbox[id='buy_bag']").is(":checked") == true){
			$("#buyBagYn").val("Y");
			var ttpResult = $("#sumPrice").html();
			var re = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;

			var result = ttpResult.replace(re,"");

			var resultPrice = parseInt(result) + 4000;
			$("#sumPrice").html(totalComma(resultPrice));
		}else{
			$("#buyBagYn").val("N");
			var ttpResult = $("#sumPrice").html();
			var re = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;

			var result = ttpResult.replace(re,"");

			var resultPrice = parseInt(result) - 4000;
			$("#sumPrice").html(totalComma(resultPrice));
		}
	});
	var devlType = '<%=devlType%>';
	var type = '<%=type%>';
	var quantity = $(".inp_qtt_text").val();
	$("#buyQty").val(quantity);
	
	if($("input:checkbox[id='buy_weekend']").is(":checked") == true){
		$("#devlWeekEnd").val("2");
	}else if($("input:checkbox[id='buy_weekend']").is(":checked") == false){
		$("#devlWeekEnd").val("0");
	}
	
	$("#buy_weekend").change(function(){

		if($(this).is(":checked") == true){
			$("#devlWeekEnd").val("2");

		}else{
			$("#devlWeekEnd").val("0");
		}
		
    	data = $('#selectDevlWeek option:selected').val();

    	var i = $(".inp_qtt_text").val();
        var devlWeek = $("#devlWeek").val(data);
        var devlW = $("#devlW").val();
	   	var reP  = weekP.replace(",","");
	   	var rePw = devlWeekVal.replace(",","");
	   	if(gId != "82" && gId != "83" && gId != "84" && gId != "85" && gId != "51" && gId != "65" && gId != "73" && gId != "54"&& gId != "15"&& gId != "75"&& gId != "76" && gId != "77"&& gId != "79"&& gId != "80"&& gId != "81"&& gId != "102"&& gId != "103"&& gId != "93"&& gId != "94"&& gId != "93"&& gId != "95"&& gId != "96"&& gId != "97"&& gId != "104"){
	   		totalPrice = parseInt($("#changePayPrice").val()) * parseInt($("#devlWeek").val()) * (parseInt($("#devl_day").val()) + parseInt($("#devlWeekEnd").val())) * i;
		   	if(bType == null){
				/* bTypeNum = Integer.parseInt(bType);
				bTypeNum = 0; */
				totalPrice = totalPrice;
			}else{
				if(aType =="P"){
					dBtype = parseInt(bType)/100.0;
					totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
				}else if(aType == "W"){
					totalPrice = totalPrice - parseInt(bType);
				}else if(aType == null){
					totalPrice = totalPrice;
				}
			}
	   	}else{
	   		total = parseInt($("#changePayPrice").val()) * i;
	   		if(bType == null){
				/* bTypeNum = Integer.parseInt(bType);
				bTypeNum = 0; */
				totalPrice = totalPrice;
			}else{
				if(aType =="P"){
					dBtype = parseInt(bType)/100.0;
					totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
				}else if(aType == "W"){
					totalPrice = totalPrice - parseInt(bType);
				}else if(aType == null){
					totalPrice = totalPrice;
				}
			}
	   	}
    		$("#sumPrice").html(totalComma(totalPrice));
    		$("#devlW").val(data);
    		if($("input:checkbox[id='buy_bag']").is(":checked") == true){
    			$("#buyBagYn").val("Y");
    			var ttpResult = $("#sumPrice").html();
    			var re = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;

    			var result = ttpResult.replace(re,"");

    			var resultPrice = parseInt(result) + 4000;
    			$("#sumPrice").html(totalComma(resultPrice));
    		}else{
    			$("#buyBagYn").val("N");
    		}		
		
	});


	var selectDevlWeek = $('#selectDevlWeek option:selected').val();
	$("#devlWeek").val(selectDevlWeek);

	var selectDevlDay = $('#selectDevlDay option:selected').val();
	$("#devlDay").val(selectDevlDay);

	$("#type").val(type);
	Date.prototype.addDays = function(days) {
        this.setDate(this.getDate() + parseInt(days));
        return this;
    };

   	var fHour =  new Date().getHours();

	var minDateT = 0;
	if(gId == "32" || gId == "40" || gId == "69" || gId == "92"){
		minDateT = 4;
	}else if(gId == "50" ||gId == "72" ||gId == "43" ||gId == "46" ||gId == "42" ||gId == "71" ||gId == "34" || gId == "36" || gId == "43" || gId == "44" || gId == "48" || gId == "90" || gId == "91" || gId == "82" || gId == "83" || gId == "84" || gId == "65" || gId == "88" || gId == "51"|| gId == "87" || gId == "73" || gId == "85" || gId == "86"){
		minDateT = 6;
	}else if(gId == "89"){
		if(fHour < 15){  //오후 3시 이전에는 2일
			minDateT = 2;
		}else{
			minDateT = 3;
		}
	}else{
		minDateT = 1;
	}

   	var fday = new Date().addDays(minDateT);
   	var year = "";
   	var month = "";
   	var day = "";
   	var thisDate = "";

   	var holiDays = new Array();
<%
for(int i=0; i<holiDay.size(); i++){
%>
	holiDays[<%=i%>]='<%=holiDay.get(i)%>';
<%
}
%>
    $('#option_scheduler').datepicker({
        range :     false,
        toggleSelected: false,
        onlyDateSelect : true,
        inline :    true,
        language :  "ko",
        /* minDate : new Date(), */
        minDate : new Date(),
        navTitles: {
            days: '<i>yyyy</i>. MM'
        },
        onRenderCell : function(date, cellType)  {
        	var	currentYear = date.getFullYear();
	        var currentMonth = date.getMonth()+1;
	    	var currentDate = date.getDate();
	    	var currentToday = currentYear +"."+ (currentMonth<10 ? "0"+currentMonth : currentMonth) +"."+ (currentDate<10 ? "0"+currentDate : currentDate);
	        if(cellType == 'day'){
	        	if ((date >= new Date()) && (date <= fday)){
	        		return {
	        			classes : '-disabled-',
	        			disabled : true
	        		}
	        	}
	        	if(holiDays.indexOf(currentToday) != -1){
	                return {
	                    classes : '-holiday-',
	                    disabled: true
	                }
	            }
	        }

        },
        onSelect: function onSelect(fd, date, picker) {
       	    var thisDate = leadingZeros(date.getFullYear(), 4) + '-' +
       	    leadingZeros(date.getMonth() + 1, 2) + '-' +
       	    leadingZeros(date.getDate(), 2);
       	    var thisDateText = leadingZeros(date.getFullYear())+"-"+(leadingZeros(date.getMonth()+1))+"-"+leadingZeros(date.getDate());

	       	 function leadingZeros(n, digits) {
	       	  var zero = '';
	       	  n = n.toString();

	       	  if (n.length < digits) {
	       	    for (i = 0; i < digits - n.length; i++)
	       	      zero += '0';
	       	  }
	       	  return zero + n;
	       	}
        	$("#day").val(thisDate);
        	$("#dayText").val(thisDateText);
        	$("#day").val(thisDateText);
        	$("#option_scheduler").hide().removeClass("on");
        }
    });
    $('#pop_scheduler').data('datepicker');

    $(":input").filter(".only_number")
	.css("imeMode", "disabled")
	.keypress(function(event){
		if (event.which && (event.which < 48 || event.which > 57))
		{
			event.preventDefault();
		}
	});

 	// 옵션변경 수량선택
   	var total = 0;
 	var totalPrice = "";
    var quantityFn = {
    	onSet : function(i){
    		$(".inp_qtt_text").val(i);
    		return false;
    	},
    	plus : function(){
    		var $val = $(".inp_qtt_text").val();
    		var i = Number($val)+1;
		   	var pSave = $("#pSave").val();			        // +시 가격 변동 사항을 실시간으로 변경
		   	var repS = pSave.replace(",","");
		   	/* var totalPrice	= (parseInt(repS) / 10) * parseInt($("#devlWeek").val()) * parseInt($("#devl_day").val()) * i; */
		   	if(gId != "82" && gId != "83" && gId != "84" && gId != "85" && gId != "51" && gId != "65" && gId != "73" && gId != "54"&& gId != "15"&& gId != "75"&& gId != "76" && gId != "77"&& gId != "79"&& gId != "80"&& gId != "81"&& gId != "102"&& gId != "103"&& gId != "93"&& gId != "94"&& gId != "93"&& gId != "95"&& gId != "96"&& gId != "97"&& gId != "104"){
			   	totalPrice	= parseInt(pSave) * parseInt($("#devlWeek").val()) * (parseInt($("#devl_day").val()) + parseInt($("#devlWeekEnd").val()) * i;
			   	if(bType == null){
					/* bTypeNum = Integer.parseInt(bType);
					bTypeNum = 0; */
					totalPrice = totalPrice;
				}else{
					if(aType =="P"){
						dBtype = parseInt(bType)/100.0;
						totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
					}else if(aType == "W"){
						totalPrice = totalPrice - parseInt(bType);
					}else if(aType == null){
						totalPrice = totalPrice;
					}
				}
		   	}else{
		   		totalPrice	= parseInt(pSave) * i;
		   		if(bType == null){
					/* bTypeNum = Integer.parseInt(bType);
					bTypeNum = 0; */
					totalPrice = totalPrice;
				}else{
					if(aType =="P"){
						dBtype = parseInt(bType)/100.0;
						totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
					}else if(aType == "W"){
						totalPrice = totalPrice - parseInt(bType);
					}else if(aType == null){
						totalPrice = totalPrice;
					}
				}
		   	}
		   	/* var totalPrice	= parseInt(repS) * i; */
		   	$("#buyQty").val(i);
    		$("#sumPrice").html(totalComma(totalPrice));
    		if($("input:checkbox[id='buy_bag']").is(":checked") == true){
    			$("#buyBagYn").val("Y");
    			var ttpResult = $("#sumPrice").html();
    			var re = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;

    			var result = ttpResult.replace(re,"");

    			var resultPrice = parseInt(result) + 4000;
    			$("#sumPrice").html(totalComma(resultPrice));
    		}else{
    			$("#buyBagYn").val("N");
    		}
    		quantityFn.onSet(i);
    	},
    	minus : function(){
    		var $val = $(".inp_qtt_text").val();
    		var i = Number($val)-1;
    		if(i < 1) {
    			alert("수량은 1개 이상 선택해주세요.");
    			return false;
   			}else{
			   	var mSave = $("#mSave").val();				// -시 가격 변동 사항을 실시간으로 변경
			   	var repS = mSave.replace(",","");
			   	$("#buyQty").val(i);
			   	/* var totalPrice	= (parseInt(repS) / 10) * parseInt($("#devlWeek").val()) * parseInt($("#devl_day").val()) * i; */
				if(gId != "82" && gId != "83" && gId != "84" && gId != "85" && gId != "51" && gId != "65" && gId != "73" && gId != "54"&& gId != "15"&& gId != "75"&& gId != "76" && gId != "77"&& gId != "79"&& gId != "80"&& gId != "81"&& gId != "102"&& gId != "103"&& gId != "93"&& gId != "94"&& gId != "93"&& gId != "95"&& gId != "96"&& gId != "97"&& gId != "104"){

			   		totalPrice	= parseInt(repS) * parseInt($("#devlWeek").val()) * (parseInt($("#devl_day").val()) + parseInt($("#devlWeekEnd").val())) * i;
				   	if(bType == null){
						/* bTypeNum = Integer.parseInt(bType);
						bTypeNum = 0; */
						totalPrice = totalPrice;
					}else{
						if(aType =="P"){
							dBtype = parseInt(bType)/100.0;
							totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
						}else if(aType == "W"){
							totalPrice = totalPrice - parseInt(bType);
						}else if(aType == null){
							totalPrice = totalPrice;
						}
					}
			   	}else{
			   		totalPrice	= parseInt(repS) * i;
			   		if(bType == null){
						/* bTypeNum = Integer.parseInt(bType);
						bTypeNum = 0; */
						totalPrice = totalPrice;
					}else{
						if(aType =="P"){
							dBtype = parseInt(bType)/100.0;
							totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
						}else if(aType == "W"){
							totalPrice = totalPrice - parseInt(bType);
						}else if(aType == null){
							totalPrice = totalPrice;
						}
					}
			   	}
// 			   	var totalPrice	= parseInt(repS) * i;
	    		$("#sumPrice").html(totalComma(totalPrice));
	    		if($("input:checkbox[id='buy_bag']").is(":checked") == true){
	    			$("#buyBagYn").val("Y");
	    			var ttpResult = $("#sumPrice").html();
	    			var re = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;

	    			var result = ttpResult.replace(re,"");

	    			var resultPrice = parseInt(result) + 4000;
	    			$("#sumPrice").html(totalComma(resultPrice));
	    		}else{
	    			$("#buyBagYn").val("N");
	    		}
   			}

    		quantityFn.onSet(i);

    	}
    }

    // 배송기간 선택시 가격 실시간으로 변동
    var data = "";
   	var weekP = $("#sumPrice").html();		// -시 가격 변동 사항을 실시간으로 변경
   	var devlWeekVal = $("#sumPriceWeek").val(); //초기 가격(변동없는)
   	var caId = $("#cartId").val();
    $('#selectDevlWeek').change(function(){
    	data = $('#selectDevlWeek option:selected').val();

    	var i = $(".inp_qtt_text").val();
        var devlWeek = $("#devlWeek").val(data);
        var devlW = $("#devlW").val();
	   	var reP  = weekP.replace(",","");
	   	var rePw = devlWeekVal.replace(",","");
	   	if(gId != "82" && gId != "83" && gId != "84" && gId != "85" && gId != "51" && gId != "65" && gId != "73" && gId != "54"&& gId != "15"&& gId != "75"&& gId != "76" && gId != "77"&& gId != "79"&& gId != "80"&& gId != "81"&& gId != "102"&& gId != "103"&& gId != "93"&& gId != "94"&& gId != "93"&& gId != "95"&& gId != "96"&& gId != "97"&& gId != "104"){
	   		totalPrice = parseInt($("#changePayPrice").val()) * parseInt($("#devlWeek").val()) * (parseInt($("#devl_day").val()) + parseInt($("#devlWeekEnd").val())) * i;
		   	if(bType == null){
				/* bTypeNum = Integer.parseInt(bType);
				bTypeNum = 0; */
				totalPrice = totalPrice;
			}else{
				if(aType =="P"){
					dBtype = parseInt(bType)/100.0;
					totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
				}else if(aType == "W"){
					totalPrice = totalPrice - parseInt(bType);
				}else if(aType == null){
					totalPrice = totalPrice;
				}
			}
	   	}else{
	   		total = parseInt($("#changePayPrice").val()) * i;
	   		if(bType == null){
				/* bTypeNum = Integer.parseInt(bType);
				bTypeNum = 0; */
				totalPrice = totalPrice;
			}else{
				if(aType =="P"){
					dBtype = parseInt(bType)/100.0;
					totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
				}else if(aType == "W"){
					totalPrice = totalPrice - parseInt(bType);
				}else if(aType == null){
					totalPrice = totalPrice;
				}
			}
	   	}
    		$("#sumPrice").html(totalComma(totalPrice));
    		$("#devlW").val(data);
    		if($("input:checkbox[id='buy_bag']").is(":checked") == true){
    			$("#buyBagYn").val("Y");
    			var ttpResult = $("#sumPrice").html();
    			var re = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;

    			var result = ttpResult.replace(re,"");

    			var resultPrice = parseInt(result) + 4000;
    			$("#sumPrice").html(totalComma(resultPrice));
    		}else{
    			$("#buyBagYn").val("N");
    		}
    });
    var groupId = '<%=caId%>';
    var devlDay = $("#devl_day").val();
    if(groupId == "31" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "32" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "82"){
		$("#selectDevlWeek option:last").remove();
	}else if(groupId == "85"){
		$("#selectDevlWeek option:last").remove();
	}else if(groupId == "36" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "40" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "44" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "48" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "34" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "42" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "46" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "71" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "43" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "50" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "72" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}else if(groupId == "69" && devlDay == "3"){
		$("#selectDevlWeek option:first").remove();
	}

    // 3일 5일 구분
   	$('#selectDevlDay').change(function(){
   		data = $('#selectDevlDay option:selected').val();
   		$("#changeDevlDay").val(data);
   		if(groupId == "31" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "31" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "32" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "32" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "36" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "36" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "40" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "40" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "44" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "44" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "48" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "48" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "34" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "34" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "42" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "42" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "46" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "46" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "71" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "71" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "43" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "43" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "50" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "50" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "72" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "72" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}else if(groupId == "69" && data == "3"){
   			$("#selectDevlWeek option:first").remove();
   			$("#devlWeek").val("2");
   			$("#selectDevlWeek").val("2").attr("selected","selected");
   		}else if(groupId == "69" && data == "5"){
   			$("#selectDevlWeek").prepend("<option value='1'>1주</option>");
   			$("#selectDevlWeek").val("1");
   			$("#devlWeek").val("1");
   		}
   		var i = $(".inp_qtt_text").val();
   		var reP  = weekP.replace(",","");
   		if(gId != "82" && gId != "83" && gId != "84" && gId != "85" && gId != "51" && gId != "65" && gId != "73" && gId != "54"&& gId != "15"&& gId != "75"&& gId != "76" && gId != "77"&& gId != "79"&& gId != "80"&& gId != "81"&& gId != "102"&& gId != "103"&& gId != "93"&& gId != "94"&& gId != "93"&& gId != "95"&& gId != "96"&& gId != "97"&& gId != "104"){

	   		totalPrice = parseInt($("#changePayPrice").val()) * parseInt($("#devlWeek").val()) * (parseInt($("#devl_day").val()) + parseInt($("#devl_weekend").val())) * i;
		   	if(bType == null){
				/* bTypeNum = Integer.parseInt(bType);
				bTypeNum = 0; */
				totalPrice = totalPrice;
			}else{
				if(aType =="P"){
					dBtype = parseInt(bType)/100.0;
					totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
				}else if(aType == "W"){
					totalPrice = totalPrice - parseInt(bType);
				}else if(aType == null){
					totalPrice = totalPrice;
				}
			}
	   	}else{
	   		total = parseInt($("#changePayPrice").val()) * i;
	   		if(bType == null){
				/* bTypeNum = Integer.parseInt(bType);
				bTypeNum = 0; */
				totalPrice = totalPrice;
			}else{
				if(aType =="P"){
					dBtype = parseInt(bType)/100.0;
					totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
				}else if(aType == "W"){
					totalPrice = totalPrice - parseInt(bType);
				}else if(aType == null){
					totalPrice = totalPrice;
				}
			}
	   	}
	   	$("#sumPrice").html(totalComma(totalPrice));
		if($("input:checkbox[id='buy_bag']").is(":checked") == true){
			$("#buyBagYn").val("Y");
			var ttpResult = $("#sumPrice").html();
			var re = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;

			var result = ttpResult.replace(re,"");

			var resultPrice = parseInt(result) + 4000;
			$("#sumPrice").html(totalComma(resultPrice));
		}else{
			$("#buyBagYn").val("N");
		}
    });

    //콤마 가격 붙여주기
    function totalComma(total){
    	total = total + "";
    	point = total.length % 3 ;
    	len = total.length;
    	str = total.substring(0, point);
    	while (point < len) {
    	    if (str != "") str += ",";
    	    str += total.substring(point, point + 3);
    	    point += 3;
    	}
		return totalPrice = str;
    }
    // 수량 직접 입력시
    $('.inp_qtt_text').change(function(e) {
        var i = $(this).val();
	   	var pSave = $("#pSave").val();
	   	var repS = pSave.replace(",","");
	   	var totalPrice = 0;
	   	if(gId != "82" && gId != "83" && gId != "84" && gId != "85" && gId != "51" && gId != "65" && gId != "73" && gId != "54"&& gId != "15"&& gId != "75"&& gId != "76" && gId != "77"&& gId != "79"&& gId != "80"&& gId != "81"&& gId != "102"&& gId != "103"&& gId != "93"&& gId != "94"&& gId != "93"&& gId != "95"&& gId != "96"&& gId != "97"&& gId != "104"){
	   		totalPrice = parseInt(pSave) * parseInt($("#devlWeek").val()) * (parseInt($("#devl_day").val()) + parseInt($("#devl_weekend").val())) * i;
		   	if(bType == null){
				/* bTypeNum = Integer.parseInt(bType);
				bTypeNum = 0; */
				totalPrice = totalPrice;
			}else{
				if(aType =="P"){
					dBtype = parseInt(bType)/100.0;
					totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
				}else if(aType == "W"){
					totalPrice = totalPrice - parseInt(bType);
				}else if(aType == null){
					totalPrice = totalPrice;
				}
			}
	   	}else{
	   		totalPrice = parseInt(pSave) * i;
	   		if(bType == null){
				/* bTypeNum = Integer.parseInt(bType);
				bTypeNum = 0; */
				totalPrice = totalPrice;
			}else{
				if(aType =="P"){
					dBtype = parseInt(bType)/100.0;
					totalPrice = totalPrice - (totalPrice * dBtype); // %세일 계산
				}else if(aType == "W"){
					totalPrice = totalPrice - parseInt(bType);
				}else if(aType == null){
					totalPrice = totalPrice;
				}
			}
	   	}
	   	$("#buyQty").val(i);
		$("#sumPrice").html(totalComma(totalPrice));
		if($("input:checkbox[id='buy_bag']").is(":checked") == true){
			$("#buyBagYn").val("Y");
			var ttpResult = $("#sumPrice").html();
			var re = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;

			var result = ttpResult.replace(re,"");

			var resultPrice = parseInt(result) + 4000;
			$("#sumPrice").html(totalComma(resultPrice));
		}else{
			$("#buyBagYn").val("N");
		}
    });
    var eslMemberId = '<%=eslMemberId%>';
 	// 일배 type(2) 택배 type(1)로 나눠서 작업
    $(".btn").click(function(){
   	if(eslMemberId != ""){
 	var total = $("#sumPrice").html();
 	var dayYn = $("#day").val();
 	if(dayYn == ""){
 		alert("배송일을 선택하길 바랍니다.");
 	}else if(dayYn != ""){
	 	$("#sumPriceWeek").val(total);
	    	var queryString = $("form[name=optionForm]").serialize() ;

	    	$.ajax({
	            url : "order/__ajax_goods_set_options_path.jsp",
	            type : 'post',
	            data : queryString,
	            async : true,
	            success : function(data){
					$('.pop_close').trigger('click');
					//popFn.hide($('#pop_bx_calendar'));
					setTimeout(function(){ location.reload(); }, 100);
	            },
	            error : function(a,b,c){
	                alert('error : ' + a.responseText);
	                moving = false;
	            }
	       });
	 	}
   	}else{
   		alert("로그인을 먼저 하시기 바랍니다.");
   		var url = "/mobile/customer/login.jsp";
   		$(location).attr('href',url);
   	}

    });

    function cal_on() {
    	var cal = $("#option_scheduler");
    	if(!$("#option_scheduler").hasClass("on")){
    		$("#option_scheduler").show().addClass("on");
    	}else{
    		$("#option_scheduler").hide().removeClass("on");
    	}

    }
</script>