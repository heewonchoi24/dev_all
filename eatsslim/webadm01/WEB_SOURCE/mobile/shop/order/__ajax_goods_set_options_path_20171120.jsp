<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.*"%>

<%
	JSONObject obj = new JSONObject();
	String data 	= "";
	String code		= "";

	String cartInstType		= ut.inject(request.getParameter("cartInstType")); //-- cartInstType=new �űԵ��, �űԵ�Ͻ� �̹� ��ٱ��Ͽ� ��ǰ�� �ִٸ� �ɼǺ��� alertâ ������
	String day				= ut.inject(request.getParameter("day"));
	String cartType 		= ut.inject(request.getParameter("cart_type")); //-- ��ٱ���=C �Ǵ� �ٷα���=L
	String devlWeek 		= ut.inject(request.getParameter("devlWeek")); //-- ���Ϲ�� ����
	String devlDay			= ut.inject(request.getParameter("devlDay")); //-- ���Ϲ�� ����
	String groupCode		= ut.inject(request.getParameter("groupCode"));
	String devlType			= ut.inject(request.getParameter("devlType"));
	String buyBagYn			= ut.inject(request.getParameter("buyBagYn"));
	String pcAndMobileType	= ut.inject(request.getParameter("pcAndMobileType"));

	int groupId			= 0; //-- �׷�ID
	int price		 	= 0; //-- ��ü�ݾ�
	int buyQty			= 0; //-- ��ǰ����
	int buyQty2			= 0; //-- �̴Ϲ��ϰ�� �ѽļ�Ʈ ����
	int buyQty3			= 0; //-- �̴Ϲ��ϰ�� ��ļ�Ʈ ����
	
	try{
		groupId			= Integer.parseInt(ut.inject(request.getParameter("groupId")));
		price		 	= Integer.parseInt(ut.inject(request.getParameter("totalPrice")));
		buyQty			= request.getParameter("buyQty") == null ? 0 : Integer.parseInt(ut.inject(request.getParameter("buyQty")));
		buyQty2			= request.getParameter("buyQty2") == null ? 0 : Integer.parseInt(ut.inject(request.getParameter("buyQty2")));
		buyQty3			= request.getParameter("buyQty3") == null ? 0 : Integer.parseInt(ut.inject(request.getParameter("buyQty3")));
		
		//-- �̴Ϲ��ϰ�� ������ �ѽļ�Ʈ�;�ļ�Ʈ ���Ѽ������� �Ѵ�.
		if("0300993".equals(groupCode)){
			buyQty = buyQty2 + buyQty3;
		}
		
		if(groupId == 0 || price == 0 || buyQty == 0){
			code		= "error";
			data		= "������ ��Ȯ���� �ʽ��ϴ�. - 1";
			obj.put("code",code);
			obj.put("data",data);
			out.clear();
			out.println(obj);
			out.flush();
			return;
		}
	}
	catch(Exception e){
		code		= "error";
		data		= "������ ��Ȯ���� �ʽ��ϴ�. - 2";
		obj.put("code",code);
		obj.put("data",data);
		out.clear();
		out.println(obj);
		out.flush();
		if(true)return;
	}
	
	if(!"Y".equals(buyBagYn) ) buyBagYn  = "N"; // ���Ϲ���� �ƴҰ��� Null���̴� N���� ����
	if("".equals(devlWeek) ) devlWeek  = "0"; // ���Ϲ���� �ƴҰ��� Null���̴� 0���� ����
	if("".equals(devlDay) ) devlDay  = "0"; // ���Ϲ���� �ƴҰ��� Null���̴� 0���� ����
	
	if(cartType == null || "".equals(cartType)) cartType = "C";
	/*
	System.out.println(" day :"+day);
	System.out.println(" cartType :"+cartType);
	System.out.println(" devlWeek :"+devlWeek);
	System.out.println(" price :"+price);
	System.out.println(" devlDay :"+devlDay);
	System.out.println(" buyQty :"+buyQty);
	System.out.println(" groupId :"+groupId);
	
	System.out.println(" devlType :"+devlType);
	System.out.println(" price :"+price);
	System.out.println(" buyBagYn :"+buyBagYn);
	System.out.println(" eslMemberId : "+eslMemberId);
	*/
	String query			= "";
	String queryDel			= "";
	String query1			= "";
	stmt					= null;
	Statement stmt1			= null;
	Statement stmtDel		= null;
	rs						= null;
	ResultSet rs1			= null;
	ResultSet rsDel			= null;
	stmt					= conn.createStatement();
	stmt1					= conn.createStatement();
	stmtDel					= conn.createStatement();
	int purchaseCnt			= 0;
	
	//-- �ٷα��� ����
	query		= "DELETE FROM ESL_CART WHERE MEMBER_ID = '"+eslMemberId+"' AND CART_TYPE = 'L'";
	pstmt		= conn.prepareStatement(query);
	pstmt.executeUpdate();
	
	//-- ���Ϲ�� �ֹ��� ī����
	query1		= "SELECT COUNT(*) PURCHASE_CNT FROM ESL_ORDER O, ESL_ORDER_GOODS OG WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.MEMBER_ID = '"+ eslMemberId +"' AND ((O.ORDER_STATE > 0 AND O.ORDER_STATE < 90) OR O.ORDER_STATE = '911') AND OG.DEVL_TYPE = '0001'";
	try {
		rs1	= stmt1.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	if (rs1.next()) {
		purchaseCnt		= rs1.getInt("PURCHASE_CNT");
	}
	rs1.close();
	
	
	if (devlType.equals("0001")  && !buyBagYn.equals("Y") && purchaseCnt < 1) {
		code		= "error";
		data		= "�ű� ���� �� ���ð����� �ʼ��� �����ϼž� �մϴ�.";
	}
	else if (devlType.equals("0001")  && day.equals("") ) {
		code		= "error";
		data		= "��¥�� �Է��ϼž� �մϴ�..";
	}
	else{
		if("".equals(day)) day = ut.getTimeStamp(1); //-- DATE_FORMAT( NOW(),'%Y-%m-%d')
		
		
		int cartId = 0;
		query1		= "SELECT ID FROM ESL_CART WHERE MEMBER_ID = '"+eslMemberId+"' AND GROUP_ID = '"+groupId+"' AND CART_TYPE='"+cartType+"'";
		try {
			rs1	= stmt1.executeQuery(query1);
			if (rs1.next()) {
				cartId = rs1.getInt("ID");
			}
			rs1.close();
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
		
		if (cartId > 0) { //-- ��ٱ��Ͽ� �ִٸ� ����
			query		= "UPDATE ";
			query		+= " ESL_CART ";
			query		+= " SET DEVL_DAY = ? , DEVL_WEEK = ? , PRICE = ? , DEVL_DATE = ? , BUY_QTY = ?, BUY_BAG_YN = ? WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, devlDay);
			pstmt.setString(2, devlWeek);
			pstmt.setInt(3, price);
			pstmt.setString(4, day);
			pstmt.setInt(5, buyQty);
			pstmt.setString(6, buyBagYn);
			pstmt.setInt(7, cartId);

			pstmt.executeUpdate();
			code		= "success";

			query		= "UPDATE ";
			query		+= " ESL_CART ";
			query		+= " SET DEVL_DAY = '" + devlDay + "' , DEVL_WEEK = '" + devlWeek + "' , PRICE = '" + price + "' , DEVL_DATE = '" + day + "' , BUY_QTY = '" + buyQty + "', BUY_BAG_YN = '" + buyBagYn + "' WHERE ID = '" + cartId + "'";
			
			//System.out.println(ut.getTimeStamp(9) + "'" + eslMemberId + "' =======================================================================================");
			//System.out.println("DEBUG LOG : " + query);
			
			//-- �űԵ�Ͻ� ��ǰ�� �̹� ����� �Ǿ� �ִٸ� �˸�
			if("new".equals(cartInstType) ) data = "�̹� ��ٱ��Ͽ� ��� ��ǰ�Դϴ�.\n�ɼ������� ������Ʈ �Ǿ����ϴ�.";
		}
		else{ //-- ��ٱ��Ͽ� ���ٸ� ���
			query		= "INSERT INTO ESL_CART ";
			query		+= "	(MEMBER_ID, GROUP_ID, BUY_QTY, DEVL_TYPE, DEVL_DAY, DEVL_WEEK, DEVL_DATE, PRICE, INST_DATE, BUY_BAG_YN, CART_TYPE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?)";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, eslMemberId);
			pstmt.setInt(2, groupId);
			pstmt.setInt(3, buyQty);
			pstmt.setString(4, devlType);
			pstmt.setString(5, devlDay);
			pstmt.setString(6, devlWeek);
			pstmt.setString(7, day);
			pstmt.setInt(8, price);
			pstmt.setString(9, buyBagYn);
			pstmt.setString(10, cartType);
			pstmt.executeUpdate();
			code		= "success";
			
			query		= "INSERT INTO ESL_CART ";
			query		+= "	(MEMBER_ID, GROUP_ID, BUY_QTY, DEVL_TYPE, DEVL_DAY, DEVL_WEEK, DEVL_DATE, PRICE, INST_DATE, BUY_BAG_YN, CART_TYPE)";
			query		+= " VALUES";
			query		+= "	('" + eslMemberId + "', '" + groupId + "', '" + buyQty + "', '" + devlType + "', '" + devlDay + "', '" + devlWeek + "', '" + day + "', '" + price + "', NOW(), '" + buyBagYn + "', '" + cartType + "')";
			//System.out.println(ut.getTimeStamp(9) + "'" + eslMemberId + "' =======================================================================================");
			//System.out.println("DEBUG LOG : " + query);
			
			//-- �̴Ϲ��ϰ�� īƮID�� ���Ѵ�.
			if("0300993".equals(groupCode)){ // � 0301000
				query1		= "SELECT IFNULL(MAX(ID),0) AS ID FROM ESL_CART WHERE MEMBER_ID = '"+eslMemberId+"' AND GROUP_ID = '"+groupId+"' AND CART_TYPE='"+cartType+"'";
				try {
					rs1	= stmt1.executeQuery(query1);
					if (rs1.next()) {
						cartId = rs1.getInt("ID");
					}
					rs1.close();
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}
				
			}
			
		}
		
		//-- �̴Ϲ��ϰ�� ESL_CART_DELIVERY���� ����Ѵ�.
		if("0300993".equals(groupCode) && cartId > 0){ // � 0301000
			query		= "DELETE FROM ESL_CART_DELIVERY WHERE CART_ID = "+ cartId;
			stmt.executeUpdate(query);

			if (cartId > 0) {
				if (buyQty2 > 0) {
					query		= "INSERT INTO ESL_CART_DELIVERY ";
					query		+= "	(CART_ID, GROUP_CODE, BUY_CNT, GROUP_ID)";
					query		+= " VALUES";
					query		+= "	(?, '0301000', ?, ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, cartId);
					pstmt.setInt(2, buyQty2);
					pstmt.setInt(3, groupId);
					pstmt.executeUpdate();
				}
				if (buyQty3 > 0) {
					query		= "INSERT INTO ESL_CART_DELIVERY ";
					query		+= "	(CART_ID, GROUP_CODE, BUY_CNT, GROUP_ID)";
					query		+= " VALUES";
					query		+= "	(?, '0301001', ?, ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, cartId);
					pstmt.setInt(2, buyQty3);
					pstmt.setInt(3, groupId);
					pstmt.executeUpdate();
				}
			}

		}
		
	}
	
	obj.put("code",code);
	obj.put("data",data);
	out.clear();
	out.println(obj);
	out.flush();
%>
