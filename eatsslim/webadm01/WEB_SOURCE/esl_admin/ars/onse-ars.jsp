<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_mssql.jsp"%>
<%@ page import="java.net.*,java.io.*,java.util.List" %>
<%@ page import="org.jdom2.*,org.jdom2.input.SAXBuilder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
</head>
<body>
<%
	//String T_ID = HttpUtil.get(request, "T_ID");
	//String T_TIME = HttpUtil.get(request, "T_TIME");
	//String MENU_NAME = HttpUtil.get(request, "MENU_NAME");
	//String ANI = HttpUtil.get(request, "ANI");
	//String DTMF_CNT = HttpUtil.get(request, "DTMF_CNT");
	//String DTMF_1 = HttpUtil.get(request, "DTMF_1");

	String T_ID = request.getParameter("T_ID");
	String T_TIME = request.getParameter("T_TIME");
	String MENU_NAME = request.getParameter("MENU_NAME");
	String ANI = request.getParameter("ANI");
	String DTMF_CNT = request.getParameter("DTMF_CNT");
	String DTMF_1 = request.getParameter("DTMF_1");

	boolean sucess_flg = false;
	int customer_num = 0, index_no = 0;
	String mem_id = "";
	String rval = "";         
	int rslt; 
	String strPhoneNum1 = "";
	String strPhoneNum2 = "";
	String strPhoneNum3 = "";

	out.println("<form name='outfrm' method='post'>");
	out.println("<input type='hidden' name='T_ID' value='"+T_ID+"'>");
	out.println("<input type='hidden' name='T_TIME' value='"+T_TIME+"'>");
	out.println("<input type='hidden' name='RESULT' value='0'>");
	out.println("<input type='hidden' name='MENU_NAME' value='"+MENU_NAME+"'>");
	out.println("<input type='hidden' name='ACTION_TYPE' value='3'>");
	out.println("<input type='hidden' name='NEXT_MENU' value=''>");
	out.println("<input type='hidden' name='MENT_FLAG' value='0'>");
	out.println("<input type='hidden' name='MENT_CNT' value='1'>");
	
	try{ 
		 StringBuffer strBufSql = new StringBuffer();
					  
		 //DTMF_1
		 //DTMF_1 ="01072066245";
		 if(DTMF_1.length() == 10){
			 strPhoneNum1 = DTMF_1.substring(0,3);
			 strPhoneNum2 = DTMF_1.substring(3,6);
			 strPhoneNum3 = DTMF_1.substring(6,10);
		 }else{
			 strPhoneNum1 = DTMF_1.substring(0,3);
			 strPhoneNum2 = DTMF_1.substring(3,7);
			 strPhoneNum3 = DTMF_1.substring(7,11);            	 
		 }
		 
		 //strBufSql.append("SELECT MEM_ID, CUSTOMER_NUM FROM MEMBER_INFO WHERE HPHONE_TYPE = '"+strPhoneNum1+"' and HPHONE_FIRST = '"+strPhoneNum2+"' and HPHONE_SECOND = '"+strPhoneNum3+"' ");
		 strBufSql.append("SELECT CUSTOMER_NUM, INDEX_NO FROM pulmuone.dbo.ITF_MEMBER_INFO_FNC('0002400000', '129884') A WHERE A.HPHONE_TYPE = '"+strPhoneNum1+"' and A.HPHONE_FIRST = '"+strPhoneNum2+"' and A.HPHONE_SECOND = '"+strPhoneNum3+"'");
		 
		 rs_mssql = stmt_mssql.executeQuery(strBufSql.toString());
		 
		 while(rs_mssql.next()){
			customer_num = rs_mssql.getInt("CUSTOMER_NUM");
			index_no = rs_mssql.getInt("INDEX_NO");
		 }
		 rs_mssql.close();
		 
		 //customer_num = 21551441;
		 //index_no = 7847205;

		 if(customer_num == 0){
			 sucess_flg = false;
		 }else{
			 // 등록		 
			try{
				String fileUrl = "https://cs.pulmuone.kr:3443/sso/sso_site_used_itf_proc.asp?";
				String fileParam = "RETURN_TYPE=XML&CMD=U&REG_SITE_NO=0002400000&ACCESS_KEY=129884&CUSTOMER_NUM="+customer_num+"&INDEX_NO="+index_no+"&SITE_NO=0002400000&SMS_YN=N";
				URL furl = new URL(fileUrl+fileParam);
				URLConnection httpConn = furl.openConnection();

				//httpConn.setConnectTimeout(60000);
				//httpConn.setReadTimeout(60000);
				httpConn.setDoOutput(true);
				//httpConn.setUseCaches(false);
			
				SAXBuilder builder = new SAXBuilder();
				Document doc = builder.build(new InputStreamReader(httpConn.getInputStream())); 
				Element xmlRoot = doc.getRootElement(); //xml 데이터의 첫번째 태그 호출 
				List xmlList = xmlRoot.getChildren(); //xml 첫번째 태그 list 형태로 변형
				List xmlList2 = null;
				Element eleStatus = null;
				Element cheleStatus = null;
				String result = "";

				eleStatus = (Element)xmlList.get(0); //list의 첫번째 태그 element를 가져옴
				//Element eleStatus2 = (Element)xmlList.get(1); //list의 두번째 태그 element를 가져옴
				
				xmlList2 = eleStatus.getChildren();
				
				for (int k =0;k<xmlList2.size();k++) {
					cheleStatus = (Element)xmlList2.get(k);

					if ("status".equals(cheleStatus.getName())) {
						result = cheleStatus.getText();
					}
				}
				
				if (result.equals("200")) {
					sucess_flg = true;
				}
				else {
					sucess_flg = false;
				}
				
			}catch(Exception e){
				out.println(e);
				//e.printStackTrace();
				sucess_flg = false;
			}			 
			 
		 }
		 
	}catch(Exception e){ 
			//out.println("SQL ERROR " + e);   
			sucess_flg = false;
	}finally{ 
			if(rs_mssql!=null)try{rs_mssql.close();}catch(SQLException sqe){} 
			if(stmt_mssql!=null)try{stmt_mssql.close();}catch(SQLException sqe){} 
			if(conn_mssql!=null)try{conn_mssql.close();}catch(SQLException sqe){} 
	} 

	if(sucess_flg == true){ 
		String query	= "";

		query		= "UPDATE ESL_MEMBER SET SMS_YN = 'N' WHERE CUSTOMER_NUM = '"+ customer_num +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		out.println("<input type='hidden' name='MENT_1' value='F_등록성공'>");
	}else{
		out.println("<input type='hidden' name='MENT_1' value='F_등록실패'>");
	}
			
	out.println("</form>");	
%> 

</body>
</html>