<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="lgdacom.XPayClient.XPayClient"%>
<%
request.setCharacterEncoding("euc-kr");
    /*
     * [����������û ������(STEP2-2)]
     *
     * LG���÷������� ���� �������� LGD_PAYKEY(����Key)�� ������ ���� ������û.(�Ķ���� ���޽� POST�� ����ϼ���)
     */

    String configPath = "C:/lgdacom";  //LG���÷������� ������ ȯ������("/conf/lgdacom.conf,/conf/mall.conf") ��ġ ����.
	configPath="/home/webadm01/WEB_SOURCE/esl_admin/lgdacom";
    /*
     *************************************************
     * 1.�������� ��û - BEGIN
     *  (��, ���� �ݾ�üũ�� ���Ͻô� ��� �ݾ�üũ �κ� �ּ��� ���� �Ͻø� �˴ϴ�.)
     *************************************************
     */
    
    String CST_PLATFORM                 = request.getParameter("CST_PLATFORM");
    String CST_MID                      = request.getParameter("CST_MID");
    String LGD_MID                      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
    String LGD_PAYKEY                   = request.getParameter("LGD_PAYKEY");

    //�ش� API�� ����ϱ� ���� WEB-INF/lib/XPayClient.jar �� Classpath �� ����ϼž� �մϴ�. 
    XPayClient xpay = new XPayClient();
   	boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);   	

   	if( !isInitOK ) {
    	//API �ʱ�ȭ ���� ȭ��ó��
        out.println( "������û�� �ʱ�ȭ �ϴµ� �����Ͽ����ϴ�.<br>");
        out.println( "LG���÷������� ������ ȯ�������� ���������� ��ġ �Ǿ����� Ȯ���Ͻñ� �ٶ��ϴ�.<br>");        
        out.println( "mall.conf���� Mert ID = Mert Key �� �ݵ�� ��ϵǾ� �־�� �մϴ�.<br><br>");
        out.println( "������ȭ LG���÷��� 1544-7772<br>");
        return;
   	
   	}else{      
   		try{
   			/*
   	   	     *************************************************
   	   	     * 1.�������� ��û(�������� ������) - END
   	   	     *************************************************
   	   	     */
	    	xpay.Init_TX(LGD_MID);
	    	xpay.Set("LGD_TXNAME", "PaymentByKey");
	    	xpay.Set("LGD_PAYKEY", LGD_PAYKEY);
	    
	    	//�ݾ��� üũ�Ͻñ� ���ϴ� ��� �Ʒ� �ּ��� Ǯ� �̿��Ͻʽÿ�.
	    	//String DB_AMOUNT = "DB�� ���ǿ��� ������ �ݾ�"; //�ݵ�� �������� �Ұ����� ��(DB�� ����)���� �ݾ��� �������ʽÿ�.
	    	//xpay.Set("LGD_AMOUNTCHECKYN", "Y");
	    	//xpay.Set("LGD_AMOUNT", DB_AMOUNT);
	    	
    	}catch(Exception e) {
    		out.println("LG���÷��� ���� API�� ����� �� �����ϴ�. ȯ������ ������ Ȯ���� �ֽñ� �ٶ��ϴ�. ");
    		out.println(""+e.getMessage());    	
    		return;
    	}
   	}

    /*
     * 2. �������� ��û ���ó��
     *
     * ���� ������û ��� ���� �Ķ���ʹ� �����޴����� �����Ͻñ� �ٶ��ϴ�.
     */
     if ( xpay.TX() ) {
         //1)������� ȭ��ó��(����,���� ��� ó���� �Ͻñ� �ٶ��ϴ�.)

		 /*
         out.println( "������û�� �Ϸ�Ǿ����ϴ�.  <br>");
         out.println( "TX ������û Response_code = " + xpay.m_szResCode + "<br>");
         out.println( "TX ������û Response_msg = " + xpay.m_szResMsg + "<p>");
         
         out.println("�ŷ���ȣ : " + xpay.Response("LGD_TID",0) + "<br>");
         out.println("�������̵� : " + xpay.Response("LGD_MID",0) + "<br>");
         out.println("�����ֹ���ȣ : " + xpay.Response("LGD_OID",0) + "<br>");
         out.println("�����ݾ� : " + xpay.Response("LGD_AMOUNT",0) + "<br>");
         out.println("����ڵ� : " + xpay.Response("LGD_RESPCODE",0) + "<br>");
         out.println("����޼��� : " + xpay.Response("LGD_RESPMSG",0) + "<p>");
         
         for (int i = 0; i < xpay.ResponseNameCount(); i++)
         {
             out.println(xpay.ResponseName(i) + " = ");
             for (int j = 0; j < xpay.ResponseCount(); j++)
             {
                 out.println("\t" + xpay.Response(xpay.ResponseName(i), j) + "<br>");
             }
         }
         out.println("<p>");
		 */
         
         if( "0000".equals( xpay.m_szResCode ) ) {
         	//����������û ��� ���� DBó��
         	//out.println("����������û ��� ���� DBó���Ͻñ� �ٶ��ϴ�.<br>");
         	            	
         	//����������û ��� ���� DBó�� ���н� Rollback ó��
         	boolean isDBOK = true; //DBó�� ���н� false�� ������ �ּ���.
         	if( !isDBOK ) {
         		xpay.Rollback("���� DBó�� ���з� ���Ͽ� Rollback ó�� [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
         		
                 out.println( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0) + "<br>");
                 out.println( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) + "<p>");
         		
                 if( "0000".equals( xpay.m_szResCode ) ) {
                 	out.println("�ڵ���Ұ� ���������� �Ϸ� �Ǿ����ϴ�.<br>");
                 }else{
         			out.println("�ڵ���Ұ� ���������� ó������ �ʾҽ��ϴ�.<br>");
                 }
         	}
         	%>
			
			<form method="post" name="frmMobileComplete" id="frmMobileComplete" action="/proc/order_proc_mobile.jsp">
			<input type="hidden" name="orderEnv" value="M" />
			<input type="hidden" name="order_num" value="<%=xpay.Response("LGD_OID",0)%>"/>
			<input type="hidden" name="pay_type" value="" />
			<input type="hidden" name="LGD_OID" value="<%=xpay.Response("LGD_OID",0)%>"/>
			<input type="hidden" name="LGD_TID" value="<%=xpay.Response("LGD_TID",0)%>" />
			<input type="hidden" name="LGD_CARDNUM" value="<%=xpay.Response("LGD_CARDNUM",0)%>" />
			<input type="hidden" name="LGD_FINANCECODE" value="<%=xpay.Response("LGD_FINANCECODE",0)%>" />
			<input type="hidden" name="LGD_FINANCENAME" value="<%=xpay.Response("LGD_FINANCENAME",0)%>" />
			<input type="hidden" name="LGD_ACCOUNTNUM" value="<%=xpay.Response("LGD_ACCOUNTNUM",0)%>" />
			<input type="hidden" name="LGD_FINANCEAUTHNUM" value="<%=xpay.Response("LGD_FINANCEAUTHNUM",0)%>" />
			<input type="hidden" name="LGD_CUSTOM_USABLEPAY" id = 'LGD_CUSTOM_USABLEPAY' value="SC0010-SC0030-SC0040"/>
			</form>				
		
			<script type="text/javascript">
			var f=document.frmMobileComplete;
			//var f=parent.document.frmOrder;
			//f.LGD_TID.value = "<%=xpay.Response("LGD_TID",0)%>";
			//f.LGD_CARDNUM.value = "<%=xpay.Response("LGD_CARDNUM",0)%>";
			//f.LGD_FINANCECODE.value = "<%=xpay.Response("LGD_FINANCECODE",0)%>";
			//f.LGD_FINANCENAME.value = "<%=xpay.Response("LGD_FINANCENAME",0)%>";
			//f.LGD_ACCOUNTNUM.value = "<%=xpay.Response("LGD_ACCOUNTNUM",0)%>";
			//f.LGD_FINANCEAUTHNUM.value = "<%=xpay.Response("LGD_FINANCEAUTHNUM",0)%>";
			if("<%=xpay.Response("LGD_PAYTYPE",0)%>"=="SC0010"){ //�ſ�ī��
				f.pay_type.value="10";
			}else if("<%=xpay.Response("LGD_PAYTYPE",0)%>"=="SC0030"){ //������ü
				f.pay_type.value="20";
			}else if("<%=xpay.Response("LGD_PAYTYPE",0)%>"=="SC0040"){ //�������(�������Ա�)
				f.pay_type.value="30";
			}
			//if(parent.document.getElementById('payBtn'))parent.document.getElementById('payBtn').style.display="none";
			//if(parent.document.getElementById('pay_ing'))parent.document.getElementById('pay_ing').style.display="";

			//alert("�ֹ������Ϸ� �������� ��Ÿ�������� ��� ��ٷ� �ֽʽÿ�.");			
			//parent.payMobileComplete("<%=xpay.Response("LGD_OID",0)%>");
			/*f.action="/proc/order_mobile_proc.jsp";*/
			f.submit();
			
			//self.close();
			</script>


			<%
         }else{
         	//����������û ��� ���� DBó��
         	out.println("����������û ��� ���� DBó���Ͻñ� �ٶ��ϴ�.<br>");            	
         }
     }else {
         //2)API ��û���� ȭ��ó��
         out.println( "������û�� �����Ͽ����ϴ�.  <br>");
         out.println( "TX ������û Response_code = " + xpay.m_szResCode + "<br>");
         out.println( "TX ������û Response_msg = " + xpay.m_szResMsg + "<p>");
         
     	//����������û ��� ���� DBó��
     	//out.println("����������û ��� ���� DBó���Ͻñ� �ٶ��ϴ�.<br>");            	            
     }
%>