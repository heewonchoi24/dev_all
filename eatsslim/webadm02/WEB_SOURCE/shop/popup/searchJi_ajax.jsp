<?xml version="1.0" encoding="utf-8" ?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_bm.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String query		= "";
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
//String ztype		= ut.inject(request.getParameter("ztype"));

String schSidoNm		= ut.inject(request.getParameter("schSidoNm"));
String schDong			= ut.inject(request.getParameter("schDong"));
String schGbBonNo		= ut.inject(request.getParameter("schGbBonNo"));
String schGbBuNo		= ut.inject(request.getParameter("schGbBuNo"));
String schDoroNm		= ut.inject(request.getParameter("schDoroNm"));
String schGmNm			= ut.inject(request.getParameter("schGmNm"));
String schGmBonNo		= ut.inject(request.getParameter("schGmBonNo"));
String schGmBuNo		= ut.inject(request.getParameter("schGmBuNo"));
String currentPage		= ut.inject(request.getParameter("currentPage"));
String schPageSize		= ut.inject(request.getParameter("schPageSize"));

String zipcode		= "";
String zipcode1		= "";
String zipcode2		= "";
String sidoNm			= "";
String sigunguNm		= "";
String gmbonNo			= "";
String gmbuNo		= "";
String gbbonNo		= "";
String gbbuNo		= "";
String doseNm	= "";
String gmNm	= "";
String doroNm	= "";
String omdNm	= "";
String riNm	= "";
String addr	= "";
//String gbnm	= "";
String devltype		= "";
String devlPtnCd	= "";
String devltype1	= "";
String devltype2	= "";
int cnt				= 0;
int totalCnt = 0;
/*
currentPage = "1";
schPageSize = "10";
mode = "post";
schDong = "공릉e";
schSidoNm = "서울특별시";
*/

if (mode.equals("post")) {
	if ( (schDong == null || schDong.equals("")) && (schGmNm == null || schGmNm.equals("")) ) {
		code		= "error";
		data		= "<error><![CDATA[검색어를 입력하세요.]]></error>";
	} else {
		try {
			
			
			
			query		= "SELECT TBL.* ";
			query		+= " FROM		";	
			query		+= "  (SELECT ROWNUM AS NUM ";
			query		+= "    , TMP.* ";
			query		+= "  FROM";
			query		+= "   (SELECT A.*";
			query		+= "     , FLOOR((ROWNUM-1)/"+schPageSize+"+1) AS PAGE ";
			query		+= "     , COUNT(*) OVER()        AS TOTCNT";
			query		+= "   FROM ";
			query		+= "    (";
			query		+= "    SELECT DISTINCT POST AS ZIP";
			//query		+= "        , SUBSTR(ZIP, 1, 3) || '-' || SUBSTR(ZIP, 4) AS ZIP_CD_WITH_DASH ";
			query		+= "        , ZIP_CD";
			query		+= "        , SIDO_NM";
			query		+= "        , SIGUNGU_NM";
			query		+= "        , OMD_NM";
			query		+= "        , RI AS RI_NM";
			query		+= "        , '' AS DOSE_NM         ";
			query		+= "        , GM_NM";
			query		+= "        , DORO_CD";
			query		+= "        , DORO_NM";
			query		+= "        , GM_BON_NO";
			query		+= "        , GM_BU_NO";
			query		+= "        , GM_NO";
			query		+= "        , BJD_CD";
			query		+= "        , BJD_NM";
			query		+= "        , OMD_NO";
			query		+= "        , GB_BON_NO     ";
			query		+= "        , GB_BU_NO";
			query		+= "        , NVL(SIDO_NM, '') || ' ' || DECODE(SIGUNGU_NM, null , '', SIGUNGU_NM  || ' ') || DECODE(DECODE(BJD_NM,NULL,HJD_NM, BJD_NM),NULL,OMD_NM, DECODE(HJD_NM,null,BJD_NM,HJD_NM))";
			query		+= "        || DECODE(RI,NULL,'',' ' || RI || ' ') || DECODE(RI, NULL, ' ' || GB_BON_NO, GB_BON_NO) || DECODE(GB_BU_NO, '0', '', '-' || GB_BU_NO) ||  DECODE(GB_BON_NO, NULL, GM_NM, ' ' || GM_NM)  AS ADDR";
			query		+= "        , DELIVERY_YN";
			query		+= "        , JISA_CD";
			query		+= "        , SATURDAY_YN";
			query		+= "    FROM CM_ZIP_NEW_M";
			query		+= "    WHERE 1=1";
			if (schSidoNm != null && !schSidoNm.equals("")) {
				query		+= "    AND SIDO_NM = '"+schSidoNm+ "' ";
			}
			/*if (schZip != null && !schZip.equals("")) {
				query		+= "    AND ZIP = '"+schZip+ "' ";
			}
			if (schZip2 != null && !schZip2.equals("")) {
				query		+= "    AND POST = '"+schZip2+ "' ";
			}*/
			if (schDong != null && !schDong.equals("")) {
				query		+= "    AND (BJD_NM LIKE '"+schDong+ "%' OR HJD_NM LIKE '"+schDong+ "%' OR OMD_NM LIKE '"+schDong+ "%')";
			}
			if (schGbBonNo != null && !schGbBonNo.equals("")) {
				query		+= "    AND GB_BON_NO = '"+schGbBonNo+ "'";
			}
			if (schGbBuNo != null && !schGbBuNo.equals("")) {
				query		+= "    AND GB_BU_NO = '"+schGbBuNo+ "' ";
			}
			/*
			if (schGmBonNo != null && !schGmBonNo.equals("")) {
				query		+= "    AND GM_BON_NO = '"+schGmBonNo+ "' ";
			}
			if (schGmBuNo != null && !schGmBuNo.equals("")) {
				query		+= "    AND GM_BU_NO = '"+schGmBuNo+ "' ";
			}
			if (schSigunguNm != null && !schSigunguNm.equals("")) {
				query		+= "    AND SIGUNGU_NM = '"+schSigunguNm+ "' ";
			}
			if (schDoroNm != null && !schDoroNm.equals("")) {
				query		+= "    AND DORO_NM LIKE '"+schDoroNm+ "'%' ";
			}
			*/
			if (schGmNm != null && !schGmNm.equals("")) {
				query		+= "    AND GM_NM LIKE '"+schGmNm+ "%'";
			}
			query		+= "    AND POST != '0' ";
			query		+= "    ORDER BY ADDR ";
			query		+= "   ) A ";
			query		+= "   ORDER BY A.ADDR";
			query		+= "   ) TMP ";
			query		+= "  ) TBL ";
			query		+= " WHERE TBL.PAGE = "+ currentPage +" ";
			query		+= " ORDER BY TBL.NUM DESC";
			
			
			pstmt_bm	= conn_bm.prepareStatement(query);
			rs_bm		= pstmt_bm.executeQuery();			
			
			
			while (rs_bm.next()) {
				zipcode		= rs_bm.getString("ZIP");
				sidoNm		= rs_bm.getString("SIDO_NM");
				sigunguNm	= rs_bm.getString("SIGUNGU_NM");
				gmbonNo		= rs_bm.getString("GM_BON_NO");
				gmbuNo		= rs_bm.getString("GM_BU_NO");
				gbbonNo		= rs_bm.getString("GB_BON_NO");
				gbbuNo		= rs_bm.getString("GB_BU_NO");
				doseNm		= rs_bm.getString("DOSE_NM");
				gmNm		= rs_bm.getString("GM_NM");
				doroNm		= rs_bm.getString("DORO_NM");
				omdNm		= rs_bm.getString("OMD_NM");
				riNm		= rs_bm.getString("RI_NM");
				addr		= rs_bm.getString("ADDR");
				//gbnm		= rs_bm.getString("GB_NM");
				devltype	= rs_bm.getString("DELIVERY_YN");
				devlPtnCd	= rs_bm.getString("SATURDAY_YN");
				totalCnt	= rs_bm.getInt("TOTCNT");
				if (devltype.equals("Y")) {
					if ( devlPtnCd.equals("Y") ) {
						devltype1	= "O";
						devltype2	= "O";
					} else {
						devltype1	= "X";
						devltype2	= "O";
					}
				} else {
					devltype1	= "X";
					devltype2	= "X";
				}	

				data		+= "<address><![CDATA["+ zipcode +"]]>|<![CDATA["+ sidoNm +"]]>|<![CDATA["+ sigunguNm +"]]>|<![CDATA["+ gmbonNo +"]]>|<![CDATA["+ gmbuNo +"]]>|";
				data		+= "<![CDATA["+ gbbonNo +"]]>|<![CDATA["+ gbbuNo +"]]>|<![CDATA["+ doseNm +"]]>|<![CDATA["+ gmNm +"]]>|<![CDATA["+ doroNm +"]]>|<![CDATA["+ omdNm +"]]>|<![CDATA["+ riNm +"]]>|<![CDATA["+ addr +"]]>|";
				data		+= "<![CDATA["+ devltype1 +"]]>|<![CDATA["+ devltype2 +"]]></address>";
					
				cnt++;					
			}
			
			int totalCount = totalCnt;
			int currentIndex=Integer.parseInt(currentPage);
			int pageSize = 10; // Row Size
			int pageGroupSize = 10;
			int totalPage = 0;
			int startIndex = 0;
			int endIndex = 0;

			if(totalCount == 0){
				totalPage = 1;
				startIndex = 1;
				endIndex = 1;
			}else{
				totalPage = (int)Math.ceil((double)totalCount/(double)pageSize);

				int pageGroup = (int)Math.ceil((double)(currentIndex*pageSize)/(double)(pageSize*pageGroupSize));
				if(pageGroup > 1){
					startIndex = (pageGroup-1) * pageGroupSize + 1;
				}else{
					startIndex = 1;
				}

				if(totalPage == 1){
					endIndex = 1;
				}else{
					int ePage = startIndex + pageGroupSize - 1;
					if(totalPage < ePage){
						endIndex = totalPage;
					}else{
						endIndex = ePage;
					}
				}
			}
			
			data		+= "<paging><![CDATA["+ totalPage +"]]>|<![CDATA["+ startIndex +"]]>|<![CDATA["+ endIndex +"]]></paging>";
			
			
			if (cnt > 0) {				
				code		= "success";
			} else {
				code		= "success";
				data		= "<address><![CDATA[nodata|검색된 배송가능지역이 없습니다.]]></address>";
			}
		} catch (Exception e) {
			out.println(e+"=>"+query);
			code		= "error";
			data		= "<error><![CDATA[장애가 발생하였습니다.\n잠시 후 다시 이용해 주십시오.]]></error>";
		}
	}
}

out.println("<response>");
out.println("<result>"+ code +"</result>");
out.println(data);
out.println("</response>");
%>
<%@ include file="/lib/dbclose_bm.jsp"%>