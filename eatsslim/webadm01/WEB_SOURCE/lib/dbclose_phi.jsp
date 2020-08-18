<%
if (rs_phi != null) try { rs_phi.close(); } catch (Exception e) {}
if (stmt_phi != null) try { stmt_phi.close(); } catch (Exception e) {}
if (pstmt_phi != null) try { pstmt_phi.close(); } catch (Exception e) {}
if (conn_phi != null) try { conn_phi.close(); } catch (Exception e) {}
%>