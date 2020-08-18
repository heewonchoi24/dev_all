<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import ="java.net.*" %>
<%@ page import="java.io.*,java.util.*, java.text.*, java.sql.*" %>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/xpay/config.jsp" %>
<%
	//**************************//
	//
	// ��۰�� �۽� JSP ����
	//
	//**************************//

	String service_url = "";

	// �׽�Ʈ��
	//service_url = "http://pgweb.uplus.co.kr:7085/pg/wmp/mertadmin/jsp/escrow/rcvdlvinfo.jsp"; 

	// ���񽺿�
	//service_url = "https://pgweb.uplus.co.kr/pg/wmp/mertadmin/jsp/escrow/rcvdlvinfo.jsp"; 

	service_url = "https://pgweb.uplus.co.kr/pg/wmp/mertadmin/jsp/escrow/rcvdlvinfo.jsp";
	
	String query ="";
	String query1 ="";
	String mid ="";
	String oid ="";
	String productid ="";
	String orderdate ="";
	String dlvtype ="01";
	String rcvdate ="";
	String rcvname ="";
	String rcvrelation ="";
	String dlvdate ="";
	String dlvcompcode ="�Ե��ù�";
	String dlvcomp ="";
	String dlvno ="";
	String dlvworker ="";
	String dlvworkertel  ="";
	String hashdata ="";
	String mertkey =""; //LG���÷������� �߱��� ����Ű�� ������ �ֽñ� �ٶ��ϴ�.
	Statement stmt1		= null;
	ResultSet rs1		= null;
	stmt1				= conn.createStatement();
	
    boolean resp = false;

		
	query="SELECT ORDER_NUM, RCV_NAME, CON_DT FROM (";
	query+=" SELECT EO.ORDER_NUM, EO.RCV_NAME, DATE_FORMAT(now(), '%Y%m%d%H%i') AS CON_DT, IFNULL(RESULT_YN,'N') as RES_YN FROM";
	query+=" ( ";
	query+=" SELECT ORDER_NUM, CASE WHEN RCV_NAME  = '' THEN TAG_NAME WHEN RCV_NAME is null  THEN TAG_NAME ELSE RCV_NAME END AS RCV_NAME ";
	query+=" FROM ESL_ORDER ";
	query+=" WHERE PG_ESCROW_YN ='Y' ";
	query+=" AND DATE_FORMAT(DATE_ADD(now(), INTERVAL -4 DAY), '%Y%m%d') = DATE_FORMAT(PAY_DATE, '%Y%m%d')";
	//query+=" AND ORDER_STATE in ('01','911') ) EO ";
	query+=" ) EO ";
	query+=" LEFT OUTER JOIN ";
	query+=" ESL_ESCROW_LOG EEL ";
	query+=" ON EO.ORDER_NUM = EEL.ORDER_NUM ";
	query+=" ) AA ";
	query+=" WHERE RES_YN <> 'Y' ";	
	
	//if(request.getRemoteAddr().equals("175.198.80.126")){out.println(sql+"<br>");}
	try {
	rs			= stmt.executeQuery(query);
	} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
	}
	
	while (rs.next()) {
		mid=LGD_MID;
		oid=rs.getString("ORDER_NUM");
		rcvname=rs.getString("RCV_NAME");
		dlvdate=rs.getString("CON_DT"); //�߼�����
		dlvcompcode="HD"; //�Ե��ù� �ڵ�
		dlvno=rs.getString("CON_DT"); //�����ȣ
		mertkey=LGD_MERTKEY;
		//rcvdate=dlvdate;
	
		//******************************//
		// ���ȿ� ����Ű ���� - ����
		//******************************//
		StringBuffer sb = new StringBuffer();
		//if("03".equals(dlvtype))
		//{
			// �߼�����
			//sb.append(mid);
			//sb.append(oid);
			//sb.append(dlvdate);
			//sb.append(dlvtype);
			//sb.append(dlvcompcode);
			//sb.append(dlvno);
			//sb.append(mertkey);		
			
		
		//}
		//else if("01".equals(dlvtype))
		//{
			// �������� 
			sb.append(mid);
			sb.append(oid);
			sb.append(dlvtype);
			sb.append(dlvdate);
			//sb.append(rcvdate);		
			sb.append(mertkey);
			//dlvno= "";
			//dlvcompcode = "";
			//dlvdate = "";
		//}	
		
		byte[] bNoti = sb.toString().getBytes();

		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] digest = md.digest(bNoti);

		StringBuffer strBuf = new StringBuffer();

		for (int i=0 ; i < digest.length ; i++) 
		{
			int c = digest[i] & 0xff;
			if (c <= 15)
			{
				strBuf.append("0");
			}
			strBuf.append(Integer.toHexString(c));
		}

		hashdata = strBuf.toString();
		//******************************//
		// ���ȿ� ����Ű ���� - ��
		//******************************//

		//******************************//
		// ������ �Ķ���� ���ڿ� ���� - ����
		//******************************//
		String sendMsg = "";
		StringBuffer msgBuf = new StringBuffer();
		msgBuf.append("mid=" + mid + "&" );	
		msgBuf.append("oid=" + oid+"&");
		msgBuf.append("productid=" + productid + "&" );
		msgBuf.append("orderdate=" + "" + "&" );
		msgBuf.append("dlvtype=" + dlvtype + "&" );			
		msgBuf.append("rcvdate=" + dlvdate + "&" );
		msgBuf.append("rcvname=" + rcvname + "&" );
		msgBuf.append("rcvrelation=" + "����" + "&" );			
		msgBuf.append("dlvdate=" + ""+ "&" );
		msgBuf.append("dlvcompcode=" + "" + "&" );	
		msgBuf.append("dlvno=" + dlvno + "&" );
		msgBuf.append("dlvworker=" + dlvworker + "&" );
		msgBuf.append("dlvworkertel=" + dlvworkertel + "&" );
		msgBuf.append("hashdata=" + hashdata );

		sendMsg = msgBuf.toString();

		StringBuffer errmsg = new StringBuffer();
		//******************************//
		// ������ �Ķ���� ���ڿ� ���� - ��
		//******************************//
		
		//*************************************//
		// HTTP�� ��۰�� ���
		//*************************************//
		URL surl = new URL(service_url);
		resp = sendRCVInfo(sendMsg,surl,errmsg);

		if(resp)
		{                                   
			//��������� �����̸�
			//out.println("OK, OID="+oid);
			
			query1="INSERT INTO ESL_ESCROW_LOG (ORDER_NUM, WORK_DATE, MEMO, RESULT_YN) VALUES ( '" + oid + "', now(), 'ó���Ϸ�', 'Y')";
			
			//settlelog,'\n����ũ�ι߼�ó��',now()) where ordno='"+oid+"'";
			try{stmt1.executeUpdate(query1);	}catch(Exception e){out.println(e);if(true)return;}
		} 
		else 
		{                                    
			//��� ������ �����̸�
			query1="INSERT INTO ESL_ESCROW_LOG (ORDER_NUM, WORK_DATE, MEMO, RESULT_YN) VALUES ( '" + oid + "', now(), '" + errmsg + "', 'N')";
			try{stmt1.executeUpdate(query1);	}catch(Exception e){out.println(e);if(true)return;}
			//out.println("FAIL Msg:"+errmsg+"<br><br>"+url);
		}

	}

%>


<%!
	//*************************************************
	// �Ʒ��κ� ���� �������� ����
	//*************************************************
	private boolean sendRCVInfo(String sendMsg, URL url, StringBuffer errmsg) throws Exception{
        OutputStreamWriter wr = null;
        BufferedReader br = null;
        HttpURLConnection conn = null;
        boolean result = false;
		String errormsg = null;

        try {
            conn = (HttpURLConnection)url.openConnection();
            conn.setDoOutput(true);
            wr = new OutputStreamWriter(conn.getOutputStream());
            wr.write(sendMsg);
            wr.flush();
            for (int i=0; ; i++) {
                String headerName = conn.getHeaderFieldKey(i);
                String headerValue = conn.getHeaderField(i);

                if (headerName == null && headerValue == null) {
                    break;
                }
                if (headerName == null) {
                    headerName = "Version";
                }

                errmsg.append(headerName + ":" + headerValue + "\n");
            }


            br = new BufferedReader(new InputStreamReader(conn.getInputStream ()));

            String in;
            StringBuffer sb = new StringBuffer();
            while(((in = br.readLine ()) != null )){
                sb.append(in);
            }

            errmsg.append(sb.toString().trim());
            if ( sb.toString().trim().equals("OK")){
                result = true;
            }else{
				errormsg = sb.toString().trim();
			}

        } catch ( Exception ex ) {
            errmsg.append("EXCEPTION : " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            try {
                if ( wr != null) wr.close();
                if ( br != null) br.close();
            } catch(Exception e){
            }
        }
        return result;

    }
%>

<%@ include file="/lib/dbclose.jsp" %>