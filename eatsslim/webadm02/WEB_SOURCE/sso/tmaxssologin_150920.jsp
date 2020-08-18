<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="com.tmax.eam.*"%>
<%@ include file="/lib/dbconn_mssql.jsp"%>
<%
String userid	= "";
String passwd	= "";
String common	= "";

/*********************** tmax eam �� ���� �ڵ� ************************/
String tokenStr = (String)request.getParameter(Common.PARAM_TOKEN);
String nextPage = (String)request.getParameter(Common.PARAM_NEXTURL);
String siteno	= Common.encode("0002400000");	//ECMD ����Ʈ ��ȣ�� �����Ұ�!

/*********************** ���� ��û�� ���� URL ***********************/
String fullURL	= javax.servlet.http.HttpUtils.getRequestURL(request).toString();
String serviceServletPath = request.getServletPath();
int ii = fullURL.indexOf(serviceServletPath);
String serviceURL = fullURL.substring(0,ii) + "/";
/*********************** ���� ��û�� ���� URL ***********************/

if (nextPage == null) {
	nextPage	= "first.jsp";
	out.println("############## NextPageURL is null");
} else {
	nextPage	= Common.decode(nextPage);
	out.println("############## NextPageURL = " + nextPage);
}

out.println("<br>[tokenStr tmaxssologin.jsp] Parameter�� ���� token = " + tokenStr);

TmaxSSOToken token = null;

try {
	token		= new TmaxSSOToken(tokenStr, EAMFilter.logger);
} catch (Exception e) {
	if (tokenStr != null)  
		e.printStackTrace();
}

String id	= null;
%>

	
<%
if(session.getAttribute("DIMENSION_VALUE") == null) {
	String referer = request.getHeader("referer");
	String sessionDimensionValue = "";
	if(session.getAttribute("DIMENSION_VALUE") == null){
		if(referer!= null && referer.length()!=0) {
			// �������� ���ڿ� ����
			referer = referer.replaceAll("http://", "").replaceAll("https://", "");
			referer = referer.substring(0,referer.indexOf("/"));
			sessionDimensionValue = referer;
		}else{
			sessionDimensionValue = "direct";
		}
		
		session.setAttribute("DIMENSION_VALUE", sessionDimensionValue);
	}
	
}
%>


<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-61938491-5', 'auto',{
   'allowLinker':true
  });
  
  ga('require','linker');
  ga('linker:autoLink', ['pulmuone.co.kr']);  
  
  var dimensionValue = '<%=session.getAttribute("DIMENSION_VALUE")%>';
  ga('set', 'dimension1', dimensionValue);
  ga('set', 'dimension2', '<%=session.getAttribute("esl_customer_num")==null?"N":"Y"%>');            //�α��ν� ����ȣ����
  ga('set', 'dimension3', '<%=session.getAttribute("esl_customer_num")==null?"":session.getAttribute("esl_customer_num")%>');            //�α��ν� ����ȣ����
  
  
  ga('send', 'pageview');

</script>
<%
if (tokenStr != null) {
	id				= token.getUserId();
	String pass		= token.getSecret();
	String cmm		= token.getCommon();
	String etc		= token.getETC();
	String AllInfo	= token.getTokenAllInfo();
	boolean loginCheck = false;

	userid = cmm;

/*
	out.println("<br>etc : " + etc);	
	out.println("<br>userId : " + id);
	out.println("<br>pass : " + pass);
	out.println("<br>cmm : " + cmm);
	out.println("<br>etc : " + etc);
	out.println("<br>AllInfo : " + AllInfo);
*/
	
	if (!TmaxSSOSession.verifyToken(token)) {
%>
<html><body><br>invalid token</body></html>
<%
			//return;
	}
	
	//�ӽ÷� loginCheck�� false�� �����س��� ������.
	if (cmm !=null){
		//loginCheck = false;
		loginCheck = true;
	}

	/* ����� ������ �Ϸ�Ǹ� ���� ���� ���� �����մϴ�. */
	if(loginCheck) {
		
		/* ���� ����ڿ� �´� ���� �� �����ϴ� �κ��� �� */
		//session.setAttribute("userid", id);
		
		//nextPage="http://www.pulmuonecaf.com/";
		//response.sendRedirect(nextPage);
		//session.invalidate(); //������ �ʱ�ȭ			
		nextPage	= "https://www.eatsslim.co.kr/proc/checkMember.jsp?id="+etc;

		/*
		//mssql ȸ������ ��ȸ
		String sqlquery="";
		sqlquery="SELECT TOP 1";
		sqlquery+=" A.CUSTOMER_NUM,A.NAME";
		sqlquery+=" FROM MEMBER_INFO A, SITE_USED_YN B";
		sqlquery+=" WHERE A.CUSTOMER_NUM = B.CUSTOMER_NUM";
		sqlquery+=" AND A.DEREG_APP_YN = 'N'";
		sqlquery+=" AND B.SITE_USE = 'Y'";
		//sqlquery+=" AND B.SITE_NO = '0002800000'"; //�ǿ��½� �ּ�����
		sqlquery+=" AND A.MEM_ID='"+etc+"'";
		try{rs_mssql = stmt_mssql.executeQuery(sqlquery);}catch(Exception e){out.println(e+"=>"+sqlquery);if(true)return;}
		if(rs_mssql.next()){
			session.setAttribute("member_id",etc);
			session.setAttribute("member_no",rs_mssql.getString("CUSTOMER_NUM"));
			session.setAttribute("member_name",rs_mssql.getString("NAME"));
			session.setAttribute("member_gubun","1");
			session.setAttribute("member_level","1");
			session.setAttribute("member_code","U");
			nextPage="http://www.pulmuonecaf.com/proc/checkMember.jsp?id="+etc;
			
		}else{
			out.println("����ȸ�� ������ �����Ͽ����ϴ�.");if(true)return;
		}
		rs_mssql.close();
		*/		

		/* ���� ���� ������ ��� �����Ǹ� SSO ���� ���� �� ���� �̵� �������� �̵��մϴ�. */
		if(TmaxSSOSession.login(request,token)){
			response.sendRedirect(nextPage);
		}
	} else {
		/* ����� ������ �Ϸ�� ���� ��� ���� ó�� �Ǵ� �̵� �������� �����մϴ�. */
		out.println("<br>����� ������ �Ϸ�� ���� ��� ���� ó��");
		//response.sendRedirect(serviceURL + "index2.jsp");
	}
} else {
	/* ���� ��ū�� ���� ��� ���� �α����� �����մϴ�. */
	//response.sendRedirect("http://222.231.17.20/index.jsp");	
	//out.println("���� ��ū�� ���� ��� ���� �α����� �����մϴ�");
	response.sendRedirect("http://member.pulmuone.co.kr/sso_login.jsp?siteno=" + siteno);
}
%>
<%@ include file="/lib/dbclose_mssql.jsp" %>
