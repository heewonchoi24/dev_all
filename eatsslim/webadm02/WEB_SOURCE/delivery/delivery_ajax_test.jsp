<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%@ page import="java.sql.*"%>
<%
    Connection conn_phi			= null;
	Statement stmt_phi			= null; 
	ResultSet rs_phi			= null; 
	PreparedStatement pstmt_phi	= null;
	
	String driverName_phi		= "oracle.jdbc.driver.OracleDriver";
    String url_phi				= "jdbc:oracle:thin:@192.1.5.136:1541:FLD";
    String id_phi				= "ESSMALL";
    String pwd_phi				= "ESSMALL1234";
    
    try {
        Class.forName(driverName_phi);      
    } catch(ClassNotFoundException e) {
        out.println("DB 연결 에러");
        e.printStackTrace();
        return;
    }
      
    conn_phi = DriverManager.getConnection(url_phi,id_phi,pwd_phi);
	stmt_phi = conn_phi.createStatement();
%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1_phi	= null; 
ResultSet rs1_phi	= null; 
stmt1_phi			= conn_phi.createStatement();
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String sido			= ut.inject(request.getParameter("sido"));
if (sido != null && sido.length() > 0) {
	sido		= new String(sido.getBytes("8859_1"), "EUC-KR");
}
String gugun		= ut.inject(request.getParameter("gugun"));
if (gugun != null && gugun.length() > 0) {
	gugun		= new String(gugun.getBytes("8859_1"), "EUC-KR");
}
String parterId		= "";
String partnerName	= "";
String reprName		= "";
int i				= 0;

if (sido.equals("") || sido == null) {
	out.println("<script type='text/javascript'>alert('시도를 선택하세요.');</script>");
} else if (gugun.equals("") || gugun == null) {
	out.println("<script type='text/javascript'>alert('구군을 선택하세요.');</script>");
} else {
	query		= "SELECT DISTINCT P.PARTNERNAME, P.REPRNAME, P.PARTNERID";
	query		+= " FROM PHIBABY.V_PARTNER P, PHIBABY.V_ZIPCODE_LD Z";
	query		+= " WHERE P.PARTNERID = Z.PARTNERID AND Z.SIDO = '"+sido+"' AND Z.GUGUN LIKE '%"+gugun+"%'";
	query		+= " AND Z.DLVTYPE = '0001' AND DLVPTNCD = '01' ORDER BY PARTNERNAME";
	out.println(query);

	pstmt_phi	= conn_phi.prepareStatement(query);
	rs_phi		= pstmt_phi.executeQuery();

	while (rs_phi.next()) {
		parterId		= rs_phi.getString("PARTNERID");
		partnerName		= rs_phi.getString("PARTNERNAME");
		reprName		= rs_phi.getString("REPRNAME");

		query1		= "SELECT DISTINCT GUGUN, DONG FROM PHIBABY.V_ZIPCODE_LD WHERE PARTNERID = '"+ parterId +"' ";
		rs1_phi		= stmt1_phi.executeQuery(query1);

		data		+= "<tr>";
		data		+= "<td>"+ partnerName +"</td>";
		data		+= "<td>"+ reprName +"</td>";
		data		+= "<td class=\"last\" style=\"text-align:left;\">";
		i			= 0;
		while (rs1_phi.next()) {
			if (rs1_phi.getString("GUGUN").indexOf(gugun) >= 0) {
				data		+= rs1_phi.getString("GUGUN") +" "+ rs1_phi.getString("DONG");
				data		+= ", ";
				i++;
			}
		}
		data		+= "</td>";
		data		+= "</tr>";
	}

	out.println("<script type='text/javascript' src='js/jquery-1.8.3.min.js'></script>");
	if (i > 0) {
		out.println("<script type='text/javascript'>$('#devlList', parent.document).html('"+ data +"');</script>");
	} else {
		out.println("<script type='text/javascript'>$('#devlList', parent.document).html('<tr><td colspan=\"3\">해당 지역에는 배달점이 없습니다.</td></tr>');</script>");
	}
}
%>
<%@ include file="/lib/dbclose.jsp"%>
<%@ include file="/lib/dbclose_phi.jsp"%>