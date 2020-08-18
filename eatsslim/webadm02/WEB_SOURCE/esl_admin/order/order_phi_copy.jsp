<%
query		= "UPDATE PHIBABY.P_ORDER_MALL_PHI_ITF SET INTERFACE_FLAG_YN = 'Y' WHERE ORD_NO = '"+ orderNum +"' AND INTERFACE_FLAG_YN <> 'Y' ";
try {
	stmt_phi.executeUpdate(query);
} catch(Exception e) {
	out.println(e);
	if(true)return;
}

query		= "SELECT * FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND ( STATE < 90 or (GROUP_CODE = '0300668' and STATE = '911') ) ";
try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

i = 1;
while (rs.next()) {
	// 시퀀스 조회
	query		= "SELECT MAX(ORD_SEQ) FROM PHIBABY.P_ORDER_MALL_PHI_ITF";
	try {
		rs_phi		= stmt_phi.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs_phi.next()) {
		ordSeq		= rs_phi.getInt(1) + 1;
	}
	rs_phi.close();

	query1		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
	query1		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM, SHOP_CD, GOODS_LEVEL, SHOP_ORD_NO)";
	query1		+= "	VALUES";
	query1		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?, ?, ?)";
	pstmt_phi	= conn_phi.prepareStatement(query1);

	pstmt_phi.setInt(1, ordSeq);
	pstmt_phi.setString(2, rs.getString("ORDER_DATE"));
	pstmt_phi.setString(3, orderNum);
	pstmt_phi.setString(4, rs.getString("CUSTOMER_NUM"));
	pstmt_phi.setString(5, "I");
	pstmt_phi.setString(6, rs.getString("ORDER_NAME"));
	pstmt_phi.setString(7, rs.getString("RCV_NAME"));
	pstmt_phi.setString(8, rs.getString("RCV_ZIPCODE"));
	pstmt_phi.setString(9, rs.getString("RCV_ADDR1"));
	pstmt_phi.setString(10, rs.getString("RCV_ADDR2"));
	pstmt_phi.setString(11, rs.getString("RCV_TEL"));
	pstmt_phi.setString(12, rs.getString("RCV_HP"));
	pstmt_phi.setString(13, rs.getString("RCV_EMAIL"));
	pstmt_phi.setInt(14, rs.getInt("TOT_SELL_PRICE"));
	pstmt_phi.setInt(15, rs.getInt("TOT_PAY_PRICE"));
	pstmt_phi.setInt(16, rs.getInt("TOT_DEVL_PRICE"));
	pstmt_phi.setInt(17, rs.getInt("TOT_DC_PRICE"));
	pstmt_phi.setString(18, rs.getString("PAY_TYPE"));
	pstmt_phi.setString(19, rs.getString("DEVL_TYPE"));
	pstmt_phi.setString(20, rs.getString("AGENCYID"));
	pstmt_phi.setString(21, rs.getString("RCV_REQUEST"));
	pstmt_phi.setInt(22, i);
	pstmt_phi.setString(23, rs.getString("DEVL_DATE").replace("-",""));
	pstmt_phi.setString(24, rs.getString("GROUP_CODE"));
	pstmt_phi.setInt(25, rs.getInt("ORDER_CNT"));
	pstmt_phi.setInt(26, rs.getInt("PRICE"));
	pstmt_phi.setInt(27, rs.getInt("PAY_PRICE"));
	pstmt_phi.setString(28, rs.getString("SHOP_CD"));
	pstmt_phi.setString(29, rs.getString("GUBUN_CODE"));
	pstmt_phi.setString(30, rs.getString("SHOP_ORDER_NUM"));
	try {
		pstmt_phi.executeUpdate();
	} catch (Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	i++;
}
%>