<%
/**
 * @date : 2019-01-17
 * @author : Heewon Choi
 * 체험단 주문 로직 파일(프로모션에서 체험단 주문하는 경우)
 */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"  pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
Statement stmt1		= null;
ResultSet rs1		= null;

String data 	= "";
String code		= "";

String query1   = "";
int result	    = 0;

String groupCode	= ut.inject(request.getParameter("groupCode"));
int	groupId			= Integer.parseInt(ut.inject(request.getParameter("groupId")));

int ckInstDate = 0;
int ckPurchaseTprice = 0;
int cKOM = 0;

// 소셜로그인시 팝업
query1     = " SELECT EXISTS (SELECT SNS_ACCESS_KEY FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"' AND SNS_ACCESS_KEY != '' ) RESULT ";
pstmt      = conn.prepareStatement(query1);
try {
	rs = pstmt.executeQuery();
} catch(Exception e) {
	out.println(e+"=>"+query1);
	code		= "error";
	data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
}
			  
if (rs.next()) {
	result             = rs.getInt("RESULT");
}

rs.close();

if(result > 0){
	code		= "error";
	data		= "<error><![CDATA[소셜 로그인은 체험단 신청이 불가합니다.]]></error>";
			  
}else {

	// ID 기준 신청,선정,구매이력 있을 시 팝업
	query1     = " SELECT  ";
	query1    += "  (SELECT COUNT(*) FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"' AND DATE_FORMAT(INST_DATE, '%Y%m%d') >= '20190218') AS INST_DATE, ";
	query1    += "  (SELECT PURCHASE_TPRICE FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"') AS PURCHASE_TPRICE, ";
	query1    += "  (SELECT COUNT(ORDER_NUM) FROM ESL_ORDER WHERE (ORDER_STATE > 00 AND ORDER_STATE < 90) AND MEMBER_ID = '"+ eslMemberId +"') AS C_OM ";	 
	query1    += " FROM ESL_MEMBER ";
 	query1    += " WHERE MEM_ID = '"+ eslMemberId +"' LIMIT 1 ";
	pstmt        = conn.prepareStatement(query1);
	try {
		rs       = pstmt.executeQuery();
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	}

	if (rs.next()) {
		ckInstDate           = rs.getInt("INST_DATE");
		ckPurchaseTprice     = rs.getInt("PURCHASE_TPRICE");
		cKOM				 = rs.getInt("C_OM");
	}

	rs.close();

	if(ckInstDate < 1 || ckPurchaseTprice > 0 || cKOM > 0){
		code		 = "error";
		data		 = "<error><![CDATA[체험단은 잇슬림 이용 경험이 없는 2.18일 이후 가입한 신규 고객만 신청 가능합니다.]]></error>";
	}else{

		// 5가지 제품 실주문 10개 미만 수량 체크
		query1       = " SELECT COUNT(EO.ORDER_NUM) RESULT ";
		query1      += " FROM ESL_GOODS_GROUP EGG, ESL_ORDER EO, ESL_ORDER_GOODS EOG ";
		query1      += " WHERE EGG.ID = EOG.GROUP_ID ";
		query1      += " AND EO.ORDER_NUM = EOG.ORDER_NUM  ";
		query1      += " AND EGG.GROUP_CODE = '"+groupCode+"' ";
		query1      += " AND DATE_FORMAT(EO.ORDER_DATE, '%Y%m%d') = DATE_FORMAT(NOW(), '%Y%m%d') ";
		query1      += " AND EOG.EXP_PROMOTION = '01' ";
		pstmt        = conn.prepareStatement(query1);
		try {
			rs       = pstmt.executeQuery();
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			code     = "error";
			data	 = "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}

		if (rs.next()) {
			result = rs.getInt("RESULT");
		}

		rs.close();

		System.out.println("result1:  " + result);

		if(result > 9){
			code		= "error";
			data		= "<error><![CDATA[해당 상품 주문 신청이 종료되었습니다.]]></error>";

		}else{

			// 장바구니에 해당 상품 담기
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd"); 
			Date date = new Date();
			Calendar cal = Calendar.getInstance(); 
			//cal.setTime(date); 
			//cal.add(Calendar.DATE, 3);
			//date = cal.getTime();
			//String day = dt.format(date);
			String devlDatePhi = "";
			int holidayCnt = 0;

			boolean bHolyday = true;
			for (int j = 0; j < 31; j++) {
				
				devlDatePhi		= dt.format(cal.getTime());	

				query1		= "SELECT COUNT(ID) FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY = '"+ devlDatePhi +"' AND HOLIDAY_TYPE = '02'";
				try {
					rs = stmt.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}				

				if (rs.next()) {
					holidayCnt		= rs.getInt(1);
				}
				rs.close();
				
				if (holidayCnt > 0) {
					cal.add(Calendar.DATE, 1);
				} else if (cal.get(cal.DAY_OF_WEEK) == 1 || cal.get(cal.DAY_OF_WEEK) == 7) { //일요일, 토요일은 배송을 하지 않는다
					cal.add(Calendar.DATE, 1);
				} else if (cal.get(cal.DAY_OF_WEEK) == 5) { //목요일은 배송일 +4일을 한다
					cal.add(Calendar.DATE, 4);
				} else if (cal.get(cal.DAY_OF_WEEK) == 6) { //금요일은 배송일 +3일을 한다
					cal.add(Calendar.DATE, 3);
				} else if (cal.get(cal.DAY_OF_WEEK) == 4) { //수요일는 배송일 +5을 한다
					cal.add(Calendar.DATE, 5);
				} else {
					cal.add(Calendar.DATE, 3);
					bHolyday = false;
				} 			
				devlDatePhi		= dt.format(cal.getTime());	

				if (!bHolyday) break;
			}

			// 바로구매 삭제
			query1		= "DELETE FROM ESL_CART WHERE MEMBER_ID = '"+eslMemberId+"' AND CART_TYPE = 'L'";
			pstmt		= conn.prepareStatement(query1);
			pstmt.executeUpdate();

			try {
				query1          = " INSERT INTO ESL_CART ";
				query1         += " (MEMBER_ID, GROUP_ID, BUY_QTY, DEVL_TYPE, DEVL_DAY, DEVL_WEEK, DEVL_DATE, PRICE, INST_DATE, BUY_BAG_YN, CART_TYPE, DEVL_WEEKEND, EXP_PROMOTION) ";
				query1         += " VALUES ";
				query1         += " (?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?, ?) ";
				pstmt           = conn.prepareStatement(query1);
				pstmt.setString(1, eslMemberId);
				pstmt.setInt(2, groupId);
				pstmt.setInt(3, 1);// 1
				pstmt.setString(4, "0001");
				pstmt.setString(5, "1");
				pstmt.setString(6, "0");
				pstmt.setString(7, devlDatePhi);
				pstmt.setInt(8, 1000);
				pstmt.setString(9, "N");
				pstmt.setString(10, "L");
				pstmt.setString(11, "0");
				pstmt.setString(12, "01");// 체험단 프로모션
				pstmt.executeUpdate();
				code		= "success";
			} catch (Exception e) {
				out.println(e+"=>"+query1);
				code		= "error";
				data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
			}
		}
	}
			 
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>
