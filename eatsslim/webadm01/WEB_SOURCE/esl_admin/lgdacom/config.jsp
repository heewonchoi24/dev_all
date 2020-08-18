<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
    String CST_PLATFORM         = "service";                 //LG유플러스 결제서비스 선택(test:테스트, service:서비스)
    String CST_MID              = "eatsslim1";                      //LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요.
    String configPath 			= "C:/lgdacom";  										//LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.
	configPath="/home/webadm01/WEB_SOURCE/esl_admin/lgdacom";
	String PortNum=("test".equals(CST_PLATFORM.trim())?":7085":""); //포트번호

	String LGD_MID              = ("test".equals(CST_PLATFORM)?"t":"")+CST_MID;                     //상점아이디(자동생성)   
	String LGD_MERTKEY          = "bbc52915b7b3cc90d88c76b78856dcba";                      //상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
%>