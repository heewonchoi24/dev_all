<%@ page contentType="text/html; charset=EUC-KR" %>
<%//�׽�Ʈ��
request.setCharacterEncoding("euc-kr");
    /*
     * [ ������� ȭ��������]
     */

    String LGD_TID                 = request.getParameter("LGD_TID");			//LG���÷��� �ŷ���ȣ
    String LGD_OID                 = request.getParameter("LGD_OID");			//�ֹ���ȣ
    String LGD_PAYTYPE             = request.getParameter("LGD_PAYTYPE");		//��������
    String LGD_PAYDATE    		   = request.getParameter("LGD_PAYDATE");		//��������
    String LGD_FINANCECODE         = request.getParameter("LGD_FINANCECODE");	//��������ڵ�
    String LGD_FINANCENAME         = request.getParameter("LGD_FINANCENAME");	//��������̸�
    String LGD_FINANCEAUTHNUM      = request.getParameter("LGD_FINANCEAUTHNUM");//��������ι�ȣ
    String LGD_ACCOUNTNUM          = request.getParameter("LGD_ACCOUNTNUM");	//�Ա��� ���� (�������)
    String LGD_BUYER               = request.getParameter("LGD_BUYER");			//�����ڸ�
    String LGD_PRODUCTINFO         = request.getParameter("LGD_PRODUCTINFO");	//��ǰ��
    String LGD_AMOUNT              = request.getParameter("LGD_AMOUNT");		//�����ݾ�
    String LGD_RESPCODE            = request.getParameter("LGD_RESPCODE");		//����ڵ�
    String LGD_RESPMSG             = request.getParameter("LGD_RESPMSG");		//����޼���
        
    if (("0000".equals(LGD_RESPCODE))) { 	//����������
    	out.println("* Xpay-lite (ȭ��)������������� �����Դϴ�." + "<p>");

    	out.println("����ڵ� : " + LGD_RESPCODE + "<br>");
    	out.println("����޼��� : " + LGD_RESPMSG + "<br>");
    	out.println("�ŷ���ȣ : " + LGD_TID + "<br>");
    	out.println("�ֹ���ȣ : " + LGD_OID + "<br>");
    	out.println("������ : " + LGD_BUYER + "<br>");
    	out.println("��ǰ�� : " + LGD_PRODUCTINFO + "<br>");
    	out.println("�����ݾ� : " + LGD_AMOUNT + "<br>");
    	out.println("�������� : " + LGD_PAYTYPE + "<br>");
    	out.println("�����Ͻ� : " + LGD_PAYDATE + "<br>");
    	out.println("�������ڵ� : " + LGD_FINANCECODE + "<br>");
        
        if (("SC0010".equals(LGD_PAYTYPE))) {			//�ſ�ī�� ������		
        	out.println("ī���� : " + LGD_FINANCENAME + "<br>");
        	out.println("���ι�ȣ : " + LGD_FINANCEAUTHNUM + "<br>");
        } 
        else if (("SC0030".equals(LGD_PAYTYPE))) {		//������ü ������
        	out.println("�������� : " + LGD_FINANCENAME + "<br>");
        }
        else if (("SC0040".equals(LGD_PAYTYPE))) {		//������� ������ (�Ҵ�)
        	out.println("�Ա����� : " + LGD_FINANCENAME + "<br>");
        	out.println("�Աݰ��¹�ȣ : " + LGD_ACCOUNTNUM + "<br>");
        } 
        else {											//��Ÿ ������
        	out.println("������� : " + LGD_FINANCENAME + "<br>");
        	out.println("��������ι�ȣ : " + LGD_FINANCEAUTHNUM + "<br>");
        }
    } else {	 //�������н�
    	out.println("������ ���еǾ����ϴ�." + "<p>");
    	out.println("����ڵ� : " + LGD_RESPCODE + "<br>");
    	out.println("����޼��� : " + LGD_RESPMSG + "<br>");
    }
 
%>
