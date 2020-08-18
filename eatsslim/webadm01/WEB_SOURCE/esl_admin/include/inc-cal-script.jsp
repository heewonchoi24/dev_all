<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
//===============================날짜
Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.add ( Calendar.DATE, -2 ); //3일전
String preDate3=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
cal.add ( Calendar.DATE, -6 ); //7일전
String preDate7=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
cal.add ( Calendar.MONTH, -1 ); //1개월전
String preMonth1=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
cal.add ( Calendar.MONTH, -3 ); //3개월전
String preMonth3=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
cal.add ( Calendar.YEAR, -1 ); //12개월전
String preYear1=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
//===============================
%><!-- 달력 입력 컨트롤 시작 -->