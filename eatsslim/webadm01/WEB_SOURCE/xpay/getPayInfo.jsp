<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="config.jsp" %>
<%//�ؽ�Ű ������
request.setCharacterEncoding("euc-kr");
	String LGD_CLOSEDATE = "20991231240000";
   
    LGD_OID = request.getParameter("LGD_OID"); //�ֹ���ȣ(�������� ����ũ�� �ֹ���ȣ�� �Է��ϼ���)
	LGD_AMOUNT = request.getParameter("LGD_AMOUNT"); //�����ݾ�("," �� ������ �����ݾ��� �Է��ϼ���)
	//LGD_CLOSEDATE = request.getParameter("LGD_CLOSEDATE");

	String omemId = request.getParameter("OMEMBERID"); //�������̵�

    /*
     * 3. hashdata ��ȣȭ (�������� ������)
	 * �⺻ �Ķ���͸� ���õǾ� ������, ������ �ʿ��Ͻ� �Ķ���ʹ� �����޴����� �����Ͻþ� �߰��Ͻñ� �ٶ��ϴ�. 
     * hashdata ��ȣȭ�� �ŷ� �������� �������� ����Դϴ�. 
     *
     * hashdata ��ȣȭ ����( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
     * LGD_MID : �������̵�
     * LGD_OID : �ֹ���ȣ
     * LGD_AMOUNT : �ݾ� 
     * LGD_TIMESTAMP : Ÿ�ӽ�����
     * LGD_MERTKEY : ����Ű(mertkey)
     *
     * hashdata ������ ���� 
     * LG���÷������� �߱��� ����Ű(MertKey)�� �ݵ�� �Է��� �ֽñ� �ٶ��ϴ�.
     */  
    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
    sb.append(LGD_TIMESTAMP);
    sb.append(LGD_MERTKEY);

    byte[] bNoti = sb.toString().getBytes();
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] digest = md.digest(bNoti);
	int i=0;

    StringBuffer strBuf = new StringBuffer();
    for (i=0 ; i < digest.length ; i++) {
        int c = digest[i] & 0xff;
        if (c <= 15){
            strBuf.append("0");
        }
        strBuf.append(Integer.toHexString(c));
    }

    String LGD_HASHDATA = strBuf.toString();
%>

<script type="text/javascript">
var f=parent.document.LGD_PAYINFO;
f.LGD_OID.value="<%=LGD_OID%>";
f.LGD_AMOUNT.value="<%=LGD_AMOUNT%>";
f.LGD_TIMESTAMP.value="<%=LGD_TIMESTAMP%>";
f.LGD_HASHDATA.value="<%=LGD_HASHDATA%>";
f.LGD_CLOSEDATE.value="<%=LGD_CLOSEDATE%>";

<% if ( omemId.equals("test0517") ) { %>
parent.doAnsimKeyin();
<% } else { %>
parent.doPay_ActiveX('<%=platform%>');
<% } %>
</script>
