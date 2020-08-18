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
 * ������û �� ���ȭ�� ó�� 
 */

function doPay_ActiveX(platform){
    ret = xpay_check(document.getElementById('LGD_PAYINFO'), platform);

	if (ret=="00"){     //ActiveX �ε� ����  
        var LGD_RESPCODE        = dpop.getData('LGD_RESPCODE');       	  //����ڵ�
        var LGD_RESPMSG         = dpop.getData('LGD_RESPMSG');        	  //����޼��� 
                      
        if( "0000" == LGD_RESPCODE && LGD_RESPMSG != "26") { //�������� (26�� ������ü �� ������밡�� ������ ��ϵǾ����� �ʽ��ϴ�) (LGD_RESPCODE�� 26�� ���;� �ϴµ� LGD_RESPMSG�� �������ְ� ����)
	        var LGD_TID             = dpop.getData('LGD_TID');            //LG���÷��� �ŷ���ȣ
	        var LGD_OID             = dpop.getData('LGD_OID');            //�ֹ���ȣ 
	        var LGD_PAYTYPE         = dpop.getData('LGD_PAYTYPE');        //��������
	        var LGD_PAYDATE         = dpop.getData('LGD_PAYDATE');        //��������
	        var LGD_FINANCECODE     = dpop.getData('LGD_FINANCECODE');    //��������ڵ�
	        var LGD_FINANCENAME     = dpop.getData('LGD_FINANCENAME');    //��������̸�        
	        var LGD_FINANCEAUTHNUM  = dpop.getData('LGD_FINANCEAUTHNUM'); //��������ι�ȣ
	        var LGD_ACCOUNTNUM      = dpop.getData('LGD_ACCOUNTNUM');     //�Ա��� ���� (�������)
	        var LGD_BUYER           = dpop.getData('LGD_BUYER');          //�����ڸ�
	        var LGD_PRODUCTINFO     = dpop.getData('LGD_PRODUCTINFO');    //��ǰ��
	        var LGD_AMOUNT          = dpop.getData('LGD_AMOUNT');         //�����ݾ�
            var LGD_NOTEURL_RESULT  = dpop.getData('LGD_NOTEURL_RESULT'); //����DBó��(LGD_NOTEURL)��� ('OK':����,�׿�:����)
			var LGD_CARDNUM = dpop.getData('LGD_CARDNUM'); //�ſ�ī���ȣ

	        //�޴����� ������� �Ķ���ͳ����� �����Ͻþ� �ʿ��Ͻ� �Ķ���͸� �߰��Ͽ� ����Ͻñ� �ٶ��ϴ�. 
	                     
            //var msg = "������� : " + LGD_RESPMSG + "\n";            
            //msg += "LG���÷����ŷ�TID : " + LGD_TID +"\n";
			var msg = "������ �Ϸ�Ǿ����ϴ�.";
                                    
            //if( LGD_NOTEURL_RESULT != "null" ) msg += LGD_NOTEURL_RESULT +"\n";
           // alert(msg);
			document.frmOrder.LGD_TID.value = LGD_TID;
			document.frmOrder.LGD_CARDNUM.value = LGD_CARDNUM;
			document.frmOrder.LGD_FINANCECODE.value = LGD_FINANCECODE;
			document.frmOrder.LGD_FINANCENAME.value = LGD_FINANCENAME;
			document.frmOrder.LGD_ACCOUNTNUM.value = LGD_ACCOUNTNUM;
			document.frmOrder.LGD_FINANCEAUTHNUM.value = LGD_FINANCEAUTHNUM;
			if(LGD_PAYTYPE=="SC0010"){ //�ſ�ī��
				document.frmOrder.pay_type[0].checked=true;
			}else if(LGD_PAYTYPE=="SC0030"){ //������ü
				document.frmOrder.pay_type[1].checked=true;
			}else if(LGD_PAYTYPE=="SC0040"){ //�������(�������Ա�)
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
     
        } else { //��������
            alert("������ �����Ͽ����ϴ�.\n��������:" + LGD_RESPMSG);			
			location.reload();
        }
    } else {
            alert("LG U+ ���ڰ����� ���� XPayPlugin ����� ��ġ���� �ʾҽ��ϴ�."); 
			xpay_showInstall();  //��ġ�ȳ� �˾������� ǥ�� �ڵ� �߰�
    }     
}

/*
 * ������û �� ���ȭ�� ó�� 
 */
function doAnsimKeyin(){
//CST_PLATFORM�� test(�׽�Ʈ) �Ǵ� service(����)�� �Ѱ��ֽø� �˴ϴ�. 
    ret = ansimkeyin_check(document.getElementById('LGD_PAYINFO'), 'service'); 

    if (ret=="00"){ //plug-in ���� �ε�
        var LGD_RESPCODE       = dpop.getData('LGD_RESPCODE');       //����ڵ�
        var LGD_RESPMSG        = dpop.getData('LGD_RESPMSG');        //����޼���
	      if( "0000" == LGD_RESPCODE ) { //�������� 
            var LGD_TID            = dpop.getData('LGD_TID');            //LG���÷��� �ŷ�KEY
	        var LGD_PAYDATE        = dpop.getData('LGD_PAYDATE');        //��������
            var LGD_FINANCECODE    = dpop.getData('LGD_FINANCECODE');    //��������ڵ�
            var LGD_FINANCENAME    = dpop.getData('LGD_FINANCENAME');    //��������̸�
            var LGD_NOTEURL_RESULT = dpop.getData('LGD_NOTEURL_RESULT'); //����DBó�����
			
	        var LGD_FINANCEAUTHNUM  = dpop.getData('LGD_FINANCEAUTHNUM'); //��������ι�ȣ
			var LGD_CARDNUM 		= dpop.getData('LGD_CARDNUM'); //�ſ�ī���ȣ
			var LGD_PAYTYPE         = dpop.getData('LGD_PAYTYPE');        //��������
			
			var msg = "������ �Ϸ�Ǿ����ϴ�.";
			
			document.frmOrder.LGD_TID.value = LGD_TID;
			document.frmOrder.LGD_CARDNUM.value = LGD_CARDNUM;
			document.frmOrder.LGD_FINANCECODE.value = LGD_FINANCECODE;
			document.frmOrder.LGD_FINANCENAME.value = LGD_FINANCENAME;
			document.frmOrder.LGD_FINANCEAUTHNUM.value = LGD_FINANCEAUTHNUM;
			
			document.frmOrder.pay_type.checked=true;
			if(document.getElementById('btnPay'))document.getElementById('btnPay').style.display="none";

			document.frmOrder.action="/proc/order_proc.jsp";
			document.frmOrder.submit();			
			
	
            //alert("������ �����Ͽ����ϴ�. LG���÷��� �ŷ�ID : " + LGD_TID);
            /*
             * �������� ȭ�� ó��
             */        
       
        } else { //��������
             alert("������ �����Ͽ����ϴ�. " + LGD_RESPMSG);
			 location.reload();
            /*
             * �������� ȭ�� ó��
             */        
        }
    } else {
        alert("LG���÷��� ���ڰ����� ���� ActiveX ��ġ ����");
    }     
} 

</script>

<form method="post" id="LGD_PAYINFO" name="LGD_PAYINFO" action ="/xpay/note_url.jsp">

	<input type="hidden" name="LGD_MID"             value="kvp_eatsslim1"/>                        				<!-- �������̵� -->
	<input type="hidden" name="LGD_OID"             id = 'LGD_OID'              value=""/>            <!-- �ֹ���ȣ -->
	<input type="hidden" name="LGD_BUYER"           id = 'LGD_BUYER'            value=""/>          <!-- ������ -->
	<input type="hidden" name="LGD_PRODUCTINFO"     id = 'LGD_PRODUCTINFO'      value="<%=productName%>"/>    <!-- ��ǰ���� -->
	<input type="hidden" name="LGD_AMOUNT"          id = 'LGD_AMOUNT'           value=""/>         <!-- �����ݾ� -->
	<input type="hidden" name="LGD_BUYEREMAIL"      value=""/>                 				<!-- ������ �̸��� -->
	<input type="hidden" name="LGD_CUSTOM_SKIN"     value="green"/>                			<!-- ����â SKIN  (red, blue, cyan, green, yellow) -->
	<input type="hidden" name="LGD_TIMESTAMP"       value=""/>                  				<!-- Ÿ�ӽ����� -->
	<input type="hidden" name="LGD_HASHDATA"        value=""/>                   				<!-- MD5 �ؽ���ȣ�� -->
	<input type="hidden" name="LGD_NOTEURL"			value="<%=LGD_NOTEURL%>"/>                    				<!-- ������� ���������� URL --> 
	<input type="hidden" name="LGD_VERSION"         value="JSP_XPay_lite_1.0"/>			        					<!-- �������� (�������� ������) -->
	
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
	<input type="hidden" name="LGD_CUSTOM_USABLEPAY" id = 'LGD_CUSTOM_USABLEPAY' value=""/> <!--Ư���������ܸ� ���̰� �� ��� ��� ��)SC0010-SC0030-->
	
	<!--<input type="hidden" name="LGD_CUSTOM_LOGO" id = 'LGD_CUSTOM_LOGO' value=""/>-->  <!-- ����â �ΰ� -->
	<input type="hidden" name="LGD_ESCROW_USEYN" id = 'LGD_ESCROW_USEYN' value="Y"/>
	<input type="hidden" name="LGD_DISPLAY_BUYERPHONE" id = 'LGD_DISPLAY_BUYERPHONE' value="Y"/>

	
	<!-- �������(������) ���������� �Ͻô� ��� �ּ��� �ݵ�� ���� �Ͻñ� �ٶ��ϴ�. -->
	<input type="hidden" name="LGD_CASNOTEURL"			    value="<%=LGD_CASNOTEURL%>"/>       <!-- ������� NOTEURL -->

	<!-- ����âUI �̸����ּ� �Է¿��� -->
	<input type="hidden" name="LGD_DISPLAY_BUYEREMAIL" id = "LGD_DISPLAY_BUYEREMAIL" value="N"/>
</form>

<%
String findStr="(?i).*MSIE.*";
String UA=request.getHeader("user-agent");
if(UA.matches(findStr)){
%>
<script language="javascript" src="<%=request.getScheme()%>://xpay.uplus.co.kr<%="test".equals(platform)?(request.getScheme().equals("https")?":7443":":7080"):""%>/xpay/js/xpay.js" type="text/javascript"></script>
</script>
<%}else{ //IE�� ������%>
<script language="javascript" src="<%=request.getScheme()%>://xpay.uplus.co.kr<%="test".equals(platform)?(request.getScheme().equals("https")?":7443":":7080"):""%>/xpay/js/xpay_ub.js" type="text/javascript"></script>
<%}%>