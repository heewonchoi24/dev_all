<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="lgdacom.XPayClient.XPayClient"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="config.jsp" %>
<h3>PG�� ���� ��� ���</h3>
<%
    /*
     * [������� ��û ������]
     *
     * LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)�� ������ ��� ��û�� �մϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     * (���ν� LG���÷������� ���� �������� PAYKEY�� ȥ������ ������.)
     */
    //String CST_PLATFORM         = "test";                 //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)
    //String CST_MID              = "pmoamio";                      //LG���÷������� ���� �߱޹����� �������̵� �Է��ϼ���.
    //String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
                                                                                        //�������̵�(�ڵ�����)
    String LGD_TID              = request.getParameter("LGD_TID");                      //LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)

    /*String configPath 			= "C:/lgdacom";  										//LG���÷������� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����.
	if(request.getServerName().equals("183.101.223.86") || request.getServerName().equals("p.tmap4.com")){ // case developServer
		configPath="C:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\Admin\\lgdacom";
	} else { //case realServer
		configPath="/www/Admin/lgdacom";
	}*/
        
    LGD_TID     				= ( LGD_TID == null )?"":LGD_TID; 
	//---------------�߰�	
	String LGD_CANCELAMOUNT     	= request.getParameter("LGD_CANCELAMOUNT");             //�κ���� �ݾ�
    String LGD_REMAINAMOUNT     	= request.getParameter("LGD_REMAINAMOUNT");             //���� �ݾ�
//    String LGD_CANCELTAXFREEAMOUNT  = request.getParameter("LGD_CANCELTAXFREEAMOUNT");      //�鼼��� �κ���� �ݾ� (����/�鼼 ȥ������� ����)
    String LGD_CANCELREASON     	= request.getParameter("LGD_CANCELREASON"); 		    //��һ���
    String LGD_RFBANKCODE     		= request.getParameter("LGD_RFBANKCODE"); 		    	//ȯ�Ұ��� �����ڵ� (������¸� �ʼ�)
    String LGD_RFACCOUNTNUM     	= request.getParameter("LGD_RFACCOUNTNUM"); 		    //ȯ�Ұ��� ��ȣ (������¸� �ʼ�)
    String LGD_RFCUSTOMERNAME     	= request.getParameter("LGD_RFCUSTOMERNAME"); 		    //ȯ�Ұ��� ������ (������¸� �ʼ�)
    String LGD_RFPHONE     			= request.getParameter("LGD_RFPHONE"); 		    		//��û�� ����ó (������¸� �ʼ�)
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
	//---------------�߰�
	xpay.Set("LGD_CANCELAMOUNT", LGD_CANCELAMOUNT);
    xpay.Set("LGD_REMAINAMOUNT", LGD_REMAINAMOUNT);
//    xpay.Set("LGD_CANCELTAXFREEAMOUNT", LGD_CANCELTAXFREEAMOUNT);
	xpay.Set("LGD_RFBANKCODE", LGD_RFBANKCODE);
    xpay.Set("LGD_RFACCOUNTNUM", LGD_RFACCOUNTNUM);
    xpay.Set("LGD_RFCUSTOMERNAME", LGD_RFCUSTOMERNAME);
    xpay.Set("LGD_RFPHONE", LGD_RFPHONE);
	//---------------
 
    /*
     * 1. ������� ��û ���ó��
     *
     * ��Ұ�� ���� �Ķ���ʹ� �����޴����� �����Ͻñ� �ٶ��ϴ�.
	 *
	 * [[[�߿�]]] ���翡�� ������� ó���ؾ��� �����ڵ�
	 * 1. �ſ�ī�� : 0000, AV11  
	 * 2. ������ü : 0000, RF00, RF10, RF09, RF15, RF19, RF23, RF25 (ȯ�������� �����-> ȯ�Ұ���ڵ�.xls ����)
	 * 3. ������ ���������� ��� 0000(����) �� ��Ҽ��� ó��
	 *
     */	
    if (xpay.TX()) {
        //1)������Ұ�� ȭ��ó��(����,���� ��� ó���� �Ͻñ� �ٶ��ϴ�.)
        out.println("���� ��ҿ�û�� �Ϸ�Ǿ����ϴ�.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
		
    }else {
        //2)API ��û ���� ȭ��ó��
        out.println("���� ��ҿ�û�� �����Ͽ����ϴ�.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
    }

	///////////////////////////////PG ��Ұ�� ����
	String pgcancel="N", pgcancel_code="", pgcancel_msg="";
	String[] arrResCode=new String[] {"0000", "AV11", "RF00", "RF10", "RF09", "RF15", "RF19", "RF23", "RF25"};

	for( int ii = 0; ii < arrResCode.length; ii++ ){
		if(arrResCode[i].equals(xpay.m_szResCode)){
			pgcancel="Y";
		}
	}
	String query		= "";
	pgcancel_code=xpay.m_szResCode;
	pgcancel_msg=xpay.m_szResMsg;
	query="UPDATE ESL_ORDER set PG_CANCEL='"+pgcancel+"',PG_CANCEL_CODE='"+pgcancel_code+"',PG_CANCEL_MSG='"+pgcancel_msg+"' WHERE PG_TID='"+LGD_TID+"'";
	try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
	/////////////////////////////////
%>
<%@ include file="/inc/dbclose.jsp" %>