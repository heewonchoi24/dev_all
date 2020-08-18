<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%
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
Calendar cal		= Calendar.getInstance();
String groupId		= ut.inject(request.getParameter("groupId"));
String devlType		= ""; // ut.inject(request.getParameter("devlType"));
String groupName    = ""; // ut.inject(request.getParameter("groupName"));
String groupInfo1   = ""; // ut.inject(request.getParameter("groupInfo1"));
int groupPrice	    = 0;  //ut.inject(request.getParameter("groupPrice"));
int totalPrice      = 0; //Integer.parseInt(ut.inject(request.getParameter("totalPrice")));
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

List<Map> infoNoticeList = new ArrayList(); //-- ��ǰ����


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

String minDate = "";


//-- ��ǰ����
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

//-- �޹�������
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

//-- ��ǰ ����
query		= "SELECT ";
query		+= " (SELECT TITLE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS SALE_TITLE, ";
query		+= " (SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS ATYPE, ";
query		+= " (SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS BTYPE, ";
query		+= " GUBUN1, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1, KAL_INFO, GROUP_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5";
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
	if(!ut.isNaN(devlModiDay) || "".equals(devlFirstDay) ) devlModiDay = "0";

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
 			salePrice = groupPrice - (int)(groupPrice * dBtype); // %���� ���
 			//System.out.println(salePrice);
 		}else if(aType.equals("W")){
 			salePrice = groupPrice - Integer.parseInt(bType);
 		}
 	}

 	//-- ù��۽��۰�����
 	int optMinDate = Integer.parseInt(devlFirstDay);
 	if("0301369".equals(groupCode) && 150000 <= Integer.parseInt(ut.getTimeStamp(10))){
 		//-- �ﾾ������ ����3�� �����̸� 2�� ���ĸ� 3�Ϸ� ó��
 		optMinDate += 1;
 	}
 	cal.add(Calendar.DATE, optMinDate);
 	minDate		= dt.format(cal.getTime());

}
DecimalFormat df 	= new DecimalFormat("#,###");
%>
<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/expansion.css">
<div id="setOptionsCal">
    <div class="inner">
        <header class="pop_header"><h1>�ɼ� ����</h1></header>
        <div class="pop_content">

		<div class="title"><%=groupName%></div>

<%
if(infoNoticeList != null && !infoNoticeList.isEmpty() ){
%>
		<div class="prd_info">
       		<div class="title">��ǰ����</div>
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
        <form action="" name="optionForm">
        	<input type="hidden" name="cartInstType" value="new">
	        <input type="hidden" name="devlWeek" id="opt_devlWeek" value="">
	        <input type="hidden" name="devlDay" id="opt_devlDay" value="">
	        <input type="hidden" name="groupId" id="opt_groupId" value="<%=groupId%>">
	        <input type="hidden" name="groupCode" id="opt_groupCode" value="<%=groupCode%>">
	        <input type="hidden" name="devlType" id="opt_devlType" value="<%=devlGoodsType%>">
	       	<input type="hidden" name="buyBagYn" id="opt_buyBagYn" value="">
	       	<input type="hidden" name="pcAndMobileType" id="opt_pcAndMobileType" value="mobile">
			<input type="hidden" name="totalPrice" id="opt_totalPrice" value="">
<%
if(devlGoodsType.equals("0001")){
	if(isDevlWeek){//-- ���Ϲ�� �����Ұ��� �ִٸ�
		if("02".equals(gubun1)){ //-- ���α׷� ���̾�Ʈ�� ���ϰ� �Ⱓ�� ������ �ִ�.
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
        	<div class="opt_select_group  ty2" id="opt_selectDevlDay" name="selectDevlDay">
        		<span class="h">��� ����</span>
				<select name="selectDevlDay" id="opt_selectDevlDay" class="inp_st inp_st100p">
					<% if(arrDevlWeek5 != null){ %><option value="5">�� 5ȸ (��~��)</option><% } %>
					<% if(arrDevlWeek3 != null){ %><option value="3">�� 3ȸ (��/��/��)</option><% } %>
				</select>
        	</div>
        	<div class="opt_select_group ty2">
        		<span class="h">��� �Ⱓ</span>
				<select name="selectDevlWeek" id="opt_selectDevlWeek" class="inp_st inp_st100p">
<%
			String[] arrFor = null;
			if(arrDevlWeek5 != null){
				arrFor = arrDevlWeek5;
			}
			else{
				arrFor = arrDevlWeek3;
			}
			for(int forCt = 0; forCt < arrFor.length;forCt++){
%>
					<option value="<%=arrFor[forCt]%>"><%=arrFor[forCt]%>��</option>
<%
			}
%>
				</select>
        	</div>
<%
		} //if("02".equals(gubun1)){} else
	} //if(isDevlWeek){ %>

        	<div class="opt_select_group ty2">
        		<span class="h">����</span>
				<div class="inp_quantity">
        			<input type="text" class="inp_qtt_text only_number" name="buyQty" id="opt_buyQty" value="1">
        			<button type="button" class="inp_qtt_minus" onclick="optQuantityFn.minus();">-</button>
        			<button type="button" class="inp_qtt_plus" onclick="optQuantityFn.plus();">+</button>
        		</div>
        	</div>

        	<div class="opt_select_date ty2">

        		<span class="h">ù �����</span>
        		<span onclick="cal_on();">
	            	<input type="text" class="dayText"  id="dayText" name="day_cron" value="ù ����� ����" readonly>
	            	<input type="hidden" id="opt_day" name="day" value="">
	                <button type="button" class=""></button>
                </span>
            </div>
            <div id="option_scheduler"></div>

        	<div class="opt_select_group">
		<%
			if(bagCnt < 1){
				%>
				<input type="checkbox" id="opt_buy_bag" name="buy_bag" checked="checked" disabled="disabled"/>
				<%
			}else if(bagCnt > 0){
				%>
				<input type="checkbox" id="opt_buy_bag" name="buy_bag"/>
				<%
			}
		%>
				<label for="opt_buy_bag"><span></span><strong class="f16">���ð��� ���� (4,000��)</strong></label>
				<p>���ð����� �ʼ��� �����ϼž� ��ǰ�� �ż��ϰ� ��۹����� �� �ֽ��ϴ�.</p>
        	</div>
<%
} //if(devlGoodsType.equals("0001")){
else{
%>
			<input type="hidden" name="selectDevlDay" id="opt_selectDevlDay" value="0">
			<input type="hidden" name="selectDevlWeek" id="opt_selectDevlWeek" value="0">

        	<div class="opt_select_group ty2">
        		<span class="h">����</span>
				<div class="inp_quantity">
	        		<ul>
<% if(!"0300993".equals(groupCode)){ %>
						<li>
							<div class="inp_quantity">
			        			<input type="text" class="inp_qtt_text only_number" name="buyQty" id="opt_buyQty" value="1">
			        			<button type="button" class="inp_qtt_minus" onclick="optQuantityFn.minus();">-</button>
			        			<button type="button" class="inp_qtt_plus" onclick="optQuantityFn.plus();">+</button>
			        		</div>
						</li>
<% } else { %>
						<li>
							<div class="opt_title">�ѽļ�Ʈ</div>
							<div class="inp_quantity">
			        			<input type="text" class="inp_qtt_text only_number" name="buyQty2" id="opt_buyQty2" value="1">
			        			<button type="button" class="inp_qtt_minus" onclick="optQuantityFn2.minus();">-</button>
			        			<button type="button" class="inp_qtt_plus" onclick="optQuantityFn2.plus();">+</button>
			        		</div>
						</li>
						<li>
							<div class="opt_title">��ļ�Ʈ</div>
							<div class="inp_quantity">
			        			<input type="text" class="inp_qtt_text only_number" name="buyQty3" id="opt_buyQty3" value="1">
			        			<button type="button" class="inp_qtt_minus" onclick="optQuantityFn3.minus();">-</button>
			        			<button type="button" class="inp_qtt_plus" onclick="optQuantityFn3.plus();">+</button>
			        		</div>
						</li>
<% } %>
					</ul>
				</div>
       		</div>
<%
}
%>
        	<div class="options_total">
<%
if(groupPrice == salePrice){
%>
				<p><span><strong id="opt_sumPrice">&nbsp;</strong></span></p>
<%
}else{
%>
				<p><del id="opt_orgPrice">&nbsp;</del><span><strong id="opt_sumPrice">&nbsp;</strong></span><p>
				<% if(groupPrice != salePrice){ %><p><span><%=saleTitle%></span></p><% } %>
<%
}
%>
        	</div>

            <div class="bottom_btn_area">
                <!-- <button type="button" class="btn btn_dgray huge" onclick="$('.pop_close').trigger('click');">�����ϱ�</button> -->
					<%
						if ( "0301544".equals(groupCode) || "0301546".equals(groupCode) || "0301547".equals(groupCode) || "0301548".equals(groupCode) || "0301549".equals(groupCode) || "0331".equals(groupCode) || "0300978".equals(groupCode)) {
					%>
							<span>���� ���Ű� �Ұ����� ��ǰ�Դϴ�.</span>
					<%
						} else {
					%>				
                <button type="button" id="btnOptionForm" class="btn btn_white huge">��ٱ��� ���</button>
                <button type="button" id="btnOptionFormOrder" class="btn btn_dgray huge btn_order">�ٷ� �ֹ��ϱ�</button>
					<%
						}
					%>				
            </div>
            </form>
        </div>
    </div>
</div>
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
if(optGroupCode == "0301369"  || optGroupCode == "0301590" || optGroupCode == "0301079"){ //3�� ���ĵǸ� 1���� ���Ѵ�.
	if(optHour >= 15){
		optMinDate += 1;
	}
}


if(optIsDevlWeek){
	if(true || optGroupCode != "0331"){
		$('#opt_selectDevlWeek > option[value="2"]').attr('selected', 'true');
	}

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


}

$("#opt_buy_bag").change(function(){
	if($(this).is(":checked") == true){
		$("#opt_buyBagYn").val("Y");
	   	optCalAmount();
	}else{
		$("#opt_buyBagYn").val("N");
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
$('#option_scheduler').datepicker({
	dateFormat: "yyyy-mm-dd",
	range :     false,
    toggleSelected: false,
    onlyDateSelect : true,
    inline :    true,
    language :  "ko",
    /* minDate : new Date(), */
    minDate : new Date('<%=minDate%>'),
    navTitles: {
        days: '<i>yyyy</i>. MM'
    },
    onRenderCell : function(date, cellType)  {
    	var	currentYear = date.getFullYear();
        var currentMonth = date.getMonth()+1;
    	var currentDate = date.getDate();
    	var currentToday = currentYear +"."+ (currentMonth<10 ? "0"+currentMonth : currentMonth) +"."+ (currentDate<10 ? "0"+currentDate : currentDate);
        if(cellType == 'day'){
        	if ((date >= new Date()) && (date <= optMinDate)){
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
    	/*
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
    	//$("#opt_day").val(thisDate);
    	*/
    	$("#dayText").val(fd);
    	$("#opt_day").val(fd);
    	$("#option_scheduler").hide().removeClass("on");
    }
});


/*
$(".opt-date-pick").datepick({
    dateFormat: "yyyy-mm-dd",
    minDate: optMinDate,
    showTrigger: '#calImg'
});
*/
		//     $('#pop_scheduler').data('datepicker');

$(":input").filter(".only_number").css("imeMode", "disabled").keypress(function(event){
	if (event.which && (event.which < 48 || event.which > 57)){
		event.preventDefault();
	}
});


 	// �ɼǺ��� ��������
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
    			alert("������ 1�� �̻� �������ּ���.");
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
        			alert("�ּ� �ֹ��� 2Set���� �����մϴ�.");
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
        		if(i3 < 0) {
        			i3 = 0;
       			}
        		if((i2+i3) < 2) {
        			alert("�ּ� �ֹ��� 2Set���� �����մϴ�.");
        			return false;
       			}else{
       				optQuantityFn3.onSet(i3);
       			   	optCalAmount();
       			}
        	}
        }

    // 3�� 5�� ����
    var optOptionWeek = {"week3":"<%=devlWeek3%>","week5":"<%=devlWeek5%>"};
   	$('#opt_selectDevlDay').change(function(){
   		var arrOptionWeek = optOptionWeek["week"+$(this).find("option:selected").val()].split(",");
   		$("#opt_selectDevlWeek option").remove();
   		for(var forCt = 0; forCt < arrOptionWeek.length; forCt++){
   			$('#opt_selectDevlWeek').append("<option value='" + arrOptionWeek[forCt] + "'>" + arrOptionWeek[forCt] + "��</option>");
   		}
   		$('#opt_selectDevlWeek > option[value="2"]').attr('selected', 'true');
   		$("#opt_devlWeek").val($("#opt_selectDevlWeek option:selected").val());
   		$("#opt_devlDay").val($('#opt_selectDevlDay option:selected').val());
   		optCalAmount();
    });

    // ��۱Ⱓ ���ý� ���� �ǽð����� ����
    $('#opt_selectDevlWeek').change(function(){
       $("#opt_devlWeek").val($('#opt_selectDevlWeek option:selected').val());
       optCalAmount();
    });

    // ���� ���� �Է½�
    $('#opt_buyQty').on("keyup",function(e) {
        var ct = $(this).val();
        if(isNaN(ct) || 1 > parseInt(ct)){
        	$('#opt_buyQty').val(1);
        }
        optCalAmount();
    });

    //�޸� ���� �ٿ��ֱ�
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

    //-- �ݾ��� ����Ѵ�.
    function optCalAmount(){
    	if(optGroupCode == "0300993"){ //-- �̴Ϲ��ϰ�� �ѽ�,��ļ�Ʈ�� ����
	   		optSaleTotalPrice	= optSalePrice * (parseInt($("#opt_buyQty2").val()) + parseInt($("#opt_buyQty3").val()));
	   		if(optSalePrice != optGoodsPrice){
		   		optGoodsTotalPrice	= optGoodsPrice * (parseInt($("#opt_buyQty2").val()) + parseInt($("#opt_buyQty3").val()));
	   		}
    	}
    	else{
	    	if(optIsDevlWeek && optGubun1 != "02"){ //-- ����üũ�̸鼭 ���α׷����̾�Ʈ�� �ƴѻ�ǰ
		   		optSaleTotalPrice	= optSalePrice * parseInt($("#opt_devlWeek").val()) * parseInt($("#opt_devlDay").val()) * parseInt($("#opt_buyQty").val());


		   		if(optSalePrice != optGoodsPrice){
			   		optGoodsTotalPrice	= optGoodsPrice * parseInt($("#opt_devlWeek").val()) * parseInt($("#opt_devlDay").val()) * parseInt($("#opt_buyQty").val());
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
		$("#opt_sumPrice").html(totalComma(optSaleTotalPrice)+"��");
		if(optSalePrice != optGoodsPrice){
			$("#opt_orgPrice").html(totalComma(optGoodsTotalPrice)+"��");
   		}
    }

    $(function(){
    	optCalAmount();
    });

 	var eslMemberId = '<%=eslMemberId%>';
    $("#btnOptionForm").click(function(){
	   	if(eslMemberId != ""){
		 	if(optIsDevlWeek && $("#opt_day").val() == ""){
		 		alert("������� ������ �ּ���.");
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
		            		if(data.data != ""){
		            			alert(data.data);
		            		}
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
	   		alert("�α����� ���� �Ͻñ� �ٶ��ϴ�.");
	   		var url = "/mobile/customer/login.jsp";
	   		$(location).attr('href',url);
	   	}

    });
    $("#btnOptionFormOrder").click(function(){
	   	if(eslMemberId != ""){
		 	if(optIsDevlWeek && $("#opt_day").val() == ""){
		 		alert("������� ������ �ּ���.");
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
		            url : "/mobile/shop/order/__ajax_goods_set_options_path.jsp?cart_type=L",
		            type : 'post',
		            data : queryString,
		    		dataType : "json",
		            async : true,
		            success : function(data){
		            	if(data.code == "success"){
		            		location.href='/mobile/shop/order.jsp?mode=L';
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
		        });

		 	}
	   	}else{
	   		alert("�α����� ���� �Ͻñ� �ٶ��ϴ�.");
	   		var url = "/mobile/customer/login.jsp";
	   	}
    });
</script>
<script>
    function cal_on() {
    	var cal = $("#option_scheduler");
    	if(!$("#option_scheduler").hasClass("on")){
    		$("#option_scheduler").show().addClass("on");
    	}else{
    		$("#option_scheduler").hide().removeClass("on");
    	}

    }
</script>