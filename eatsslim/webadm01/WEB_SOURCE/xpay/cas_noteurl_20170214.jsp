<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_bm.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp" %>
<%@ include file="config.jsp" %>
<%//������ �Ա��� �Ϸ�Ǹ� �� �������� PG�翡�� ȣ���ϰ� �ȴ�.
request.setCharacterEncoding("euc-kr");

String query		= "";

//#######################################################
//##################�������϶��� ȣ����##################
//#######################################################
    /*
     * [���� �������ó��(DB) ������]
     *
     * 1) ������ ������ ���� hashdata�� ������ �ݵ�� �����ϼž� �մϴ�.
     *
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
    String LGD_FINANCECODE = "";        // ��������ڵ�(�����ڵ�)
    String LGD_FINANCENAME = "";        // ��������̸�(�����̸�)
    String LGD_ESCROWYN = "";           // ����ũ�� ���뿩��
    //String LGD_TIMESTAMP = "";          // Ÿ�ӽ�����
    String LGD_ACCOUNTNUM = "";         // ���¹�ȣ(�������Ա�) 
    String LGD_CASTAMOUNT = "";         // �Ա��Ѿ�(�������Ա�)
    String LGD_CASCAMOUNT = "";         // ���Աݾ�(�������Ա�)
    String LGD_CASFLAG = "";            // �������Ա� �÷���(�������Ա�) - 'R':�����Ҵ�, 'I':�Ա�, 'C':�Ա���� 
    String LGD_CASSEQNO = "";           // �Աݼ���(�������Ա�)
    String LGD_CASHRECEIPTNUM = "";     // ���ݿ����� ���ι�ȣ
    String LGD_CASHRECEIPTSELFYN = "";  // ���ݿ����������߱������� Y: �����߱��� ����, �׿� : ������
    String LGD_CASHRECEIPTKIND = "";    // ���ݿ����� ���� 0: �ҵ������ , 1: ����������
    String LGD_PAYER = "";    			// �ӱ��ڸ�
    
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
    LGD_TIMESTAMP           = request.getParameter("LGD_TIMESTAMP");
    LGD_ACCOUNTNUM          = request.getParameter("LGD_ACCOUNTNUM");
    LGD_CASTAMOUNT          = request.getParameter("LGD_CASTAMOUNT");
    LGD_CASCAMOUNT          = request.getParameter("LGD_CASCAMOUNT");
    LGD_CASFLAG             = request.getParameter("LGD_CASFLAG");
    LGD_CASSEQNO            = request.getParameter("LGD_CASSEQNO");
    LGD_CASHRECEIPTNUM      = request.getParameter("LGD_CASHRECEIPTNUM");
    LGD_CASHRECEIPTSELFYN   = request.getParameter("LGD_CASHRECEIPTSELFYN");
    LGD_CASHRECEIPTKIND     = request.getParameter("LGD_CASHRECEIPTKIND");
    LGD_PAYER     			= request.getParameter("LGD_PAYER");
    
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
     * OK  : ���� ó����� ����
     * �׿� : ���� ó����� ����
     *
     * �� ���ǻ��� : ������ 'OK' �����̿��� �ٸ����ڿ��� ���ԵǸ� ����ó�� �ǿ��� �����Ͻñ� �ٶ��ϴ�.
     */    
    String resultMSG = "������� ���� DBó��(LGD_CASNOTEURL) ������� �Է��� �ֽñ� �ٶ��ϴ�.";  
    
    if (LGD_HASHDATA2.trim().equals(LGD_HASHDATA)) { //�ؽ��� ������ �����̸�
        if ( ("0000".equals(LGD_RESPCODE.trim())) ){ //������ �����̸�
			query="";
        	if( "R".equals( LGD_CASFLAG.trim() ) ) {
                /*
                 * ������ �Ҵ� ���� ��� ���� ó��(DB) �κ�
                 * ���� ��� ó���� �����̸� "OK"
                 */    
                //if( ������ �Ҵ� ���� ����ó����� ���� ) resultMSG = "OK";
				resultMSG = "OK";
				out.println(resultMSG.toString());
				
        		
        	}else if( "I".equals( LGD_CASFLAG.trim() ) ) {
 	            /*
    	         * ������ �Ա� ���� ��� ���� ó��(DB) �κ�
        	     * ���� ��� ó���� �����̸� "OK"
            	 */    
            	//if( ������ �Ա� ���� ����ó����� ���� ) resultMSG = "OK";
				resultMSG = "OK";
				out.println(resultMSG.toString());

				if(LGD_CASCAMOUNT==null)LGD_CASCAMOUNT="0";
				if(LGD_CASTAMOUNT==null)LGD_CASTAMOUNT="0";
				if(!LGD_CASCAMOUNT.equals("0")){
					if(LGD_CASCAMOUNT.equals(LGD_CASTAMOUNT)){ //�Ѿװ� �Աݾ��� ������ �ϳ�
						query="UPDATE ESL_ORDER SET PAY_DATE=NOW(),ORDER_STATE='01',PAY_YN='Y', PG_TID = '"+ LGD_TID +"',ORDER_LOG=CONCAT(ORDER_LOG,'\nPG�� �������ԱݿϷ�(�Ѿ�:"+LGD_CASTAMOUNT+",�Աݾ�:"+LGD_CASCAMOUNT+") ',NOW()) WHERE ORDER_NUM='"+LGD_OID+"'";
						try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

%>
<%@ include file="/lib/phi_insert.jsp"%>
<%

						query="UPDATE ESL_ORDER_GOODS SET ORDER_STATE='01' WHERE ORDER_NUM='"+LGD_OID+"'";
						try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
					}else{
						query="UPDATE ESL_ORDER SET ORDER_LOG=CONCAT(ORDER_LOG,'\nPG�� ������κ��ԱݿϷ�(�Ѿ�:"+LGD_CASTAMOUNT+",�Աݾ�:"+LGD_CASCAMOUNT+") ',NOW()) WHERE ORDER_NUM='"+LGD_OID+"'";
						try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
					}
				}else{
					query="UPDATE ESL_ORDER SET ORDER_LOG=CONCAT(ORDER_LOG,'\nPG�� �������Ա�(�Ѿ�:"+LGD_CASTAMOUNT+",�Աݾ�:"+LGD_CASCAMOUNT+") ',NOW()) WHERE ORDER_NUM='"+LGD_OID+"'";
					try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
				}
				

        	}else if( "C".equals( LGD_CASFLAG.trim() ) ) {
 	            /*
    	         * ������ �Ա���� ���� ��� ���� ó��(DB) �κ�
        	     * ���� ��� ó���� �����̸� "OK"
            	 */    
            	//if( ������ �Ա����  ���� ����ó����� ���� ) resultMSG = "OK";

				//������Ҹ� ����.
				resultMSG = "OK";
				out.println(resultMSG.toString());

				if(LGD_CASCAMOUNT==null)LGD_CASCAMOUNT="0";
				query="UPDATE ESL_ORDER SET PAY_DATE=NOW(),ORDER_STATE='91',ORDER_LOG=CONCAT(ORDER_LOG,'\nPG�� �������Ա����(�Ѿ�:"+LGD_CASTAMOUNT+",�Աݾ�:"+LGD_CASCAMOUNT+") ',NOW()) WHERE ORDER_NUM='"+LGD_OID+"'";
				try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

				query="UPDATE ESL_ORDER_GOODS SET ORDER_STATE='91' WHERE ORDER_NUM='"+LGD_OID+"'";
				try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

				query		= "UPDATE PHIBABY.P_ORDER_MALL_PHI_ITF SET INTERFACE_FLAG_YN = 'Y' WHERE ORD_NO = '"+ LGD_OID +"'";
				try {
					stmt_phi.executeUpdate(query);
				} catch(Exception e) {
					out.println(e);
					if(true)return;
				}

				int ordSeq			= 0;
				SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
				String instDate		= dt.format(new Date());

				// ������ ��ȸ
				query		= "SELECT MAX(ORD_SEQ) FROM PHIBABY.P_ORDER_MALL_PHI_ITF";
				try {
					rs_phi		= stmt_phi.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs_phi.next()) {
					ordSeq		= rs_phi.getInt(1) + 1;
				}
				rs_phi.close();

				query		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
				query		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM)";
				query		+= "	VALUES";
				query		+= "	("+ ordSeq +", '"+ instDate +"', '"+ LGD_OID +"', '00000000', 'D', '���', '���', '111111', '���', '���', '00000000000', '00000000000', 'cancel', 0, 0, 0, 0, '30', '0001', '', '', 1, '"+ instDate +"', '000000', 0, 0, 0, SYSDATE)";
				try {
					stmt_phi.executeUpdate(query);
				} catch(Exception e) {
					out.println(e);
					if(true)return;
				}
/*
				//=========��� ��Ÿ ó��
				String m_no="";
				query="insert into ESL_ORDER_cancel SET sno=null,ORDER_NUM="+LGD_OID+",state=91,reason='1',reason_etc='�������Ա����',feedback='',regdt=NOW()";
				query+=",rprice='"+LGD_CASCAMOUNT+"'";
				try{stmt2.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

				//���� ȯ��
				query="select couponcd,(select m_no from ESL_ORDER WHERE ORDER_NUM=oi.ORDER_NUM) as m_no from ESL_ORDER_item oi WHERE ORDER_NUM='"+LGD_OID+"' and couponcd>0";
				try{rs = stmt.executeQuery(query);}catch(Exception e){out.println(e);if(true)return;}
				while(rs.next()){
					m_no=rs.getString("m_no");
					query="UPDATE gd_coupon_download SET isUse='N' WHERE couponcd='"+rs.getString("couponcd")+"' and m_no='"+m_no+"'"; //��밡���ϵ��� ����
					try{stmt2.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
				}
				rs.close();
				query="delete from gd_coupon_order WHERE ORDER_NUM='"+LGD_OID+"'";
				try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

				//��ҿϷ�� ���������� ���ϸ��� ����(�κ�����)
				query="delete from gd_mileage_log WHERE m_no='"+m_no+"' and ORDER_NUM='"+LGD_OID+"'";
				try{stmt2.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
*/


        	}   
			
        } else { //������ �����̸�
            /*
             * �ŷ����� ��� ���� ó��(DB) �κ�
             * ������� ó���� �����̸� "OK"
             */  
           //if( �������� ����ó����� ���� ) resultMSG = "OK";   
			 resultMSG = "alert('���� ������ �߻��Ͽ����ϴ�. �����ڵ�="+LGD_RESPCODE.toString()+"');";
			 out.println("<script>"+resultMSG.toString()+"</script>");
        }
    } else { //�ؽ����� ������ �����̸�
        /*
         * hashdata���� ���� �α׸� ó���Ͻñ� �ٶ��ϴ�. 
         */      
        resultMSG = "alert('������� ���� DBó��(LGD_CASNOTEURL) �ؽ��� ������ �����Ͽ����ϴ�.');";
  	    out.println("<script>"+resultMSG.toString()+"</script>");
    }
    

%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_bm.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>