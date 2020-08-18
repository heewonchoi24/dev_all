<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.security.MessageDigest, java.util.*" %>
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
    String CST_PLATFORM         = "service";                 //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)
    String CST_MID              = "eatsslim";                      //LG���÷����� ���� �߱޹����� �������̵� �Է��ϼ���.
    String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
                                                                                        //�������̵�(�ڵ�����)
    String LGD_OID              = request.getParameter("LGD_OID");                      //�ֹ���ȣ(�������� ����ũ�� �ֹ���ȣ�� �Է��ϼ���)
    String LGD_AMOUNT           = request.getParameter("LGD_AMOUNT");                   //�����ݾ�("," �� ������ �����ݾ��� �Է��ϼ���)
    String LGD_MERTKEY          = "bbc52915b7b3cc90d88c76b78856dcba";              		//����MertKey(mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�)
    String LGD_BUYER            = request.getParameter("LGD_BUYER");                    //�����ڸ�
    String LGD_PRODUCTINFO      = request.getParameter("LGD_PRODUCTINFO");              //��ǰ��
    String LGD_BUYEREMAIL       = request.getParameter("LGD_BUYEREMAIL");               //������ �̸���
    String LGD_TIMESTAMP        = request.getParameter("LGD_TIMESTAMP");                //Ÿ�ӽ�����
    String LGD_CUSTOM_FIRSTPAY  = request.getParameter("LGD_CUSTOM_FIRSTPAY");          //�������� �ʱ��������
    String LGD_CUSTOM_SKIN      = "red";                                                //�������� ����â ��Ų(red, blue, cyan, green, yellow)

	String ServerAddr="";
	ServerAddr = "http://www.eatsslim.co.kr";

    /*
     * �������(������) ���� ������ �Ͻô� ��� �Ʒ� LGD_CASNOTEURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�.
     */
    String LGD_CASNOTEURL		= ServerAddr+"/mobile/xpayMobile/cas_noteurl.jsp";

    /*
     * LGD_RETURNURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�. �ݵ�� ���� �������� ������ ����Ʈ�� ��  ȣ��Ʈ�̾�� �մϴ�. �Ʒ� �κ��� �ݵ�� �����Ͻʽÿ�.
     */
    String LGD_RETURNURL		= ServerAddr+"/mobile/xpayMobile/returnurl.jsp";// FOR MANUAL

    /*
     * ISP ī����� ������ �����ISP���(�������� ���������ʴ� �񵿱���)�� ���, LGD_KVPMISPNOTEURL/LGD_KVPMISPWAPURL/LGD_KVPMISPCANCELURL�� �����Ͽ� �ֽñ� �ٶ��ϴ�.
     */
    String LGD_KVPMISPNOTEURL       = ServerAddr+"/mobile/xpayMobile/note_url.jsp";
    String LGD_KVPMISPWAPURL		= ServerAddr+"/mobile/xpayMobile/mispwapurl.jsp?LGD_OID=" + LGD_OID;  //ISP ī�� ������, URL ��� �۸� �Է½�, ��ȣ����
    String LGD_KVPMISPCANCELURL     = ServerAddr+"/mobile/xpayMobile/cancel_url.jsp";

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
<title>����LG���÷��� ���ڰἭ�� �����׽�Ʈ</title>
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
      lgdwin = open_paymentwindow(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type);
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
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="">
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
        <td colspan="2">* �߰� �� ������û �Ķ���ʹ� �޴����� �����Ͻñ� �ٶ��ϴ�.</td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td colspan="2">
		<input type="button" value="������û" onclick="launchCrossPlatform();"/>
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
