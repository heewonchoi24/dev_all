<%
if (rs_mssql != null) try { rs_mssql.close(); } catch (Exception e) {}
if (stmt_mssql != null) try { stmt_mssql.close(); } catch (Exception e) {}
if (pstmt_mssql != null) try { pstmt_mssql.close(); } catch (Exception e) {}
if (conn_mssql != null) try { conn_mssql.close(); } catch (Exception e) {}
%>