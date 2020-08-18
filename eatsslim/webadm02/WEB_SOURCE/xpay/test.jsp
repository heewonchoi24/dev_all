<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="/inc/dbconn.jsp" %>
<%@ include file="/inc/common.jsp"%>
<%@ include file="config.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

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

	 String resultMSG = "������� ���� DBó��(LGD_CASNOTEURL) ������� �Է��� �ֽñ� �ٶ��ϴ�.";  


 	            /*
    	         * ������ �Ա���� ���� ��� ���� ó��(DB) �κ�
        	     * ���� ��� ó���� �����̸� "OK"
            	 */    
            	//if( ������ �Ա����  ���� ����ó����� ���� ) resultMSG = "OK";

				//������Ҹ� ����.
				resultMSG = "OK";
				out.println(resultMSG.toString());

				if(LGD_CASCAMOUNT==null)LGD_CASCAMOUNT="0";
				sql="update gd_order set cdt=now(),state='91',settlelog=CONCAT(settlelog,'\nPG�� �������Ա����(�ݾ�:"+LGD_CASCAMOUNT+") ',now()) where ordno='"+LGD_OID+"'";
				try{stmt.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

				sql="update gd_order_item set istate='91' where ordno='"+LGD_OID+"'";
				try{stmt.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

				//=========��� ��Ÿ ó��
				String m_no="";
				sql="insert into gd_order_cancel set sno=null,ordno="+LGD_OID+",state=91,reason='1',reason_etc='�������Ա����',feedback='',regdt=now()";
				sql+=",rprice='"+LGD_CASCAMOUNT+"'";
				try{stmt2.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

				//���� ȯ��
				sql="select couponcd,(select m_no from gd_order where ordno=oi.ordno) as m_no from gd_order_item oi where ordno='"+LGD_OID+"' and couponcd>0";
				try{rs = stmt.executeQuery(sql);}catch(Exception e){out.println(e);if(true)return;}
				while(rs.next()){
					m_no=rs.getString("m_no");
					sql="update gd_coupon_download set isUse='N' where couponcd='"+rs.getString("couponcd")+"' and m_no='"+m_no+"'"; //��밡���ϵ��� ����
					try{stmt2.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}
				}
				rs.close();
				sql="delete from gd_coupon_order where ordno='"+LGD_OID+"'";
				try{stmt.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

				//��ҿϷ�� ���������� ���ϸ��� ����(�κ�����)
				sql="delete from gd_mileage_log where m_no='"+m_no+"' and ordno='"+LGD_OID+"'";
				try{stmt2.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}


    

%>
<%@ include file="/inc/dbclose.jsp" %>
