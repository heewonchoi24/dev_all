<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("euc-kr");
	HashMap payReqMap = (HashMap)session.getAttribute("PAYREQ_MAP");//���� ��û��, Session�� �����ߴ� �Ķ���� MAP 

/*
  payreq_crossplatform.jsp ���� ���ǿ� �����ߴ� �Ķ���� ���� ��ȿ���� üũ 
  ���� ���� �ð�(�α��� �����ð�)�� ������ ���� �ϰų� ������ ������� �ʴ� ��� DBó�� �Ͻñ� �ٶ��ϴ�.
*/
	if(payReqMap == null) 
	{
		out.println("������ ���� �Ǿ��ų� ��ȿ���� ���� ��û �Դϴ�.");
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
			if("<%=request.getParameter("LGD_PAYTYPE")%>"=="SC0010"){ //�ſ�ī��
				f.settlekind[0].checked=true;
			}else if("<%=request.getParameter("LGD_PAYTYPE")%>"=="SC0030"){ //������ü
				f.settlekind[1].checked=true;
			}else if("<%=request.getParameter("LGD_PAYTYPE")%>"=="SC0040"){ //�������(�������Ա�)
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
	//response.sendRedirect("/mobile/payment_end.jsp?ono="+request.getParameter("LGD_OID")); //����������� �̵�
	//if(true)return;

	LGD_PAYKEY = request.getParameter("LGD_PAYKEY");
	payReqMap.put("LGD_RESPCODE"	, LGD_RESPCODE);
	payReqMap.put("LGD_RESPMSG"		, LGD_RESPMSG);
	payReqMap.put("LGD_PAYKEY"		, LGD_PAYKEY);
%>
<!--�Ʒ��� ������-->
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
	//out.println("LGD_RESPCODE:" + LGD_RESPCODE + " ,LGD_RESPMSG:" + LGD_RESPMSG +"<br><br><br><center><a href='/mobile/indentation_list.jsp'><img src='/mobile/images/btn/btn_prev.gif' border='0'/></a></center>"); //���� ���п� ���� ó�� ���� �߰�
	out.println("<script>alert('" + LGD_RESPMSG +"');location.href='/mobile/shop/dietMeal.jsp';</script>"); //���� ���п� ���� ó�� ���� �߰�
}
%>
</body>
</html>