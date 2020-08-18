<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
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
String groupInfo		= ut.inject(multi.getParameter("group_info"));
String groupInfo1		= ut.inject(multi.getParameter("group_info1"));
String offerNotice		= multi.getParameter("offer_notice");
String cartImg			= ut.inject(multi.getParameter("org_cart_img"));
int kalInfo				= Integer.parseInt(multi.getParameter("kal_info"));
String delCartImg		= ut.inject(multi.getParameter("del_cart_img"));
String param			= ut.inject(multi.getParameter("param"));
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();
String[] arrTag			= multi.getParameterValues("tag");
String tag				= ",";
String listViewYn		= ut.inject(multi.getParameter("seen"));
String devlGoodsType			= ut.inject(multi.getParameter("devlGoodsType"));
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

String delGroupImg		= ut.inject(multi.getParameter("del_group_img"));
String groupImgM		= ut.inject(multi.getParameter("org_group_img"));
String groupImgP		= ut.inject(multi.getParameter("org_group_img"));

String[] infoNoticeId					= multi.getParameterValues("info_notice_id");
String[] infoNoticeTitle				= multi.getParameterValues("info_notice_title");
String[] infoNoticeContent				= multi.getParameterValues("info_notice_content");
String[] productNoticeId				= multi.getParameterValues("product_notice_id");
String[] productNoticeTitle				= multi.getParameterValues("product_notice_title");
String[] productNoticeContent			= multi.getParameterValues("product_notice_content");
String[] deliveryNoticeId				= multi.getParameterValues("delivery_notice_id");
String[] deliveryNoticeTitle			= multi.getParameterValues("delivery_notice_title");
String[] deliveryNoticeContent			= multi.getParameterValues("delivery_notice_content");

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
			query		+= "	(GUBUN1, GUBUN2, GROUP_CODE, GROUP_NAME, GROUP_INFO, GROUP_INFO1, OFFER_NOTICE, CART_IMG, INST_ID, INST_IP, INST_DATE, GROUP_PRICE, KAL_INFO, GROUP_IMGM, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, CATE_CODE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt		= conn.prepareStatement(query);
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
			pstmt.setInt(12, kalInfo);
			pstmt.setString(13, groupImgM);
			pstmt.setString(14, listViewYn);
			pstmt.setString(15, tag);
			pstmt.setString(16, devlGoodsType);
			pstmt.setString(17, devlFirstDay);
			pstmt.setString(18, devlModiDay);
			pstmt.setString(19, devlWeek3);
			pstmt.setString(20, devlWeek5);
			pstmt.setString(21, cateCode);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		ut.jsRedirect(out, "goods_group_list.jsp");
	}
	else if (mode.equals("upd")) {
		groupId		= Integer.parseInt(multi.getParameter("id"));
		
		
		try {
			query		= "UPDATE ESL_GOODS_GROUP SET ";
			//query		+= "	GUBUN1				= ?,";
			//query		+= "	GUBUN2				= ?,";
			//query		+= "	GROUP_CODE			= ?,";
			query		+= "	GROUP_NAME			= ?,";
			query		+= "	GROUP_INFO			= ?,";
			query		+= "	GROUP_INFO1			= ?,";
			query		+= "	OFFER_NOTICE		= ?,";
			query		+= "	CART_IMG			= ?,";
			query		+= "	GROUP_PRICE			= ?,";
			query		+= "	KAL_INFO			= ?,";
			query		+= "	GROUP_IMGM			= ?,";
			query		+= "	LIST_VIEW_YN		= ?,";
			query		+= "	TAG					= ?,";
			query		+= "	DEVL_GOODS_TYPE			= ?,";
			query		+= "	DEVL_FIRST_DAY		= ?,";
			query		+= "	DEVL_MODI_DAY		= ?,";
			query		+= "	DEVL_WEEK3			= ?,";
			query		+= "	DEVL_WEEK5			= ?,";
			query		+= "	CATE_CODE			= ?,";
			query		+= "	DISP_CATE_NAME	= ?,";
			query		+= "	DAY_EAT			= ?,";
			query		+= "	UPDT_ID				= ?,";
			query		+= "	UPDT_IP				= ?,";
			query		+= "	UPDT_DATE			= NOW()";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			//pstmt.setString(1, gubun1);
			//pstmt.setString(2, gubun2);
			//pstmt.setString(1, groupCode);
			pstmt.setString(1, groupName);
			pstmt.setString(2, groupInfo);
			pstmt.setString(3, groupInfo1);
			pstmt.setString(4, offerNotice);
			pstmt.setString(5, cartImg);
			pstmt.setInt(6, groupPrice);
			pstmt.setInt(7, kalInfo);
			pstmt.setString(8, groupImgM);
			pstmt.setString(9, listViewYn);
			pstmt.setString(10, tag);
			pstmt.setString(11, devlGoodsType);
			pstmt.setString(12, devlFirstDay);
			pstmt.setString(13, devlModiDay);
			pstmt.setString(14, devlWeek3);
			pstmt.setString(15, devlWeek5);
			pstmt.setString(16, cateCode);
			pstmt.setString(17, dispCateName);
			pstmt.setString(18, dayEat);
			pstmt.setString(19, instId);
			pstmt.setString(20, userIp);
			pstmt.setInt(21, groupId);
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