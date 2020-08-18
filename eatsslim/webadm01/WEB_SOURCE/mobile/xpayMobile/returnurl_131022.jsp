<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("euc-kr");
	HashMap payReqMap = (HashMap)session.getAttribute("PAYREQ_MAP");//결제 요청시, Session에 저장했던 파라미터 MAP 

/*
  payreq_crossplatform.jsp 에서 세션에 저장했던 파라미터 값이 유효한지 체크 
  세션 유지 시간(로그인 유지시간)을 적당히 유지 하거나 세션을 사용하지 않는 경우 DB처리 하시기 바랍니다.
*/
	if(payReqMap == null) 
	{
		out.println("세션이 만료 되었거나 유효하지 않은 요청 입니다.");
		return;
	}
%>
<html>
<head>
	<script type="text/javascript">
		function setLGDResult() {
			document.getElementById('LGD_PAYINFO').submit();
			/*
			var f=opener.document.frmOrder;
			f.LGD_TID.value = "<%=request.getParameter("LGD_TID")%>";
			f.LGD_CARDNUM.value = "<%=request.getParameter("LGD_CARDNUM")%>";
			f.LGD_FINANCECODE.value = "<%=request.getParameter("LGD_FINANCECODE")%>";
			f.LGD_FINANCENAME.value = "<%=request.getParameter("LGD_FINANCENAME")%>";
			f.LGD_ACCOUNTNUM.value = "<%=request.getParameter("LGD_ACCOUNTNUM")%>";
			f.LGD_FINANCEAUTHNUM.value = "<%=request.getParameter("LGD_FINANCEAUTHNUM")%>";
			if("<%=request.getParameter("LGD_PAYTYPE")%>"=="SC0010"){ //신용카드
				f.settlekind[0].checked=true;
			}else if("<%=request.getParameter("LGD_PAYTYPE")%>"=="SC0030"){ //계좌이체
				f.settlekind[1].checked=true;
			}else if("<%=request.getParameter("LGD_PAYTYPE")%>"=="SC0040"){ //가상계좌(무통장입금)
				f.settlekind[2].checked=true;
			}
			f.action="/proc/order_proc.jsp";
			f.submit();
			self.close();
			*/
		}
		
	</script>
</head>
<body<%if("0000".equals(request.getParameter("LGD_RESPCODE"))){%> onload="setLGDResult()"<%}%>>
<% 
String LGD_RESPCODE = request.getParameter("LGD_RESPCODE");
String LGD_RESPMSG 	= request.getParameter("LGD_RESPMSG");
String LGD_PAYKEY	= "";

if("0000".equals(LGD_RESPCODE)){
	//response.sendRedirect("/mobile/payment_end.jsp?ono="+request.getParameter("LGD_OID")); //결과페이지로 이동
	//if(true)return;

	LGD_PAYKEY = request.getParameter("LGD_PAYKEY");
	payReqMap.put("LGD_RESPCODE"	, LGD_RESPCODE);
	payReqMap.put("LGD_RESPMSG"		, LGD_RESPMSG);
	payReqMap.put("LGD_PAYKEY"		, LGD_PAYKEY);
%>
<!--아래거 사용안함-->
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="payres.jsp"><%		
	for(Iterator i = payReqMap.keySet().iterator(); i.hasNext();){
		Object key = i.next();
		out.println("<input type='hidden' name='" + key + "' value='" + payReqMap.get(key) + "'>" );
	}
%>
</form>
<%
}
else{
	//out.println("LGD_RESPCODE:" + LGD_RESPCODE + " ,LGD_RESPMSG:" + LGD_RESPMSG +"<br><br><br><center><a href='/mobile/indentation_list.jsp'><img src='/mobile/images/btn/btn_prev.gif' border='0'/></a></center>"); //인증 실패에 대한 처리 로직 추가
	out.println("<script>alert('" + LGD_RESPMSG +"');location.href='/mobile/shop/dietMeal.jsp';</script>"); //인증 실패에 대한 처리 로직 추가
}
%>
</body>
</html>