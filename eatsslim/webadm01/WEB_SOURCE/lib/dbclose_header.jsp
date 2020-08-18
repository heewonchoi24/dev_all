<%
/**
 * @file : dbclose_header.jsp
 * @date : 2018-11-14
 * @author : Choi Heewon
 */
%>

<%
if (rs2_header != null) try { rs2_header.close(); } catch (Exception e) {}
if (stmt2_header != null) try { stmt2_header.close(); } catch (Exception e) {}
if (pstmt2_header != null) try { pstmt2_header.close(); } catch (Exception e) {}
if (conn2_header != null) try { conn2_header.close(); } catch (Exception e) {}
%>