<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
//===============================��¥
Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //����
String cDate=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.add ( Calendar.DATE, -2 ); //3����
String preDate3=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
cal.add ( Calendar.DATE, -6 ); //7����
String preDate7=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
cal.add ( Calendar.MONTH, -1 ); //1������
String preMonth1=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
cal.add ( Calendar.MONTH, -3 ); //3������
String preMonth3=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
cal.add ( Calendar.YEAR, -1 ); //12������
String preYear1=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
//===============================
%><!-- �޷� �Է� ��Ʈ�� ���� -->