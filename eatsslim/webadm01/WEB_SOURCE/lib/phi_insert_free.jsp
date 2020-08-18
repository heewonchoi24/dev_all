<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
//================PHI ¿¬µ¿
i					= 1;
int k				= 0;
int maxK			= 0;
int ordSeq			= 0;
String rcvPartner	= "";
String tagPartner	= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
Date date			= null;
String devlDatePhi	= "";
String gubun1		= "";
String gubun2		= "";
String gubun3		= "";
String groupCode	= "";
int orderCnt		= 0;
String devlType		= "";
String devlDay		= "";
String devlHoliday	= "";
String devlWeek		= "";
String devlDate		= "";
int price			= 0;
String buyBagYn		= "";
int week			= 1;
int chkCnt			= 0;
int phiCnt			= 0;
String customerNum	= "";
String gubunCode	= "";
int goodsId			= 0;

%>
<%@ include file="/lib/phi_insert_query.jsp"%>