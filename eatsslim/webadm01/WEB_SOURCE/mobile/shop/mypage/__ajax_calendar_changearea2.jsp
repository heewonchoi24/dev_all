<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");
String devlDates	= request.getParameter("devlDates");
String orderNum		= request.getParameter("order_num");
String devlDay		= request.getParameter("devlDay");
String goods		= request.getParameter("goods");
System.out.println(" orderNum : "+orderNum);
int subNum			= 0;
if (request.getParameter("sub_num") != null && request.getParameter("sub_num").length()>0)
	subNum		= Integer.parseInt(request.getParameter("sub_num"));
System.out.println(" goodsId : "+subNum);
String gubunCode	= request.getParameter("gubun_code");
System.out.println(" gubunCode : "+gubunCode);
int seq				= 0;
if (request.getParameter("seq") != null && request.getParameter("seq").length()>0)
	seq			= Integer.parseInt(request.getParameter("seq"));

String stdate_addr			= ut.inject(request.getParameter("stdate_addr"));
String ltdate_addr			= ut.inject(request.getParameter("ltdate_addr"));
String rcv_zipcode			= "";//ut.inject(request.getParameter("rcv_zipcode"));
String rcv_addr1			= "";//ut.inject(request.getParameter("rcv_addr1"));
String rcv_addr2			= "";//ut.inject(request.getParameter("rcv_addr2"));

String startYear			= "0000";
String startMonth			= "0";
String startDay				= "0";

if(stdate_addr.length() == 10){
	startYear		 = stdate_addr.substring(0,4);
	startMonth		 = stdate_addr.substring(5,7);
	startDay		 = stdate_addr.substring(8,10);
}

String endYear			= "0000";
String endMonth			= "0";
String endDay			= "0";

if(ltdate_addr.length() == 10){
	endYear		 = ltdate_addr.substring(0,4);
	endMonth	 = ltdate_addr.substring(5,7);
	endDay		 = ltdate_addr.substring(8,10);
}


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

query		= "SELECT ";
query		+= "	MEMBER_ID, PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
query		+= "	TAG_NAME, TAG_TEL, TAG_HP, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_REQUEST, PG_TID, PG_CARDNUM,";
query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, O.ORDER_STATE, ORDER_DATE, PAY_DATE, O.COUPON_PRICE, GUBUN1,";
query		+= "	ORDER_NAME, SHOP_TYPE, OUT_ORDER_NUM, OG.COUPON_NUM, OG.DEVL_DAY, DEVL_TYPE, GUBUN2, GROUP_NAME, GROUP_IMGM";
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

	//-- 제품명
	if(rs.getString("DEVL_TYPE").equals("0002")){
		goods		= ut.getGubun2Name(rs.getString("GUBUN2"));
	}
	else{
		goods		= rs.getString("GROUP_NAME");
	}

	query1		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
	query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ subNum;

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

//-- 변경 배송지 주소
query = "SELECT RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2 FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
if (stdate_addr != null && !stdate_addr.equals("")) {
	query		+= " AND DEVL_DATE >= '"+ stdate_addr +"'";
}
if (ltdate_addr != null && !ltdate_addr.equals("")) {
	query		+= " AND DEVL_DATE <= '"+ ltdate_addr +"'";
}
query += " LIMIT 1";
rs			= stmt.executeQuery(query);
if(rs.next() ){
	rcv_zipcode			= ut.isnull(rs.getString("RCV_ZIPCODE"));
	rcv_addr1			= ut.isnull(rs.getString("RCV_ADDR1"));
	rcv_addr2			= ut.isnull(rs.getString("RCV_ADDR2"));
}
else{

}
rs.close();
%>
<div id="changeDateCal">
    <div class="inner">
        <header class="pop_header"><h1>배송지 변경 (2/2)</h1></header>
        <div class="pop_content">
            <input type="hidden" class="startDate">
            <input type="hidden" class="endDate">
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
                        	<a href="javascript:void(0);" onclick="calendarPop.addCont({url : '__ajax_calendar_shipping.jsp?ordno=<%=orderNum%>&goodsId=<%=subNum%>&groupCode=<%=subNum%>', direc : 'down'})">배송지 확인</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="bx_pattern confirm">
                <div class="bx_pattern_inner">
                    <div class="text_area">
                        <strong><%=startYear%>년 <%=startMonth%>월 <%=startDay%>일</strong> 부터 <strong><%=endYear%>년 <%=endMonth%>월 <%=endDay%>일</strong> 까지의<br>배송지를<br>
                        <span>(<%=rcv_zipcode%>) <%=rcv_addr1%> <%=rcv_addr2%></span> 으로<br>변경처리 완료하였습니다.<br>감사합니다.
                    </div>
                </div>
            </div>
            <div class="bottom_btn_area btn_group">
<%--                 <button type="button" class="btn btn_white square half back" onclick="calendarPop.addCont({url : '__ajax_calendar_changearea.jsp?orderNum=<%=orderNum%>&goodsId=<%=subNum%>&groupCode=<%=gubunCode%>&goods=<%=goods%>', direc : 'prev'})">뒤로가기</button> --%>
                <button type="button" class="btn btn_dgray square huge" onclick="$('.pop_close').trigger('click');pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_calendar.jsp?ordno=<%=orderNum%>&goods=<%=goods%>&goodsId=<%=subNum%>&groupCode=<%=gubunCode%>'});">완료</button>
            </div>
        </div>
    </div>
</div>
