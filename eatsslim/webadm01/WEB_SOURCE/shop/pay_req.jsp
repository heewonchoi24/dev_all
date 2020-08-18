<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>

<%
    /*
     * 1. �⺻�������� ����
     *     
     *
     * �����⺻������ �����Ͽ� �ֽñ� �ٶ��ϴ�. 
     */
    
	String CST_PLATFORM         = "";                 								//LG���÷��� �������� ����(test:�׽�Ʈ, service:����)
    String CST_MID              = "kvp_eatsslim";                      								//LG���÷������� ���� �߱޹����� �������̵� �Է��ϼ���.
    String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
                                                                                        //�������̵�(�ڵ�����)
	String LGD_OID              = "test_0001";                      					//�ֹ���ȣ(�������� ����ũ�� �ֹ���ȣ�� �Է��ϼ���)
    String LGD_AMOUNT           = "1004";                       							//�����ݾ�("," �� ������ �����ݾ��� �Է��ϼ���)
    String LGD_BUYER            = "ȫ�浿";                        						//�����ڸ�
    String LGD_PRODUCTINFO      = "�׽�Ʈ��ǰ";                  						//��ǰ��
    String LGD_NOTEURL      	= "http://merchant_URL/note_url.jsp ";  				//����������� ó��(DB) ������ URL (URL�� �Է��� �ּ���. ��: http://pgweb.uplus.co.kr/note_url.jsp)
    String LGD_TAXFREEAMOUNT	= "";													//�鼼�ݾ� (�鼼��ǰ��� ������ ��� ��� - ����� "�κи鼼" ����� Ȯ���ϼ���)  	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>������û</title>
<script type="text/javascript">

/*
 * ������û �� ���ȭ�� ó�� 
 */

function doAnsimKeyin(){
//CST_PLATFORM�� test(�׽�Ʈ) �Ǵ� service(����)�� �Ѱ��ֽø� �˴ϴ�. 
    ret = ansimkeyin_check(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>'); 

    if (ret=="00"){ //plug-in ���� �ε�
        var LGD_RESPCODE       = dpop.getData('LGD_RESPCODE');       //����ڵ�
        var LGD_RESPMSG        = dpop.getData('LGD_RESPMSG');        //����޼���
	      if( "0000" == LGD_RESPCODE ) { //�������� 
            var LGD_TID            = dpop.getData('LGD_TID');            //LG���÷��� �ŷ�KEY
	        var LGD_PAYDATE        = dpop.getData('LGD_PAYDATE');        //��������
            var LGD_FINANCECODE    = dpop.getData('LGD_FINANCECODE');    //��������ڵ�
            var LGD_FINANCENAME    = dpop.getData('LGD_FINANCENAME');    //��������̸�
            var LGD_NOTEURL_RESULT = dpop.getData('LGD_NOTEURL_RESULT'); //����DBó�����

            alert("������ �����Ͽ����ϴ�. LG���÷��� �ŷ�ID : " + LGD_TID);
            /*
             * �������� ȭ�� ó��
             */        
       
        } else { //��������
             alert("������ �����Ͽ����ϴ�. " + LGD_RESPMSG);
            /*
             * �������� ȭ�� ó��
             */        
        }
    } else {
        alert("LG���÷��� ���ڰ����� ���� ActiveX ��ġ ����");
    }     
} 
 
</script>
</head>

<body>
<form method="post" id="LGD_PAYINFO">
<input type="hidden" name="LGD_MID" value="<%= LGD_MID %>">								<!-- �������̵� -->
<input type="hidden" name="LGD_NOTEURL" value="<%= LGD_NOTEURL %>">						<!-- �������ó��_URL(LGD_NOTEURL) -->
<table>
    <tr>
        <td>�ֹ���ȣ </td>
        <td><input type="text" name="LGD_OID" value="<%= LGD_OID %>">					<!-- �ֹ���ȣ --></td>
    </tr>
    <tr>
        <td>��ǰ���� </td>
        <td><input type="text" name="LGD_PRODUCTINFO" value="<%= LGD_PRODUCTINFO %>">	<!-- ��ǰ���� --></td>
    </tr>
    <tr>
        <td>�����ݾ� </td>
        <td><input type="text" name="LGD_AMOUNT" value="<%= LGD_AMOUNT %>">				<!-- �����ݾ� --></td>
    </tr>
    <tr>
        <td>�����ڸ� </td>
        <td><input type="text" name="LGD_BUYER" value="<%= LGD_BUYER %>">				<!-- ������ --></td>
    </tr>
     <tr>
        <td>
        <input type="button" value="������û(ActiveX)" onclick="doAnsimKeyin()"/><br>
        </td>
    </tr>
</table>
</form>

</body>
<!--  xpay.js�� �ݵ�� body �ؿ� �νñ� �ٶ��ϴ�. -->
<script language="javascript" src="http://xpay.uplus.co.kr/ansim-keyin/js/ansim-keyin.js" type="text/javascript"></script>
</html>
