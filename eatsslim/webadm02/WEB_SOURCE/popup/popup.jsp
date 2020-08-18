<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query	= "";
int popupId		= 0;
String title	= "";
String[] attrArr;
String[] widthArr;
String[] heightArr;
int width		= 0;
int height		= 0;
String content	= "";
String link		= "";

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	popupId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT TITLE, ATTR, CONTENT, LINK FROM ESL_POPUP WHERE ID = "+ popupId;
	rs			= stmt.executeQuery(query);

	if (rs.next()) {
		title		= rs.getString("TITLE");
		attrArr		= rs.getString("ATTR").split(",");
		widthArr	= attrArr[0].split("=");
		width		= Integer.parseInt(widthArr[1]);
		heightArr	= attrArr[1].split("=");
		height		= Integer.parseInt(heightArr[1]) - 25;
		content		= rs.getString("CONTENT");
		link		= ut.isnull(rs.getString("LINK"));
	}
} else {
	out.println("<script>self.close();</script>");
	if (true) return;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title><%=title%></title>
<style>
body {margin:0; padding:0;}
img{border:0;}
ul{list-style:none; margin:0; padding:0}
.popup_box .img_line{width:<%=width%>px; height:<%=height%>px; margin:0 auto;}
.popup_box .pop_close_line{height:25px; background:#000; text-align:right; font-size:12px; color:#FFF;}
</style>

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
  
  ga('send', 'pageview');

</script>


<script type="text/javascript">
<!--
function setCookie(name, value, expiredays) {
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" +
	todayDate.toGMTString() + ";"
}
function popup_closeWin() {        
	if (document.forms[0].pop_close.checked)                
		setCookie( "popup_<%=popupId%>", "done" , 1); // 1=하룻동안 공지창 열지 않음        
	self.close();
}

function popClose(url) {
	
	ga('send', 'event', 'button', 'click', '<%=title%>');
	
	if (url) {
		opener.location = url;
	}	
	self.close();
}
//-->
</script>
</head>
<body>
	<div class="popup_box">
		<ul>
		<li class="img_line"><a href="javascript:;" onclick="popClose('<%=link%>');"><%=content%></a></li>
		<li class="pop_close_line">
			<form name="form1">
            <label for="c_close">오늘 하루 이창을 열지 않음</label>&nbsp;
			<input type="checkbox" name="pop_close" onclick="popup_closeWin();">
            </form>
		</li>
		</ul>
	</div>
</body>
</html>