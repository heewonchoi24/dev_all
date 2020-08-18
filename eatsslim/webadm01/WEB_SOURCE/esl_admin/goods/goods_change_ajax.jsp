<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp" %>
<%
request.setCharacterEncoding("utf-8");

// MODE = submit1_goodsChange
int intTotalCnt					      = 0;
String query						  = "";
boolean error		    	   		  = false;
String code							  = "";
String data							  = "";
String mode			  				  = ut.inject(request.getParameter("mode"));
String deliveryDate		   			  = ut.inject(request.getParameter("deliveryDate"));
String setCode						  = ut.inject(request.getParameter("setCode"));
String cateCode						  = ut.inject(request.getParameter("cateCode"));
String cateId						  = ut.inject(request.getParameter("cateId"));
String instId						  = (String)session.getAttribute("esl_admin_id");
String userIp						  = request.getRemoteAddr();

//MODE = submit2_goodsChange
String r_stdate                   	  = ut.inject(request.getParameter("r_stdate"));
String r_ltdate                 	  = ut.inject(request.getParameter("r_ltdate"));
String mr_stdate                      = ut.inject(request.getParameter("mr_stdate"));
String mr_ltdate                	  = ut.inject(request.getParameter("mr_ltdate"));

List<Map<String,Object>> setCodeList  = null;
Map<String,Object> setCodeMap	      = null;
List<Map<String,Object>> idList 	  = null;
Map<String,Object> idMap	    	  = null;
int intCntSetCode 					  = 0;
int intCalHolidayCnt                  = 0;	// 휴일 계산
int intCal2HolidayCnt                 = 0;  // 휴일 계산

Calendar cal			= Calendar.getInstance();	// 선택시작일
Calendar cal2			= Calendar.getInstance();	// 패턴적용시작일

Calendar first_cal		= Calendar.getInstance();	// 날짜 계산용
Calendar second_cal		= Calendar.getInstance();	// 날짜 계산용

int week			= cal.get(Calendar.DAY_OF_WEEK);
SimpleDateFormat dFormat = new SimpleDateFormat ( "yyyy-MM-dd" );

if (instId == null || instId.equals("")) {
	code		= "error";
	data		= "<error><![CDATA[로그인을 해주세요.]]></error>";
} else if (request.getHeader("REFERER")==null) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (request.getHeader("REFERER").indexOf(request.getServerName())<1) {
	code		= "error";
	data		= "<error><![CDATA[정상적으로 접근을 해주십시오.]]></error>";
} else if (mode.equals("submit1_goodsChange")) {


	 if(cateCode.equals("0301590")){	// 
		 cateId = "20";
	 }

	try {
		query	= "SELECT COUNT(*) FROM ESL_GOODS_CATEGORY_SCHEDULE WHERE CATEGORY_CODE = ? AND DEVL_DATE = ? ";
		pstmt	= conn.prepareStatement(query);
		pstmt.setString(1, cateCode);
		pstmt.setString(2, deliveryDate);
		rs		= pstmt.executeQuery();
		if (rs.next()) {
			intTotalCnt	= rs.getInt(1);
		} 
		if (rs != null) try { rs.close(); } catch (Exception e) {}
		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		
		System.out.println("intTotalCnt: " + intTotalCnt);
		
		if(intTotalCnt > 0){// 값이 있으므로 update
		 	try {
		 		query		= "UPDATE ESL_GOODS_CATEGORY_SCHEDULE SET SET_CODE = ?, UPDT_ID = ?, UPDT_IP = ?, UPDT_DATE = NOW() WHERE DEVL_DATE = ? AND CATEGORY_CODE = ? ";
				pstmt		= conn.prepareStatement(query);
				pstmt.setString(1, setCode);
				pstmt.setString(2, instId);
				pstmt.setString(3, userIp);
				pstmt.setString(4, deliveryDate);
				pstmt.setString(5, cateCode);
				pstmt.executeUpdate();

				System.out.println("query: " + query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			} 
		 	code		= "update";
			System.out.println("query: " + query);
		}
		else{// 값이 0개면 새로 값을 insert 해준다  if(intTotalCnt == 0)
			try {
				query	= " INSERT INTO ESL_GOODS_CATEGORY_SCHEDULE (ID, CATEGORY_ID, CATEGORY_CODE, SET_CODE, DEVL_DATE, INST_ID, INST_IP, INST_DATE) ";
				query  += " VALUES ((SELECT ifnull(MAX(ECS.ID),0)+1 FROM ESL_GOODS_CATEGORY_SCHEDULE ECS), ?, ?, ?, ?, ?, ?, NOW()) ";
				pstmt   = conn.prepareStatement(query);
				pstmt.setString(1, cateId);
				pstmt.setString(2, cateCode);
				pstmt.setString(3, setCode);
				pstmt.setString(4, deliveryDate);
				pstmt.setString(5, instId);
				pstmt.setString(6, userIp);
				pstmt.executeUpdate();

				System.out.println("query: " + query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			} 
			code		= "insert";
		}
	
	} catch (Exception e) {
		code		= "error";
		data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
	}
} else if (mode.equals("submit2_goodsChange")) {
	
   	// DELETE	
	try{
		query		= "DELETE FROM ESL_GOODS_CATEGORY_SCHEDULE WHERE CATEGORY_CODE = ? AND DEVL_DATE between ? AND ? ";
		pstmt		= conn.prepareStatement(query);
		pstmt.setString(1, cateCode);
		pstmt.setString(2, mr_stdate);
		pstmt.setString(3, mr_ltdate);
		pstmt.executeUpdate();
	} catch (Exception e) {
		ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
		ut.jsBack(out);
		return;
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
	}
	
	
   	// 선택일
	Date date_1 =  dFormat.parse(r_stdate);	// 선택시작일
	first_cal.setTime(date_1);
	Date date_2 =  dFormat.parse(r_ltdate);	// 선택종료일
	second_cal.setTime(date_2);
	
	// 날짜 계산
	long fDay1 = first_cal.getTimeInMillis()/86400000;
	long sDay2 = second_cal.getTimeInMillis()/86400000;
	long cntDay1 = sDay2 - fDay1;
	
	// 초기화
	first_cal.clear();
	second_cal.clear();
	
	// 패턴 적용일
	Date date_3 =  dFormat.parse(mr_stdate);	// 패턴적용시작일
	first_cal.setTime(date_3);
	Date date_4 =  dFormat.parse(mr_ltdate);	// 패턴적용종료일
	second_cal.setTime(date_4);
	
	// 날짜 계산
    long fDay3 = first_cal.getTimeInMillis()/86400000;
	long sDay4 = second_cal.getTimeInMillis()/86400000;
	long cntDay2 = sDay4 - fDay3;
	
	// 각각 날짜 계산한 값을 int형으로 형변환
	int cnt1 = (int) cntDay1;
	int cnt2 = (int) cntDay2;
	
	// 초기화
	first_cal.clear();
	second_cal.clear();
	
	// 선택시작일을 cal에 담음
	Date date =  dFormat.parse(r_stdate);
	cal.setTime(date);
	
	// 패턴적용시작일을 cal에 담음
	Date r_date =  dFormat.parse(mr_stdate);
	cal2.setTime(r_date);
	
	// 선택일 기준 for문
	int new_cnt = 0;// 전체 패턴적용일 수 만큼 도는 변수
	for(int k = 0; k <= cnt1; k++){
		//전체카운트만큼 루프
		if(new_cnt <= cnt2){
			//선택일 이후는 하루씩 증가
			if(k > 0){
				cal.add(Calendar.DATE, 1);
			}
			// 선택일 그대로 반영
			else{
				cal.add(Calendar.DATE, 0);
			}
			
			// 메뉴 선택일이 holiday이면 해당 날짜의 식단은 패스한다.
			try{
				query	= 	" SELECT COUNT(*) ";
				query  += 	" FROM ESL_SYSTEM_HOLIDAY ";
				query  += 	" WHERE HOLIDAY = ? ORDER BY HOLIDAY DESC, ID DESC ";
				pstmt	=   conn.prepareStatement(query);
				pstmt.setString(1, dFormat.format(cal.getTime()));
        		rs		= pstmt.executeQuery();
        		if (rs.next()) {
        			intCalHolidayCnt	= rs.getInt(1);
        		} 
        		if (rs != null) try { rs.close(); } catch (Exception e) {}
        		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        		
            } catch (Exception e) {
           	 	code		= "error";
                data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
            } finally {
           		 if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            }
			
			// 패턴반복적용일이 holiday이면 해당 날짜의 식단은 패스한다.
			try{
				query	= 	" SELECT COUNT(*) ";
				query  += 	" FROM ESL_SYSTEM_HOLIDAY ";
				query  += 	" WHERE HOLIDAY = ? ORDER BY HOLIDAY DESC, ID DESC ";
				pstmt	=   conn.prepareStatement(query);
				pstmt.setString(1, dFormat.format(cal2.getTime()));
        		rs		= pstmt.executeQuery();
        		if (rs.next()) {
        			intCal2HolidayCnt	= rs.getInt(1);
        		} 
        		if (rs != null) try { rs.close(); } catch (Exception e) {}
        		if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        		
            } catch (Exception e) {
           	 	code		= "error";
                data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
            } finally {
           		 if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            }
			
			/**********************************************************
				공휴일체크			
			***********************************************************/
			// 선택일이 공휴일일때 패스
			if(intCalHolidayCnt < 1){
				
				// 반영일이 공휴일일때 패스
                if(intCal2HolidayCnt > 0){
               	 	cal2.add(Calendar.DATE, 1);
               	 	
                }
                else{
                	//////////////////////////////// 미니밀 - 일요일 제외
    	            if(cateCode.equals("0301590")){
    	            	
    	                 if(cal.get(cal.DAY_OF_WEEK) == 1){// 선택일이 일요일일 때
    	                     cal.add(Calendar.DATE, 1);
    	                     k=k+1;
    	                 }
    	                 
   	                	 if(cal2.get(cal2.DAY_OF_WEEK) == 1){// 패턴적용일이 일요일일 때
   		                     cal2.add(Calendar.DATE, 1);
   		                     new_cnt++;
   		                 }
    	                 
    	                 // select & insert
    	                 try {
    		                 query= " INSERT INTO ESL_GOODS_CATEGORY_SCHEDULE (ID, CATEGORY_ID, CATEGORY_CODE, SET_CODE, DEVL_DATE, INST_ID, INST_IP, INST_DATE) ";
    		                 query  += " SELECT (SELECT ifnull(MAX(ECS.ID),0)+1 FROM ESL_GOODS_CATEGORY_SCHEDULE ECS), 20, CATEGORY_CODE, SET_CODE, ?, INST_ID, INST_IP, NOW() FROM ESL_GOODS_CATEGORY_SCHEDULE ";
    		                 query  += " WHERE CATEGORY_CODE = ? AND DEVL_DATE = ? ";
    		                 pstmt   = conn.prepareStatement(query);
							 
    		                 pstmt.setString(1, dFormat.format(cal2.getTime()));
    		                 pstmt.setString(2, cateCode);
    		                 pstmt.setString(3, dFormat.format(cal.getTime()));
    		                 pstmt.executeUpdate();
    		             } catch (Exception e) {
    		            	 code		= "error";
    		                 data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
    		             } finally {
    		            		 if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    		             }
    	                 cal2.add(Calendar.DATE, 1);
    	                 code = "insert";
    	            }
					////////////////////////////////// 그 외 식단 - 토, 일요일 제외
    	            else{
    	                if(cal.get(cal.DAY_OF_WEEK) == 7){// 선택일이 토요일일 때
    	                   cal.add(Calendar.DATE, 2);
    	                   k=k+2;
    	                }
    	                if(cal2.get(cal2.DAY_OF_WEEK) == 7){// 패턴적용일이 토요일일 때
    	                    cal2.add(Calendar.DATE, 2);
    	                    new_cnt++;
    	                    new_cnt++;
    	                }
    	                // select & insert
    	                try {
    		                 query= " INSERT INTO ESL_GOODS_CATEGORY_SCHEDULE (ID, CATEGORY_ID, CATEGORY_CODE, SET_CODE, DEVL_DATE, INST_ID, INST_IP, INST_DATE) ";
    		                 query  += " SELECT (SELECT ifnull(MAX(ECS.ID),0)+1 FROM ESL_GOODS_CATEGORY_SCHEDULE ECS), CATEGORY_ID, CATEGORY_CODE, SET_CODE, ?, INST_ID, INST_IP, NOW() FROM ESL_GOODS_CATEGORY_SCHEDULE ";
    		                 query  += " WHERE CATEGORY_CODE = ? AND DEVL_DATE = ? ";
    		                 pstmt   = conn.prepareStatement(query);
    		                 pstmt.setString(1, dFormat.format(cal2.getTime()));
    		                 pstmt.setString(2, cateCode);
    		                 pstmt.setString(3, dFormat.format(cal.getTime()));
    		                 pstmt.executeUpdate();
    		             } catch (Exception e) {
    		            	 code		= "error";
    		                 data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
    		             } finally {
    		            		 if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    		             }
    	                 cal2.add(Calendar.DATE, 1);
    	                 code = "insert";
    	            }
    				
    				
                }// end of else
			}// end of if(intCalHolidayCnt < 1)
		}// end of if(new_cnt <= cnt2)
			
		//전체 선택일 수와 같고 전체 패턴적용일 수보다 작을시 선택일 다시 조회
		if(k == cnt1){
			if(new_cnt <= cnt2){
				k = -1;
				cal.setTime(date);
			}
		}
		new_cnt++;
	} 
	
}

out.println("<response>");
out.println("<result>"+code+"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="../lib/dbclose.jsp"%>

