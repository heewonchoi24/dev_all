<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ include file="/lib/config.jsp"%>
<%

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String orderNum		= request.getParameter("orderNum");
int goodsId			= 0;
if (request.getParameter("goodsId") != null && request.getParameter("goodsId").length()>0)
	goodsId			= Integer.parseInt(request.getParameter("goodsId"));
int i				= 0;

String startDevlDate	= "";
String endDevlDate		= "";
String devlDate			= "";
String devlDateTmp		= "";
String devlWeek			= "";
int    orderCnt			= 0;
int    devlDateCnt		= 0;
int    devlDateTmpCnt	= 0;

String gubunCode	= "";
String groupName	= "";
String subGoodsName	= "";
int groupId			= 0;
String ordState		= "";
String goodsImg		= "";
String nowDate		= "";

Calendar cal		= Calendar.getInstance();

int nowYear			= cal.get(Calendar.YEAR);
int nowMonth		= cal.get(Calendar.MONTH)+1;

int nowDay			= cal.get(Calendar.DAY_OF_MONTH);
int nowHour			= cal.get(Calendar.HOUR_OF_DAY);


String week_day		= ut.inject(request.getParameter("week_day"));
int schWeek			= 0;
if (request.getParameter("sch_week") != null && request.getParameter("sch_week").length()>0)
	schWeek			= Integer.parseInt(request.getParameter("sch_week"));
int weekDay			= (week_day.equals("") || week_day == null || week_day.equals("undefined"))? 0 : Integer.parseInt(week_day);
int cnt				= 0;

int year			= nowYear;
int month			= nowMonth-3;

/*====================================================*/
/* 테이스티 세트 메뉴 리뉴얼 시작 날짜와 비교 하기 위해 정확한 주문일자 조회 */
String orderDateDetail = "";
String dateQuery = "";
String replaceDevlDate = "";

dateQuery		= "SELECT ORDER_DATE FROM ESL_ORDER WHERE ORDER_NUM = '" + orderNum + "'";
try { rs = stmt.executeQuery(dateQuery);}catch(Exception e) {out.println(e+"=>"+dateQuery);	if(true)return;}
if (rs.next()) replaceDevlDate = rs.getString("ORDER_DATE").replace("-", "").replace(" ","").replace(":","").replace(".","").substring(0,10);
rs.close();

int dateForTasty = Integer.parseInt(replaceDevlDate);
/*====================================================*/

String groupCode	= ut.inject(request.getParameter("groupCode"));
if (year > 2013) {
	if (groupCode.equals("0300601")) {
		groupCode		= "0300717";
	} else if (groupCode.equals("0300602")) {
		groupCode		= "0300718";
	} else if (groupCode.equals("0300603")) {
		groupCode		= "0300719";
	} else if (groupCode.equals("0300604")) {
		groupCode		= "0300720";
	} else if (groupCode.equals("0300605")) {
		groupCode		= "0300721";
	} else if (groupCode.equals("0300606")) {
		groupCode		= "0300722";
	} else if (groupCode.equals("0300607")) {
		groupCode		= "0300723";
	} else if (groupCode.equals("0300608")) {
		groupCode		= "0300724";
	} else {
		groupCode		= groupCode;
	}
} else {
	if (groupCode.equals("0300717")) {
		groupCode		= "0300601";
	} else if (groupCode.equals("0300718")) {
		groupCode		= "0300602";
	} else if (groupCode.equals("0300719")) {
		groupCode		= "0300603";
	} else if (groupCode.equals("0300720")) {
		groupCode		= "0300604";
	} else if (groupCode.equals("0300721")) {
		groupCode		= "0300605";
	} else if (groupCode.equals("0300722")) {
		groupCode		= "0300606";
	} else if (groupCode.equals("0300723")) {
		groupCode		= "0300607";
	} else if (groupCode.equals("0300724")) {
		groupCode		= "0300608";
	} else {
		groupCode		= groupCode;
	}
}

try {
	query		= "SELECT COUNT(ID)";
	query		+= " FROM ESL_ORDER_DEVL_DATE";
	query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ goodsId;
	query		+= " AND STATE in ('01', '02')";
	query		+= " AND GROUP_CODE <> '0300668'"; //-- 배송가방은 노출하지 않는다.
	rs	= stmt.executeQuery(query);
	if (rs.next()) {
		cnt			= rs.getInt(1);
	} else {
		cnt			= 0;
	}
	rs.close();
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

List<Map<String,Object>> dataList				 = new ArrayList();
List<Map<String,Object>> subDataList			 = new ArrayList();
Map<String,Object> dataMap						 = new HashMap();
Map<String,Object> subDataMap					 = new HashMap();

int j = 0;
//-- 값이 있을경우만 실행
if(cnt > 0){
	//-- 배송 시작일 종료일
	query		= "SELECT ";
	query		+= "	MIN(DEVL_DATE) AS START_DEVL_DATE,MAX(DEVL_DATE) AS END_DEVL_DATE";
	query		+= " FROM ESL_ORDER_DEVL_DATE A";
	query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ goodsId;
	query		+= " AND STATE in ('01', '02')";
	query		+= " AND GROUP_CODE <> '0300668'"; //-- 배송가방은 노출하지 않는다.
	try {
		rs	= stmt.executeQuery(query);
		if(rs.next()){
			startDevlDate		= rs.getString("START_DEVL_DATE");
			endDevlDate			= rs.getString("END_DEVL_DATE");
		}
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	rs.close();


	query		= "SELECT ";
	query		+= "	DEVL_DATE, ";
	query		+= "	DAYOFWEEK(DEVL_DATE) AS DEVL_WEEK, ";
	query		+= "	(SELECT COUNT(*) FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM='"+ orderNum +"' AND GOODS_ID = "+ goodsId+" AND DEVL_DATE=A.DEVL_DATE AND STATE in ('01', '02') AND GROUP_CODE <> '0300668') DEVL_DATE_CNT, ";
	query		+= "	(SELECT GROUP_NAME FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ groupCode +"') GROUP_NAME, ";
	query		+= "	(SELECT GROUP_IMGM FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ groupCode +"') GROUP_IMGM, ";
	query		+= "	(SELECT ID FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ groupCode +"') GROUP_ID, ";
	query		+= "	ORDER_CNT, GROUP_CODE, STATE ";
	//if(groupCode.equals("0301737")){// 테이스티 세트
		//query		+= " ,(SELECT CATE_NAME FROM ESL_GOODS_CATEGORY WHERE CATE_CODE = GROUP_CODE) CATE_NAME ";
	//}
	query		+= " FROM ESL_ORDER_DEVL_DATE A";
	query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ goodsId;
	query		+= " AND STATE in ('01', '02')";
	query		+= " AND GROUP_CODE <> '0300668'"; //-- 배송가방은 노출하지 않는다.
	query		+= " ORDER BY DEVL_DATE ASC";
	
	//System.out.println(query);
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	int memoIdx = 0;
	while (rs.next()) {
		String goodsCateName = "";
		subDataMap		 = new HashMap();
		groupId			= rs.getInt("GROUP_ID");
		ordState		= rs.getString("STATE");
		devlDate		= rs.getString("DEVL_DATE");
		devlWeek		= rs.getString("DEVL_WEEK");
		orderCnt		= rs.getInt("ORDER_CNT");
		devlDateCnt		= rs.getInt("DEVL_DATE_CNT");
		goodsImg		= rs.getString("GROUP_IMGM");
		//if(groupCode.equals("0301737")){// 테이스티 세트
			//goodsCateName	= rs.getString("CATE_NAME");
		//}
		subGoodsName	= "";

		if(devlDateTmpCnt < 1)	devlDateTmpCnt  = rs.getInt("DEVL_DATE_CNT");

		//if (memoIdx == 0 ) {
			groupName		= rs.getString("GROUP_NAME");// +"("+ rs.getString("ORDER_CNT") +")";
		//}
		gubunCode		= rs.getString("GROUP_CODE");

		if (groupCode.length() < 7) {
			if (gubunCode.equals("0300668")) {
				subGoodsName		+= "배송가방";
			} else if (gubunCode.equals("0071285")) {
				subGoodsName		+= "리프레시클렌즈 세트";
			} else if (ordState.equals("02")) {
				subGoodsName		+= "증정";
			} else {
				query1		= "SELECT CATEGORY_NAME, AMOUNT";
				query1		+= " FROM ESL_GOODS_GROUP_EXTEND";
				query1		+= " WHERE GROUP_ID = "+ groupId;
				query1		+= " AND WEEK = "+ devlWeek;

				try {
					rs1 = stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}

				while (rs1.next()) {
					//groupName		+= rs1.getString("CATEGORY_NAME") + rs1.getInt("AMOUNT");
					subGoodsName		+= " - " + rs1.getString("CATEGORY_NAME");
				}
				rs1.close();
			}
		} else {
			if (gubunCode.equals("0300668")) {
				subGoodsName		+= "배송가방";
			} else if (gubunCode.equals("0071199")) {
				subGoodsName		+= "리프레시클렌즈 세트";
			} else if (gubunCode.equals("0070817")) {
				subGoodsName		+= "자몽&마테 발효녹즙";
			} else if (ordState.equals("02")) {
				subGoodsName		+= "증정";
			} else if (groupCode.equals("0301737")) {// 테이스티 세트	
                subGoodsName =  gCodeList.get(j);
				j++;
				if(j == 5){
					j = 0;
				}
				
			} else {
				query1		= "SELECT SET_NAME, THUMB_IMG, BIG_IMG, AMOUNT";
				query1		+= " FROM ESL_GOODS_GROUP_EXTEND G, ESL_GOODS_SET S, ESL_GOODS_CATEGORY_SCHEDULE CS";
				query1		+= " WHERE G.CATEGORY_ID = S.CATEGORY_ID AND CS.SET_CODE = S.SET_CODE";
				query1		+= " AND CS.DEVL_DATE = '"+ devlDate +"' AND G.GROUP_ID = "+ groupId;
				try {
					rs1 = stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}

				//System.out.println("query1: " + query1);

				while (rs1.next()) {
					//groupName		+= rs1.getString("SET_NAME") + rs1.getInt("AMOUNT");
					if(!"".equals(subGoodsName) ) subGoodsName += " - ";
					subGoodsName		+= rs1.getString("SET_NAME");
					//goodsImg		= rs1.getString("THUMB_IMG");
					goodsImg		= rs1.getString("BIG_IMG");
				}
				rs1.close();
			}
		}

		subDataMap.put("title",groupName);
		subDataMap.put("subTitle",subGoodsName);
		subDataMap.put("quantity",orderCnt);
		subDataMap.put("daycnt",devlDateCnt);
		subDataMap.put("image",webUploadDir +"goods/"+ goodsImg);
		subDataMap.put("startdate",startDevlDate);
		subDataMap.put("enddate",endDevlDate);

		subDataList.add(subDataMap);
		if(devlDateTmpCnt == 1){
			if(devlDate != null && devlDate.length() == 10){
				dataMap.put("devdate",devlDate);
				dataMap.put("year",devlDate.substring(0,4));
				dataMap.put("month",devlDate.substring(5,7));
				dataMap.put("day",devlDate.substring(8,10));
			}
			else{
				dataMap.put("devdate","");
				dataMap.put("year","");
				dataMap.put("month","");
				dataMap.put("day","");
			}
			
			if(startDevlDate.equals(devlDate)){
				dataMap.put("rangetype","start");
			}
			else if(endDevlDate.equals(devlDate)){
				dataMap.put("rangetype","end");
			}
			else{
				dataMap.put("rangetype","");
			}
			/*
			if(memoIdx == 0){
				dataMap.put("rangetype","start");
			}
			else if(memoIdx == cnt - 1){
				dataMap.put("rangetype","end");
			}
			else{
				dataMap.put("rangetype","");
			}
			*/

			dataMap.put("list",subDataList);
			dataList.add(dataMap);
			subDataList		 = new ArrayList();
			dataMap = new HashMap();
		}
		devlDateTmpCnt--;

		memoIdx++;
	}
	rs.close();

}

//out.println(dataList.toString());

JSONObject list = new JSONObject();
list.put("data",dataList);
out.clear();
out.println(list);
out.flush();
%>

