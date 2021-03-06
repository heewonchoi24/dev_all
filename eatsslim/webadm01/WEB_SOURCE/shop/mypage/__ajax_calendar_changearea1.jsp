<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");
String devlDates	= request.getParameter("devlDates");
String devlDay		= request.getParameter("devlDay");
String orderNum		= request.getParameter("orderNum");
String goods		= request.getParameter("goods");
System.out.println(" orderNum : "+orderNum);
int subNum			= 0;
if (request.getParameter("goodsId") != null && request.getParameter("goodsId").length()>0)
	subNum		= Integer.parseInt(request.getParameter("goodsId"));
System.out.println(" goodsId : "+subNum);
String gubunCode	= request.getParameter("groupCode");
System.out.println(" gubunCode : "+gubunCode);
int seq				= 0;
if (request.getParameter("seq") != null && request.getParameter("seq").length()>0)
	seq			= Integer.parseInt(request.getParameter("seq"));

/* if (orderNum == null || orderNum.equals("")) {
	out.println("<script>self.close();</script>");
	if (true) return;
} */

String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
int tcnt				= 0;
String memberId			= "";
String memberName		= "";
String payType			= "";
String rcvName			= "";
String rcvTel			= "";
String rcvHp			= "";
String rcvZipcode		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvRequest		= "";
String tagName			= "";
String tagTel			= "";
String tagHp			= "";
String tagZipcode		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
String pgTid			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String orderState		= "";
String orderDate		= "";
String orderDayState	= "";
String payDate			= "";
String minDate			= "";
String maxDate			= "";
String agId				= "";
String agName			= "";
int couponTprice		= 0;
int devlId				= 0;
String groupCode		= "";
SimpleDateFormat dt		= new SimpleDateFormat("yyyy-MM-dd");
String today			= dt.format(new Date());
String devlState		= "";
int payPrice			= 0;
int orderCnt			= 0;
String gubun1			= "";
String state			= "";
int compare				= 0;
String shopType			= "";
String outOrderNum		= "";
String groupName		= "";
String weekDay			= "";
String prdtSetName		= "";
String couponNum		= "";
String vendor			= "";
String groupImg			= "";

String devlGoodsType			= "";
String devlFirstDay		= "";
String devlModiDay		= "";
String devlWeek3		= "";
String devlWeek5		= "";

query		= "SELECT ";
query		+= "	MEMBER_ID, PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
query		+= "	TAG_NAME, TAG_TEL, TAG_HP, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_REQUEST, PG_TID, PG_CARDNUM,";
query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, O.ORDER_STATE, ORDER_DATE, PAY_DATE, O.COUPON_PRICE, GUBUN1,";
query		+= "	ORDER_NAME, SHOP_TYPE, OUT_ORDER_NUM, OG.COUPON_NUM, OG.DEVL_DAY, DEVL_TYPE, GUBUN2, GROUP_NAME, GROUP_IMGM, G.DEVL_GOODS_TYPE, G.DEVL_FIRST_DAY, G.DEVL_MODI_DAY, G.DEVL_WEEK3, G.DEVL_WEEK5";
query		+= " FROM ESL_ORDER O, ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G";
query		+= " WHERE O.ORDER_NUM = OG.ORDER_NUM AND OG.GROUP_ID = G.ID AND O.ORDER_NUM = '"+ orderNum +"' AND OG.ID = "+ subNum;

try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	memberId		= rs.getString("MEMBER_ID");
	memberName		= rs.getString("ORDER_NAME");
	payType			= rs.getString("PAY_TYPE");
	rcvName			= rs.getString("RCV_NAME");
	rcvTel			= rs.getString("RCV_TEL");
	rcvHp			= rs.getString("RCV_HP");
	rcvZipcode		= rs.getString("RCV_ZIPCODE");
	rcvAddr1		= rs.getString("RCV_ADDR1");
	rcvAddr2		= rs.getString("RCV_ADDR2");
	rcvRequest		= rs.getString("RCV_REQUEST");
	tagName			= rs.getString("TAG_NAME");
	tagTel			= rs.getString("TAG_TEL");
	tagHp			= rs.getString("TAG_HP");
	tagZipcode		= rs.getString("TAG_ZIPCODE");
	tagAddr1		= rs.getString("TAG_ADDR1");
	tagAddr2		= rs.getString("TAG_ADDR2");
	tagRequest		= rs.getString("TAG_REQUEST");
	pgTid			= (rs.getString("PG_TID") == null)? "" : rs.getString("PG_TID");
	pgCardNum		= rs.getString("PG_CARDNUM");
	pgFinanceName	= rs.getString("PG_FINANCENAME");
	pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
	orderState		= rs.getString("ORDER_STATE");
	orderDate		= rs.getString("ORDER_DATE");
	payDate			= rs.getString("PAY_DATE");
	couponTprice	= rs.getInt("COUPON_PRICE");
	gubun1			= rs.getString("GUBUN1");
	shopType		= rs.getString("SHOP_TYPE");
	outOrderNum		= ut.isnull(rs.getString("OUT_ORDER_NUM"));
	couponNum		= rs.getString("COUPON_NUM");
	devlDay			= rs.getString("DEVL_DAY");
	groupImg		= rs.getString("GROUP_IMGM");

	devlGoodsType			= ut.isnull(rs.getString("DEVL_GOODS_TYPE") );
	devlFirstDay		= ut.isnull(rs.getString("DEVL_FIRST_DAY") );
	devlModiDay			= ut.isnull(rs.getString("DEVL_MODI_DAY") );
	devlWeek3			= ut.isnull(rs.getString("DEVL_WEEK3") );
	devlWeek5			= ut.isnull(rs.getString("DEVL_WEEK5") );
	if(!ut.isNaN(devlFirstDay) || "".equals(devlFirstDay) ) devlFirstDay = "0";
	if(!ut.isNaN(devlModiDay) || "".equals(devlModiDay) ) devlModiDay = "0";

	//-- 제품명
	if(rs.getString("DEVL_TYPE").equals("0002")){
		goods		= ut.getGubun2Name(rs.getString("GUBUN2"));
	}
	else{
		goods		= rs.getString("GROUP_NAME");
	}

	query1		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
	query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ subNum;
	query1		+= " AND GROUP_CODE <> '0300668'"; //-- 배송가방은 노출하지 않는다.

	try {
		rs1			= stmt.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	if (rs1.next()) {
		minDate			= rs1.getString("MIN_DATE");
		maxDate			= rs1.getString("MAX_DATE");
		devlDates		= ut.isnull(minDate) +" ~ "+ ut.isnull(maxDate);
	} else {
		devlDates		= "-";
	}


	query1		= "SELECT EODD.RCV_NAME, EODD.RCV_HP, EODD.AGENCYID, EODA.AGENCY_NAME FROM ESL_ORDER_DEVL_DATE EODD LEFT JOIN ESL_ORDER_DEVL_AGENCY EODA ON EODD.AGENCYID = EODA.AGENCY_ID ";
	query1		+= " WHERE EODD.ORDER_NUM = '"+ orderNum +"'" ;
	query1		+= " ORDER BY EODD.DEVL_DATE LIMIT 1  ";
	try {
		rs1			= stmt.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	if (rs1.next()) {
		agId			= ut.isnull(rs1.getString("AGENCYID"));
		agName			= ut.isnull(rs1.getString("AGENCY_NAME"));
		rcvName			= ut.isnull(rs1.getString("RCV_NAME"));
		rcvHp			= ut.isnull(rs1.getString("RCV_HP"));
	}
	rs1.close();

	if (!couponNum.equals("") && couponNum.length() > 0) {
		query1		= "SELECT C.VENDOR FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
		query1		+= " WHERE C.ID = CM.COUPON_ID AND CM.COUPON_NUM = '"+ couponNum +"'";
		try {
			rs1			= stmt.executeQuery(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}

		if (rs1.next()) {
			vendor			= rs1.getString("VENDOR");
		}
		rs1.close();
	}
}
rs.close();

/**
- 오늘을 기준으로 상품 제작 소요일을 더한 값을 변경 시작일로 설정하고
- 그 시작일로 부터 배송완료일까지의 상품의 갯수를 선택 하도록 한다.
- 설정일은 주문일로 부터 6개월까지를 연장 할 수 있도록 한다.
- 여러번 할경우
*/
//-- 선택 시작일
Date date			= null;
String startDate	= "";
String startChoiceDate		= "";
String startChoiceDateText		= "";
Calendar cal		= Calendar.getInstance();
date				= dt.parse(today);
int iDevlModiDay			= Integer.parseInt(devlModiDay);
if("0301369".equals(gubunCode) && 150000 < Integer.parseInt(ut.getTimeStamp(10))){
	//-- 헬씨퀴진은 오후3시 이전이면 1일을 더한다.
	iDevlModiDay++;
}
cal.add(Calendar.DATE, iDevlModiDay);
if(cal.get(cal.DAY_OF_WEEK) == 7) cal.add(Calendar.DATE, 1);
if(cal.get(cal.DAY_OF_WEEK) == 1) cal.add(Calendar.DATE, 1);
startDate		  	= dt.format(cal.getTime());
int chkCnt = 1;
while(chkCnt != 0){
	query		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ startDate +"' AND HOLIDAY_TYPE = '02'";
	try {
		rs		= stmt.executeQuery(query);
		if (rs.next()) {
			chkCnt		= rs.getInt(1);
			if(chkCnt != 0){
				cal.add(Calendar.DATE, 1);
				startDate		  	= dt.format(cal.getTime());
			}
		}
		rs.close();

	} catch(Exception e) {
		chkCnt		= 0;
		out.println(e+"=>"+query);
		if(true)return;
	}
}

//-- 상품 합계 갯수
int productTotalCnt	= 0;
query		= "SELECT IFNULL(SUM(ORDER_CNT),0) FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' )";
query		+= " AND DEVL_DATE >= '" + startDate + "'";
System.out.println(query);
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	productTotalCnt = rs.getInt(1); //남은 총 수량
}
rs.close();

if(productTotalCnt > 0){
	query		= "SELECT MIN(DEVL_DATE) FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
	query		+= " AND GOODS_ID = "+ subNum +" AND GROUP_CODE not in ( '0300668', '0301340' )";
	query		+= " AND DEVL_DATE >= '" + startDate + "'";
	System.out.println(query);
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		startChoiceDate = rs.getString(1); //패턴변경 시작일
	}
	rs.close();
}
else{
	//-- 변경할 수량이 없다면 종료 한다.
}
if("".equals(startChoiceDate) ) startChoiceDate = startDate;
String dd = startChoiceDate.substring(8,10);
String mm = startChoiceDate.substring(5,7);
String yyyy = startChoiceDate.substring(0,4);
if(startChoiceDate.substring(5,6).equals("0")) mm = startChoiceDate.substring(6,7);
if(startChoiceDate.substring(8,9).equals("0")) dd = startChoiceDate.substring(9,10);
startChoiceDateText = yyyy+"년 "+mm+"월 "+dd+"일";

//System.out.println("startDate=" + startDate);

%>
<section id="changeArea1" class="modal">
    <div class="inner">
    	<button class="modal_close"></button>
    	<div class="modal_header">
			<h1>배송지 변경 <span>(1/2)</span></h1>
			<div class="tip_scheduler">변경할 일정과 배송지를 선택해주세요.</div>
    	</div>
        <div class="modal_content">
        	<div class="inner">
        		<form name="frm_address" id="frm_address"  action="?">
	            <input type="hidden" name="mode" value="editAddress" />
	            <input type="hidden" name="order_num" id="update_order_num" value="<%=orderNum%>">
	            <input type="hidden" name="gubun_code" id="update_gubun_code" value="<%=gubunCode%>">
	            <input type="hidden" name="sub_num" id="update_sub_num" value="<%=subNum%>">
	            <div class="pop_select_items">
	                <ul>
	                    <li>
	                        <div class="img"><a href="../order_view.jsp?cateCode=0&cartId=<%=subNum%>"><img src="/data/goods/<%=groupImg%>" alt=""></a></div>
	                        <div class="desc">
	                            <div class="title"><a href="../order_view.jsp?cateCode=0&cartId=<%=subNum%>"><%=goods %></a></div>
	                            <div class="d_period">
	                            <%
	       	                         /*if(!"02".equals(gubun1)){
	     								if(devlDay.equals("5")){
	     									%>
	     									<span>월~금</span>
	     									<%
	     								}
	     								if(devlDay.equals("3")){
	     									%>
	     									<span>월/수/금</span>
	     									<%
	     								}
	     	                         }*/
								%>

							<%=devlDates %></div>
								<!-- <div class="d_destination">
									                               <%=rcvAddr1 %> <%=rcvAddr2 %>
									                            </div> -->
	                        </div>
	                        <div class="opt">
                            	<a href="javascript:void(0);" onclick="window.open('/shop/mypage/orderAreaList.jsp?jsOrderNum=<%=orderNum%>&jsGoodsId=<%=subNum%>&jsGroupCode=<%=gubunCode%>&devlType=0001','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=600,height=600')">배송지 확인</a>
                            </div>
	                    </li>
	                </ul>
	            </div>
	            <div class="bx_changearea">
	            	<input type="hidden" name="stdate_addr" id="ca_startDate" value="<%=startChoiceDate%>">
					<p class="text">위 주문에 대해</p>
					<div class="ipt_group selectDate" onclick="modalFn.show('__ajax_calendar_selectdate.jsp?mindate=<%=startChoiceDate%>&maxdate=<%=maxDate%>&caltype=start', {onLoad:calenderSetting('start')});">
				    	<input type="text" class="ipt" id="ca_startDate_text" value="<%=startChoiceDateText%> 부터" readonly="">
				    	<span class="ipt_right addon "><button type="button" class="btn"></button></span>
				    </div>
				    <div class="ipt_group">
				    	<div class="selectbox">
							<label>배송완료 시 까지의</label>
							<select name="ltdate_addr" id="ca_startDate2" onchange="selectbox(this);">
								<option  value="<%=maxDate%>">배송완료 시 까지의</option>
								<option value="selectDate">--- 배송일 직접선택 ---</option>
							</select>
						</div>
				    </div>
				    <p class="text">주문을 다음의 배송지로 배송변경 신청합니다.</p>
	            </div>
	            <div class="bx_edit">
	                <table>
                        <tbody>
	                        <tr>
	                            <th>변경할 주소</th>
	                            <td>
									<div class="ipt_group">
								    	<input type="text" class="ipt" name="rcv_zipcode" id="rcv_zipcode" value="" readonly>
								    	<span class="ipt_right"><button type="button" class="btn" onclick="searchAddr('0001');">우편번호</button></span>
								    </div>
									<div class="ipt_group">
		                               <p><input type="text" style="margin-bottom: 5px;" class="ipt w100p" name="rcv_addr1" id="rcv_addr1" value="" readonly></p>
		                               <p><input type="text" class="ipt w100p" name="addr2" id="addr2" value=""></p>
									</div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>비고</th>
	                            <td>
									<div class="ipt_group">
										<input type="text" name="rcv_pass" class="ipt w100p" name="rcv_pass" id="rcv_pass" placeholder="공동현관 비밀번호 또는 배송시 요청사항을 입력해주세요.">
									</div>
	                            </td>
	                        </tr>
                    	</tbody>
                    </table>
	            </div>
	            <div class="btns center modal_btns">
	                <button type="button" class="btn sky radius20 large" onclick="updPtDate();">변경완료</button>
	            </div>
	            </form>
        	</div>
        </div>
    </div>
    <script type="text/javascript">
    	var iptTarget, iptTargetText, parentTarget;
    	function calenderSetting(type) {
	    	if(type == "start"){
	    		iptTarget = $("#ca_startDate");
	    		iptTargetText = $("#ca_startDate_text");
	    	}else{
	    		iptTarget = $("#ca_startDate2");
	    		iptTargetText = $("#ca_startDate2_Text");
	    	}
	    	parentTarget = $('#changeArea1');

	    }
    	$('#ca_startDate2').change(function(){
			if($(this).val() == "selectDate"){
				modalFn.show('__ajax_calendar_selectdate.jsp?mindate=<%=startDate%>&maxdate=<%=maxDate%>&caltype=start', {onLoad:calenderSetting('end')});
			}
		});

    	var isSubmit = true;
    	function updPtDate() {
    		if(!isSubmit){
    			alert("처리중에 있습니다. 잠시만 기다리세요.");
    			return false;
    		}
    		if($.trim($('#ca_startDate').val()) == ""){
    			alert("시작일을 선택하세요.");
    			return false;
    		}
    		if(!/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/.test($.trim($('#ca_startDate').val() ) ) ){
    			alert("시작일 형식을 확인하세요. ex)0000-00-00");
    			return false;
    		}
    		if($.trim($('#ca_startDate2').val()) == ""){
    			alert("종료일을 선택하세요.");
    			return false;
    		}
    		if(!/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/.test($.trim($('#ca_startDate2').val() ) ) ){
    			alert("종료일 형식을 확인하세요. ex)0000-00-00");
    			return false;
    		}


    		if($.trim($('#rcv_zipcode').val()) == ""){
    			alert("우편번호를 검색하세요.");
    			return false;
    		}

    		if($.trim($('#rcv_addr1').val()) == ""){
    			alert("우편번호를 검색하세요.");
    			return false;
    		}

    		if($.trim($('#addr2').val()) == ""){
    			alert("상세주소를 입력하세요.");
    			return false;
    		}

    		if(!confirm("주소를 변경하시겠습니까?\n확인을 누르시고 완료화면이 나올때까지 기다리세요.")){
    			return false;
    		}

    		isSubmit = false;

    		$('body').append('<div id="popProgressBackground"></div><div id="popProgressCircle"><img src="/mobile/common/images/ico/calLoading.png"><p>Waiting</p></div>');

    		$.post("__ajax_calendar_changearea_db.jsp", $("#frm_address").serialize(),
    		function(data) {
    			$(data).find("result").each(function() {
    				if ($(this).text() == "success") {
    					//alert("success");
    					var param = 'order_num=' + $("#update_order_num").val() + '&gubun_code=' + $("#update_gubun_code").val() +
    					            '&sub_num=' + $("#update_sub_num").val() +
    					            '&stdate_addr=' + $("#ca_startDate").val() + '&ltdate_addr=' + $("#ca_startDate2").val() +
    					            '&goods=<%=goods%>' + '&devlDay=<%=devlDay%>';
    					modalFn.show('__ajax_calendar_changearea2.jsp?'+param);

    				} else {
    					isSubmit = true;
    					$(data).find("error").each(function() {
    						alert($(this).text());
    					});
    				}
    			});
    		}, "xml");
    		return false;

    	}

    	function searchAddr(str) {
    		window.open('/shop/popup/AddressSearchJiPop.jsp?ztype='+ str,'chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');
    	}

    </script>
</section>