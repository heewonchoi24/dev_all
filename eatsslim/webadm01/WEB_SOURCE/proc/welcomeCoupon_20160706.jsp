<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
String cpTable		= "ESL_COUPON";
/*
// À£ÄÄÄíÆù ÄûÁø»óÇ° 5Ãµ¿ø Àû¿ë
query		= "SELECT ID FROM "+ cpTable +" WHERE COUPON_NAME = 'ÀÕ½½¸² À£ÄÄÄíÆù_ÄûÁø 2ÁÖ 5Ãµ¿ø ÇÒÀÎ±Ç' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponId	= rs.getInt(1);
}
rs.close();

if (couponId > 0) {
} else {
	query		= "INSERT INTO "+ cpTable;
	query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
	query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE)";
	query		+= " VALUES";
	query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
	pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, "ÀÕ½½¸² À£ÄÄÄíÆù_ÄûÁø 2ÁÖ 5Ãµ¿ø ÇÒÀÎ±Ç");
	pstmt.setString(2, "01");
	pstmt.setString(3, stdate);
	pstmt.setString(4, ltdate);
	pstmt.setString(5, "02");
	pstmt.setString(6, "W");
	pstmt.setInt(7, 5000);
	pstmt.setString(8, "Y");
	pstmt.setInt(9, 0);
	pstmt.setInt(10, 0);
	pstmt.setString(11, "02");
	pstmt.setInt(12, 0);
	pstmt.setString(13, "admin");
	pstmt.setString(14, userIp);
	pstmt.executeUpdate();
	try {
		rs			= pstmt.getGeneratedKeys();
		if (rs.next()) {
			couponId		= rs.getInt(1);
		}
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
	rs.close();

	for (i = 1; i < 11; i++) {
		switch (i) {
			case 1 :
				groupCode		= "0300717";
				groupName		= "ÄûÁø";
				break;
			case 2 :
				groupCode		= "0300722";
				groupName		= "ÄûÁø+¾Ë¶ó±î¸£¶¼ ½½¸²";
				break;
			case 3 :
				groupCode		= "0300958";
				groupName		= "ÄûÁø+¾Ë¶ó±î¸£¶¼ Çï¾¾";
				break;
			case 4 :
				groupCode		= "0300962";
				groupName		= "ÄûÁø+¾Ë¶ó±î¸£¶¼ ½½¸²+¾Ë¶ó±î¸£¶¼ Çï¾¾";
				break;
			case 5 :
				groupCode		= "0300944";
				groupName		= "ÄûÁø+º§·±½º½¦ÀÌÅ©1Æ÷";
				break;
			case 6 :
				groupCode		= "0301079";
				groupName		= "ÄûÁø+¹Ì´Ï¹Ð1°³";
				break;
			case 7 :
				groupCode		= "0300719";
				groupName		= "¾Ë¶ó±î¸£¶¼ ½½¸²";
				break;
			case 8 :
				groupCode		= "0300957";
				groupName		= "¾Ë¶ó±î¸£¶¼ Çï¾¾";
				break;
			case 9 :
				groupCode		= "0301081";
				groupName		= "¾Ë¶ó±î¸£¶¼ ½½¸²+¹Ì´Ï¹Ð1°³";
				break;
			case 10 :
				groupCode		= "0301082";
				groupName		= "¾Ë¶ó±î¸£¶¼ Çï¾¾+¹Ì´Ï¹Ð1°³";
				break;
			case 11 :
				groupCode		= "0300960";
				groupName		= "¾Ë¶ó±î¸£¶¼ Çï¾¾+¾Ë¶ó±î¸£¶¼ ½½¸²";
				break;
		}

		query		= "INSERT INTO "+ cpTable +"_GOODS ";
		query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
		query		+= " VALUES";
		query		+= "	("+ couponId +", '"+ groupCode +"', '"+ groupName +"')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%ÀÕ½½¸² À£ÄÄÄíÆù_ÄûÁø 2ÁÖ%'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponCnt	= rs.getInt(1);
}
rs.close();

if (couponCnt > 0) {	
} else {
	SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
	couponNum		= "ET" + dt.format(new Date()) + "001";

	query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
	query		+= " VALUES ("+ couponId +",'"+ couponNum +"','"+ memberId +"','N',NOW())";
	try {
		stmt.executeUpdate(query);
	} catch (Exception e) {
		out.println(e);
		if(true)return;
	}
	giveCoupon++;
}
rs.close();

couponId	= 0;

// À£ÄÄÄíÆù ÄûÁø»óÇ° 1¸¸¿ø Àû¿ë
query		= "SELECT ID FROM "+ cpTable +" WHERE COUPON_NAME = 'ÀÕ½½¸² À£ÄÄÄíÆù_ÄûÁø 4ÁÖ 1¸¸¿ø ÇÒÀÎ±Ç' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponId	= rs.getInt(1);
}
rs.close();

if (couponId > 0) {
} else {
	query		= "INSERT INTO "+ cpTable;
	query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
	query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE)";
	query		+= " VALUES";
	query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
	pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, "ÀÕ½½¸² À£ÄÄÄíÆù_ÄûÁø 4ÁÖ 1¸¸¿ø ÇÒÀÎ±Ç");
	pstmt.setString(2, "01");
	pstmt.setString(3, stdate);
	pstmt.setString(4, ltdate);
	pstmt.setString(5, "02");
	pstmt.setString(6, "W");
	pstmt.setInt(7, 10000);
	pstmt.setString(8, "Y");
	pstmt.setInt(9, 0);
	pstmt.setInt(10, 190000);
	pstmt.setString(11, "02");
	pstmt.setInt(12, 0);
	pstmt.setString(13, "admin");
	pstmt.setString(14, userIp);
	pstmt.executeUpdate();
	try {
		rs			= pstmt.getGeneratedKeys();
		if (rs.next()) {
			couponId		= rs.getInt(1);
		}
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
	rs.close();

	for (i = 1; i < 7; i++) {
		switch (i) {
			case 1 :
				groupCode		= "0300717";
				groupName		= "ÄûÁø";
				break;
			case 2 :
				groupCode		= "0300722";
				groupName		= "ÄûÁø+¾Ë¶ó±î¸£¶¼ ½½¸²";
				break;
			case 3 :
				groupCode		= "0300958";
				groupName		= "ÄûÁø+¾Ë¶ó±î¸£¶¼ Çï¾¾";
				break;
			case 4 :
				groupCode		= "0300962";
				groupName		= "ÄûÁø+¾Ë¶ó±î¸£¶¼ ½½¸²+¾Ë¶ó±î¸£¶¼ Çï¾¾";
				break;
			case 5 :
				groupCode		= "0300944";
				groupName		= "ÄûÁø+º§·±½º½¦ÀÌÅ©1Æ÷";
				break;
			case 6 :
				groupCode		= "0301079";
				groupName		= "ÄûÁø+¹Ì´Ï¹Ð1°³";
				break;
		}

		query		= "INSERT INTO "+ cpTable +"_GOODS ";
		query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
		query		+= " VALUES";
		query		+= "	("+ couponId +", '"+ groupCode +"', '"+ groupName +"')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%ÀÕ½½¸² À£ÄÄÄíÆù_ÄûÁø 4ÁÖ%'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponCnt	= rs.getInt(1);
}
rs.close();

if (couponCnt > 0) {	
} else {
	SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
	couponNum		= "ET" + dt.format(new Date()) + "002";

	query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
	query		+= " VALUES ("+ couponId +",'"+ couponNum +"','"+ memberId +"','N',NOW())";
	try {
		stmt.executeUpdate(query);
	} catch (Exception e) {
		out.println(e);
		if(true)return;
	}
	giveCoupon++;
}
rs.close();
*/

couponId	= 0;

// À£ÄÄÄíÆù ÇÁ·Î±×·¥ Àû¿ë
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = 'ÀÕ½½¸² À£ÄÄÄíÆù_2ÁÖÇÁ·Î±×·¥ 1¸¸¿ø ÇÒÀÎ±Ç' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponId	= rs.getInt(1);
}
rs.close();

if (couponId > 0) {
} else {
	query		= "INSERT INTO "+ cpTable;
	query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
	query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE)";
	query		+= " VALUES";
	query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
	pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, "ÀÕ½½¸² À£ÄÄÄíÆù_2ÁÖÇÁ·Î±×·¥ 1¸¸¿ø ÇÒÀÎ±Ç");
	pstmt.setString(2, "01");
	pstmt.setString(3, stdate);
	pstmt.setString(4, ltdate);
	pstmt.setString(5, "02");
	pstmt.setString(6, "W");
	pstmt.setInt(7, 10000);
	pstmt.setString(8, "Y");
	pstmt.setInt(9, 0);
	pstmt.setInt(10, 0);
	pstmt.setString(11, "02");
	pstmt.setInt(12, 0);
	pstmt.setString(13, "admin");
	pstmt.setString(14, userIp);
	pstmt.executeUpdate();
	try {
		rs			= pstmt.getGeneratedKeys();
		if (rs.next()) {
			couponId		= rs.getInt(1);
		}
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
	rs.close();

	for (i = 1; i < 2; i++) {
		query		= "INSERT INTO "+ cpTable +"_GOODS ";
		query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
		query		+= " VALUES";
		query		+= "	("+ couponId +", '02252', 'ÁýÁß°¨·® 2ÁÖ')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%ÀÕ½½¸² À£ÄÄÄíÆù_2ÁÖÇÁ·Î±×·¥%'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponCnt	= rs.getInt(1);
}
rs.close();

if (couponCnt > 0) {
} else {
	SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
	couponNum		= "ET" + dt.format(new Date()) + "003";

	query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
	query		+= " VALUES ("+ couponId +",'"+ couponNum +"','"+ memberId +"','N',NOW())";
	try {
		stmt.executeUpdate(query);
	} catch (Exception e) {
		out.println(e);
		if(true)return;
	}
	giveCoupon++;
}
rs.close();

couponId	= 0;

// À£ÄÄÄíÆù ÇÁ·Î±×·¥ Àû¿ë
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = 'ÀÕ½½¸² À£ÄÄÄíÆù_4ÁÖÇÁ·Î±×·¥ 2¸¸¿ø ÇÒÀÎ±Ç' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponId	= rs.getInt(1);
}
rs.close();

if (couponId > 0) {
} else {
	query		= "INSERT INTO "+ cpTable;
	query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
	query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE)";
	query		+= " VALUES";
	query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
	pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, "ÀÕ½½¸² À£ÄÄÄíÆù_4ÁÖÇÁ·Î±×·¥ 2¸¸¿ø ÇÒÀÎ±Ç");
	pstmt.setString(2, "01");
	pstmt.setString(3, stdate);
	pstmt.setString(4, ltdate);
	pstmt.setString(5, "02");
	pstmt.setString(6, "W");
	pstmt.setInt(7, 20000);
	pstmt.setString(8, "Y");
	pstmt.setInt(9, 0);
	pstmt.setInt(10, 0);
	pstmt.setString(11, "02");
	pstmt.setInt(12, 0);
	pstmt.setString(13, "admin");
	pstmt.setString(14, userIp);
	pstmt.executeUpdate();
	try {
		rs			= pstmt.getGeneratedKeys();
		if (rs.next()) {
			couponId		= rs.getInt(1);
		}
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
	rs.close();

	for (i = 1; i < 2; i++) {
		query		= "INSERT INTO "+ cpTable +"_GOODS ";
		query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
		query		+= " VALUES";
		query		+= "	("+ couponId +", '02244', '°¨·®&À¯Áö 4ÁÖ ÇÁ·Î±×·¥')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%ÀÕ½½¸² À£ÄÄÄíÆù_4ÁÖÇÁ·Î±×·¥%'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponCnt	= rs.getInt(1);
}
rs.close();

if (couponCnt > 0) {
} else {
	SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
	couponNum		= "ET" + dt.format(new Date()) + "004";

	query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
	query		+= " VALUES ("+ couponId +",'"+ couponNum +"','"+ memberId +"','N',NOW())";
	try {
		stmt.executeUpdate(query);
	} catch (Exception e) {
		out.println(e);
		if(true)return;
	}
	giveCoupon++;
}
rs.close();

/*
couponId	= 0;

// À£ÄÄÄíÆù 3ÀÏ ÇÁ·Î±×·¥ Àû¿ë
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = 'ÀÕ½½¸² À£ÄÄÄíÆù_3ÀÏÇÁ·Î±×·¥ ¹Ý¾× ÇÒÀÎ±Ç' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponId	= rs.getInt(1);
}
rs.close();

if (couponId > 0) {
} else {
	query		= "INSERT INTO "+ cpTable;
	query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
	query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE)";
	query		+= " VALUES";
	query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
	pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, "ÀÕ½½¸² À£ÄÄÄíÆù_3ÀÏÇÁ·Î±×·¥ ¹Ý¾× ÇÒÀÎ±Ç");
	pstmt.setString(2, "01");
	pstmt.setString(3, stdate);
	pstmt.setString(4, ltdate);
	pstmt.setString(5, "02");
	pstmt.setString(6, "P");
	pstmt.setInt(7, 50);
	pstmt.setString(8, "Y");
	pstmt.setInt(9, 0);
	pstmt.setInt(10, 0);
	pstmt.setString(11, "02");
	pstmt.setInt(12, 0);
	pstmt.setString(13, "admin");
	pstmt.setString(14, userIp);
	pstmt.executeUpdate();
	try {
		rs			= pstmt.getGeneratedKeys();
		if (rs.next()) {
			couponId		= rs.getInt(1);
		}
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
	rs.close();

	for (i = 1; i < 2; i++) {
		query		= "INSERT INTO "+ cpTable +"_GOODS ";
		query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
		query		+= " VALUES";
		query		+= "	("+ couponId +", '02261', '3ÀÏ ÇÁ·Î±×·¥')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%ÀÕ½½¸² À£ÄÄÄíÆù_3ÀÏÇÁ·Î±×·¥%'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponCnt	= rs.getInt(1);
}
rs.close();

if (couponCnt > 0) {
} else {
	SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
	couponNum		= "ET" + dt.format(new Date()) + "003";

	query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
	query		+= " VALUES ("+ couponId +",'"+ couponNum +"','"+ memberId +"','N',NOW())";
	try {
		stmt.executeUpdate(query);
	} catch (Exception e) {
		out.println(e);
		if(true)return;
	}
	giveCoupon++;
}
rs.close();
*/
/*
couponId	= 0;

// À£ÄÄÄíÆù Å¬·»ÁîÇÁ·Î±×·¥ 1ÁÖ Àû¿ë
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = 'ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥1ÁÖ 5000¿ø ÇÒÀÎ±Ç' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponId	= rs.getInt(1);
}
rs.close();

if (couponId > 0) {
} else {
	query		= "INSERT INTO "+ cpTable;
	query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
	query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE)";
	query		+= " VALUES";
	query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
	pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, "ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥1ÁÖ 5000¿ø ÇÒÀÎ±Ç");
	pstmt.setString(2, "01");
	pstmt.setString(3, stdate);
	pstmt.setString(4, ltdate);
	pstmt.setString(5, "02");
	pstmt.setString(6, "W");
	pstmt.setInt(7, 5000);
	pstmt.setString(8, "Y");
	pstmt.setInt(9, 0);
	pstmt.setInt(10, 0);
	pstmt.setString(11, "02");
	pstmt.setInt(12, 0);
	pstmt.setString(13, "admin");
	pstmt.setString(14, userIp);
	pstmt.executeUpdate();
	try {
		rs			= pstmt.getGeneratedKeys();
		if (rs.next()) {
			couponId		= rs.getInt(1);
		}
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
	rs.close();

	for (i = 1; i < 2; i++) {
		query		= "INSERT INTO "+ cpTable +"_GOODS ";
		query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
		query		+= " VALUES";
		query		+= "	("+ couponId +", '02271', 'Å¬·»ÁîÇÁ·Î±×·¥1ÁÖ')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥1ÁÖ%'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponCnt	= rs.getInt(1);
}
rs.close();

if (couponCnt > 0) {
} else {
	SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
	couponNum		= "ET" + dt.format(new Date()) + "004";

	query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
	query		+= " VALUES ("+ couponId +",'"+ couponNum +"','"+ memberId +"','N',NOW())";
	try {
		stmt.executeUpdate(query);
	} catch (Exception e) {
		out.println(e);
		if(true)return;
	}
	giveCoupon++;
}
rs.close();

couponId	= 0;

// À£ÄÄÄíÆù Å¬·»ÁîÇÁ·Î±×·¥ 2ÁÖ Àû¿ë
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = 'ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥2ÁÖ 1¸¸¿ø ÇÒÀÎ±Ç' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponId	= rs.getInt(1);
}
rs.close();

if (couponId > 0) {
} else {
	query		= "INSERT INTO "+ cpTable;
	query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
	query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE)";
	query		+= " VALUES";
	query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
	pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, "ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥2ÁÖ 1¸¸¿ø ÇÒÀÎ±Ç");
	pstmt.setString(2, "01");
	pstmt.setString(3, stdate);
	pstmt.setString(4, ltdate);
	pstmt.setString(5, "02");
	pstmt.setString(6, "W");
	pstmt.setInt(7, 10000);
	pstmt.setString(8, "Y");
	pstmt.setInt(9, 0);
	pstmt.setInt(10, 0);
	pstmt.setString(11, "02");
	pstmt.setInt(12, 0);
	pstmt.setString(13, "admin");
	pstmt.setString(14, userIp);
	pstmt.executeUpdate();
	try {
		rs			= pstmt.getGeneratedKeys();
		if (rs.next()) {
			couponId		= rs.getInt(1);
		}
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
	rs.close();

	for (i = 1; i < 2; i++) {
		query		= "INSERT INTO "+ cpTable +"_GOODS ";
		query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
		query		+= " VALUES";
		query		+= "	("+ couponId +", '02282', 'Å¬·»ÁîÇÁ·Î±×·¥2ÁÖ')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥2ÁÖ%'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponCnt	= rs.getInt(1);
}
rs.close();

if (couponCnt > 0) {
} else {
	SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
	couponNum		= "ET" + dt.format(new Date()) + "004";

	query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
	query		+= " VALUES ("+ couponId +",'"+ couponNum +"','"+ memberId +"','N',NOW())";
	try {
		stmt.executeUpdate(query);
	} catch (Exception e) {
		out.println(e);
		if(true)return;
	}
	giveCoupon++;
}
rs.close();

couponId	= 0;

// À£ÄÄÄíÆù Å¬·»ÁîÇÁ·Î±×·¥ 4ÁÖ Àû¿ë
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = 'ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥4ÁÖ 2¸¸¿ø ÇÒÀÎ±Ç' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponId	= rs.getInt(1);
}
rs.close();

if (couponId > 0) {
} else {
	query		= "INSERT INTO "+ cpTable;
	query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
	query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE)";
	query		+= " VALUES";
	query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
	pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, "ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥4ÁÖ 2¸¸¿ø ÇÒÀÎ±Ç");
	pstmt.setString(2, "01");
	pstmt.setString(3, stdate);
	pstmt.setString(4, ltdate);
	pstmt.setString(5, "02");
	pstmt.setString(6, "W");
	pstmt.setInt(7, 20000);
	pstmt.setString(8, "Y");
	pstmt.setInt(9, 0);
	pstmt.setInt(10, 0);
	pstmt.setString(11, "02");
	pstmt.setInt(12, 0);
	pstmt.setString(13, "admin");
	pstmt.setString(14, userIp);
	pstmt.executeUpdate();
	try {
		rs			= pstmt.getGeneratedKeys();
		if (rs.next()) {
			couponId		= rs.getInt(1);
		}
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
	rs.close();

	for (i = 1; i < 2; i++) {
		query		= "INSERT INTO "+ cpTable +"_GOODS ";
		query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
		query		+= " VALUES";
		query		+= "	("+ couponId +", '02294', 'Å¬·»ÁîÇÁ·Î±×·¥4ÁÖ')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥4ÁÖ%'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponCnt	= rs.getInt(1);
}
rs.close();

if (couponCnt > 0) {
} else {
	SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
	couponNum		= "ET" + dt.format(new Date()) + "004";

	query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
	query		+= " VALUES ("+ couponId +",'"+ couponNum +"','"+ memberId +"','N',NOW())";
	try {
		stmt.executeUpdate(query);
	} catch (Exception e) {
		out.println(e);
		if(true)return;
	}
	giveCoupon++;
}
rs.close();
*/

couponId	= 0;

// À£ÄÄÄíÆù Å¬·»ÁîÇÁ·Î±×·¥ 5Ãµ¿ø Àû¿ë
query		= "SELECT ID FROM "+ cpTable +" WHERE COUPON_NAME = 'ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥ 5Ãµ¿ø ÇÒÀÎ±Ç' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponId	= rs.getInt(1);
}
rs.close();

if (couponId > 0) {
} else {
	query		= "INSERT INTO "+ cpTable;
	query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
	query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE)";
	query		+= " VALUES";
	query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
	pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, "ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥ 5Ãµ¿ø ÇÒÀÎ±Ç");
	pstmt.setString(2, "01");
	pstmt.setString(3, stdate);
	pstmt.setString(4, ltdate);
	pstmt.setString(5, "02");
	pstmt.setString(6, "W");
	pstmt.setInt(7, 5000);
	pstmt.setString(8, "Y");
	pstmt.setInt(9, 0);
	pstmt.setInt(10, 0);
	pstmt.setString(11, "02");
	pstmt.setInt(12, 0);
	pstmt.setString(13, "admin");
	pstmt.setString(14, userIp);
	pstmt.executeUpdate();
	try {
		rs			= pstmt.getGeneratedKeys();
		if (rs.next()) {
			couponId		= rs.getInt(1);
		}
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
	rs.close();

	for (i = 1; i < 4; i++) {
		switch (i) {
			case 1 :
				groupCode		= "02271";
				groupName		= "Å¬·»ÁîÇÁ·Î±×·¥1ÁÖ";
				break;
			case 2 :
				groupCode		= "02282";
				groupName		= "Å¬·»ÁîÇÁ·Î±×·¥2ÁÖ";
				break;
			case 3 :
				groupCode		= "02294";
				groupName		= "Å¬·»ÁîÇÁ·Î±×·¥4ÁÖ";
				break;
		}

		query		= "INSERT INTO "+ cpTable +"_GOODS ";
		query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
		query		+= " VALUES";
		query		+= "	("+ couponId +", '"+ groupCode +"', '"+ groupName +"')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%ÀÕ½½¸² À£ÄÄÄíÆù_Å¬·»ÁîÇÁ·Î±×·¥ 5Ãµ¿ø%'";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	couponCnt	= rs.getInt(1);
}
rs.close();

if (couponCnt > 0) {	
} else {
	SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
	couponNum		= "ET" + dt.format(new Date()) + "002";

	query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
	query		+= " VALUES ("+ couponId +",'"+ couponNum +"','"+ memberId +"','N',NOW())";
	try {
		stmt.executeUpdate(query);
	} catch (Exception e) {
		out.println(e);
		if(true)return;
	}
	giveCoupon++;
}
rs.close();

%>