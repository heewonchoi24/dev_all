<%
if (rs_bm != null) try { rs_bm.close(); } catch (Exception e) {}
if (stmt_bm != null) try { stmt_bm.close(); } catch (Exception e) {}
if (pstmt_bm != null) try { pstmt_bm.close(); } catch (Exception e) {}
if (conn_bm != null) try { conn_bm.close(); } catch (Exception e) {}
%>