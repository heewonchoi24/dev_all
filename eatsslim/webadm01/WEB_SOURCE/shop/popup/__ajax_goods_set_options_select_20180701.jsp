<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
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


String query		= "";
String query1		= "";
String query2		= "";
String query3		= "";
String query4		= "";
int noticeId		= 0;
String topYn		= "";
String title		= "";
String bannerImg 	= "";
String clickLink 	= "";
String content		= "";
String listImg		= "";
int maxLength		= 0;
String imgUrl		= "";
String instDate 	= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
String cartId		= ut.inject(request.getParameter("cartId"));
String groupId		= ""; // ut.inject(request.getParameter("cartId"));
String devlType		= ""; // ut.inject(request.getParameter("devlType"));
String groupName    = ""; // ut.inject(request.getParameter("groupName"));
String groupInfo1   = ""; // ut.inject(request.getParameter("groupInfo1"));
int groupPrice	    = 0;  //ut.inject(request.getParameter("groupPrice"));
int totalPrice      = 0;  //Integer.parseInt(ut.inject(request.getParameter("totalPrice")));
int salePrice      = 0;

//System.out.println("groupId : "+groupId);

String devlGoodsType			= "";
String devlFirstDay		= "";
String devlModiDay		= "";
String devlWeek3		= "";
String devlWeek5		= "";

String[] arrDevlWeek3 = null;
String[] arrDevlWeek5 = null;
boolean isDevlWeek = false;

Map<String, Object> cartMap = new HashMap(); //-- 장바구니정보
List<Map> infoNoticeList = new ArrayList(); //-- 상품정보


Statement stmt1		= null;
ResultSet rs1		= null;
Statement stmt2		= null;
ResultSet rs2		= null;
Statement stmt3		= null;
ResultSet rs3		= null;
Statement stmt4		= null;
ResultSet rs4		= null;
stmt1				= conn.createStatement();
stmt2				= conn.createStatement();
stmt3				= conn.createStatement();
stmt4				= conn.createStatement();
String gubun1	  = "";
// String groupName  = "";
String groupInfo = "";
// String groupInfo1 = "";
String saleTitle    = "";
String aType 	  = "";
String bType 	  = "";
int kalInfo		  = 0;
int groupPrice1   = 0;
// int totalPrice	  = 0;
int bTypeNum	  = 0;
String cartImg	  = "";
String groupImg	  = "";
String groupCode  = "";
String gubun2	  = "";
String tag		  = "";
double dBtype;
int bagCnt			= 0;

//-- 장바구니 정보
query		= "SELECT ID,  MEMBER_ID,  GROUP_ID,  BUY_QTY,  DEVL_TYPE,  DEVL_DAY,  DEVL_WEEK,  DEVL_DATE,  PRICE,  INST_DATE,  BUY_BAG_YN,  CART_TYPE,  ORDER_YN,  SS_TYPE ";
query		+= " FROM ESL_CART ";
query		+= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND ID = "+ cartId;
rs1	= stmt.executeQuery(query);
if(rs1.next()){
	cartMap.put("ID",				rs1.getString("ID"));
	cartMap.put("MEMBER_ID",		rs1.getString("MEMBER_ID"));
	cartMap.put("GROUP_ID",			rs1.getString("GROUP_ID"));
	cartMap.put("BUY_QTY",			rs1.getString("BUY_QTY"));
	cartMap.put("DEVL_TYPE",		rs1.getString("DEVL_TYPE"));
	cartMap.put("DEVL_DAY",			rs1.getString("DEVL_DAY"));
	cartMap.put("DEVL_WEEK",		rs1.getString("DEVL_WEEK"));
	cartMap.put("DEVL_DATE",		rs1.getString("DEVL_DATE"));
	cartMap.put("PRICE",			rs1.getString("PRICE"));
	cartMap.put("BUY_BAG_YN",		rs1.getString("BUY_BAG_YN"));
	groupId = rs1.getString("GROUP_ID");
}
else{
	out.println("장바구니 정보가 없습니다.");
	return;
}
rs1.close();


//-- 상품정보
query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
query		+= " WHERE NOTICE_TYPE='INFO' AND GOODS_GROUP_ID = "+ groupId;
rs1	= stmt.executeQuery(query);
while(rs1.next()){
	Map noticeMap = new HashMap();
	noticeMap.put("id",rs1.getString("ID"));
	noticeMap.put("title",rs1.getString("NOTICE_TITLE"));
	noticeMap.put("content",rs1.getString("NOTICE_CONTENT"));
	infoNoticeList.add(noticeMap);
}
rs1.close();

/*
query4		= "SELECT COUNT(*) PURCHASE_CNT FROM ESL_ORDER O, ESL_ORDER_GOODS OG WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.MEMBER_ID = '"+ eslMemberId +"' AND ((O.ORDER_STATE > 0 AND O.ORDER_STATE < 90) OR O.ORDER_STATE = '911') AND OG.DEVL_TYPE = '0001'";
try {
	rs4	= stmt4.executeQuery(query4);
} catch(Exception e) {
	out.println(e+"=>"+query4);
	if(true)return;
}

if (rs4.next()) {
	bagCnt		= rs4.getInt("PURCHASE_CNT");
}
*/

//-- 상품 정보
query		= "SELECT ";
query		+= " (SELECT TITLE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS SALE_TITLE, ";
query		+= " (SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS ATYPE, ";
query		+= " (SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS BTYPE, ";
query		+= "  GUBUN1, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1, KAL_INFO, GROUP_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5";
query		+= " FROM ESL_GOODS_GROUP EGG ";
query		+= "  WHERE USE_YN = 'Y' ";
query		+= " AND LIST_VIEW_YN = 'Y' ";
query		+= " AND ID=" + groupId;
rs1 = stmt1.executeQuery(query);
if(rs1.next()){
	saleTitle	= ut.isnull(rs1.getString("SALE_TITLE") );
	aType		= rs1.getString("ATYPE");
	bType		= rs1.getString("BTYPE");
	gubun1		= rs1.getString("GUBUN1");
	groupCode	= rs1.getString("GROUP_CODE");
	groupName   = rs1.getString("GROUP_NAME");
	groupPrice  = rs1.getInt("GROUP_PRICE");
	groupPrice1 = rs1.getInt("GROUP_PRICE1");
	groupInfo	= rs1.getString("GROUP_INFO");
	groupInfo1  = rs1.getString("GROUP_INFO1");
	kalInfo 	= rs1.getInt("KAL_INFO");
	cartImg		= rs1.getString("CART_IMG");
	groupImg	= rs1.getString("GROUP_IMGM");
	gubun2		= rs1.getString("GUBUN2");
	tag			= rs1.getString("TAG");
	devlGoodsType			= ut.isnull(rs1.getString("DEVL_GOODS_TYPE") );
	devlFirstDay		= ut.isnull(rs1.getString("DEVL_FIRST_DAY") );
	devlModiDay			= ut.isnull(rs1.getString("DEVL_MODI_DAY") );
	devlWeek3			= ut.isnull(rs1.getString("DEVL_WEEK3") );
	devlWeek5			= ut.isnull(rs1.getString("DEVL_WEEK5") );


	if(!ut.isNaN(devlFirstDay) || "".equals(devlFirstDay) ) devlFirstDay = "0";
	if(!ut.isNaN(devlModiDay) || "".equals(devlModiDay) ) devlModiDay = "0";

	if(!"".equals(devlWeek3)){
		arrDevlWeek3 = devlWeek3.split(",");
		isDevlWeek = true;
	}
	if(!"".equals(devlWeek5)){
		arrDevlWeek5 = devlWeek5.split(",");
		isDevlWeek = true;
	}

	salePrice = groupPrice;
 	if(bType != null){
 		if(aType.equals("P")){
 			dBtype = Integer.parseInt(bType)/100.0;
 			salePrice = groupPrice - (int)(groupPrice * dBtype); // %세일 계산
 			System.out.println(salePrice);
 		}else if(aType.equals("W")){
 			salePrice = groupPrice - Integer.parseInt(bType);
 		}
 	}
}

if("0300993".equals(groupCode) ){ //-- 미니밀일경우 한식수량,양식수량을 더한다.
	//-- 한식수량
	query		= "SELECT BUY_CNT ";
	query		+= " FROM ESL_CART_DELIVERY ";
	query		+= " WHERE GROUP_CODE = '0301000' AND CART_ID = "+ cartId;
	rs1	= stmt.executeQuery(query);
	if(rs1.next()){
		cartMap.put("BUY_QTY2",rs1.getString("BUY_CNT"));
	}
	else{
		cartMap.put("BUY_QTY2","0");
	}
	rs1.close();

	//-- 양식수량
	query		= "SELECT BUY_CNT ";
	query		+= " FROM ESL_CART_DELIVERY ";
	query		+= " WHERE GROUP_CODE = '0301001' AND CART_ID = "+ cartId;
	rs1	= stmt.executeQuery(query);
	if(rs1.next()){
		cartMap.put("BUY_QTY3",rs1.getString("BUY_CNT"));
	}
	else{
		cartMap.put("BUY_QTY3","0");
	}
	rs1.close();

}

DecimalFormat df 	= new DecimalFormat("#,###");

//-- 휴무일정보
query       = "SELECT DATE_FORMAT(HOLIDAY, '%Y.%m.%d') HOLIDAY, HOLIDAY_NAME";
query       += " FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY_TYPE = '02' ";
query       += " ORDER BY HOLIDAY DESC, ID DESC";
pstmt       = conn.prepareStatement(query);
rs        = pstmt.executeQuery();

ArrayList<String> holiDay = new ArrayList();
while (rs.next()) {
    holiDay.add(rs.getString("HOLIDAY"));
}
rs.close();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>옵션 변경</title>
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/dist/images/ico/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;">
</div>
	<div class="pop-wrap ff_noto">
		<div class="headpop">
		    <h2>옵션 변경</h2>
		</div>
	    <div class="contentpop">
			<div id="setOptionsCal">
        		<form action="" name="optionForm">
			        <input type="hidden" name="devlWeek" id="opt_devlWeek" value="">
			        <input type="hidden" name="devlDay" id="opt_devlDay" value="">
					<input type="hidden" name="devlWeekEnd" id="opt_devlWeekEnd" value="">
			        <input type="hidden" name="groupId" id="opt_groupId" value="<%=groupId%>">
			        <input type="hidden" name="groupCode" id="opt_groupCode" value="<%=groupCode%>">
			        <input type="hidden" name="devlType" id="opt_devlType" value="<%=devlGoodsType%>">
		        	<input type="hidden" name="buyBagYn" id="opt_buyBagYn" value="<%=cartMap.get("BUY_BAG_YN")%>">
		        	<input type="hidden" name="pcAndMobileType" id="opt_pcAndMobileType" value="pc">
					<input type="hidden" name="totalPrice" id="opt_totalPrice" value="">
<%
if(infoNoticeList != null && !infoNoticeList.isEmpty() ){
%>
					<div class="prd_info">
		        		<div class="title">상품정보</div>
		        		<div class="tableBox">
		        			<table>
			        			<colgroup>
									<col width="29.5%"/>
									<col width="*"/>
								</colgroup>
								<tbody>
<%
	for(Map nMap : infoNoticeList){
%>
									<tr>
										<th><%=nMap.get("title") %></th>
										<td><%=nMap.get("content") %></td>
									</tr>
<%
	}
%>
								</tbody>
			        		</table>
		        		</div>
		        	</div>
<%
}
%>
					<table>
						<colgroup>
							<col width="29.5%">
							<col width="*">
						</colgroup>
						<tbody>
<%
if(devlGoodsType.equals("0001")){
	if(isDevlWeek){//-- 일일배송 선택할것이 있다면
		if("02".equals(gubun1)){ //-- 프로그램 다이어트는 요일과 기간이 정해져 있다.
			if(!"".equals(devlWeek3)){
%>
						<input type="hidden" name="selectDevlDay" id="opt_selectDevlDay" value="3">
						<input type="hidden" name="selectDevlWeek" id="opt_selectDevlWeek" value="<%=devlWeek3%>">
<%
			}
			else{
%>
						<input type="hidden" name="selectDevlDay" id="opt_selectDevlDay" value="5">
						<input type="hidden" name="selectDevlWeek" id="opt_selectDevlWeek" value="<%=devlWeek5%>">
<%
			}
		}
		else{
%>
						<tr>
							<th>배송 요일</th>
							<td>
							<div class="opt_select_group selectWrap" id="opt_selectDevlDay" name="selectDevlDay">
								<select name="selectDevlDay" id="opt_selectDevlDay" class="notCustom">
									<% if(arrDevlWeek5 != null){ %><option value="5"<%="5".equals((String)cartMap.get("DEVL_DAY")) ? " selected":"" %>>주 5회 (월~금)</option><% } %>
									<% if(arrDevlWeek3 != null){ %><option value="3"<%="3".equals((String)cartMap.get("DEVL_DAY")) ? " selected":"" %>>주 3회 (월/수/금)</option><% } %>
								</select>
							</div>
							</td>
						</tr>
						<tr>
							<th>배송 기간</th>
							<td>
							<div class="selectWrap">
							<select name="selectDevlWeek" id="opt_selectDevlWeek" class="notCustom">
<%
			String[] arrFor = null;
			if("5".equals((String)cartMap.get("DEVL_DAY"))){
				arrFor = arrDevlWeek5;
			}
			else{
				arrFor = arrDevlWeek3;
			}
			for(int forCt = 0; forCt < arrFor.length;forCt++){
%>
								<option value="<%=arrFor[forCt]%>"<%=arrFor[forCt].equals((String)cartMap.get("DEVL_WEEK")) ? " selected":"" %>><%=arrFor[forCt]%>주</option>
<%
			}
%>
							</select>
							</div>
							</td>
						</tr>
<%
		} //if("02".equals(gubun1)){} else
	} //if(isDevlWeek){ %>
						<tr>
							<th>수량</th>
							<td>
								<div class="inp_quantity">
				        			<input type="text" class="inp_qtt_text only_number" name="buyQty" id="opt_buyQty" value="<%=cartMap.get("BUY_QTY")%>">
				        			<button type="button" class="inp_qtt_minus" onclick="optQuantityFn.minus();">-</button>
				        			<button type="button" class="inp_qtt_plus" onclick="optQuantityFn.plus();">+</button>
				        		</div>
							</td>
						</tr>
						<tr>
							<th>첫 배송일</th>
							<td>
								<div class="inp_datepicker">
									<input type="text" id="opt_day" name="day" class="dp-applied opt-date-pick" readonly value="<%=cartMap.get("DEVL_DATE")%>"/>
								</div>
							</td>
						</tr>
						<% if("0301590".equals(groupCode)){ %>	
						<tr>
							<th>주말식단</th>
							<td>
								<div class="inp_thermos">
									<input type="checkbox" id="opt_buy_weekend" name="buy_weekend" checked="checked"/>
									<label for="opt_buy_weekend">토 포함</label>
									<p>주말식단은 금요일에 함께 배송됩니다.</p>
								</div>
							</td>
						</tr>
						<% } %>
						<tr>
							<th>보냉가방</th>
							<td>
								<div class="inp_thermos">

									<p>주문하신 식단은 잇슬림 전용 대여용 보냉가방과 함께 신선하게 배송됩니다.</p>
								</div>
							</td>
						</tr>
<%
} //if(devlGoodsType.equals("0001")){
else{
%>
						<input type="hidden" name="selectDevlDay" id="opt_selectDevlDay" value="0">
						<input type="hidden" name="selectDevlWeek" id="opt_selectDevlWeek" value="0">
						<tr>
							<th>수량</th>
							<td>
				        		<ul>
<% if(!"0300993".equals(groupCode)){ %>
									<li>
										<div class="inp_quantity">
						        			<input type="text" class="inp_qtt_text only_number" name="buyQty" id="opt_buyQty" value="<%=cartMap.get("BUY_QTY")%>">
						        			<button type="button" class="inp_qtt_minus" onclick="optQuantityFn.minus();">-</button>
						        			<button type="button" class="inp_qtt_plus" onclick="optQuantityFn.plus();">+</button>
						        		</div>
									</li>
<% } else { %>
									<li>
										<div class="opt_title">한식세트</div>
										<div class="inp_quantity">
						        			<input type="text" class="inp_qtt_text only_number" name="buyQty2" id="opt_buyQty2" value="<%=cartMap.get("BUY_QTY2")%>">
						        			<button type="button" class="inp_qtt_minus" onclick="optQuantityFn2.minus();">-</button>
						        			<button type="button" class="inp_qtt_plus" onclick="optQuantityFn2.plus();">+</button>
						        		</div>
									</li>
									<li>
										<div class="opt_title">양식세트</div>
										<div class="inp_quantity">
						        			<input type="text" class="inp_qtt_text only_number" name="buyQty3" id="opt_buyQty3" value="<%=cartMap.get("BUY_QTY3")%>">
						        			<button type="button" class="inp_qtt_minus" onclick="optQuantityFn3.minus();">-</button>
						        			<button type="button" class="inp_qtt_plus" onclick="optQuantityFn3.plus();">+</button>
						        		</div>
									</li>
<% } %>
								</ul>
							</td>
						</tr>
<%
}
%>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2">
							<% if(groupPrice != salePrice){ %><span class="event_area"><%=saleTitle%></span><% } %>
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<%
							if(groupPrice == salePrice){
								%>
								<span><strong id="opt_sumPrice">&nbsp;</strong></span>
								<%
							}else{
								%>
								<del id="opt_orgPrice">&nbsp;</del><span><strong id="opt_sumPrice">&nbsp;</strong></span>
								<p><span></span></p>
								<!-- (3월 특별 고객할인 이벤트가) -->
								<%
							}
							%>
							</td>
						</tr>
						</tfoot>
					</table>
				</form>
            </div>
			<div class="bottom_btn_area">
                <button type="button" id="btnOptionForm" class="btn btn_dgray huge">장바구니 담기</button>
		</div>
		<!-- End contentpop -->
	</div>
</body>
<script>
var optGroupCode = '<%=groupCode%>';
var optSaleTotalPrice = "";
var optGoodsTotalPrice = "";
var optIsDevlWeek = <%=isDevlWeek%>;
var optSalePrice = <%=salePrice%>;
var optGoodsPrice = <%=groupPrice%>;
var optHour =  new Date().getHours();
var optMinDate = <%=devlFirstDay%>;
var optGubun1 = "<%=gubun1%>";
//if(optGroupCode == "0301369"){ //헬씨퀴진만 3시 이후되면 1일을 더한다.
	if(optHour >= 15){
		optMinDate += 1;
	}
//}


if(optIsDevlWeek){
	if(optGubun1 != "02"){
		$("#opt_devlDay").val($('#opt_selectDevlDay option:selected').val());
		$("#opt_devlWeek").val($('#opt_selectDevlWeek option:selected').val());
	}
	else{
		$("#opt_devlDay").val($('#opt_selectDevlDay').val());
		$("#opt_devlWeek").val($('#opt_selectDevlWeek').val());
	}

	if($("input:checkbox[id='opt_buy_bag']").is(":checked") == true){
		$("#opt_buyBagYn").val("Y");
	}else if($("input:checkbox[id='opt_buy_bag']").is(":checked") == false){
		$("#opt_buyBagYn").val("N");
	}

	if($("input:checkbox[id='opt_buy_weekend']").is(":checked") == true){
		$("#opt_devlWeekEnd").val("1");
	}else if($("input:checkbox[id='opt_buy_weekend']").is(":checked") == false){
		$("#opt_devlWeekEnd").val("0");
	}
}



$("#opt_buy_bag").change(function(){

	if($(this).is(":checked") == true){
		$("#opt_buyBagYn").val("Y");
	   	optCalAmount();

	}else{
		if (confirm("신선한 제품 배송을 위해서는 보냉가방이\r\n꼭 필요합니다.\r\n체크박스를 해제 하시겠습니까?")){
			$("#opt_buyBagYn").val("N");
			optCalAmount();
		} else {
			$(this).prop("checked", true);
		}
	}
});

$("#opt_buy_weekend").change(function(){
	if($(this).is(":checked") == true){
		$("#opt_devlWeekEnd").val("1");
	   	optCalAmount();
	}else{
		$("#opt_devlWeekEnd").val("0");
		optCalAmount();
	}
});

Date.prototype.addDays = function(days) {
    this.setDate(this.getDate() + parseInt(days));
    return this;
};

var holiDays = new Array();
<%
for(int i=0; i<holiDay.size(); i++){
%>
    holiDays[<%=i%>]='<%=holiDay.get(i)%>';
<%
}
%>
$(".opt-date-pick").datepick({
    dateFormat: "yyyy.mm.dd",
    minDate: optMinDate,
    showTrigger: '#calImg',
    showAnim: 'slideDown',
    changeMonth: false,
    onDate: function(date) {
    	var currentYear = date.getFullYear(),
	    	currentMonth = date.getMonth()+1,
	    	currentDate = date.getDate(),
	   		currentToday = currentYear +"."+ (currentMonth<10 ? "0"+currentMonth : currentMonth) +"."+ (currentDate<10 ? "0"+currentDate : currentDate);

	   	for (i = 0; i < holiDays.length; i++) {
	   		if (currentToday == holiDays[i]) {
	   			return {dateClass: '-holiday-', selectable: false};
	   		}
	   	}
		return {};
    }
});
		//     $('#pop_scheduler').data('datepicker');

$(":input").filter(".only_number").css("imeMode", "disabled").keypress(function(event){
	if (event.which && (event.which < 48 || event.which > 57)){
		event.preventDefault();
	}
});


 	// 옵션변경 수량선택
    var optQuantityFn = {
    	onSet : function(i){
    		$("#opt_buyQty").val(i);
    	},
    	plus : function(){
    		var $val = $("#opt_buyQty").val();
    		var i = Number($val)+1;
    		optQuantityFn.onSet(i);
		   	optCalAmount();
    	},
    	minus : function(){
    		var $val = $("#opt_buyQty").val();
    		var i = Number($val)-1;
    		if(i < 1) {
    			alert("수량은 1개 이상 선택해주세요.");
    			return false;
   			}else{
   				optQuantityFn.onSet(i);
   			   	optCalAmount();
   			}
    	}
    }
    var optQuantityFn2 = {
        	onSet : function(i2){
        		$("#opt_buyQty2").val(i2);
        	},
        	plus : function(){
        		var $val2 = $("#opt_buyQty2").val();
        		var i2 = Number($val2)+1;
        		optQuantityFn2.onSet(i2);
    		   	optCalAmount();
        	},
        	minus : function(){
        		var $val2 = $("#opt_buyQty2").val();
        		var $val3 = $("#opt_buyQty3").val();
        		var i2 = Number($val2)-1;
        		var i3 = Number($val3);
        		if(i2 < 0) {
        			i2 = 0;
       			}
				if((i2+i3) < 2) {
        			alert("최소 주문은 2Set부터 가능합니다.");
        			return false;
       			}else{
       				optQuantityFn2.onSet(i2);
       			   	optCalAmount();
       			}
        	}
        }
    var optQuantityFn3 = {
        	onSet : function(i3){
        		$("#opt_buyQty3").val(i3);
        	},
        	plus : function(){
        		var $val3 = $("#opt_buyQty3").val();
        		var i3 = Number($val3)+1;
        		optQuantityFn3.onSet(i3);
    		   	optCalAmount();
        	},
        	minus : function(){
        		var $val2 = $("#opt_buyQty2").val();
        		var $val3 = $("#opt_buyQty3").val();
        		var i2 = Number($val2);
        		var i3 = Number($val3)-1;
        		if(i3 < 1) {
        			i3 = 0;
       			}
        		if((i2+i3) < 2) {
        			alert("최소 주문은 2Set부터 가능합니다.");
        			return false;
       			}else{
       				optQuantityFn3.onSet(i3);
       			   	optCalAmount();
       			}
        	}
        }

    // 3일 5일 구분
    var optOptionWeek = {"week3":"<%=devlWeek3%>","week5":"<%=devlWeek5%>"};
   	$('#opt_selectDevlDay').change(function(){
   		var arrOptionWeek = optOptionWeek["week"+$(this).find("option:selected").val()].split(",");
   		$("#opt_selectDevlWeek option").remove();
   		for(var forCt = 0; forCt < arrOptionWeek.length; forCt++){
   			$('#opt_selectDevlWeek').append("<option value='" + arrOptionWeek[forCt] + "'>" + arrOptionWeek[forCt] + "주</option>");
   		}
   		$('#opt_selectDevlWeek > option[value="2"]').attr('selected', 'true');
   		$("#opt_devlWeek").val($("#opt_selectDevlWeek option:selected").val());
   		$("#opt_devlDay").val($('#opt_selectDevlDay option:selected').val());
   		optCalAmount();
    });

    // 배송기간 선택시 가격 실시간으로 변동
    $('#opt_selectDevlWeek').change(function(){
       $("#opt_devlWeek").val($('#opt_selectDevlWeek option:selected').val());
       optCalAmount();
    });

    // 수량 직접 입력시
    $('#opt_buyQty').on("keyup",function(e) {
        var ct = $(this).val();
        if(isNaN(ct) || 1 > parseInt(ct)){
        	$('#opt_buyQty').val(1);
        }
        optCalAmount();
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
		return str;
    }


    //-- 금액을 계산한다.
    function optCalAmount(){
    	if(optGroupCode == "0300993"){ //-- 미니밀일경우 한식,양식세트로 적용
	   		optSaleTotalPrice	= optSalePrice * (parseInt($("#opt_buyQty2").val()) + parseInt($("#opt_buyQty3").val()));
	   		if(optSalePrice != optGoodsPrice){
		   		optGoodsTotalPrice	= optGoodsPrice * (parseInt($("#opt_buyQty2").val()) + parseInt($("#opt_buyQty3").val()));
	   		}
    	}
    	else{
	    	if(optIsDevlWeek && optGubun1 != "02"){ //-- 요일체크이면서 프로그램다이어트가 아닌상품
		   		optSaleTotalPrice	= optSalePrice * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val());


		   		if(optSalePrice != optGoodsPrice){
			   		optGoodsTotalPrice	= optGoodsPrice * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val());
		   		}

		   	}else{
		   		optSaleTotalPrice	= optSalePrice * parseInt($("#opt_buyQty").val());
		   		if(optSalePrice != optGoodsPrice){
			   		optGoodsTotalPrice	= optGoodsPrice * parseInt($("#opt_buyQty").val());
		   		}
		   	}
    	}
    	if($("#opt_buyBagYn").val() == "Y") optSaleTotalPrice += 4000;
    	$("#opt_totalPrice").val(optSaleTotalPrice);
		$("#opt_sumPrice").html(totalComma(optSaleTotalPrice)+"원");
		if(optSalePrice != optGoodsPrice){
			$("#opt_orgPrice").html(totalComma(optGoodsTotalPrice)+"원");
   		}
    }

    $(function(){
    	optCalAmount();
    });

 	var eslMemberId = '<%=eslMemberId%>';
    $("#btnOptionForm").click(function(){
	   	if(eslMemberId != ""){
		 	if(optIsDevlWeek && $("#opt_day").val() == ""){
		 		alert("배송일을 선택해 주세요.");
		 	}
		 	else{

		 		if(optIsDevlWeek && optGubun1 != "02"){
		 			$("#opt_devlDay").val($('#opt_selectDevlDay option:selected').val());
		 			$("#opt_devlWeek").val($('#opt_selectDevlWeek option:selected').val());
		 		}
		 		else{
		 			$("#opt_devlDay").val($('#opt_selectDevlDay').val());
		 			$("#opt_devlWeek").val($('#opt_selectDevlWeek').val());
		 		}

		    	var queryString = $("form[name=optionForm]").serialize() ;

		    	$.ajax({
		            url : "/mobile/shop/order/__ajax_goods_set_options_path.jsp",
		            type : 'post',
		            data : queryString,
		    		dataType : "json",
		            async : true,
		            success : function(data){
		            	if(data.code == "success"){
		            		top.location.reload();
		            		//$(".jquery-lightbox-button-close").click();
		            	}
		            	else{
		            		alert(data.data);
		            	}
		            },
		            error : function(a,b,c){
		                alert('error : ' + c);
		                moving = false;
		            }
		        })
		 	}
	   	}else{
	   		alert("로그인을 먼저 하시기 바랍니다.");
	   		var url = "/shop/popup/loginCheck.jsp";
	   		$.lightbox(url, {
	            width  : 640,
	            height : 740
	        });
	   	}

    });
    //-- 장바구니값 설정
</script>

</html>