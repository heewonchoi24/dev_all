<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="javax.servlet.http.HttpSession,java.text.DecimalFormat,java.text.SimpleDateFormat,java.util.*,java.util.Date"%>
<%@ include file="config.jsp" %>
<%
request.setCharacterEncoding("euc-kr");
    /*
     * [���� ������û ������(STEP2-1)]
     *
     * ���������������� �⺻ �Ķ���͸� ���õǾ� ������, ������ �ʿ��Ͻ� �Ķ���ʹ� �����޴����� �����Ͻþ� �߰� �Ͻñ� �ٶ��ϴ�.
     */

    /*
     * 1. �⺻���� ������û ���� ����
     *
     * �⺻������ �����Ͽ� �ֽñ� �ٶ��ϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     */

    String LGD_BUYER            = request.getParameter("LGD_BUYER");                    //�����ڸ�
    String LGD_PRODUCTINFO      = request.getParameter("LGD_PRODUCTINFO");              //��ǰ��
    String LGD_BUYEREMAIL       = request.getParameter("LGD_BUYEREMAIL");               //������ �̸���

	LGD_OID              = request.getParameter("LGD_OID");                      //�ֹ���ȣ(�������� ����ũ�� �ֹ���ȣ�� �Է��ϼ���)
	LGD_AMOUNT           = request.getParameter("LGD_AMOUNT");                   //�����ݾ�("," �� ������ �����ݾ��� �Է��ϼ���)

    String LGD_CUSTOM_FIRSTPAY  = request.getParameter("LGD_CUSTOM_FIRSTPAY");          //�������� �ʱ��������
    String LGD_CUSTOM_SKIN      = "red";                                                //�������� ����â ��Ų(red, blue, cyan, green, yellow)
	
	String LGD_CLOSEDATE		= request.getParameter("LGD_CLOSEDATE");          //�������Ա� ��������

	String LGD_DISPLAY_BUYEREMAIL		= request.getParameter("LGD_DISPLAY_BUYEREMAIL");

    /*
     *************************************************
     * 2. MD5 �ؽ���ȣȭ (�������� ������) - BEGIN
     *
     * MD5 �ؽ���ȣȭ�� �ŷ� �������� �������� ����Դϴ�.
     *************************************************
     *
     * �ؽ� ��ȣȭ ����( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
     * LGD_MID          : �������̵�
     * LGD_OID          : �ֹ���ȣ
     * LGD_AMOUNT       : �ݾ�
     * LGD_TIMESTAMP    : Ÿ�ӽ�����
     * LGD_MERTKEY      : ����MertKey (mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�)
     *
     * MD5 �ؽ������� ��ȣȭ ������ ����
     * LG���÷������� �߱��� ����Ű(MertKey)�� ȯ�漳�� ����(lgdacom/conf/mall.conf)�� �ݵ�� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.
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
     * 2. MD5 �ؽ���ȣȭ (�������� ������) - END
     *************************************************
     */

     String CST_WINDOW_TYPE = "submit";//�����Ұ�
     HashMap payReqMap = new HashMap();
     payReqMap.put("CST_PLATFORM"                , CST_PLATFORM);                   	// �׽�Ʈ, ���� ����
     payReqMap.put("CST_MID"                     , CST_MID );                        	// �������̵�
     payReqMap.put("CST_WINDOW_TYPE"             , CST_WINDOW_TYPE );                        	// �������̵�
     payReqMap.put("LGD_MID"                     , LGD_MID );                        	// �������̵�
     payReqMap.put("LGD_OID"                     , LGD_OID );                        	// �ֹ���ȣ
     payReqMap.put("LGD_BUYER"                   , LGD_BUYER );                      	// ������
     payReqMap.put("LGD_PRODUCTINFO"             , LGD_PRODUCTINFO );                	// ��ǰ����
     payReqMap.put("LGD_AMOUNT"                  , LGD_AMOUNT );                     	// �����ݾ�
     payReqMap.put("LGD_BUYEREMAIL"              , LGD_BUYEREMAIL );                 	// ������ �̸���
     payReqMap.put("LGD_CUSTOM_SKIN"             , LGD_CUSTOM_SKIN );                	// ����â SKIN
     payReqMap.put("LGD_CUSTOM_PROCESSTYPE"      , LGD_CUSTOM_PROCESSTYPE );         	// Ʈ����� ó�����
     payReqMap.put("LGD_TIMESTAMP"               , LGD_TIMESTAMP );                  	// Ÿ�ӽ�����
     payReqMap.put("LGD_HASHDATA"                , LGD_HASHDATA );      	           	// MD5 �ؽ���ȣ��
     payReqMap.put("LGD_RETURNURL"   			, LGD_RETURNURL );      			   	// �������������
     payReqMap.put("LGD_VERSION"         		, "JSP_SmartXPay_1.0");			   	   	// �������� (�������� ������)
     payReqMap.put("LGD_CUSTOM_FIRSTPAY"  		, LGD_CUSTOM_FIRSTPAY );				// ����Ʈ ��������
	 payReqMap.put("LGD_DISPLAY_BUYEREMAIL"  	, LGD_DISPLAY_BUYEREMAIL );


     /*
     ****************************************************
     * �ȵ���̵��� �ſ�ī�� ISP(����/BC)�������� ���� (����)*
     ****************************************************

     (����)LGD_CUSTOM_ROLLBACK �� ����  "Y"�� �ѱ� ���, LG U+ ���ڰ������� ���� ISP(����/��) ���������� �������� note_url���� ���Ž�  "OK" ������ �ȵǸ�  �ش� Ʈ�������  ������ �ѹ�(�ڵ����)ó���ǰ�,
     LGD_CUSTOM_ROLLBACK �� �� �� "C"�� �ѱ� ���, �������� note_url���� "ROLLBACK" ������ �� ���� �ش� Ʈ�������  �ѹ�ó���Ǹ�  �׿��� ���� ���ϵǸ� ���� ���οϷ� ó���˴ϴ�.
     ����, LGD_CUSTOM_ROLLBACK �� ���� "N" �̰ų� null �� ���, �������� note_url����  "OK" ������  �ȵɽ�, "OK" ������ �� ������ 3�а������� 2�ð�����  ���ΰ���� �������մϴ�.
     */

     payReqMap.put("LGD_CUSTOM_ROLLBACK"         , "");		   	   				   // �񵿱� ISP���� Ʈ����� ó������
     payReqMap.put("LGD_KVPMISPNOTEURL"  		 , LGD_KVPMISPNOTEURL );		   // �񵿱� ISP(ex. �ȵ���̵�) ���ΰ���� �޴� URL
     payReqMap.put("LGD_KVPMISPWAPURL"  		 , LGD_KVPMISPWAPURL );			   // �񵿱� ISP(ex. �ȵ���̵�) ���οϷ��� ����ڿ��� �������� ���οϷ� URL
     payReqMap.put("LGD_KVPMISPCANCELURL"  		 , LGD_KVPMISPCANCELURL );		   // ISP �ۿ��� ��ҽ� ����ڿ��� �������� ��� URL

     /*
     ****************************************************
     * �ȵ���̵��� �ſ�ī�� ISP(����/BC)�������� ����    (��) *
     ****************************************************
     */

     // �ȵ���̵� ���� �ſ�ī�� ����  ISP(����/BC)�������� ���� (����)
     // payReqMap.put("LGD_KVPMISPAUTOAPPYN", "Y");
     // Y: �ȵ���̵忡�� ISP�ſ�ī�� ������, ���翡�� 'App To App' ������� ����, BCī��翡�� ���� ���� ������ �ް� ������ ���� �����ϰ��� �Ҷ� ���

     // �������(������) ���������� �Ͻô� ���  �Ҵ�/�Ա� ����� �뺸�ޱ� ���� �ݵ�� LGD_CASNOTEURL ������ LG ���÷����� �����ؾ� �մϴ� .
      payReqMap.put("LGD_CASNOTEURL"          , LGD_CASNOTEURL );               // ������� NOTEURL

  /*Return URL���� ���� ��� ���� �� ���õ� �Ķ���� �Դϴ�.*/
	payReqMap.put("LGD_RESPCODE"  		 , "" );
	payReqMap.put("LGD_RESPMSG"  		 , "" );
	payReqMap.put("LGD_PAYKEY"  		 , "" );
	
	payReqMap.put("LGD_CLOSEDATE"  		 , LGD_CLOSEDATE );
	
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
<script language="javascript" src="http://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">
/*
* iframe���� ����â�� ȣ���Ͻñ⸦ ���Ͻø� iframe���� ���� (������ ���� �Ұ�)
*/
	var LGD_window_type = '<%=CST_WINDOW_TYPE%>';	

/*
* �����Ұ�
*/
function launchCrossPlatform(){
	var lgdwin = open_paymentwindow(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type);
}
/*
* FORM ��  ���� ����
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

</script>
</head>
<body onload="launchCrossPlatform()">
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="" target="">
<!--
<table>
    <tr>
        <td>������ �̸� </td>
        <td><%= LGD_BUYER %></td>
    </tr>
    <tr>
        <td>��ǰ���� </td>
        <td><%= LGD_PRODUCTINFO %></td>
    </tr>
    <tr>
        <td>�����ݾ� </td>
        <td><%= LGD_AMOUNT %></td>
    </tr>
    <tr>
        <td>������ �̸��� </td>
        <td><%= LGD_BUYEREMAIL %></td>
    </tr>
    <tr>
        <td>�ֹ���ȣ </td>
        <td><%= LGD_OID %></td>
    </tr>
    <tr>
        <td colspan="2">
		<input type="button" value="������û" onclick="launchCrossPlatform();"/>
        </td>
    </tr>
</table>
-->
<%
	for(Iterator ii = payReqMap.keySet().iterator(); ii.hasNext();){
		Object key = ii.next();
		out.println("<input type='hidden' name='" + key + "' id='"+key+"' value='" + payReqMap.get(key) + "'>" );
	}
%>

</form>