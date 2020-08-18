<%
if (rs_tbr != null) try { rs_tbr.close(); } catch (Exception e) {}
if (stmt_tbr != null) try { stmt_tbr.close(); } catch (Exception e) {}
if (pstmt_tbr != null) try { pstmt_tbr.close(); } catch (Exception e) {}
if (conn_tbr != null) try { conn_tbr.close(); } catch (Exception e) {}
%>