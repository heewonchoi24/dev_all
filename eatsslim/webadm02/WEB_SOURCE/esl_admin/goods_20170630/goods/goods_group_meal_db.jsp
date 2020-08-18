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
//out.println("savePath="+savePath);if(true)return;

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
int cateId				= 0;
String cateName			= "";
int amount				= 0;
String[] arrCate;
String groupInfo		= ut.inject(multi.getParameter("group_info"));
String offerNotice		= ut.inject(multi.getParameter("offer_notice"));
String cartImg			= ut.inject(multi.getParameter("org_cart_img"));
String delCartImg		= ut.inject(multi.getParameter("del_cart_img"));
String param			= ut.inject(multi.getParameter("param"));
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();

if (mode != null) {
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

				if(formName.equals("cart_img")){					
					newFileName = "groupCart_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					cartImg	= newFileName;
				}
			}
		}
	} catch(Exception e) {
		out.print("파일 업로드 에러..! "+e+"<br>");
	}

	if (delCartImg.length() > 0) {
		File f1 = new File(savePath+cartImg);
		if (f1.exists()) f1.delete();
		cartImg		= "";
	}

	if (mode.equals("ins")) {
		try {
			query		= "INSERT INTO ESL_GOODS_GROUP";
			query		+= "	(GUBUN1, GUBUN2, GROUP_CODE, GROUP_NAME, GROUP_INFO, OFFER_NOTICE, CART_IMG, INST_ID, INST_IP, INST_DATE, GROUP_PRICE, GROUP_PRICE1, GROUP_PRICE2, GROUP_PRICE3, GROUP_PRICE4)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?, ?, ?)";
			pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, gubun1);
			pstmt.setString(2, gubun2);
			pstmt.setString(3, groupCode);
			pstmt.setString(4, groupName);
			pstmt.setString(5, groupInfo);
			pstmt.setString(6, offerNotice);
			pstmt.setString(7, cartImg);
			pstmt.setString(8, instId);
			pstmt.setString(9, userIp);
			pstmt.setInt(10, groupPrice);
			pstmt.setInt(11, groupPrice1);
			pstmt.setInt(12, groupPrice2);
			pstmt.setInt(13, groupPrice3);
			pstmt.setInt(14, groupPrice4);
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

		ut.jsRedirect(out, "goods_group_list.jsp");
	} else if (mode.equals("upd")) {
		groupId		= Integer.parseInt(multi.getParameter("id"));

		try {
			query		= "UPDATE ESL_GOODS_GROUP SET ";
			query		+= "	GROUP_INFO		= ?,";
			query		+= "	OFFER_NOTICE	= ?,";
			query		+= "	CART_IMG		= ?,";
			query		+= "	GROUP_PRICE		= ?,";
			query		+= "	GROUP_PRICE1	= ?,";
			query		+= "	GROUP_PRICE2	= ?,";
			query		+= "	GROUP_PRICE3	= ?,";
			query		+= "	GROUP_PRICE4	= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, groupInfo);
			pstmt.setString(2, offerNotice);
			pstmt.setString(3, cartImg);
			pstmt.setInt(4, groupPrice);
			pstmt.setInt(5, groupPrice1);
			pstmt.setInt(6, groupPrice2);
			pstmt.setInt(7, groupPrice3);
			pstmt.setInt(8, groupPrice4);
			pstmt.setString(9, instId);
			pstmt.setString(10, userIp);
			pstmt.setInt(11, groupId);
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

		ut.jsRedirect(out, "goods_group_list.jsp?"+ param);
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>