<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
String cpTable		= "ESL_COUPON";
/*
// �������� ������ǰ 5õ�� ����
query		= "SELECT ID FROM "+ cpTable +" WHERE COUPON_NAME = '�ս��� ��������_���� 2�� 5õ�� ���α�' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
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
	pstmt.setString(1, "�ս��� ��������_���� 2�� 5õ�� ���α�");
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
				groupName		= "����";
				break;
			case 2 :
				groupCode		= "0300722";
				groupName		= "����+�˶��� ����";
				break;
			case 3 :
				groupCode		= "0300958";
				groupName		= "����+�˶��� �ﾾ";
				break;
			case 4 :
				groupCode		= "0300962";
				groupName		= "����+�˶��� ����+�˶��� �ﾾ";
				break;
			case 5 :
				groupCode		= "0300944";
				groupName		= "����+����������ũ1��";
				break;
			case 6 :
				groupCode		= "0301079";
				groupName		= "����+�̴Ϲ�1��";
				break;
			case 7 :
				groupCode		= "0300719";
				groupName		= "�˶��� ����";
				break;
			case 8 :
				groupCode		= "0300957";
				groupName		= "�˶��� �ﾾ";
				break;
			case 9 :
				groupCode		= "0301081";
				groupName		= "�˶��� ����+�̴Ϲ�1��";
				break;
			case 10 :
				groupCode		= "0301082";
				groupName		= "�˶��� �ﾾ+�̴Ϲ�1��";
				break;
			case 11 :
				groupCode		= "0300960";
				groupName		= "�˶��� �ﾾ+�˶��� ����";
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
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%�ս��� ��������_���� 2��%'";
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

// �������� ������ǰ 1���� ����
query		= "SELECT ID FROM "+ cpTable +" WHERE COUPON_NAME = '�ս��� ��������_���� 4�� 1���� ���α�' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
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
	pstmt.setString(1, "�ս��� ��������_���� 4�� 1���� ���α�");
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
				groupName		= "����";
				break;
			case 2 :
				groupCode		= "0300722";
				groupName		= "����+�˶��� ����";
				break;
			case 3 :
				groupCode		= "0300958";
				groupName		= "����+�˶��� �ﾾ";
				break;
			case 4 :
				groupCode		= "0300962";
				groupName		= "����+�˶��� ����+�˶��� �ﾾ";
				break;
			case 5 :
				groupCode		= "0300944";
				groupName		= "����+����������ũ1��";
				break;
			case 6 :
				groupCode		= "0301079";
				groupName		= "����+�̴Ϲ�1��";
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
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%�ս��� ��������_���� 4��%'";
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

// �������� ���α׷� ����
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = '�ս��� ��������_2�����α׷� 1���� ���α�' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
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
	pstmt.setString(1, "�ս��� ��������_2�����α׷� 1���� ���α�");
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
		query		+= "	("+ couponId +", '02252', '���߰��� 2��')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%�ս��� ��������_2�����α׷�%'";
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

// �������� ���α׷� ����
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = '�ս��� ��������_4�����α׷� 2���� ���α�' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
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
	pstmt.setString(1, "�ս��� ��������_4�����α׷� 2���� ���α�");
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
		query		+= "	("+ couponId +", '02244', '����&���� 4�� ���α׷�')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%�ս��� ��������_4�����α׷�%'";
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

// �������� 3�� ���α׷� ����
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = '�ս��� ��������_3�����α׷� �ݾ� ���α�' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
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
	pstmt.setString(1, "�ս��� ��������_3�����α׷� �ݾ� ���α�");
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
		query		+= "	("+ couponId +", '02261', '3�� ���α׷�')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%�ս��� ��������_3�����α׷�%'";
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

// �������� Ŭ�������α׷� 1�� ����
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = '�ս��� ��������_Ŭ�������α׷�1�� 5000�� ���α�' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
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
	pstmt.setString(1, "�ս��� ��������_Ŭ�������α׷�1�� 5000�� ���α�");
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
		query		+= "	("+ couponId +", '02271', 'Ŭ�������α׷�1��')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%�ս��� ��������_Ŭ�������α׷�1��%'";
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

// �������� Ŭ�������α׷� 2�� ����
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = '�ս��� ��������_Ŭ�������α׷�2�� 1���� ���α�' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
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
	pstmt.setString(1, "�ս��� ��������_Ŭ�������α׷�2�� 1���� ���α�");
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
		query		+= "	("+ couponId +", '02282', 'Ŭ�������α׷�2��')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%�ս��� ��������_Ŭ�������α׷�2��%'";
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

// �������� Ŭ�������α׷� 4�� ����
query		= "SELECT ID FROM ESL_COUPON WHERE COUPON_NAME = '�ս��� ��������_Ŭ�������α׷�4�� 2���� ���α�' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
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
	pstmt.setString(1, "�ս��� ��������_Ŭ�������α׷�4�� 2���� ���α�");
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
		query		+= "	("+ couponId +", '02294', 'Ŭ�������α׷�4��')";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
	}
}

query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%�ս��� ��������_Ŭ�������α׷�4��%'";
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

// �������� Ŭ�������α׷� 5õ�� ����
query		= "SELECT ID FROM "+ cpTable +" WHERE COUPON_NAME = '�ս��� ��������_Ŭ�������α׷� 5õ�� ���α�' AND STDATE = '"+ stdate +"' AND LTDATE = '"+ ltdate +"'";
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
	pstmt.setString(1, "�ս��� ��������_Ŭ�������α׷� 5õ�� ���α�");
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
				groupName		= "Ŭ�������α׷�1��";
				break;
			case 2 :
				groupCode		= "02282";
				groupName		= "Ŭ�������α׷�2��";
				break;
			case 3 :
				groupCode		= "02294";
				groupName		= "Ŭ�������α׷�4��";
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
query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ memberId +"' AND C.COUPON_NAME like '%�ս��� ��������_Ŭ�������α׷� 5õ��%'";
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