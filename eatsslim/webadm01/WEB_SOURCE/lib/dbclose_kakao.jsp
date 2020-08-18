<%
if (rs_kakao != null) try { rs_kakao.close(); } catch (Exception e) {}
if (stmt_kakao != null) try { stmt_kakao.close(); } catch (Exception e) {}
if (pstmt_kakao != null) try { pstmt_kakao.close(); } catch (Exception e) {}
if (conn_kakao != null) try { conn_kakao.close(); } catch (Exception e) {}
%>