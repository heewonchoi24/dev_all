<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
    String CST_PLATFORM         = "service";                 //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)
    String CST_MID              = "eatsslim1";                      //LG���÷������� ���� �߱޹����� �������̵� �Է��ϼ���.
    String configPath 			= "C:/lgdacom";  										//LG���÷������� ������ ȯ������("/conf/lgdacom.conf") ��ġ ����.
	configPath="/home/webadm01/WEB_SOURCE/esl_admin/lgdacom";
	String PortNum=("test".equals(CST_PLATFORM.trim())?":7085":""); //��Ʈ��ȣ

	String LGD_MID              = ("test".equals(CST_PLATFORM)?"t":"")+CST_MID;                     //�������̵�(�ڵ�����)   
	String LGD_MERTKEY          = "bbc52915b7b3cc90d88c76b78856dcba";                      //����MertKey(mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�)
%>