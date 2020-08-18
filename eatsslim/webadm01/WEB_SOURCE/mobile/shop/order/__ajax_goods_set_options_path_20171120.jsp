<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.*"%>

<%
	JSONObject obj = new JSONObject();
	String data 	= "";
	String code		= "";

	String cartInstType		= ut.inject(request.getParameter("cartInstType")); //-- cartInstType=new 신규등록, 신규등록시 이미 장바구니에 상품이 있다면 옵션변경 alert창 보여줌
	String day				= ut.inject(request.getParameter("day"));
	String cartType 		= ut.inject(request.getParameter("cart_type")); //-- 장바구니=C 또는 바로구매=L
	String devlWeek 		= ut.inject(request.getParameter("devlWeek")); //-- 일일배송 주차
	String devlDay			= ut.inject(request.getParameter("devlDay")); //-- 일일배송 요일
	String groupCode		= ut.inject(request.getParameter("groupCode"));
	String devlType			= ut.inject(request.getParameter("devlType"));
	String buyBagYn			= ut.inject(request.getParameter("buyBagYn"));
	String pcAndMobileType	= ut.inject(request.getParameter("pcAndMobileType"));

	int groupId			= 0; //-- 그룹ID
	int price		 	= 0; //-- 전체금액
	int buyQty			= 0; //-- 상품수량
	int buyQty2			= 0; //-- 미니밀일경우 한식세트 수량
	int buyQty3			= 0; //-- 미니밀일경우 양식세트 수량
	
	try{
		groupId			= Integer.parseInt(ut.inject(request.getParameter("groupId")));
		price		 	= Integer.parseInt(ut.inject(request.getParameter("totalPrice")));
		buyQty			= request.getParameter("buyQty") == null ? 0 : Integer.parseInt(ut.inject(request.getParameter("buyQty")));
		buyQty2			= request.getParameter("buyQty2") == null ? 0 : Integer.parseInt(ut.inject(request.getParameter("buyQty2")));
		buyQty3			= request.getParameter("buyQty3") == null ? 0 : Integer.parseInt(ut.inject(request.getParameter("buyQty3")));
		
		//-- 미니밀일경우 수량을 한식세트와양식세트 더한수량으로 한다.
		if("0300993".equals(groupCode)){
			buyQty = buyQty2 + buyQty3;
		}
		
		if(groupId == 0 || price == 0 || buyQty == 0){
			code		= "error";
			data		= "정보가 정확하지 않습니다. - 1";
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
		data		= "정보가 정확하지 않습니다. - 2";
		obj.put("code",code);
		obj.put("data",data);
		out.clear();
		out.println(obj);
		out.flush();
		if(true)return;
	}
	
	if(!"Y".equals(buyBagYn) ) buyBagYn  = "N"; // 일일배송이 아닐경우는 Null값이다 N으로 설정
	if("".equals(devlWeek) ) devlWeek  = "0"; // 일일배송이 아닐경우는 Null값이다 0으로 설정
	if("".equals(devlDay) ) devlDay  = "0"; // 일일배송이 아닐경우는 Null값이다 0으로 설정
	
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
	
	//-- 바로구매 삭제
	query		= "DELETE FROM ESL_CART WHERE MEMBER_ID = '"+eslMemberId+"' AND CART_TYPE = 'L'";
	pstmt		= conn.prepareStatement(query);
	pstmt.executeUpdate();
	
	//-- 일일배송 주문건 카운팅
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
		data		= "신규 구매 시 보냉가방은 필수로 구매하셔야 합니다.";
	}
	else if (devlType.equals("0001")  && day.equals("") ) {
		code		= "error";
		data		= "날짜를 입력하셔야 합니다..";
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
		
		if (cartId > 0) { //-- 장바구니에 있다면 수정
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
			
			//-- 신규등록시 상품이 이미 등록이 되어 있다면 알림
			if("new".equals(cartInstType) ) data = "이미 장바구니에 담긴 상품입니다.\n옵션정보가 업데이트 되었습니다.";
		}
		else{ //-- 장바구니에 없다면 등록
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
			
			//-- 미니밀일경우 카트ID를 구한다.
			if("0300993".equals(groupCode)){ // 운영 0301000
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
		
		//-- 미니밀일경우 ESL_CART_DELIVERY에도 등록한다.
		if("0300993".equals(groupCode) && cartId > 0){ // 운영 0301000
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
