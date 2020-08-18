<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="config.jsp" %>
<%
request.setCharacterEncoding("euc-kr");
%>

<script type="text/javascript">

/*
 * 결제요청 및 결과화면 처리 
 */

function doPay_ActiveX(platform){
    ret = xpay_check(document.getElementById('LGD_PAYINFO'), platform);

	if (ret=="00"){     //ActiveX 로딩 성공  
        var LGD_RESPCODE        = dpop.getData('LGD_RESPCODE');       	  //결과코드
        var LGD_RESPMSG         = dpop.getData('LGD_RESPMSG');        	  //결과메세지 
                      
        if( "0000" == LGD_RESPCODE && LGD_RESPMSG != "26") { //결제성공 (26은 계좌이체 시 상점사용가능 은행이 등록되어있지 않습니다) (LGD_RESPCODE에 26이 들어와야 하는데 LGD_RESPMSG에 전송해주고 있음)
	        var LGD_TID             = dpop.getData('LGD_TID');            //LG유플러스 거래번호
	        var LGD_OID             = dpop.getData('LGD_OID');            //주문번호 
	        var LGD_PAYTYPE         = dpop.getData('LGD_PAYTYPE');        //결제수단
	        var LGD_PAYDATE         = dpop.getData('LGD_PAYDATE');        //결제일자
	        var LGD_FINANCECODE     = dpop.getData('LGD_FINANCECODE');    //결제기관코드
	        var LGD_FINANCENAME     = dpop.getData('LGD_FINANCENAME');    //결제기관이름        
	        var LGD_FINANCEAUTHNUM  = dpop.getData('LGD_FINANCEAUTHNUM'); //결제사승인번호
	        var LGD_ACCOUNTNUM      = dpop.getData('LGD_ACCOUNTNUM');     //입금할 계좌 (가상계좌)
	        var LGD_BUYER           = dpop.getData('LGD_BUYER');          //구매자명
	        var LGD_PRODUCTINFO     = dpop.getData('LGD_PRODUCTINFO');    //상품명
	        var LGD_AMOUNT          = dpop.getData('LGD_AMOUNT');         //결제금액
            var LGD_NOTEURL_RESULT  = dpop.getData('LGD_NOTEURL_RESULT'); //상점DB처리(LGD_NOTEURL)결과 ('OK':정상,그외:실패)
			var LGD_CARDNUM = dpop.getData('LGD_CARDNUM'); //신용카드번호

	        //메뉴얼의 결제결과 파라미터내용을 참고하시어 필요하신 파라미터를 추가하여 사용하시기 바랍니다. 
	                     
            //var msg = "결제결과 : " + LGD_RESPMSG + "\n";            
            //msg += "LG유플러스거래TID : " + LGD_TID +"\n";
			var msg = "결제가 완료되었습니다.";
                                    
            //if( LGD_NOTEURL_RESULT != "null" ) msg += LGD_NOTEURL_RESULT +"\n";
           // alert(msg);
			document.frmOrder.LGD_TID.value = LGD_TID;
			document.frmOrder.LGD_CARDNUM.value = LGD_CARDNUM;
			document.frmOrder.LGD_FINANCECODE.value = LGD_FINANCECODE;
			document.frmOrder.LGD_FINANCENAME.value = LGD_FINANCENAME;
			document.frmOrder.LGD_ACCOUNTNUM.value = LGD_ACCOUNTNUM;
			document.frmOrder.LGD_FINANCEAUTHNUM.value = LGD_FINANCEAUTHNUM;
			if(LGD_PAYTYPE=="SC0010"){ //신용카드
				document.frmOrder.pay_type[0].checked=true;
			}else if(LGD_PAYTYPE=="SC0030"){ //계좌이체
				document.frmOrder.pay_type[1].checked=true;
			}else if(LGD_PAYTYPE=="SC0040"){ //가상계좌(무통장입금)
				document.frmOrder.pay_type[2].checked=true;
			}
			if(document.getElementById('btnPay'))document.getElementById('btnPay').style.display="none";


			document.frmOrder.action="/proc/order_proc.jsp";
			document.frmOrder.submit();
			//if(LGD_NOTEURL_RESULT)window.location.href=LGD_NOTEURL_RESULT;
			//window.location.href="/shopping/checkoutComplete.jsp?ono="+LGD_OID;

			/* 
            document.getElementById('LGD_RESPCODE').value = LGD_RESPCODE;
            document.getElementById('LGD_RESPMSG').value = LGD_RESPMSG;
            document.getElementById('LGD_TID').value = LGD_TID;
            document.getElementById('LGD_OID').value = LGD_OID;
            document.getElementById('LGD_PAYTYPE').value = LGD_PAYTYPE;
            document.getElementById('LGD_PAYDATE').value = LGD_PAYDATE;
            document.getElementById('LGD_FINANCECODE').value = LGD_FINANCECODE;
            document.getElementById('LGD_FINANCENAME').value = LGD_FINANCENAME;
            document.getElementById('LGD_FINANCEAUTHNUM').value = LGD_FINANCEAUTHNUM;
            document.getElementById('LGD_ACCOUNTNUM').value = LGD_ACCOUNTNUM;
            document.getElementById('LGD_BUYER').value = LGD_BUYER;
            document.getElementById('LGD_PRODUCTINFO').value = LGD_PRODUCTINFO;
            document.getElementById('LGD_AMOUNT').value = LGD_AMOUNT;
              
            document.getElementById('LGD_PAYINFO').submit();
			*/
     
        } else { //결제실패
            alert("결제가 실패하였습니다.\n에러사유:" + LGD_RESPMSG);			
			location.reload();
        }
    } else {
            alert("LG U+ 전자결제를 위한 XPayPlugin 모듈이 설치되지 않았습니다."); 
			xpay_showInstall();  //설치안내 팝업페이지 표시 코드 추가
    }     
}

/*
 * 결제요청 및 결과화면 처리 
 */
function doAnsimKeyin(){
//CST_PLATFORM은 test(테스트) 또는 service(서비스)를 넘겨주시면 됩니다. 
    ret = ansimkeyin_check(document.getElementById('LGD_PAYINFO'), 'service'); 

    if (ret=="00"){ //plug-in 정상 로딩
        var LGD_RESPCODE       = dpop.getData('LGD_RESPCODE');       //결과코드
        var LGD_RESPMSG        = dpop.getData('LGD_RESPMSG');        //결과메세지
	      if( "0000" == LGD_RESPCODE ) { //결제성공 
            var LGD_TID            = dpop.getData('LGD_TID');            //LG유플러스 거래KEY
	        var LGD_PAYDATE        = dpop.getData('LGD_PAYDATE');        //결제일자
            var LGD_FINANCECODE    = dpop.getData('LGD_FINANCECODE');    //결제기관코드
            var LGD_FINANCENAME    = dpop.getData('LGD_FINANCENAME');    //결제기관이름
            var LGD_NOTEURL_RESULT = dpop.getData('LGD_NOTEURL_RESULT'); //상점DB처리결과
			
	        var LGD_FINANCEAUTHNUM  = dpop.getData('LGD_FINANCEAUTHNUM'); //결제사승인번호
			var LGD_CARDNUM 		= dpop.getData('LGD_CARDNUM'); //신용카드번호
			var LGD_PAYTYPE         = dpop.getData('LGD_PAYTYPE');        //결제수단
			
			var msg = "결제가 완료되었습니다.";
			
			document.frmOrder.LGD_TID.value = LGD_TID;
			document.frmOrder.LGD_CARDNUM.value = LGD_CARDNUM;
			document.frmOrder.LGD_FINANCECODE.value = LGD_FINANCECODE;
			document.frmOrder.LGD_FINANCENAME.value = LGD_FINANCENAME;
			document.frmOrder.LGD_FINANCEAUTHNUM.value = LGD_FINANCEAUTHNUM;
			
			document.frmOrder.pay_type.checked=true;
			if(document.getElementById('btnPay'))document.getElementById('btnPay').style.display="none";

			document.frmOrder.action="/proc/order_proc.jsp";
			document.frmOrder.submit();			
			
	
            //alert("결제가 성공하였습니다. LG유플러스 거래ID : " + LGD_TID);
            /*
             * 결제성공 화면 처리
             */        
       
        } else { //결제실패
             alert("결제가 실패하였습니다. " + LGD_RESPMSG);
			 location.reload();
            /*
             * 결제실패 화면 처리
             */        
        }
    } else {
        alert("LG유플러스 전자결제를 위한 ActiveX 설치 실패");
    }     
} 

</script>

<form method="post" id="LGD_PAYINFO" name="LGD_PAYINFO" action ="/xpay/note_url.jsp">

	<input type="hidden" name="LGD_MID"             value="kvp_eatsslim1"/>                        				<!-- 상점아이디 -->
	<input type="hidden" name="LGD_OID"             id = 'LGD_OID'              value=""/>            <!-- 주문번호 -->
	<input type="hidden" name="LGD_BUYER"           id = 'LGD_BUYER'            value=""/>          <!-- 구매자 -->
	<input type="hidden" name="LGD_PRODUCTINFO"     id = 'LGD_PRODUCTINFO'      value="<%=productName%>"/>    <!-- 상품정보 -->
	<input type="hidden" name="LGD_AMOUNT"          id = 'LGD_AMOUNT'           value=""/>         <!-- 결제금액 -->
	<input type="hidden" name="LGD_BUYEREMAIL"      value=""/>                 				<!-- 구매자 이메일 -->
	<input type="hidden" name="LGD_CUSTOM_SKIN"     value="green"/>                			<!-- 결제창 SKIN  (red, blue, cyan, green, yellow) -->
	<input type="hidden" name="LGD_TIMESTAMP"       value=""/>                  				<!-- 타임스탬프 -->
	<input type="hidden" name="LGD_HASHDATA"        value=""/>                   				<!-- MD5 해쉬암호값 -->
	<input type="hidden" name="LGD_NOTEURL"			value="<%=LGD_NOTEURL%>"/>                    				<!-- 결제결과 수신페이지 URL --> 
	<input type="hidden" name="LGD_VERSION"         value="JSP_XPay_lite_1.0"/>			        					<!-- 버전정보 (삭제하지 마세요) -->
	
	<input type="hidden" name="LGD_TID"			    id = 'LGD_TID'              value=""/>
	<input type="hidden" name="LGD_PAYTYPE"	        id = 'LGD_PAYTYPE'		    value=""/>
	<input type="hidden" name="LGD_PAYDATE"	        id = 'LGD_PAYDATE'		    value=""/>
	<input type="hidden" name="LGD_FINANCECODE"	    id = 'LGD_FINANCECODE'		value=""/>
	<input type="hidden" name="LGD_FINANCENAME"	    id = 'LGD_FINANCENAME'		value=""/>
	<input type="hidden" name="LGD_FINANCEAUTHNUM"	id = 'LGD_FINANCEAUTHNUM'	value=""/> 
	<input type="hidden" name="LGD_ACCOUNTNUM"	    id = 'LGD_ACCOUNTNUM'		value=""/>                   
	<input type="hidden" name="LGD_RESPCODE"        id = 'LGD_RESPCODE'         value=""/>
	<input type="hidden" name="LGD_RESPMSG"         id = 'LGD_RESPMSG'          value=""/>
	<input type="hidden" name="LGD_CLOSEDATE"       id = 'LGD_CLOSEDATE'        value=""/>

	<input type="hidden" name="LGD_CUSTOM_FIRSTPAY" id = 'LGD_CUSTOM_FIRSTPAY' value=""/>
	<input type="hidden" name="LGD_CUSTOM_USABLEPAY" id = 'LGD_CUSTOM_USABLEPAY' value=""/> <!--특정결제수단만 보이게 할 경우 사용 예)SC0010-SC0030-->
	
	<!--<input type="hidden" name="LGD_CUSTOM_LOGO" id = 'LGD_CUSTOM_LOGO' value=""/>-->  <!-- 결제창 로고 -->
	<input type="hidden" name="LGD_ESCROW_USEYN" id = 'LGD_ESCROW_USEYN' value="Y"/>
	<input type="hidden" name="LGD_DISPLAY_BUYERPHONE" id = 'LGD_DISPLAY_BUYERPHONE' value="Y"/>

	
	<!-- 가상계좌(무통장) 결제연동을 하시는 경우 주석을 반드시 해제 하시기 바랍니다. -->
	<input type="hidden" name="LGD_CASNOTEURL"			    value="<%=LGD_CASNOTEURL%>"/>       <!-- 가상계좌 NOTEURL -->

	<!-- 결제창UI 이메일주소 입력여부 -->
	<input type="hidden" name="LGD_DISPLAY_BUYEREMAIL" id = "LGD_DISPLAY_BUYEREMAIL" value="N"/>
</form>

<%
String findStr="(?i).*MSIE.*";
String UA=request.getHeader("user-agent");
if(UA.matches(findStr)){
%>
<script language="javascript" src="<%=request.getScheme()%>://xpay.uplus.co.kr<%="test".equals(platform)?(request.getScheme().equals("https")?":7443":":7080"):""%>/xpay/js/xpay.js" type="text/javascript"></script>
</script>
<%}else{ //IE외 브라우저%>
<script language="javascript" src="<%=request.getScheme()%>://xpay.uplus.co.kr<%="test".equals(platform)?(request.getScheme().equals("https")?":7443":":7080"):""%>/xpay/js/xpay_ub.js" type="text/javascript"></script>
<%}%>