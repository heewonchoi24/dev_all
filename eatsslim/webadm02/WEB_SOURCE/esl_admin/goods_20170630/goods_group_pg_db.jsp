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
String gubun3			= ut.inject(multi.getParameter("gubun3"));
String groupName		= ut.inject(multi.getParameter("group_name"));
String groupCode		= gubun1 + gubun2 + gubun3;
int groupPrice			= Integer.parseInt(multi.getParameter("group_price"));
String groupInfo		= ut.inject(multi.getParameter("group_info"));
String offerNotice		= ut.inject(multi.getParameter("offer_notice"));
String cartImg			= "";
String delCartImg		= "";
String itemCode			= "";
String itemName			= "";
int itemPrice			= 0;
String[] itemCodes		= multi.getParameterValues("item_code");
String[] itemNames		= multi.getParameterValues("item_name");
String[] itemPrices		= multi.getParameterValues("item_price");
String param			= ut.inject(multi.getParameter("param"));
String instId			= (String)session.getAttribute("esl_admin_id");
String userIp			= request.getRemoteAddr();
String itemType			= "";
int maxI				= 0;

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
			query		+= "	(GUBUN1, GUBUN2, GUBUN3, GROUP_CODE, GROUP_NAME, GROUP_INFO, OFFER_NOTICE, CART_IMG, INST_ID, INST_IP, INST_DATE, GROUP_PRICE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";
			pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, gubun1);
			pstmt.setString(2, gubun2);
			pstmt.setString(3, gubun3);
			pstmt.setString(4, groupCode);
			pstmt.setString(5, groupName);
			pstmt.setString(6, groupInfo);
			pstmt.setString(7, offerNotice);
			pstmt.setString(8, cartImg);
			pstmt.setString(9, instId);
			pstmt.setString(10, userIp);
			pstmt.setInt(11, groupPrice);
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
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		maxI		= Integer.parseInt(gubun3) * 2;

		for (i = 0; i < maxI; i++) {
			itemCode		= itemCodes[i];
			itemName		= itemNames[i];
			itemPrice		= Integer.parseInt(itemPrices[i]);
			itemType		= (i % 2 == 0)? "D" : "W";

			query	= "INSERT INTO ESL_GOODS_GROUP_PRICE ";
			query	+= "	(GROUP_ID, ITEM_CODE, ITEM_NAME, ITEM_PRICE, ITEM_TYPE)";
			query	+= " VALUES ("+ groupId +", '"+ itemCode +"', '"+ itemName +"',";
			query	+= itemPrice +", '"+ itemType +"')";
			try {
				stmt.executeUpdate(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				//ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
				//ut.jsBack(out);
				if(true)return;
			}
			
		}
		ut.jsRedirect(out, "goods_group_list.jsp");
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>