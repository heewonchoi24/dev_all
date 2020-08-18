<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.SimpleDateFormat,java.util.*,java.util.Date"%>
<%@ page import="lgdacom.XPayClient.XPayClient"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/xpay/config.jsp" %>
<!--h3>PG사 결제 취소 결과</h3-->
<style>
#loading_img{
    display: block;
    margin:0 auto;
    width: 100%;
}
#m_loading_img{
    display: block;
    margin:0 auto;
    width: 100%;
}
.c_cancel{
    position:relative;
    top:300px;
	margin:0 auto;
	width:300px;
	height:350px;
}
.m_c_cancel{
    position:relative;
    top:30%;
}
#txt_cancel{
    text-align:center;
    position:absolute;
    top:60px;
    width:100%;
}
#m_txt_cancel{
    text-align:center;
    position:absolute;
    font-size: 40px;
    top:100px;
    width:100%;
}
</style>
<%
request.setCharacterEncoding("euc-kr"); 

if (eslMemberId == null || eslMemberId.equals("")) {
%>
<script type="text/javascript">
alert("로그인을 해주세요.");
parent.document.location.href = "/index.jsp";
</script>
<%
	if (true) return;
}

String query		= "";
String chgstate = "";
String mode			= ut.inject(request.getParameter("mode"));
String orderNum		= ut.inject(request.getParameter("order_num"));
if(orderNum.equals("")){ out.println("주문번호 누락");if(true)return;}
String code			= ut.inject(request.getParameter("code"));
if(code==null){out.println("code 누락");if(true)return;}
String reasonType	= ut.inject(request.getParameter("reason_type"));
if (reasonType == null || reasonType.length()==0) reasonType="0";
String bankName		= ut.inject(request.getParameter("bankName")); //환불계좌은행 명
String bankUser		= ut.inject(request.getParameter("bankUser")); //환불 계좌 예금주
String bankAccount	= ut.inject(request.getParameter("bankAccount")); //환불계좌번호
String reason		= ut.inject(request.getParameter("reason"));
String payType		= ut.inject(request.getParameter("pay_type"));
String pgTID		= ut.inject(request.getParameter("pgTID")); //PG사 거래번호
String payYn        = ut.inject(request.getParameter("payYn")); //결제 여부
String msg = "";
String cancelFrom = ut.inject(request.getParameter("cancelFrom")); //주문취소를 모바일에서 했는지 체크
String mtype	= ut.inject(request.getParameter("mtype")); //주문취소를 모바일 어느쪽에서 했는지 체크

if(cancelFrom.equals("mobile")) {
	reason = "모바일 주문 취소"; //모바일로 주문취소시 취소 사유 설정
}

%>
	 <%if(cancelFrom.equals("mobile")){ %> <div class="m_c_cancel"><img id="m_loading_img" alt="loading" src="/images/m_loader_wait.gif"/> <p id="m_txt_cancel">취소중입니다. 잠시만 기다려주세요...</p></div>
 <%} else{%> <div class="c_cancel"><img id="loading_img" alt="loading" src="/images/loader_wait.gif"/> <p id="txt_cancel">취소중입니다. 잠시만 기다려주세요...</p></div><%}%>
 <%

if(payYn.equals("Y")){
    /*
     * [결제취소 요청 페이지]
     *
     * LG유플러스으로 부터 내려받은 거래번호(LGD_TID)를 가지고 취소 요청을 합니다.(파라미터 전달시 POST를 사용하세요)
     * (승인시 LG유플러스으로 부터 내려받은 PAYKEY와 혼동하지 마세요.)
     */                                                                                        //상점아이디(자동생성)
    String LGD_TID              = pgTID;                      //LG유플러스으로 부터 내려받은 거래번호(LGD_TID)
	if(LGD_TID==null || LGD_TID.length()==0){
		out.println("오류 : 거래번호(LGD_TID) 누락");if(true)return;
	}
    /*String configPath 			= "C:/lgdacom";  										//LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.
	if(request.getServerName().equals("183.101.223.86") || request.getServerName().equals("p.tmap4.com")){ // case developServer
		configPath="C:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\Admin\\lgdacom";
	} else { //case realServer
		configPath="/www/Admin/lgdacom";
	}*/       
    LGD_TID     				= ( LGD_TID == null )?"":LGD_TID; 
	//---------------추가	
	String LGD_CANCELAMOUNT     	= request.getParameter("LGD_CANCELAMOUNT");             //부분취소 금액
    String LGD_REMAINAMOUNT     	= request.getParameter("LGD_REMAINAMOUNT");             //남은 금액
//    String LGD_CANCELTAXFREEAMOUNT  = request.getParameter("LGD_CANCELTAXFREEAMOUNT");      //면세대상 부분취소 금액 (과세/면세 혼용상점만 적용)
    String LGD_CANCELREASON     	= request.getParameter("LGD_CANCELREASON"); 		    //취소사유
    String LGD_RFBANKCODE     		= request.getParameter("LGD_RFBANKCODE"); 		    	//환불계좌 은행코드 (가상계좌만 필수)
    String LGD_RFACCOUNTNUM     	= request.getParameter("LGD_RFACCOUNTNUM"); 		    //환불계좌 번호 (가상계좌만 필수)
    String LGD_RFCUSTOMERNAME     	= request.getParameter("LGD_RFCUSTOMERNAME"); 		    //환불계좌 예금주 (가상계좌만 필수)
    String LGD_RFPHONE     			= request.getParameter("LGD_RFPHONE"); 		    		//요청자 연락처 (가상계좌만 필수)
    //---------------
    XPayClient xpay = new XPayClient();
    xpay.Init(configPath, CST_PLATFORM);
	if (LGD_TID.indexOf("201612") != -1) {
		xpay.Init_TX("eatsslim");
	} else {
		xpay.Init_TX(LGD_MID);
	}
    xpay.Set("LGD_TXNAME", "Cancel");
    xpay.Set("LGD_TID", LGD_TID);
	//---------------추가
	xpay.Set("LGD_CANCELAMOUNT", LGD_CANCELAMOUNT);
    xpay.Set("LGD_REMAINAMOUNT", LGD_REMAINAMOUNT);
//    xpay.Set("LGD_CANCELTAXFREEAMOUNT", LGD_CANCELTAXFREEAMOUNT);
	xpay.Set("LGD_RFBANKCODE", LGD_RFBANKCODE);
    xpay.Set("LGD_RFACCOUNTNUM", LGD_RFACCOUNTNUM);
    xpay.Set("LGD_RFCUSTOMERNAME", LGD_RFCUSTOMERNAME);
    xpay.Set("LGD_RFPHONE", LGD_RFPHONE);
	//---------------
    /*
     * 1. 결제취소 요청 결과처리
     *
     * 취소결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
	 *
	 * [[[중요]]] 고객사에서 정상취소 처리해야할 응답코드
	 * 1. 신용카드 : 0000, AV11  
	 * 2. 계좌이체 : 0000, RF00, RF10, RF09, RF15, RF19, RF23, RF25 (환불진행중 응답건-> 환불결과코드.xls 참고)
	 * 3. 나머지 결제수단의 경우 0000(성공) 만 취소성공 처리
	 *
     */
    if (xpay.TX()) {
        //1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
        //out.println("결제 취소요청이 완료되었습니다.  <br>");
        //out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        //out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
		//out.println("<script>self.close();</script>");

		if(xpay.m_szResCode.equals("0000") || xpay.m_szResCode.equals("RF24")){
			///////////////////////////////PG 취소결과 저장		
			//out.println("결제 취소요청이 성공하였습니다.  <br>");
			//out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
			///out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");

			String pgcancel="N", pgcancel_code="", pgcancel_msg="";
			String[] arrResCode = new String[] {"0000", "AV11", "RF00", "RF10", "RF09", "RF15", "RF19", "RF23", "RF25"};

			for( int ii = 0; ii < arrResCode.length; ii++ ){
				if(arrResCode[ii].equals(xpay.m_szResCode)){
					pgcancel="Y";
				}
			}
			pgcancel_code=xpay.m_szResCode;// 0000
			pgcancel_msg=xpay.m_szResMsg;// 취소성공
			
			query		= "UPDATE ESL_ORDER SET ";
			query		+= "		PG_CANCEL			= '"+ pgcancel +"'";
			query		+= "		, PG_CANCEL_CODE	= '"+ pgcancel_code +"'";
			query		+= "		, PG_CANCEL_MSG		= '"+ pgcancel_msg +"'";
			query		+= " WHERE PG_TID = '"+ LGD_TID +"'";
			try {
				stmt.executeUpdate(query);
			} catch(Exception e) {
				out.println(e); if(true)return;
			}
			///////////////////////////////////////////
			if(mode!=null){
	
				if(mode.equals("cancel")){ //############# 취소처리

					if(code.equals("CD1")){				
						chgstate="91";
					}

					query		= "INSERT INTO ESL_ORDER_CANCEL SET ";
					query		+= "		ORDER_NUM		= '"+ orderNum +"'";
					query		+= "		, REASON_TYPE	= '"+ reasonType +"'";
					query		+= "		, REASON		= '"+ reason +"'";
					query		+= "		, ORDER_STATE	= '"+ chgstate +"'";
					query		+= "		, INST_DATE		= NOW()";
					query		+= "		, BANK_NAME		= '"+ bankName +"'";
					query		+= "		, BANK_ACCOUNT	= '"+ bankAccount +"'";
					query		+= "		, BANK_USER		= '"+ bankUser +"'";
					try {
						stmt.executeUpdate(query);
					} catch(Exception e) {
						out.println(e);
						if(true)return;
					}
				}
			}

			///////////////////////////////////////////

				msg		+= "location.href = '/xpay/Cancel.jsp?cancelFrom="+cancelFrom+"&mtype="+mtype+"&mode="+mode+"&order_num="+orderNum+"&code="+code+"&reason_type="+reasonType+"&pay_type="+payType+"&pgTID="+pgTID+"';";
			//msg = "alert('취소 처리가 완료되었습니다.');";
		}else{
			//out.println("결제 취소요청이 실패하였습니다.  <br>");
			//out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
			//out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
			%>
			<script type="text/javascript">
				<%if(cancelFrom.equals("mobile")){ %> document.getElementById("m_txt_cancel").style.display = "none";
				<%} else{%> document.getElementById("txt_cancel").style.display = "none"; <%}%>			
			</script>
			<%
			msg += "alert('취소 처리가 실패되었습니다. LG U+ 전자결제 고객센터(1544-7772)로 문의주세요.');"+"";
			if(cancelFrom.equals("mobile")) { //모바일로 주문취소시 주문리스트로 돌아감
                if (mtype.equals("2")) {
                    msg += "location.href = '/mobile/shop/mypage/orderList.jsp';";
                } else {
                    msg += "location.href = '/mobile/shop/mypage/orderList.jsp';";
                }
            }
            else {
                msg	+= "location.href = '/shop/mypage/orderList.jsp';";
            }			
		}
	}
	else {
		%>
			<script type="text/javascript">
				<%if(cancelFrom.equals("mobile")){ %> document.getElementById("m_txt_cancel").style.display = "none";
				<%} else{%> document.getElementById("txt_cancel").style.display = "none"; <%}%>			
			</script>
		<%
		//2)API 요청 실패 화면처리
		//out.println("결제 취소요청이 실패하였습니다.  <br>");
		//out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
		//out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
		msg += "alert('취소 처리가 실패되었습니다. LG U+ 전자결제 고객센터(1544-7772)로 문의주세요.');"+"";
            if(cancelFrom.equals("mobile")) { //모바일로 주문취소시 주문리스트로 돌아감
                if (mtype.equals("2")) {
                    msg += "location.href = '/mobile/shop/mypage/orderList.jsp';";
                } else {
                    msg += "location.href = '/mobile/shop/mypage/orderList.jsp';";
                }
            }
            else {
                msg	+= "location.href = '/shop/mypage/orderList.jsp';";
            }
			
    }
}
else{// 결제전/주문접수상태
	//out.println("결제전/주문접수상태");

	if(mode!=null){
	
		if(mode.equals("cancel")){ //############# 취소처리

			if(code.equals("CD1")){				
				chgstate="91";
			}

			query		= "INSERT INTO ESL_ORDER_CANCEL SET ";
			query		+= "		ORDER_NUM		= '"+ orderNum +"'";
			query		+= "		, REASON_TYPE	= '"+ reasonType +"'";
			query		+= "		, REASON		= '"+ reason +"'";
			query		+= "		, ORDER_STATE	= '"+ chgstate +"'";
			query		+= "		, INST_DATE		= NOW()";
			query		+= "		, BANK_NAME		= '"+ bankName +"'";
			query		+= "		, BANK_ACCOUNT	= '"+ bankAccount +"'";
			query		+= "		, BANK_USER		= '"+ bankUser +"'";
			try {
				stmt.executeUpdate(query);
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}
		}
	}

msg		+= "location.href = '/xpay/Cancel.jsp?cancelFrom="+cancelFrom+"&mtype="+mtype+"&mode="+mode+"&order_num="+orderNum+"&code="+code+"&reason_type="+reasonType+"&pay_type="+payType+"&pgTID="+pgTID+"';";
}
%>
<script><%=msg%></script>
<%@ include file="/lib/dbclose.jsp" %>