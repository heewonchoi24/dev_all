<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="com.tmax.eam.*"%>
<%@ include file="/lib/dbconn_mssql.jsp"%>
<%
String userid	= "";
String passwd	= "";
String common	= "";

/*********************** tmax eam 을 위한 코드 ************************/
String tokenStr = (String)request.getParameter(Common.PARAM_TOKEN);
String nextPage = (String)request.getParameter(Common.PARAM_NEXTURL);
String siteno	= Common.encode("0002400000");	//ECMD 사이트 번호로 변경할것!

/*********************** 현재 요청한 서비스 URL ***********************/
String fullURL	= javax.servlet.http.HttpUtils.getRequestURL(request).toString();
String serviceServletPath = request.getServletPath();
int ii = fullURL.indexOf(serviceServletPath);
String serviceURL = fullURL.substring(0,ii) + "/";
/*********************** 현재 요청한 서비스 URL ***********************/

if (nextPage == null) {
	nextPage	= "first.jsp";
	out.println("############## NextPageURL is null");
} else {
	nextPage	= Common.decode(nextPage);
	out.println("############## NextPageURL = " + nextPage);
}

out.println("<br>[tokenStr tmaxssologin.jsp] Parameter로 얻어온 token = " + tokenStr);

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
			// 프로토콜 문자열 제거
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
  ga('set', 'dimension2', '<%=session.getAttribute("esl_customer_num")==null?"N":"Y"%>');            //로그인시 고객번호전송
  ga('set', 'dimension3', '<%=session.getAttribute("esl_customer_num")==null?"":session.getAttribute("esl_customer_num")%>');            //로그인시 고객번호전송
  
  
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
	
	//임시로 loginCheck를 false로 설정해놓은 상태임.
	if (cmm !=null){
		//loginCheck = false;
		loginCheck = true;
	}

	/* 사용자 검증이 완료되면 업무 세션 값을 생성합니다. */
	if(loginCheck) {
		
		/* 업무 사용자에 맞는 세션 값 생성하는 부분이 들어감 */
		//session.setAttribute("userid", id);
		
		//nextPage="http://www.pulmuonecaf.com/";
		//response.sendRedirect(nextPage);
		//session.invalidate(); //세션을 초기화			
		nextPage	= "https://www.eatsslim.co.kr/proc/checkMember.jsp?id="+etc;

		/*
		//mssql 회원정보 조회
		String sqlquery="";
		sqlquery="SELECT TOP 1";
		sqlquery+=" A.CUSTOMER_NUM,A.NAME";
		sqlquery+=" FROM MEMBER_INFO A, SITE_USED_YN B";
		sqlquery+=" WHERE A.CUSTOMER_NUM = B.CUSTOMER_NUM";
		sqlquery+=" AND A.DEREG_APP_YN = 'N'";
		sqlquery+=" AND B.SITE_USE = 'Y'";
		//sqlquery+=" AND B.SITE_NO = '0002800000'"; //실오픈시 주석해제
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
			out.println("통합회원 인증에 실패하였습니다.");if(true)return;
		}
		rs_mssql.close();
		*/		

		/* 업무 인증 세션이 모두 생성되면 SSO 세션 생성 후 최종 이동 페이지로 이동합니다. */
		if(TmaxSSOSession.login(request,token)){
			response.sendRedirect(nextPage);
		}
	} else {
		/* 사용자 검증이 완료되 않을 경우 에러 처리 또는 이동 페이지를 설정합니다. */
		out.println("<br>사용자 검증이 완료되 않을 경우 에러 처리");
		//response.sendRedirect(serviceURL + "index2.jsp");
	}
} else {
	/* 인증 토큰이 없는 경우 통합 로그인을 수행합니다. */
	//response.sendRedirect("http://222.231.17.20/index.jsp");	
	//out.println("인증 토큰이 없는 경우 통합 로그인을 수행합니다");
	response.sendRedirect("http://member.pulmuone.co.kr/sso_login.jsp?siteno=" + siteno);
}
%>
<%@ include file="/lib/dbclose_mssql.jsp" %>
