<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.text.SimpleDateFormat,java.util.*,java.util.Date"%>
<%@ page import="lgdacom.XPayClient.XPayClient"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="config.jsp" %>
<!--h3>PG사 결제 취소 결과</h3-->
<%
    /*
     * [결제취소 요청 페이지]
     *
     * LG유플러스으로 부터 내려받은 거래번호(LGD_TID)를 가지고 취소 요청을 합니다.(파라미터 전달시 POST를 사용하세요)
     * (승인시 LG유플러스으로 부터 내려받은 PAYKEY와 혼동하지 마세요.)
     */
                                                                                        //상점아이디(자동생성)
    String LGD_TID              = request.getParameter("LGD_TID");                      //LG유플러스으로 부터 내려받은 거래번호(LGD_TID)
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
    xpay.Init_TX(LGD_MID);
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
    }else {
        //2)API 요청 실패 화면처리
        out.println("결제 취소요청이 실패하였습니다.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
    }

	///////////////////////////////PG 취소결과 저장
	String pgcancel="N", pgcancel_code="", pgcancel_msg="";
	String[] arrResCode=new String[] {"0000", "AV11", "RF00", "RF10", "RF09", "RF15", "RF19", "RF23", "RF25"};

	for( int ii = 0; ii < arrResCode.length; ii++ ){
		if(arrResCode[ii].equals(xpay.m_szResCode)){
			pgcancel="Y";
		}
	}
	pgcancel_code=xpay.m_szResCode;
	pgcancel_msg=xpay.m_szResMsg;
	String query		= "";
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
	/////////////////////////////////
%>
<%@ include file="/lib/dbclose.jsp" %>
<script>location.href="/shop/mypage/reorderList.jsp";</script>