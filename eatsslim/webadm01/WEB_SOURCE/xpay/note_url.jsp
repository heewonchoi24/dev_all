<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_bm.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp" %>
<%@ include file="config.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
    /*
     * [���� �������ó��(DB) ������]
     *
     * 1) ������ ������ ���� hashdata�� ������ �ݵ�� �����ϼž� �մϴ�.
     *
     */

    /*
     * ���������� ���� 
     */
    String LGD_RESPCODE = "";           // �����ڵ�: 0000(����) �׿� ����
    String LGD_RESPMSG = "";            // ����޼���
    /*String LGD_MID = "";                // �������̵� 
    String LGD_OID = "";                // �ֹ���ȣ
    String LGD_AMOUNT = "";             // �ŷ��ݾ�
	*/
    String LGD_TID = "";                // LG���÷������� �ο��� �ŷ���ȣ
    String LGD_PAYTYPE = "";            // ���������ڵ�
    String LGD_PAYDATE = "";            // �ŷ��Ͻ�(�����Ͻ�/��ü�Ͻ�)
    String LGD_HASHDATA = "";           // �ؽ���
    String LGD_FINANCECODE = "";        // ��������ڵ�(ī������/�����ڵ�/������ڵ�)
    String LGD_FINANCENAME = "";        // ��������̸�(ī���̸�/�����̸�/������̸�)
    String LGD_ESCROWYN = "";           // ����ũ�� ���뿩��
    //String LGD_TIMESTAMP = "";          // Ÿ�ӽ�����
    String LGD_FINANCEAUTHNUM = "";     // ������� ���ι�ȣ(�ſ�ī��, ������ü, ��ǰ��)

    /*
     * �ſ�ī�� ������� ����
     */
    String LGD_CARDNUM = "";            // ī���ȣ(�ſ�ī��)
    String LGD_CARDINSTALLMONTH = "";   // �Һΰ�����(�ſ�ī��) 
    String LGD_CARDNOINTYN = "";        // �������Һο���(�ſ�ī��) - '1'�̸� �������Һ� '0'�̸� �Ϲ��Һ�
    String LGD_TRANSAMOUNT = "";        // ȯ������ݾ�(�ſ�ī��)
    String LGD_EXCHANGERATE = "";       // ȯ��(�ſ�ī��)

    /*
     * �޴���
     */
    String LGD_PAYTELNUM = "";          // ������ �̿����ȭ��ȣ

    /*
     * ������ü, ������
     */
    String LGD_ACCOUNTNUM = "";         // ���¹�ȣ(������ü, �������Ա�) 
    String LGD_CASTAMOUNT = "";         // �Ա��Ѿ�(�������Ա�)
    String LGD_CASCAMOUNT = "";         // ���Աݾ�(�������Ա�)
    String LGD_CASFLAG = "";            // �������Ա� �÷���(�������Ա�) - 'R':�����Ҵ�, 'I':�Ա�, 'C':�Ա���� 
    String LGD_CASSEQNO = "";           // �Աݼ���(�������Ա�)
    String LGD_CASHRECEIPTNUM = "";     // ���ݿ����� ���ι�ȣ
    String LGD_CASHRECEIPTSELFYN = "";  // ���ݿ����������߱������� Y: �����߱��� ����, �׿� : ������
    String LGD_CASHRECEIPTKIND = "";    // ���ݿ����� ���� 0: �ҵ������ , 1: ����������

    /*
     * OKĳ����
     */
    String LGD_OCBSAVEPOINT = "";       // OKĳ���� ��������Ʈ
    String LGD_OCBTOTALPOINT = "";      // OKĳ���� ��������Ʈ
    String LGD_OCBUSABLEPOINT = "";     // OKĳ���� ��밡�� ����Ʈ

    /*
     * ��������
     */
    String LGD_BUYER = "";              // ������
    String LGD_PRODUCTINFO = "";        // ��ǰ��
    String LGD_BUYERID = "";            // ������ ID
    String LGD_BUYERADDRESS = "";       // ������ �ּ�
    String LGD_BUYERPHONE = "";         // ������ ��ȭ��ȣ
    String LGD_BUYEREMAIL = "";         // ������ �̸���
    String LGD_BUYERSSN = "";           // ������ �ֹι�ȣ
    String LGD_PRODUCTCODE = "";        // ��ǰ�ڵ�
    String LGD_RECEIVER = "";           // ������
    String LGD_RECEIVERPHONE = "";      // ������ ��ȭ��ȣ
    String LGD_DELIVERYINFO = "";       // �����
	
	String LGD_DISPLAY_BUYEREMAIL = "";

    LGD_RESPCODE            = request.getParameter("LGD_RESPCODE");
    LGD_RESPMSG             = request.getParameter("LGD_RESPMSG");
    LGD_MID                 = request.getParameter("LGD_MID");
    LGD_OID                 = request.getParameter("LGD_OID");
    LGD_AMOUNT              = request.getParameter("LGD_AMOUNT");
    LGD_TID                 = request.getParameter("LGD_TID");
    LGD_PAYTYPE             = request.getParameter("LGD_PAYTYPE");
    LGD_PAYDATE             = request.getParameter("LGD_PAYDATE");
    LGD_HASHDATA            = request.getParameter("LGD_HASHDATA");
    LGD_FINANCECODE         = request.getParameter("LGD_FINANCECODE");
    LGD_FINANCENAME         = request.getParameter("LGD_FINANCENAME");
    LGD_ESCROWYN            = request.getParameter("LGD_ESCROWYN");
	if(LGD_ESCROWYN==null)LGD_ESCROWYN="N";
    LGD_TRANSAMOUNT         = request.getParameter("LGD_TRANSAMOUNT");
    LGD_EXCHANGERATE        = request.getParameter("LGD_EXCHANGERATE");
    LGD_CARDNUM             = request.getParameter("LGD_CARDNUM");
    LGD_CARDINSTALLMONTH    = request.getParameter("LGD_CARDINSTALLMONTH");
    LGD_CARDNOINTYN         = request.getParameter("LGD_CARDNOINTYN");
    LGD_TIMESTAMP           = request.getParameter("LGD_TIMESTAMP");
    LGD_FINANCEAUTHNUM      = request.getParameter("LGD_FINANCEAUTHNUM");
    LGD_PAYTELNUM           = request.getParameter("LGD_PAYTELNUM");
    LGD_ACCOUNTNUM          = request.getParameter("LGD_ACCOUNTNUM");
    LGD_CASTAMOUNT          = request.getParameter("LGD_CASTAMOUNT");
    LGD_CASCAMOUNT          = request.getParameter("LGD_CASCAMOUNT");
    LGD_CASFLAG             = request.getParameter("LGD_CASFLAG");
    LGD_CASSEQNO            = request.getParameter("LGD_CASSEQNO");
    LGD_CASHRECEIPTNUM      = request.getParameter("LGD_CASHRECEIPTNUM");
    LGD_CASHRECEIPTSELFYN   = request.getParameter("LGD_CASHRECEIPTSELFYN");
    LGD_CASHRECEIPTKIND     = request.getParameter("LGD_CASHRECEIPTKIND");
    LGD_OCBSAVEPOINT        = request.getParameter("LGD_OCBSAVEPOINT");
    LGD_OCBTOTALPOINT       = request.getParameter("LGD_OCBTOTALPOINT");
    LGD_OCBUSABLEPOINT      = request.getParameter("LGD_OCBUSABLEPOINT");

    LGD_BUYER               = request.getParameter("LGD_BUYER");
    LGD_PRODUCTINFO         = request.getParameter("LGD_PRODUCTINFO");
    LGD_BUYERID             = request.getParameter("LGD_BUYERID");
    LGD_BUYERADDRESS        = request.getParameter("LGD_BUYERADDRESS");
    LGD_BUYERPHONE          = request.getParameter("LGD_BUYERPHONE");
    LGD_BUYEREMAIL          = request.getParameter("LGD_BUYEREMAIL");
    LGD_BUYERSSN            = request.getParameter("LGD_BUYERSSN");
    LGD_PRODUCTCODE         = request.getParameter("LGD_PRODUCTCODE");
    LGD_RECEIVER            = request.getParameter("LGD_RECEIVER");
    LGD_RECEIVERPHONE       = request.getParameter("LGD_RECEIVERPHONE");
    LGD_DELIVERYINFO        = request.getParameter("LGD_DELIVERYINFO");

	LGD_DISPLAY_BUYEREMAIL  = request.getParameter("LGD_DISPLAY_BUYEREMAIL");

    /*
     * hashdata ������ ���� mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�. 
     * LG���÷������� �߱��� ����Ű�� �ݵ�ú����� �ֽñ� �ٶ��ϴ�.
     */  
    //String LGD_MERTKEY = ""; //mertkey

    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
    sb.append(LGD_RESPCODE);
    sb.append(LGD_TIMESTAMP);
    sb.append(LGD_MERTKEY);

    byte[] bNoti = sb.toString().getBytes();
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] digest = md.digest(bNoti);

    StringBuffer strBuf = new StringBuffer();
    for (int ii=0 ; ii < digest.length ; ii++) {
        int c = digest[ii] & 0xff;
        if (c <= 15){
            strBuf.append("0");
        }
        strBuf.append(Integer.toHexString(c));
    }

    String LGD_HASHDATA2 = strBuf.toString();  //�������� �ؽ���  
    
    /*
     * ���� ó����� ���ϸ޼���
     *
     * OK   : ���� ó����� ����
     * �׿� : ���� ó����� ����
     *
     * �� ���ǻ��� : ������ 'OK' �����̿��� �ٸ����ڿ��� ���ԵǸ� ����ó�� �ǿ��� �����Ͻñ� �ٶ��ϴ�.
     */    
    String resultMSG = "������� ���� DBó��(NOTE_URL) ������� �Է��� �ֽñ� �ٶ��ϴ�.";  
    
    if (LGD_MID.equals("kvp_eatsslim1") || LGD_HASHDATA2.trim().equals(LGD_HASHDATA)) { //�ؽ��� ������ �����̸�
        if (LGD_RESPCODE.trim().equals("0000")){ //������ �����̸�
            /*
             * �ŷ����� ��� ���� ó��(DB) �κ�
             * ���� ��� ó���� �����̸� "OK"
             */    

			 query="UPDATE ESL_ORDER SET PAY_DATE=NOW(),ORDER_STATE='01',PAY_YN='Y', PG_TID = '"+ LGD_TID +"', PG_ESCROW_YN = '"+LGD_ESCROWYN +"' WHERE ORDER_NUM='"+LGD_OID+"'";
						try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

%>
<%@ include file="/lib/phi_insert.jsp"%>
<%

			query="UPDATE ESL_ORDER_GOODS SET ORDER_STATE='01' WHERE ORDER_NUM='"+LGD_OID+"'";
			try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}


            //if( �������� ����ó����� ���� ) 
            	resultMSG = "OK";   

				out.println(resultMSG.toString());

        } else { //������ �����̸�
            /*
             * �ŷ����� ��� ���� ó��(DB) �κ�
             * ������� ó���� �����̸� "OK"
             */  
           //if( �������� ����ó����� ���� ) 
        	   //resultMSG = "OK";     
			   resultMSG = "alert('���� ������ �߻��Ͽ����ϴ�. �����ڵ�="+LGD_RESPCODE.toString()+"');";
			   out.println("<script>"+resultMSG.toString()+"</script>");
        }
    } else { //�ؽ����� ������ �����̸�
        /*
         * hashdata���� ���� �α׸� ó���Ͻñ� �ٶ��ϴ�. 
         */      
        resultMSG = "alert('������� ���� DBó��(NOTE_URL) �ؽ��� ������ �����Ͽ����ϴ�.');";  
		 /*out.println("LGD_MID="+LGD_MID);
		 out.println("<br>LGD_OID="+LGD_OID);
		 out.println("<br>LGD_AMOUNT="+LGD_AMOUNT);
		 out.println("<br>LGD_TIMESTAMP="+LGD_TIMESTAMP);
		 out.println("<br>LGD_MERTKEY="+LGD_MERTKEY);
		 out.println("<br>LGD_RESPCODE="+LGD_RESPCODE);
		 out.println("<br>LGD_HASHDATA2="+LGD_HASHDATA2);
		 out.println("<br>LGD_HASHDATA="+LGD_HASHDATA);*/

		 out.println("<script>"+resultMSG.toString()+"</script>");
		 
    }
    
    

%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_bm.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>