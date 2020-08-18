<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.awt.Toolkit" %>
<%@ page import="java.awt.Graphics" %>
<%@ page import="java.awt.Image" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="java.io.File"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");
String savePath			= uploadDir + "goods/"; // 저장할 디렉토리 (절대경로)
int sizeLimit			= 2 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());

String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));
int groupId				= 0;
String gubun1			= ut.inject(multi.getParameter("gubun1"));
String gubun2			= ut.inject(multi.getParameter("gubun2"));
String groupName		= ut.inject(multi.getParameter("group_name"));
String groupCode		= ut.inject(multi.getParameter("group_code"));
int groupPrice			= Integer.parseInt(multi.getParameter("group_price"));
int groupPrice1			= Integer.parseInt(multi.getParameter("group_price1"));
int groupPrice2			= Integer.parseInt(multi.getParameter("group_price2"));
int groupPrice3			= Integer.parseInt(multi.getParameter("group_price3"));
int groupPrice4			= Integer.parseInt(multi.getParameter("group_price4"));
String[] cateCodes		= multi.getParameterValues("cate_code");
String[] amounts		= multi.getParameterValues("amount");
String[] arrTag			= multi.getParameterValues("tag");
String tag				= ",";
String listViewYn		= ut.inject(multi.getParameter("seen"));
String devlGoodsType	= ut.inject(multi.getParameter("devlGoodsType"));
String devlFirstDay		= ut.inject(multi.getParameter("devlFirstDay"));
String devlModiDay		= ut.inject(multi.getParameter("devlModiDay"));
String devlWeek3		= ut.inject(multi.getParameter("devlWeek3"));
String devlWeek5		= ut.inject(multi.getParameter("devlWeek5"));
String cateCode			= ut.isnull(multi.getParameter("cateCode"));
String dispCateName		= ut.isnull(multi.getParameter("disp_cate_name"));
String dayEat			= ut.isnull(multi.getParameter("day_eat"));

if("".equals(devlGoodsType)) devlGoodsType = "0001";
if("".equals(devlFirstDay)) devlFirstDay = "0";
if("".equals(devlModiDay)) devlModiDay = "0";

int cateId				= 0;
String cateName			= "";
int amount				= 0;
String[] arrCate;
String groupInfo		= ut.inject(multi.getParameter("group_info"));
String groupInfo1		= ut.inject(multi.getParameter("group_info1"));
String offerNotice		= ut.inject(multi.getParameter("offer_notice"));
String cartImg			= ut.inject(multi.getParameter("org_cart_img"));
int kalInfo				= Integer.parseInt(multi.getParameter("kal_info"));
String delCartImg		= ut.inject(multi.getParameter("del_cart_img"));
String param			= ut.inject(multi.getParameter("param"));
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();
String delGroupImg		= ut.inject(multi.getParameter("del_group_img"));
String groupImgM		= ut.inject(multi.getParameter("org_group_img"));
String groupImgP		= ut.inject(multi.getParameter("org_group_img"));
String soldOut		    = multi.getParameter("cb_sold_out");	// 품절처리

String[] infoNoticeId					= multi.getParameterValues("info_notice_id");
String[] infoNoticeTitle				= multi.getParameterValues("info_notice_title");
String[] infoNoticeContent				= multi.getParameterValues("info_notice_content");
String[] productNoticeId				= multi.getParameterValues("product_notice_id");
String[] productNoticeTitle				= multi.getParameterValues("product_notice_title");
String[] productNoticeContent			= multi.getParameterValues("product_notice_content");
String[] deliveryNoticeId				= multi.getParameterValues("delivery_notice_id");
String[] deliveryNoticeTitle			= multi.getParameterValues("delivery_notice_title");
String[] deliveryNoticeContent			= multi.getParameterValues("delivery_notice_content");

/* 상품별 추천 상품 시작 */
ArrayList<String> list_code = new ArrayList<String>();
list_code.add(ut.inject(multi.getParameter("rec_prd_1")));
list_code.add(ut.inject(multi.getParameter("rec_prd_2")));
list_code.add(ut.inject(multi.getParameter("rec_prd_3")));
list_code.add(ut.inject(multi.getParameter("rec_prd_4")));
list_code.add(ut.inject(multi.getParameter("rec_prd_5")));
list_code.add(ut.inject(multi.getParameter("rec_prd_6")));

ArrayList<String> list_imgno = new ArrayList<String>();
list_imgno.add("1");
list_imgno.add("2");
list_imgno.add("3");
list_imgno.add("4");
list_imgno.add("5");
list_imgno.add("6");
/* 상품별 추천 상품 끝 */

if(arrTag != null){
	for(String str : arrTag){
		tag += str + ",";
	}
}
if(",".equals(tag)) tag = "";

if (mode != null) {

	//-- 상품 이미지 삭제
	if (delGroupImg.length() > 0) {
		File f1 = new File(savePath +"/"+groupImgM);
		if (f1.exists()) f1.delete();
		groupImgM		= "";
	}
	
	//-- 장바구니 이미지 삭제
	if (delCartImg.length() > 0) {
		File f1 = new File(savePath +"/"+cartImg);
		if (f1.exists()) f1.delete();
		cartImg		= "";
	}
	
	try {
		//--------------------------------------------
		long currentTime		= System.currentTimeMillis();
		SimpleDateFormat simDf	= new SimpleDateFormat("yyMMddHHmmss");
		int randomNumber		= (int)(Math.random()*100000);
		int dot					= 0;
		String ext				= "";
		String newFileName		= "";
		String rndText			= String.valueOf(randomNumber) + simDf.format(new Date(currentTime));
		File f1, newFile;
		//--------------------------------------------

		Enumeration formNames = multi.getFileNames();  // 폼의 이름 반환
		while (formNames.hasMoreElements()) {
			String formName		= (String)formNames.nextElement();
			String ufileName	= multi.getFilesystemName(formName); // 파일의 이름 얻기
			if (ufileName != null) {
				dot	= ufileName.lastIndexOf(".");
				if (dot != -1) {
					ext = ufileName.substring(dot);
				} else {
					ext = "";
				}
				f1	= new File(savePath +"/"+ ufileName);
				if(formName.equals("cart_img") ){
					newFileName = "groupCart_" + rndText + ext;
					cartImg = newFileName;
				}
				else if(formName.equals("group_img")){
					newFileName = "groupImgM_" + rndText + ext;
					groupImgM = newFileName;
				}
				if (f1.exists()){
					newFile = new File(savePath + "/"+ newFileName);
					f1.renameTo(newFile);
				}	
			}
		}
	} catch(Exception e) {
		out.print("파일 업로드 에러..! "+e+"<br>");
	}
	
	//-- 이미지를 같게 한다.
	cartImg = groupImgM;

	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO ESL_GOODS_GROUP";
			query		+= "	(GUBUN1, GUBUN2, GROUP_CODE, GROUP_NAME, GROUP_INFO, GROUP_INFO1, OFFER_NOTICE, CART_IMG, INST_ID, INST_IP, INST_DATE, GROUP_PRICE, GROUP_PRICE1, GROUP_PRICE2, GROUP_PRICE3, GROUP_PRICE4, KAL_INFO, GROUP_IMGM, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, CATE_CODE, SOLD_OUT)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, gubun1);
			pstmt.setString(2, gubun2);
			pstmt.setString(3, groupCode);
			pstmt.setString(4, groupName);
			pstmt.setString(5, groupInfo);
			pstmt.setString(6, groupInfo1);
			pstmt.setString(7, offerNotice);
			pstmt.setString(8, cartImg);
			pstmt.setString(9, instId);
			pstmt.setString(10, userIp);
			pstmt.setInt(11, groupPrice);
			pstmt.setInt(12, groupPrice1);
			pstmt.setInt(13, groupPrice2);
			pstmt.setInt(14, groupPrice3);
			pstmt.setInt(15, groupPrice4);
			pstmt.setInt(16, kalInfo);
			pstmt.setString(17, groupImgM);
			pstmt.setString(18, listViewYn);
			pstmt.setString(19, tag);
			pstmt.setString(20, devlGoodsType);
			pstmt.setString(21, devlFirstDay);
			pstmt.setString(22, devlModiDay);
			pstmt.setString(23, devlWeek3);
			pstmt.setString(24, devlWeek5);
			pstmt.setString(25, cateCode);
			pstmt.setString(26, soldOut);
			pstmt.executeUpdate();
			rs			= pstmt.getGeneratedKeys();

			if (rs.next()) {
				groupId		= rs.getInt(1);
			}
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (rs != null) try { rs.close(); } catch (Exception e) {}
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		if (cateCodes.length > 1) {
			for (i = 1; i < cateCodes.length; i++) {
				arrCate		= cateCodes[i].split("[|]");
				cateId		= Integer.parseInt(arrCate[0]);
				cateName	= ut.inject(arrCate[1]);
				amount		= Integer.parseInt(amounts[i]);

				try {
					query		= "INSERT INTO ESL_GOODS_GROUP_EXTEND";
					query		+= "	(GROUP_ID, CATEGORY_ID, CATEGORY_NAME, AMOUNT, GROUP_CODE)";
					query		+= " VALUES";
					query		+= "	(?, ?, ?, ?, ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, groupId);
					pstmt.setInt(2, cateId);
					pstmt.setString(3, cateName);
					pstmt.setInt(4, amount);
					pstmt.setString(5, groupCode);
					pstmt.executeUpdate();

				} catch (Exception e) {
					out.println(e);
					//ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
					//ut.jsBack(out);
					return;
				} finally {
					if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				}				
			}
		}
		
		//-- 상품정보 등록
		for(int ni = 0; ni < infoNoticeId.length; ni++){
			String noticeId			= infoNoticeId[ni];
			String noticeTitle		= infoNoticeTitle[ni];
			String noticeContent	= infoNoticeContent[ni];
			
			if(noticeTitle != null && !"".equals(noticeTitle) && noticeContent != null && !"".equals(noticeContent)){
				if("0".equals(noticeId)){
					query		= "INSERT INTO ESL_GOODS_GROUP_NOTICE";
					query		+= "	(NOTICE_TYPE, UPDATE_STAT, GOODS_GROUP_ID, NOTICE_TITLE, NOTICE_CONTENT, INST_ID, INST_IP, INST_DATE)";
					query		+= " VALUES";
					query		+= "	('INFO', 'Y', ?, ?, ?, ?, ?, NOW())";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, groupId);
					pstmt.setString(2, noticeTitle);
					pstmt.setString(3, noticeContent);
					pstmt.setString(4, instId);
					pstmt.setString(5, userIp);
					pstmt.executeUpdate();
				}
				else{
					query		= "UPDATE ESL_GOODS_GROUP_NOTICE SET";
					query		+= "	UPDATE_STAT='Y', NOTICE_TITLE=?, NOTICE_CONTENT=?, UPDT_ID=?, UPDT_IP=?, UPDT_DATE=NOW() ";
					query		+= " WHERE ID=?";
					pstmt		= conn.prepareStatement(query);
					pstmt.setString(1, noticeTitle);
					pstmt.setString(2, noticeContent);
					pstmt.setString(3, instId);
					pstmt.setString(4, userIp);
					pstmt.setString(5, noticeId);
					pstmt.executeUpdate();
				}
			}
		}
		//-- 상품고시 등록
		for(int ni = 0; ni < productNoticeId.length; ni++){
			String noticeTitle		= productNoticeTitle[ni];
			String noticeContent	= productNoticeContent[ni];			
			query		= "INSERT INTO ESL_GOODS_GROUP_NOTICE";
			query		+= "	(NOTICE_TYPE, UPDATE_STAT, GOODS_GROUP_ID, NOTICE_TITLE, NOTICE_CONTENT, INST_ID, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	('PRODUCT', 'Y', ?, ?, ?, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, groupId);
			pstmt.setString(2, noticeTitle);
			pstmt.setString(3, noticeContent);
			pstmt.setString(4, instId);
			pstmt.setString(5, userIp);
			pstmt.executeUpdate();
		}
		//-- 배송고시 등록
		for(int ni = 0; ni < deliveryNoticeId.length; ni++){
			String noticeTitle		= deliveryNoticeTitle[ni];
			String noticeContent	= deliveryNoticeContent[ni];			
			query		= "INSERT INTO ESL_GOODS_GROUP_NOTICE";
			query		+= "	(NOTICE_TYPE, UPDATE_STAT, GOODS_GROUP_ID, NOTICE_TITLE, NOTICE_CONTENT, INST_ID, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	('DELIVERY', 'Y', ?, ?, ?, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, groupId);
			pstmt.setString(2, noticeTitle);
			pstmt.setString(3, noticeContent);
			pstmt.setString(4, instId);
			pstmt.setString(5, userIp);
			pstmt.executeUpdate();
		}

		ut.jsRedirect(out, "goods_group_list.jsp");
	} else if (mode.equals("upd")) {
		groupId		= Integer.parseInt(multi.getParameter("id"));
		int rec_cnt = 0;

		/* 상품별 추천상품 시작 */
		//System.out.println("groupId: " + groupId);
		query		= " SELECT COUNT(*) AS CNT FROM ESL_GOODS_GROUP_RECIMG WHERE GROUP_SUB_ID = ? ";
		try {
			pstmt       = conn.prepareStatement(query);
			pstmt.setInt(1, groupId);
			rs    = pstmt.executeQuery();
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {
			rec_cnt   = rs.getInt("CNT");		
		}
		rs.close();

		if(rec_cnt > 0){

			query		= "DELETE FROM ESL_GOODS_GROUP_RECIMG WHERE GROUP_SUB_ID = ? ";
			try {
				pstmt       = conn.prepareStatement(query);
				pstmt.setInt(1, groupId);
				pstmt.executeUpdate();
				System.out.println("query1: " + query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
		}

		for(int j=0; j<list_code.size(); j++){
			//System.out.println("list_code.size(): " + list_code.size());
			//System.out.println("list_imgno.get(j): " + list_imgno.get(j));
			//System.out.println("list_code.get(j): " + list_code.get(j));
			try{
				query		 = " INSERT INTO ESL_GOODS_GROUP_RECIMG ";
				query		+= " (GROUP_SUB_ID, IMG_NO, GROUP_SUB_CODE) ";
				query		+= " VALUES ";
				query		+= " (?, ?, ?) ";
				pstmt       = conn.prepareStatement(query);
				pstmt.setInt(1, groupId);
				pstmt.setString(2, list_imgno.get(j));
				pstmt.setString(3, list_code.get(j));
				pstmt.executeUpdate();
				//System.out.println("query2: " + query);
			}catch (Exception e) {
				out.println(e);
				ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
				ut.jsBack(out);
				return;
			} finally {
				if (rs != null) try { rs.close(); } catch (Exception e) {}
				if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
			}
		}
		/* 상품별 추천상품 끝 */

		try {
			query		= "UPDATE ESL_GOODS_GROUP SET ";
			query		+= "	GROUP_NAME		= ?,";
			query		+= "	GROUP_INFO		= ?,";
			query		+= "	GROUP_INFO1		= ?,";
			query		+= "	OFFER_NOTICE	= ?,";
			query		+= "	CART_IMG		= ?,";
			query		+= "	GROUP_PRICE		= ?,";
			query		+= "	GROUP_PRICE1	= ?,";
			query		+= "	GROUP_PRICE2	= ?,";
			query		+= "	GROUP_PRICE3	= ?,";
			query		+= "	GROUP_PRICE4	= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	KAL_INFO		= ?,";
			query		+= "	GROUP_IMGM		= ?,";
			query		+= "	LIST_VIEW_YN	= ?,";
			query		+= "	TAG				= ?,";
			query		+= "	DEVL_GOODS_TYPE	= ?,";
			query		+= "	DEVL_FIRST_DAY	= ?,";
			query		+= "	DEVL_MODI_DAY	= ?,";
			query		+= "	DEVL_WEEK3		= ?,";
			query		+= "	DEVL_WEEK5		= ?,";
			query		+= "	CATE_CODE		= ?,";
			query		+= "	DISP_CATE_NAME	= ?,";
			query		+= "	DAY_EAT			= ?,";
			query		+= "	UPDT_DATE		= NOW(),";
			query       += "    SOLD_OUT        =?";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, groupName);
			pstmt.setString(2, groupInfo);
			pstmt.setString(3, groupInfo1);
			pstmt.setString(4, offerNotice);
			pstmt.setString(5, cartImg);
			pstmt.setInt(6, groupPrice);
			pstmt.setInt(7, groupPrice1);
			pstmt.setInt(8, groupPrice2);
			pstmt.setInt(9, groupPrice3);
			pstmt.setInt(10, groupPrice4);
			pstmt.setString(11, instId);
			pstmt.setString(12, userIp);
			pstmt.setInt(13, kalInfo);
			pstmt.setString(14, groupImgM);
			pstmt.setString(15, listViewYn);
			pstmt.setString(16, tag);
			pstmt.setString(17, devlGoodsType);
			pstmt.setString(18, devlFirstDay);
			pstmt.setString(19, devlModiDay);
			pstmt.setString(20, devlWeek3);
			pstmt.setString(21, devlWeek5);
			pstmt.setString(22, cateCode);
			pstmt.setString(23, dispCateName);
			pstmt.setString(24, dayEat);
			pstmt.setString(25, soldOut);
			pstmt.setInt(26, groupId);
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (rs != null) try { rs.close(); } catch (Exception e) {}
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		query		= "DELETE FROM ESL_GOODS_GROUP_EXTEND WHERE GROUP_ID = "+ groupId;
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		query		= " SELECT SOLD_OUT FROM ESL_GOODS_GROUP WHERE ID = " + groupId;
		try {
			rs		= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {
			soldOut   = rs.getString("SOLD_OUT");		
		}
		rs.close();

		if(soldOut.equals("Y")){// 모든 회원 장바구니에서 품절된 상품 삭제
			query		= " DELETE FROM ESL_CART WHERE GROUP_ID = " + groupId;
			try {
				stmt.executeUpdate(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
		}

		if (cateCodes.length > 1) {
			for (i = 1; i < cateCodes.length; i++) {
				arrCate		= cateCodes[i].split("[|]");
				cateId		= Integer.parseInt(arrCate[0]);
				cateName	= ut.inject(arrCate[1]);
				amount		= Integer.parseInt(amounts[i]);

				try {
					query		= "INSERT INTO ESL_GOODS_GROUP_EXTEND";
					query		+= "	(GROUP_ID, CATEGORY_ID, CATEGORY_NAME, AMOUNT, GROUP_CODE)";
					query		+= " VALUES";
					query		+= "	(?, ?, ?, ?, ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, groupId);
					pstmt.setInt(2, cateId);
					pstmt.setString(3, cateName);
					pstmt.setInt(4, amount);
					pstmt.setString(5, groupCode);
					pstmt.executeUpdate();

				} catch (Exception e) {
					out.println(e);
					//ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
					//ut.jsBack(out);
					return;
				} finally {
					if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				}				
			}
		}
		
		//-- 수정 상태 변경
		query		 = "UPDATE ESL_GOODS_GROUP_NOTICE SET UPDATE_STAT='N' WHERE GOODS_GROUP_ID=?";
		pstmt		= conn.prepareStatement(query);
		pstmt.setInt(1, groupId);
		pstmt.executeUpdate();
		
		//-- 상품정보 등록
		for(int ni = 0; ni < infoNoticeId.length; ni++){
			String noticeId			= infoNoticeId[ni];
			String noticeTitle		= infoNoticeTitle[ni];
			String noticeContent	= infoNoticeContent[ni];
			
			if(noticeTitle != null && !"".equals(noticeTitle) && noticeContent != null && !"".equals(noticeContent)){
				if("0".equals(noticeId)){
					query		= "INSERT INTO ESL_GOODS_GROUP_NOTICE";
					query		+= "	(NOTICE_TYPE, UPDATE_STAT, GOODS_GROUP_ID, NOTICE_TITLE, NOTICE_CONTENT, INST_ID, INST_IP, INST_DATE)";
					query		+= " VALUES";
					query		+= "	('INFO', 'Y', ?, ?, ?, ?, ?, NOW())";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, groupId);
					pstmt.setString(2, noticeTitle);
					pstmt.setString(3, noticeContent);
					pstmt.setString(4, instId);
					pstmt.setString(5, userIp);
					pstmt.executeUpdate();
				}
				else{
					query		= "UPDATE ESL_GOODS_GROUP_NOTICE SET";
					query		+= "	UPDATE_STAT='Y', NOTICE_TITLE=?, NOTICE_CONTENT=?, UPDT_ID=?, UPDT_IP=?, UPDT_DATE=NOW() ";
					query		+= " WHERE ID=?";
					pstmt		= conn.prepareStatement(query);
					pstmt.setString(1, noticeTitle);
					pstmt.setString(2, noticeContent);
					pstmt.setString(3, instId);
					pstmt.setString(4, userIp);
					pstmt.setString(5, noticeId);
					pstmt.executeUpdate();
				}
			}
		}
		
		//-- 상품고시 등록
		for(int ni = 0; ni < productNoticeId.length; ni++){
			String noticeId			= productNoticeId[ni];
			String noticeTitle		= productNoticeTitle[ni];
			String noticeContent	= productNoticeContent[ni];
			
			if(noticeTitle != null && !"".equals(noticeTitle) && noticeContent != null && !"".equals(noticeContent)){
				if("0".equals(noticeId)){
					query		= "INSERT INTO ESL_GOODS_GROUP_NOTICE";
					query		+= "	(NOTICE_TYPE, UPDATE_STAT, GOODS_GROUP_ID, NOTICE_TITLE, NOTICE_CONTENT, INST_ID, INST_IP, INST_DATE)";
					query		+= " VALUES";
					query		+= "	('PRODUCT', 'Y', ?, ?, ?, ?, ?, NOW())";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, groupId);
					pstmt.setString(2, noticeTitle);
					pstmt.setString(3, noticeContent);
					pstmt.setString(4, instId);
					pstmt.setString(5, userIp);
					pstmt.executeUpdate();
				}
				else{
					query		= "UPDATE ESL_GOODS_GROUP_NOTICE SET";
					query		+= "	UPDATE_STAT='Y', NOTICE_TITLE=?, NOTICE_CONTENT=?, UPDT_ID=?, UPDT_IP=?, UPDT_DATE=NOW() ";
					query		+= " WHERE ID=?";
					pstmt		= conn.prepareStatement(query);
					pstmt.setString(1, noticeTitle);
					pstmt.setString(2, noticeContent);
					pstmt.setString(3, instId);
					pstmt.setString(4, userIp);
					pstmt.setString(5, noticeId);
					pstmt.executeUpdate();
				}
			}
		}
		//-- 배송고시 등록
		for(int ni = 0; ni < deliveryNoticeId.length; ni++){
			String noticeId			= deliveryNoticeId[ni];
			String noticeTitle		= deliveryNoticeTitle[ni];
			String noticeContent	= deliveryNoticeContent[ni];
			if(noticeTitle != null && !"".equals(noticeTitle) && noticeContent != null && !"".equals(noticeContent)){
				if("0".equals(noticeId)){
					query		= "INSERT INTO ESL_GOODS_GROUP_NOTICE";
					query		+= "	(NOTICE_TYPE, UPDATE_STAT, GOODS_GROUP_ID, NOTICE_TITLE, NOTICE_CONTENT, INST_ID, INST_IP, INST_DATE)";
					query		+= " VALUES";
					query		+= "	('DELIVERY', 'Y', ?, ?, ?, ?, ?, NOW())";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, groupId);
					pstmt.setString(2, noticeTitle);
					pstmt.setString(3, noticeContent);
					pstmt.setString(4, instId);
					pstmt.setString(5, userIp);
					pstmt.executeUpdate();
				}
				else{
					query		= "UPDATE ESL_GOODS_GROUP_NOTICE SET";
					query		+= "	UPDATE_STAT='Y', NOTICE_TITLE=?, NOTICE_CONTENT=?, UPDT_ID=?, UPDT_IP=?, UPDT_DATE=NOW() ";
					query		+= " WHERE ID=?";
					pstmt		= conn.prepareStatement(query);
					pstmt.setString(1, noticeTitle);
					pstmt.setString(2, noticeContent);
					pstmt.setString(3, instId);
					pstmt.setString(4, userIp);
					pstmt.setString(5, noticeId);
					pstmt.executeUpdate();
				}
			}
		}
		
		//-- 남아 있는것 삭제
		query		 = "DELETE FROM ESL_GOODS_GROUP_NOTICE WHERE UPDATE_STAT='N' AND GOODS_GROUP_ID=?";
		pstmt		= conn.prepareStatement(query);
		pstmt.setInt(1, groupId);
		pstmt.executeUpdate();
		
		ut.jsRedirect(out, "goods_group_list.jsp?"+ param);
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>