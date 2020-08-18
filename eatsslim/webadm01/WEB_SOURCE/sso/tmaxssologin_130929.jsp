<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="com.tmax.eam.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*" %>
<%@ page import="java.io.IOException"%>
<%@ page import="java.text.*" %>
<%@include file="tmaxssocommon.jsp"%>

<!--Woolrim Add-->
<%@page import="java.util.ArrayList"%>
<%@page import="com.wr.common.util.*"%>
<%@ page import = "com.wr.member.MemberBean" %>
<%@ page import = "com.wr.coupon.CouponBean" %>
<!--// Woolrim Add -->


<%
String userid = "";
/*********************** tmax sso�� ���� �ڵ� ************************/
String tokenStr = (String)request.getParameter(Common.PARAM_TOKEN);
String nextPage = (String)request.getParameter(Common.PARAM_NEXTURL);
String siteno = Common.encode("0002400000");	//ECMD ����Ʈ ��ȣ�� �����Ұ�!

boolean returnURLExist = false;
String redirectionURL ="";

Connection con = null;
Statement stmt = null;
ResultSet rs = null;
String DB_URL = "jdbc:sqlserver://192.1.5.39:1433;databaseName=PULMUONE"; 
String DB_ID = "sso"; 
String DB_PW = "sso";
String siteNum = "";


/* nextPage Setting */
if(nextPage==null){
	//nextPage="/sso/main.jsp";
	nextPage="/index.jsp";
	//System.out.println("[" +  Sdate1() + "] [SSO-TokenDistribution] NextPageURL is null :" + nextPage);

}else{	
	/* ��û�� ������ ���� ������ ��� returnurl�� �������� ��û�� �������� �����Ѵ� */
	nextPage = Common.decode(nextPage);
	//System.out.println("[" +  Sdate1() + "] [SSO-TokenDistribution] NextPageURL is  : " + nextPage);

	int returnURLIndex = -1;
	int returnURLIndexLen = -1;

	returnURLIndex = nextPage.indexOf("returnurl");
	returnURLIndexLen = nextPage.length();
	
	/* returnurl�� �����Ѵٸ� , nextPage�� url encoding�Ǿ� �ִ�.*/
	if(returnURLIndex > -1){
		String returnURLResult = "";
		returnURLResult = nextPage.substring(returnURLIndex+10,returnURLIndexLen);
		nextPage =  java.net.URLDecoder.decode(returnURLResult);
		session.setAttribute("sReturnURL",nextPage);
		System.out.println("sReturnURL��? " + session.getAttribute("sReturnURL"));
	/* ���� ���� �Ϸ� �Ŀ��� returnurl�� nextPage�� �������� �ʱ� ������ ������ ������ ���� �����´�. ���� �����Ѵٸ� returnurl exist = true */

	}else{
		redirectionURL = (String)session.getAttribute("sReturnURL");
		
		if(redirectionURL !=null && redirectionURL.length() > 0){
			returnURLExist = true;			
		}

		//session.removeAttribute("sReturnURL");
	}
}

System.out.println("SSO-TokenDistribution redirectionURL : " +  redirectionURL);
System.out.println("SSO-session1 : " +  (String)session.getAttribute("sReturnURL"));

if(tokenStr == null){
	
	//CouponBean cbean = new CouponBean();
	//cbean.setCoupon_join("selfish","������",request.getRemoteAddr());			 // ���ΰ���
	//session.setAttribute("sReturnURL", (String)session.getAttribute("sReturnURL"));
	response.sendRedirect("http://member.pulmuone.co.kr/sso_login.jsp?siteno=" + siteno);
	return;
}


TmaxSSOToken token = null;

try {
	token=new TmaxSSOToken(tokenStr, com.tmax.eam.EAMFilter.logger);
} catch (Exception e) {
	if (tokenStr != null)  
	e.printStackTrace();
}


if(token != null){

String scmm=token.getCommon();
userid = scmm;

if(!TmaxSSOSession.verifyToken(token)){
	System.out.println("[" +  Sdate1() + "] SSO-TokenDistribution verifyToken Check : " + userid);
	System.out.println("[" +  Sdate1() + "] SSO-TokenDistribution Remote IP : " + request.getRemoteAddr());
}

if(scmm !=null){
	//Ǯ������������
	//HttpUtil.setSession(request, "SESSION_CUSTOMER_NUMBER", userid);
	


try{
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
	con = DriverManager.getConnection(DB_URL, DB_ID,DB_PW);

	// ���̵�, �н�����
	String aSQL = "\n SELECT B.SITE_NO "
				+ "\n FROM MEMBER_INFO A, SITE_USED_YN B, SITE_INFO C "
				+ "\n WHERE A.CUSTOMER_NUM = '"+ userid + "' "
				+ "\n AND B.SITE_NO = '0002400000' "
				+ "\n AND B.SITE_USE = 'Y' "
				+ "\n AND A.CUSTOMER_NUM = B.CUSTOMER_NUM "
				+ "\n AND B.SITE_NO = C.SITE_NO ";

	stmt = con.createStatement();
	rs = stmt.executeQuery(aSQL);
	
	while(rs.next()){
		siteNum = rs.getString(1);
	}	
	
}
catch( Exception e )
{
	System.out.println("[tmaxssologin] Exception : " + e.toString());
}
finally
{
	try{ if( rs != null ) rs.close(); } catch( Exception e ) {}
	try{ if( stmt != null ) stmt.close(); } catch( Exception e ) {}
	try{ if( con != null ) con.close(); } catch( Exception e ) {}
}

if(siteNum == ""){
	out.println("<script>");
	out.println("alert('ȸ������ ���� ����Ʈ(www.eatsslim.com)�� ���ԵǾ� ���� �ʽ��ϴ�. [�ս���]�� üũ���ּ���..')");
	out.println("location.href='http://member.pulmuone.co.kr/customer/custSite_R1.jsp?siteno=0002400000'");
	out.println("</script>");
	return;
}	
}else{
	out.println("<script>");
	out.println("alert('���Բ����� �α����� ����ó������ �ʾҽ��ϴ�.')");
	out.println("location.href='http://www.pulmuoneshop.co.kr'");
	out.println("</script>");
}



//���ǻ���üũ
//if (HttpUtil.getSession(request, "SESSION_CUSTOMER_NUMBER") != null && HttpUtil.getSession(request, "SESSION_CUSTOMER_NUMBER") != "" ) {

	if(TmaxSSOSession.login(request,token)){
		out.println("SSO-TokenDistribution Session Login S: " + userid);
	}else{
		out.println("SSO-TokenDistribution Session Login F: " + userid);
	}

	//���ǻ�������
	if(false){								//returnURLExist ���ǿ��� ������ ������ Ÿ�� �ʰ�. 2012-07-26
		if(redirectionURL !=null && redirectionURL.equals("/index.jsp")){
			redirectionURL="";
		}
		redirectionURL = redirectionURL+"?userid="+userid;
%>
		<html>
			<body>
				<form name="fm" method="post" action="/main.jsp">
					<input name="returnurl" type="hidden" value='<%=redirectionURL%>'>
				</form>
				<script>
					document.fm.submit();
				</script>
			</body>
		</html>
<%

	}else{		
		// �α��� ���� ����(WOOLRIM)		
		String fUserNm = "";
		String fUserId = "";
		String fUserEmail = "";
		String fUser_birth = "";
		String fUser_wd = "";
		String fUser_birty_uy = "";	// ��,��
		String fUser_wd_yn = "";
		
		MemberBean bean = new MemberBean();
		ArrayList mview = bean.getView_login(userid);
		if(mview.size() > 0) {
			HashMap hm = (HashMap)mview.get(0);
	    	fUserNm = Utility.nvl((String)hm.get("NAME"));
			fUserId = Utility.nvl((String)hm.get("MEM_ID"));
			fUserEmail = Utility.nvl((String)hm.get("EMAIL"));
			fUser_birth = Utility.nvl((String)hm.get("BIRTH_DT"));
			fUser_wd = Utility.nvl((String)hm.get("WED_ANNV_DT"));
			fUser_birty_uy = Utility.nvl((String)hm.get("SOL_LUN_CL"));
			fUser_wd_yn = Utility.nvl((String)hm.get("WED_YN"));
	    }
		
		/*
		if(scmm !=null){
			out.println("userid " + userid);
			out.println("fUserId " + fUserId);
			out.println("fUserNm " + fUserNm);
			out.println("fUserEmail " + fUserEmail);
		return;
		}*/

		
		session.setAttribute("HavEatFrCustomNum",userid);
		session.setAttribute("HavEatFrUserId",fUserId);
		session.setAttribute("HavEatFrUserNm",fUserNm);
		session.setAttribute("HavEatFrUserEmail",fUserEmail);
		
		// �����߱�
		CouponBean cbean = new CouponBean();
	//	cbean.setCoupon_birth(fUser_birth, fUser_birty_uy,fUserId,fUserNm,request.getRemoteAddr());	// ������
	//	cbean.setCoupon_wd(fUser_wd, fUser_wd_yn,fUserId,fUserNm,request.getRemoteAddr());			// ��ȥ�����
		cbean.setCoupon_join(fUserId,fUserNm,request.getRemoteAddr());			 // ���ΰ���
	//	cbean.setVipCoupon(fUserId,fUserNm,request.getRemoteAddr());  //���ȸ��
	   cbean.setCoupon_QProgram(fUserId,fUserNm,request.getRemoteAddr());  //q���α׷�
	    cbean.setCoupon_SProgram(fUserId,fUserNm,request.getRemoteAddr());  //q���α׷�
		cbean.setCoupon_focusProgram(fUserId,fUserNm,request.getRemoteAddr());  //14�����߰������α׷�
		
		// �α� �ױ�
		bean.setMemLog(fUserId);
		
		// ȸ������ ó��
		bean.setInsert(userid,fUserId,fUserNm,request.getRemoteAddr());
		
		//out.print(CommonUtil.getScript("�α��� �Ǿ����ϴ�.","/index.jsp",null));

		//if(po_return_url.equals("")) {
			//out.print(CommonUtil.getScript("�α��� �Ǿ����ϴ�.","/index.jsp",null));
		//} else {
			//out.print(CommonUtil.getScript("�α��� �Ǿ����ϴ�.",po_return_url,null));
		//}
		// Woolrim Add End

			System.out.println("userid:0" + returnURLExist);
			System.out.println("userid:0" + redirectionURL);
		if(returnURLExist){
			System.out.println("userid:1" + redirectionURL);
			response.sendRedirect("https://www.eatsslim.co.kr" + redirectionURL.replaceAll("http://www.eatsslim.co.kr",""));
			//response.sendRedirect(redirectionURL);
		}else{		
			System.out.println("userid:2");
			response.sendRedirect("/index.jsp");
		}
	}

//}else{	
	//���ǻ�������
//	out.println("<script>");
//	out.println("alert('���Բ����� �α����� ����ó������ �ʾҽ��ϴ�. �����ڿ��� �����ϼ���')");
//	out.println("location.href='http://www.pulmuoneshop.co.kr'");
//	out.println("</script>");
//}

System.out.println("###########################################################");
System.out.println("####################SSO-TokenDistribution Login Sucess :"+ userid);
System.out.println("###########################################################");
	
}

%>
		

    
