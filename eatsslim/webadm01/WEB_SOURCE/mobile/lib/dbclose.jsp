<%
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (stmt != null) try { stmt.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
if (conn != null) try { conn.close(); } catch (Exception e) {}
%>