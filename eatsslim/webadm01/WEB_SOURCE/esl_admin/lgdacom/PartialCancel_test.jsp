<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<html>
<head>
    <title>LG���÷��� ���ڰ��� ���� �κ���� ���� ������</title>
</head>
<body>
    <form method="post" id="LGD_PAYINFO" action="PartialCancel.jsp">
    <div>
        <table>	
            <tr>
                <td>�������̵�(t�� ������ ���̵�) </td>
                <td><input type="text" name="CST_MID" value="pmoamio"/></td>
            </tr>
            <tr>
                <td>����,�׽�Ʈ </td>
                <td><input type="text" name="CST_PLATFORM" value="test"/></td>
            </tr>
            <tr>
                <td>LG���÷��� �ŷ���ȣ </td>
                <td><input type="text" name="LGD_TID" value=""/></td>
            </tr>
            <tr>
                <td>�κ���� �ݾ� </td>
                <td><input type="text" name="LGD_CANCELAMOUNT" value=""/></td>
            </tr>
            <tr>
                <td>����� ���� �ݾ�(�ſ�ī�常 ����) </td>
                <td><input type="text" name="LGD_REMAINAMOUNT" value=""/></td>
            </tr>
            <tr>
                <td>�鼼�κ���� �ݾ� (����/�鼼 ȥ������� ����)</td>
                <td><input type="text" name="LGD_CANCELTAXFREEAMOUNT" value=""/></td>
            </tr>
            <tr>
                <td>��һ��� </td>
                <td><input type="text" name="LGD_CANCELREASON" value=""/></td>
            </tr>			
			<tr>
                <td>ȯ�Ұ��� �����ڵ� (������¸� �ʼ�)</td>
                <td><input type="text" name="LGD_RFBANKCODE" value=""/></td>
            </tr>
		    <tr>
                <td>ȯ�Ұ��� ��ȣ (������¸� �ʼ�)</td>
                <td><input type="text" name="LGD_RFACCOUNTNUM" value=""/></td>
            </tr>
            <tr>
                <td>ȯ�Ұ��� ������ (������¸� �ʼ�)</td>
                <td><input type="text" name="LGD_RFCUSTOMERNAME" value="ȫ�浿"/></td>
            </tr>
            <tr>
                <td>��û�� ����ó (������¸� �ʼ�)</td>
                <td><input type="text" name="LGD_RFPHONE" value="01022223333"/></td>
            </tr>
	            
            <tr>
                <td>
                <input type="submit" value="�κ� ���"/><br/>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>