<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.security.MessageDigest, java.util.*" %>
<%
request.setCharacterEncoding("euc-kr");
    /*
     * [결제 인증요청 페이지(STEP2-1)]
     *
     * 샘플페이지에서는 기본 파라미터만 예시되어 있으며, 별도로 필요하신 파라미터는 연동메뉴얼을 참고하시어 추가 하시기 바랍니다.
     */

    /*
     * 1. 기본결제 인증요청 정보 변경
     *
     * 기본정보를 변경하여 주시기 바랍니다.(파라미터 전달시 POST를 사용하세요)
     */
    String CST_PLATFORM         = "service";                 //LG유플러스 결제서비스 선택(test:테스트, service:서비스)
    String CST_MID              = "eatsslim";                      //LG유플러스로 부터 발급받으신 상점아이디를 입력하세요.
    String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
                                                                                        //상점아이디(자동생성)
    String LGD_OID              = request.getParameter("LGD_OID");                      //주문번호(상점정의 유니크한 주문번호를 입력하세요)
    String LGD_AMOUNT           = request.getParameter("LGD_AMOUNT");                   //결제금액("," 를 제외한 결제금액을 입력하세요)
    String LGD_MERTKEY          = "bbc52915b7b3cc90d88c76b78856dcba";              		//상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
    String LGD_BUYER            = request.getParameter("LGD_BUYER");                    //구매자명
    String LGD_PRODUCTINFO      = request.getParameter("LGD_PRODUCTINFO");              //상품명
    String LGD_BUYEREMAIL       = request.getParameter("LGD_BUYEREMAIL");               //구매자 이메일
    String LGD_TIMESTAMP        = request.getParameter("LGD_TIMESTAMP");                //타임스탬프
    String LGD_CUSTOM_FIRSTPAY  = request.getParameter("LGD_CUSTOM_FIRSTPAY");          //상점정의 초기결제수단
    String LGD_CUSTOM_SKIN      = "red";                                                //상점정의 결제창 스킨(red, blue, cyan, green, yellow)

	String ServerAddr="";
	ServerAddr = "http://www.eatsslim.co.kr";

    /*
     * 가상계좌(무통장) 결제 연동을 하시는 경우 아래 LGD_CASNOTEURL 을 설정하여 주시기 바랍니다.
     */
    String LGD_CASNOTEURL		= ServerAddr+"/mobile/xpayMobile/cas_noteurl.jsp";

    /*
     * LGD_RETURNURL 을 설정하여 주시기 바랍니다. 반드시 현재 페이지와 동일한 프로트콜 및  호스트이어야 합니다. 아래 부분을 반드시 수정하십시요.
     */
    String LGD_RETURNURL		= ServerAddr+"/mobile/xpayMobile/returnurl.jsp";// FOR MANUAL

    /*
     * ISP 카드결제 연동중 모바일ISP방식(고객세션을 유지하지않는 비동기방식)의 경우, LGD_KVPMISPNOTEURL/LGD_KVPMISPWAPURL/LGD_KVPMISPCANCELURL를 설정하여 주시기 바랍니다.
     */
    String LGD_KVPMISPNOTEURL       = ServerAddr+"/mobile/xpayMobile/note_url.jsp";
    String LGD_KVPMISPWAPURL		= ServerAddr+"/mobile/xpayMobile/mispwapurl.jsp?LGD_OID=" + LGD_OID;  //ISP 카드 결제시, URL 대신 앱명 입력시, 앱호출함
    String LGD_KVPMISPCANCELURL     = ServerAddr+"/mobile/xpayMobile/cancel_url.jsp";

    /*
     *************************************************
     * 2. MD5 해쉬암호화 (수정하지 마세요) - BEGIN
     *
     * MD5 해쉬암호화는 거래 위변조를 막기위한 방법입니다.
     *************************************************
     *
     * 해쉬 암호화 적용( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
     * LGD_MID          : 상점아이디
     * LGD_OID          : 주문번호
     * LGD_AMOUNT       : 금액
     * LGD_TIMESTAMP    : 타임스탬프
     * LGD_MERTKEY      : 상점MertKey (mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
     *
     * MD5 해쉬데이터 암호화 검증을 위해
     * LG유플러스에서 발급한 상점키(MertKey)를 환경설정 파일(lgdacom/conf/mall.conf)에 반드시 입력하여 주시기 바랍니다.
     */
    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
    sb.append(LGD_TIMESTAMP);
    sb.append(LGD_MERTKEY);

    byte[] bNoti = sb.toString().getBytes();
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] digest = md.digest(bNoti);

    StringBuffer strBuf = new StringBuffer();
    for (int i=0 ; i < digest.length ; i++) {
        int c = digest[i] & 0xff;
        if (c <= 15){
            strBuf.append("0");
        }
        strBuf.append(Integer.toHexString(c));
    }

    String LGD_HASHDATA = strBuf.toString();
    String LGD_CUSTOM_PROCESSTYPE = "TWOTR";
    /*
     *************************************************
     * 2. MD5 해쉬암호화 (수정하지 마세요) - END
     *************************************************
     */

     String CST_WINDOW_TYPE = "submit";//수정불가
     HashMap payReqMap = new HashMap();
     payReqMap.put("CST_PLATFORM"                , CST_PLATFORM);                   	// 테스트, 서비스 구분
     payReqMap.put("CST_MID"                     , CST_MID );                        	// 상점아이디
     payReqMap.put("CST_WINDOW_TYPE"             , CST_WINDOW_TYPE );                        	// 상점아이디
     payReqMap.put("LGD_MID"                     , LGD_MID );                        	// 상점아이디
     payReqMap.put("LGD_OID"                     , LGD_OID );                        	// 주문번호
     payReqMap.put("LGD_BUYER"                   , LGD_BUYER );                      	// 구매자
     payReqMap.put("LGD_PRODUCTINFO"             , LGD_PRODUCTINFO );                	// 상품정보
     payReqMap.put("LGD_AMOUNT"                  , LGD_AMOUNT );                     	// 결제금액
     payReqMap.put("LGD_BUYEREMAIL"              , LGD_BUYEREMAIL );                 	// 구매자 이메일
     payReqMap.put("LGD_CUSTOM_SKIN"             , LGD_CUSTOM_SKIN );                	// 결제창 SKIN
     payReqMap.put("LGD_CUSTOM_PROCESSTYPE"      , LGD_CUSTOM_PROCESSTYPE );         	// 트랜잭션 처리방식
     payReqMap.put("LGD_TIMESTAMP"               , LGD_TIMESTAMP );                  	// 타임스탬프
     payReqMap.put("LGD_HASHDATA"                , LGD_HASHDATA );      	           	// MD5 해쉬암호값
     payReqMap.put("LGD_RETURNURL"   			, LGD_RETURNURL );      			   	// 응답수신페이지
     payReqMap.put("LGD_VERSION"         		, "JSP_SmartXPay_1.0");			   	   	// 버전정보 (삭제하지 마세요)
     payReqMap.put("LGD_CUSTOM_FIRSTPAY"  		, LGD_CUSTOM_FIRSTPAY );				// 디폴트 결제수단


     /*
     ****************************************************
     * 안드로이드폰 신용카드 ISP(국민/BC)결제에만 적용 (시작)*
     ****************************************************

     (주의)LGD_CUSTOM_ROLLBACK 의 값을  "Y"로 넘길 경우, LG U+ 전자결제에서 보낸 ISP(국민/비씨) 승인정보를 고객서버의 note_url에서 수신시  "OK" 리턴이 안되면  해당 트랜잭션은  무조건 롤백(자동취소)처리되고,
     LGD_CUSTOM_ROLLBACK 의 값 을 "C"로 넘길 경우, 고객서버의 note_url에서 "ROLLBACK" 리턴이 될 때만 해당 트랜잭션은  롤백처리되며  그외의 값이 리턴되면 정상 승인완료 처리됩니다.
     만일, LGD_CUSTOM_ROLLBACK 의 값이 "N" 이거나 null 인 경우, 고객서버의 note_url에서  "OK" 리턴이  안될시, "OK" 리턴이 될 때까지 3분간격으로 2시간동안  승인결과를 재전송합니다.
     */

     payReqMap.put("LGD_CUSTOM_ROLLBACK"         , "");		   	   				   // 비동기 ISP에서 트랜잭션 처리여부
     payReqMap.put("LGD_KVPMISPNOTEURL"  		 , LGD_KVPMISPNOTEURL );		   // 비동기 ISP(ex. 안드로이드) 승인결과를 받는 URL
     payReqMap.put("LGD_KVPMISPWAPURL"  		 , LGD_KVPMISPWAPURL );			   // 비동기 ISP(ex. 안드로이드) 승인완료후 사용자에게 보여지는 승인완료 URL
     payReqMap.put("LGD_KVPMISPCANCELURL"  		 , LGD_KVPMISPCANCELURL );		   // ISP 앱에서 취소시 사용자에게 보여지는 취소 URL

     /*
     ****************************************************
     * 안드로이드폰 신용카드 ISP(국민/BC)결제에만 적용    (끝) *
     ****************************************************
     */

     // 안드로이드 에서 신용카드 적용  ISP(국민/BC)결제에만 적용 (선택)
     // payReqMap.put("LGD_KVPMISPAUTOAPPYN", "Y");
     // Y: 안드로이드에서 ISP신용카드 결제시, 고객사에서 'App To App' 방식으로 국민, BC카드사에서 받은 결제 승인을 받고 고객사의 앱을 실행하고자 할때 사용

     // 가상계좌(무통장) 결제연동을 하시는 경우  할당/입금 결과를 통보받기 위해 반드시 LGD_CASNOTEURL 정보를 LG 유플러스에 전송해야 합니다 .
      payReqMap.put("LGD_CASNOTEURL"          , LGD_CASNOTEURL );               // 가상계좌 NOTEURL

  /*Return URL에서 인증 결과 수신 시 셋팅될 파라미터 입니다.*/
	payReqMap.put("LGD_RESPCODE"  		 , "" );
	payReqMap.put("LGD_RESPMSG"  		 , "" );
	payReqMap.put("LGD_PAYKEY"  		 , "" );
	
	String _ua = request.getHeader("user-agent").toLowerCase();
	
	if ( _ua.indexOf("iphone") > -1 || _ua.indexOf("ipod") > -1 || _ua.indexOf("ipad") > -1 ) {
		payReqMap.put("LGD_MTRANSFERNOTEURL"  	 , "N" );
		payReqMap.put("LGD_MTRANSFERWAPURL"  	 , "" );
		payReqMap.put("LGD_MTRANSFERCANCELURL" 	 , "" );
		payReqMap.put("LGD_MTRANSFERAUTOAPPYN"   , "N" );	
	} else {
		payReqMap.put("LGD_MTRANSFERNOTEURL"  	 , "A" );
		payReqMap.put("LGD_MTRANSFERWAPURL"  	 , "" );
		payReqMap.put("LGD_MTRANSFERCANCELURL" 	 , "" );
		payReqMap.put("LGD_MTRANSFERAUTOAPPYN"   , "A" );	
	}
	
	session.setAttribute("PAYREQ_MAP", payReqMap);

 %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>통합LG유플러스 전자결서비스 결제테스트</title>
<script language="javascript" src="http://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">

/*
* iframe으로 결제창을 호출하시기를 원하시면 iframe으로 설정 (변수명 수정 불가)
*/
	var LGD_window_type = '<%=CST_WINDOW_TYPE%>';
/*
* 수정불가
*/
function launchCrossPlatform(){
      lgdwin = open_paymentwindow(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type);
}
/*
* FORM 명만  수정 가능
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

</script>
</head>
<body onload="launchCrossPlatform()">
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="">
<table>
    <tr>
        <td>구매자 이름 </td>
        <td><%= LGD_BUYER %></td>
    </tr>
    <tr>
        <td>상품정보 </td>
        <td><%= LGD_PRODUCTINFO %></td>
    </tr>
    <tr>
        <td>결제금액 </td>
        <td><%= LGD_AMOUNT %></td>
    </tr>
    <tr>
        <td>구매자 이메일 </td>
        <td><%= LGD_BUYEREMAIL %></td>
    </tr>
    <tr>
        <td>주문번호 </td>
        <td><%= LGD_OID %></td>
    </tr>
    <tr>
        <td colspan="2">* 추가 상세 결제요청 파라미터는 메뉴얼을 참조하시기 바랍니다.</td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td colspan="2">
		<input type="button" value="인증요청" onclick="launchCrossPlatform();"/>
        </td>
    </tr>
</table>
<%
	for(Iterator i = payReqMap.keySet().iterator(); i.hasNext();){
		Object key = i.next();
		out.println("<input type='hidden' name='" + key + "' id='"+key+"' value='" + payReqMap.get(key) + "'>" );
	}
%>
</form>

</body>

</html>
