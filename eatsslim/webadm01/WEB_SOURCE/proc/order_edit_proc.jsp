<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.SimpleDateFormat,java.util.*,java.util.Date"%>
<%@ page import="lgdacom.XPayClient.XPayClient"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/xpay/config.jsp" %>
<!--h3>PG�� ���� ��� ���</h3-->
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
alert("�α����� ���ּ���.");
parent.document.location.href = "/index.jsp";
</script>
<%
	if (true) return;
}

String query		= "";
String chgstate = "";
String mode			= ut.inject(request.getParameter("mode"));
String orderNum		= ut.inject(request.getParameter("order_num"));
if(orderNum.equals("")){ out.println("�ֹ���ȣ ����");if(true)return;}
String code			= ut.inject(request.getParameter("code"));
if(code==null){out.println("code ����");if(true)return;}
String reasonType	= ut.inject(request.getParameter("reason_type"));
if (reasonType == null || reasonType.length()==0) reasonType="0";
String bankName		= ut.inject(request.getParameter("bankName")); //ȯ�Ұ������� ��
String bankUser		= ut.inject(request.getParameter("bankUser")); //ȯ�� ���� ������
String bankAccount	= ut.inject(request.getParameter("bankAccount")); //ȯ�Ұ��¹�ȣ
String reason		= ut.inject(request.getParameter("reason"));
String payType		= ut.inject(request.getParameter("pay_type"));
String pgTID		= ut.inject(request.getParameter("pgTID")); //PG�� �ŷ���ȣ
String payYn        = ut.inject(request.getParameter("payYn")); //���� ����
String msg = "";
String cancelFrom = ut.inject(request.getParameter("cancelFrom")); //�ֹ���Ҹ� ����Ͽ��� �ߴ��� üũ
String mtype	= ut.inject(request.getParameter("mtype")); //�ֹ���Ҹ� ����� ����ʿ��� �ߴ��� üũ

if(cancelFrom.equals("mobile")) {
	reason = "����� �ֹ� ���"; //����Ϸ� �ֹ���ҽ� ��� ���� ����
}

%>
	 <%if(cancelFrom.equals("mobile")){ %> <div class="m_c_cancel"><img id="m_loading_img" alt="loading" src="/images/m_loader_wait.gif"/> <p id="m_txt_cancel">������Դϴ�. ��ø� ��ٷ��ּ���...</p></div>
 <%} else{%> <div class="c_cancel"><img id="loading_img" alt="loading" src="/images/loader_wait.gif"/> <p id="txt_cancel">������Դϴ�. ��ø� ��ٷ��ּ���...</p></div><%}%>
 <%

if(payYn.equals("Y")){
    /*
     * [������� ��û ������]
     *
     * LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)�� ������ ��� ��û�� �մϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     * (���ν� LG���÷������� ���� �������� PAYKEY�� ȥ������ ������.)
     */                                                                                        //�������̵�(�ڵ�����)
    String LGD_TID              = pgTID;                      //LG���÷������� ���� �������� �ŷ���ȣ(LGD_TID)
	if(LGD_TID==null || LGD_TID.length()==0){
		out.println("���� : �ŷ���ȣ(LGD_TID) ����");if(true)return;
	}
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
        //out.println("���� ��ҿ�û�� �Ϸ�Ǿ����ϴ�.  <br>");
        //out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        //out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
		//out.println("<script>self.close();</script>");

		if(xpay.m_szResCode.equals("0000") || xpay.m_szResCode.equals("RF24")){
			///////////////////////////////PG ��Ұ�� ����		
			//out.println("���� ��ҿ�û�� �����Ͽ����ϴ�.  <br>");
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
			pgcancel_msg=xpay.m_szResMsg;// ��Ҽ���
			
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
	
				if(mode.equals("cancel")){ //############# ���ó��

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
			//msg = "alert('��� ó���� �Ϸ�Ǿ����ϴ�.');";
		}else{
			//out.println("���� ��ҿ�û�� �����Ͽ����ϴ�.  <br>");
			//out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
			//out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
			%>
			<script type="text/javascript">
				<%if(cancelFrom.equals("mobile")){ %> document.getElementById("m_txt_cancel").style.display = "none";
				<%} else{%> document.getElementById("txt_cancel").style.display = "none"; <%}%>			
			</script>
			<%
			msg += "alert('��� ó���� ���еǾ����ϴ�. LG U+ ���ڰ��� ������(1544-7772)�� �����ּ���.');"+"";
			if(cancelFrom.equals("mobile")) { //����Ϸ� �ֹ���ҽ� �ֹ�����Ʈ�� ���ư�
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
		//2)API ��û ���� ȭ��ó��
		//out.println("���� ��ҿ�û�� �����Ͽ����ϴ�.  <br>");
		//out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
		//out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
		msg += "alert('��� ó���� ���еǾ����ϴ�. LG U+ ���ڰ��� ������(1544-7772)�� �����ּ���.');"+"";
            if(cancelFrom.equals("mobile")) { //����Ϸ� �ֹ���ҽ� �ֹ�����Ʈ�� ���ư�
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
else{// ������/�ֹ���������
	//out.println("������/�ֹ���������");

	if(mode!=null){
	
		if(mode.equals("cancel")){ //############# ���ó��

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