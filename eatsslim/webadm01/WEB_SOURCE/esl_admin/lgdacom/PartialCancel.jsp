<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="lgdacom.XPayClient.XPayClient"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="config.jsp" %>
<h3>PG�� ���� ��� ���</h3>
<%
    /*
     * [���� �κ���� ��û ������]
     *
     * LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)�� ������ �κ���� ��û�� �մϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     * (���ν� LG���÷������� ���� �������� PAYKEY�� ȥ������ ������.)
     */
    //String CST_PLATFORM         	= request.getParameter("CST_PLATFORM");                 //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)
    //String CST_MID              	= request.getParameter("CST_MID");                      //LG���÷������� ���� �߱޹����� �������̵� �Է��ϼ���.
    //String LGD_MID              	= ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
                                                                                        	//�������̵�(�ڵ�����)
    String LGD_TID              	= request.getParameter("LGD_TID");                      //LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)
	LGD_TID     				= ( LGD_TID == null )?"":LGD_TID; 
    String LGD_CANCELAMOUNT     	= request.getParameter("LGD_CANCELAMOUNT");             //�κ���� �ݾ�
    String LGD_REMAINAMOUNT     	= request.getParameter("LGD_REMAINAMOUNT");             //���� �ݾ�
//    String LGD_CANCELTAXFREEAMOUNT  = request.getParameter("LGD_CANCELTAXFREEAMOUNT");      //�鼼��� �κ���� �ݾ� (����/�鼼 ȥ������� ����)
    String LGD_CANCELREASON     	= request.getParameter("LGD_CANCELREASON"); 		    //��һ���
    String LGD_RFBANKCODE     		= request.getParameter("LGD_RFBANKCODE"); 		    	//ȯ�Ұ��� �����ڵ� (������¸� �ʼ�)
    String LGD_RFACCOUNTNUM     	= request.getParameter("LGD_RFACCOUNTNUM"); 		    //ȯ�Ұ��� ��ȣ (������¸� �ʼ�)
    String LGD_RFCUSTOMERNAME     	= request.getParameter("LGD_RFCUSTOMERNAME"); 		    //ȯ�Ұ��� ������ (������¸� �ʼ�)
    String LGD_RFPHONE     			= request.getParameter("LGD_RFPHONE"); 		    		//��û�� ����ó (������¸� �ʼ�)
     
    //String configPath 				= "C:/lgdacom";  										//LG���÷������� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����.
    
        
    LGD_CANCELAMOUNT     			= ( LGD_CANCELAMOUNT == null )?"":LGD_CANCELAMOUNT; 
    LGD_REMAINAMOUNT     			= ( LGD_REMAINAMOUNT == null )?"":LGD_REMAINAMOUNT; 
//    LGD_CANCELTAXFREEAMOUNT     = ( LGD_CANCELTAXFREEAMOUNT == null )?"":LGD_CANCELTAXFREEAMOUNT;
    LGD_CANCELREASON       			= ( LGD_CANCELREASON == null )?"":LGD_CANCELREASON;
    LGD_RFBANKCODE       			= ( LGD_RFBANKCODE == null )?"":LGD_RFBANKCODE;
    LGD_RFACCOUNTNUM       			= ( LGD_RFACCOUNTNUM == null )?"":LGD_RFACCOUNTNUM;
    LGD_RFCUSTOMERNAME       		= ( LGD_RFCUSTOMERNAME == null )?"":LGD_RFCUSTOMERNAME;
    LGD_RFPHONE       				= ( LGD_RFPHONE == null )?"":LGD_RFPHONE;
    
    XPayClient xpay = new XPayClient();
    xpay.Init(configPath, CST_PLATFORM);
	if (LGD_TID.indexOf("201612") != -1) {
		xpay.Init_TX("eatsslim");
	} else {
		xpay.Init_TX(LGD_MID);
	}
  	xpay.Set("LGD_TXNAME", "PartialCancel");
    xpay.Set("LGD_TID", LGD_TID);    
    xpay.Set("LGD_CANCELAMOUNT", LGD_CANCELAMOUNT);
    xpay.Set("LGD_REMAINAMOUNT", LGD_REMAINAMOUNT);
//    xpay.Set("LGD_CANCELTAXFREEAMOUNT", LGD_CANCELTAXFREEAMOUNT);
	xpay.Set("LGD_RFBANKCODE", LGD_RFBANKCODE);
    xpay.Set("LGD_RFACCOUNTNUM", LGD_RFACCOUNTNUM);
    xpay.Set("LGD_RFCUSTOMERNAME", LGD_RFCUSTOMERNAME);
    xpay.Set("LGD_RFPHONE", LGD_RFPHONE);
 
    /*
     * 1. ���� �κ���� ��û ���ó��
     *
     */
    if (xpay.TX()) {
        //1)���� �κ���Ұ�� ȭ��ó��(����,���� ��� ó���� �Ͻñ� �ٶ��ϴ�.)
        out.println("���� �κ���� ��û�� �Ϸ�Ǿ����ϴ�.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
        
        for (int ii = 0; ii < xpay.ResponseNameCount(); ii++)
        {
            out.println(xpay.ResponseName(ii) + " = ");
            for (int j = 0; j < xpay.ResponseCount(); j++)
            {
                out.println("\t" + xpay.Response(xpay.ResponseName(ii), j) + "<br>");
            }
        }
        out.println("<p>");
        
    }else {
        //2)API ��û ���� ȭ��ó��
        out.println("���� �κ���� ��û�� �����Ͽ����ϴ�.  <br>");
        out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
    }
	int i		= 0;
	///////////////////////////////PG ��Ұ�� ����
	String pgcancel="N", pgcancel_code="", pgcancel_msg="";
	String[] arrResCode=new String[] {"0000", "AV11", "RF00", "RF10", "RF09", "RF15", "RF19", "RF23", "RF25"};

	for( int ii = 0; ii < arrResCode.length; ii++ ){
		if(arrResCode[i].equals(xpay.m_szResCode)){
			pgcancel="Y";
		}
	}
	String query	= "";
	pgcancel_code=xpay.m_szResCode;
	pgcancel_msg=xpay.m_szResMsg;
	query="UPDATE ESL_ORDER SET PG_CANCEL='"+pgcancel+"',PG_CANCEL_CODE='"+pgcancel_code+"',PG_CANCEL_MSG='"+pgcancel_msg+"' WHERE PG_TID='"+LGD_TID+"'";
	try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
	/////////////////////////////////
%>
<%@ include file="/lib/dbclose.jsp" %>