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
String ztype		= ut.inject(request.getParameter("ztype"));

String schSidoNm		= ut.inject(request.getParameter("sidonm"));
String schZip		= ut.inject(request.getParameter("zip"));
String schZip2		= ut.inject(request.getParameter("zip2"));
String schDong		= ut.inject(request.getParameter("dong"));
String schGbBonNo		= ut.inject(request.getParameter("gbbonno"));
String schGbBuNo		= ut.inject(request.getParameter("gbbuno"));
String schGmBonNo		= ut.inject(request.getParameter("gmbonno"));
String schGmBuNo		= ut.inject(request.getParameter("gmbuno"));
String schSigunguNm		= ut.inject(request.getParameter("sigungunm"));
String schDoroNm		= ut.inject(request.getParameter("doronm"));
String schGmNm		= ut.inject(request.getParameter("gmNm"));


String zipcode		= "";
String zipcode1		= "";
String zipcode2		= "";
String sidoNm			= "";
String sigunguNm		= "";
String gmbonNo			= "";
String gmbuNo		= "";
String gbbonNo		= "";
String gbbuNo		= "";
String gmNm	= "";
String doroNm	= "";
String omdNm	= "";
String riNm	= "";
//String gbnm	= "";
String devltype		= "";
String devlPtnCd	= "";
String devltype1	= "";
String devltype2	= "";
int cnt				= 0;

mode = "post";
schDong = "공릉";
schSidoNm = "서울특별시";

if (mode.equals("post")) {
	if (schDong == null || schDong.equals("")) {
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
			query		+= "     , FLOOR((ROWNUM-1)/10+1) AS PAGE ";
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
			if (schZip != null && !schZip.equals("")) {
				query		+= "    AND ZIP = '"+schZip+ "' ";
			}
			if (schZip2 != null && !schZip2.equals("")) {
				query		+= "    AND POST = '"+schZip2+ "' ";
			}
			if (schDong != null && !schDong.equals("")) {
				query		+= "    AND (BJD_NM LIKE '"+schDong+ "%' OR HJD_NM LIKE '"+schDong+ "%' OR OMD_NM LIKE '"+schDong+ "%')";
			}
			if (schGbBonNo != null && !schGbBonNo.equals("")) {
				query		+= "    AND GB_BON_NO = '"+schGbBonNo+ "'";
			}
			if (schGbBuNo != null && !schGbBuNo.equals("")) {
				query		+= "    AND GB_BU_NO = '"+schGbBuNo+ "' ";
			}
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
			if (schGmNm != null && schGmNm.equals("")) {
				query		+= "    AND GM_NM LIKE '"+schGmNm+ "%'";
			}
			query		+= "    AND POST != '0' AND ( TMP_ADDCOL ='Y' OR TMP_ADDCOL IS NULL)";
			query		+= "    ORDER BY ADDR ";
			query		+= "   ) A ";
			query		+= "   ORDER BY A.ADDR";
			query		+= "   ) TMP ";
			query		+= "  ) TBL ";
			query		+= " WHERE TBL.PAGE = 1 ";
			query		+= " ORDER BY TBL.NUM DESC";
			
			
			pstmt_phi	= conn_phi.prepareStatement(query);
			rs_phi		= pstmt_phi.executeQuery();			
			
			
			while (rs_phi.next()) {
				zipcode		= rs_phi.getString("ZIP");
				sidoNm		= rs_phi.getString("SIDO_NM");
				sigunguNm	= rs_phi.getString("SIGUNGU_NM");
				gmbonNo		= rs_phi.getString("GM_BON_NO");
				gmbuNo		= rs_phi.getString("GM_BU_NO");
				gbbonNo		= rs_phi.getString("GB_BON_NO");
				gbbuNo		= rs_phi.getString("GB_BU_NO");
				gmNm		= rs_phi.getString("GM_NM");
				doroNm		= rs_phi.getString("DORO_NM");
				omdNm		= rs_phi.getString("OMD_NM");
				riNm		= rs_phi.getString("RI_NM");
				//gbnm		= rs_phi.getString("GB_NM");
				devltype	= rs_phi.getString("DELIVERY_YN");
				devlPtnCd	= rs_phi.getString("SATURDAY_YN");
				if (devltype.equals("Y") && devlPtnCd.equals("Y")) {
					devltype1	= "O";
					devltype2	= "O";

					data		+= "<address><![CDATA["+ zipcode +"]]>|<![CDATA["+ sidoNm +"]]>|<![CDATA["+ sigunguNm +"]]>|<![CDATA["+ gmbonNo +"]]>|<![CDATA["+ gmbuNo +"]]>|";
					data		+= "<![CDATA["+ gbbonNo +"]]>|<![CDATA["+ gbbuNo +"]]>|<![CDATA["+ gmNm +"]]>|<![CDATA["+ doroNm +"]]>|<![CDATA["+ omdNm +"]]>|<![CDATA["+ riNm +"]]></address>";

					cnt++;
				} else {
					devltype1	= "X";
					devltype2	= (sidoNm.equals("제주특별자치도"))? "X" : "O";

					data		+= "<address><![CDATA["+ zipcode +"]]>|<![CDATA["+ sidoNm +"]]>|<![CDATA["+ sigunguNm +"]]>|<![CDATA["+ gmbonNo +"]]>|<![CDATA["+ gmbuNo +"]]>|";
					data		+= "<![CDATA["+ gbbonNo +"]]>|<![CDATA["+ gbbuNo +"]]>|<![CDATA["+ gmNm +"]]>|<![CDATA["+ doroNm +"]]>|<![CDATA["+ omdNm +"]]>|<![CDATA["+ riNm +"]]></address>";

					if (!sidoNm.equals("제주특별자치도")) {
						cnt++;
					}
				}
			}
			
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
<%@ include file="/lib/dbclose_phi.jsp"%>