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
String setName			= ut.inject(multi.getParameter("set_name"));
String setCode			= ut.inject(multi.getParameter("set_code"));
int setPrice			= Integer.parseInt(multi.getParameter("set_price"));
int cateId				= Integer.parseInt(multi.getParameter("cate_code"));
String setInfo			= ut.inject(multi.getParameter("set_info"));
int setId				= 0;
String portionSize		= ut.inject(multi.getParameter("portion_size"));
String calorie			= ut.inject(multi.getParameter("calorie"));
String carbohydrateG	= ut.inject(multi.getParameter("carbohydrate_g"));
String carbohydrateP	= ut.inject(multi.getParameter("carbohydrate_p"));
String sugarG			= ut.inject(multi.getParameter("sugar_g"));
String sugarP			= ut.inject(multi.getParameter("sugar_p"));
String proteinG			= ut.inject(multi.getParameter("protein_g"));
String proteinP			= ut.inject(multi.getParameter("protein_p"));
String fatG				= ut.inject(multi.getParameter("fat_g"));
String fatP				= ut.inject(multi.getParameter("fat_p"));
String saturatedFatG	= ut.inject(multi.getParameter("saturated_fat_g"));
String saturatedFatP	= ut.inject(multi.getParameter("saturated_fat_p"));
String transFatG		= ut.inject(multi.getParameter("trans_fat_g"));
String transFatP		= ut.inject(multi.getParameter("trans_fat_p"));
String cholesterolG		= ut.inject(multi.getParameter("cholesterol_g"));
String cholesterolP		= ut.inject(multi.getParameter("cholesterol_p"));
String natriumG			= ut.inject(multi.getParameter("natrium_g"));
String natriumP			= ut.inject(multi.getParameter("natrium_p"));
String makeDate			= ut.inject(multi.getParameter("make_date"));
String thumbImg			= ut.inject(multi.getParameter("org_thumb_img"));
String bigImg			= ut.inject(multi.getParameter("org_big_img"));
String delThumbImg		= ut.inject(multi.getParameter("del_thumb_img"));
String delBigImg		= ut.inject(multi.getParameter("del_big_img"));
String[] etcNames		= multi.getParameterValues("etc_name");
String[] etcContents	= multi.getParameterValues("etc_content");
String[] etcPercents	= multi.getParameterValues("etc_percent");
String[] prdtNames		= multi.getParameterValues("prdt_name");
String[] prdtTypes		= multi.getParameterValues("prdt_type");
String[] producers		= multi.getParameterValues("producer");
String[] rawMaterials	= multi.getParameterValues("raw_materials");
String etcName			= "";
String etcContent		= "";
String etcPercent		= "";
String prdtName			= "";
String prdtType			= "";
String producer			= "";
String rawMaterial		= "";
String bigo				= ut.inject(multi.getParameter("bigo"));
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

				if(formName.equals("thumb_img")){					
					newFileName = "setThumnb_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					thumbImg	= newFileName;
				}

				if (formName.equals("big_img")) {
					newFileName = "setBig_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					bigImg	= newFileName;
				}
			}
		}
	} catch(Exception e) {
		out.print("파일 업로드 에러..! "+e+"<br>");
	}

	if (delThumbImg.length() > 0) {
		File f1 = new File(savePath+thumbImg);
		if (f1.exists()) f1.delete();
		thumbImg		= "";
	}
	if (delBigImg.length() > 0) {
		File f1 = new File(savePath+bigImg);
		if (f1.exists()) f1.delete();
		bigImg			= "";
	}

	if (mode.equals("ins")) {
		try {
			query		= "UPDATE ESL_GOODS_CATEGORY SET ";
			query		+= "			GOODS_SET_CNT = GOODS_SET_CNT + 1";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, cateId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		try {
			query		= "INSERT INTO ESL_GOODS_SET";
			query		+= "	(CATEGORY_ID, SET_CODE, SET_NAME, SET_PRICE, SET_INFO, MAKE_DATE, THUMB_IMG, BIG_IMG, BIGO, INST_ID, INST_IP, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
			pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, cateId);
			pstmt.setString(2, setCode);
			pstmt.setString(3, setName);
			pstmt.setInt(4, setPrice);
			pstmt.setString(5, setInfo);
			pstmt.setString(6, makeDate);
			pstmt.setString(7, thumbImg);
			pstmt.setString(8, bigImg);
			pstmt.setString(9, bigo);
			pstmt.setString(10, instId);
			pstmt.setString(11, userIp);
			pstmt.executeUpdate();

			rs			= pstmt.getGeneratedKeys();
			if (rs.next()) {
				setId		= rs.getInt(1);
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

		try {
			query		= "INSERT INTO ESL_GOODS_SET_CONTENT";
			query		+= "	(SET_ID, PORTION_SIZE, CALORIE, CARBOHYDRATE_G, CARBOHYDRATE_P, SUGAR_G, SUGAR_P,";
			query		+= "	PROTEIN_G, PROTEIN_P, FAT_G, FAT_P, SATURATED_FAT_G, SATURATED_FAT_P, TRANS_FAT_G, TRANS_FAT_P,";
			query		+= "	CHOLESTEROL_G, CHOLESTEROL_P, NATRIUM_G, NATRIUM_P)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, setId);
			pstmt.setString(2, portionSize);
			pstmt.setString(3, calorie);
			pstmt.setString(4, carbohydrateG);
			pstmt.setString(5, carbohydrateP);
			pstmt.setString(6, sugarG);
			pstmt.setString(7, sugarP);
			pstmt.setString(8, proteinG);
			pstmt.setString(9, proteinP);
			pstmt.setString(10, fatG);
			pstmt.setString(11, fatP);
			pstmt.setString(12, saturatedFatG);
			pstmt.setString(13, saturatedFatP);
			pstmt.setString(14, transFatG);
			pstmt.setString(15, transFatP);
			pstmt.setString(16, cholesterolG);
			pstmt.setString(17, cholesterolP);
			pstmt.setString(18, natriumG);
			pstmt.setString(19, natriumP);
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		if (etcNames.length > 1) {
			for (i = 1; i < etcNames.length; i++) {
				etcName		= ut.inject(etcNames[i]);
				etcContent	= ut.inject(etcContents[i]);
				etcPercent	= ut.inject(etcPercents[i]);

				try {
					query		= "INSERT INTO ESL_GOODS_SET_CONTENT_EXTEND";
					query		+= "	(SET_ID, ETC_NAME, ETC_CONTENT, ETC_PERCENT)";
					query		+= " VALUES";
					query		+= "	(?, ?, ?, ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, setId);
					pstmt.setString(2, etcName);
					pstmt.setString(3, etcContent);
					pstmt.setString(4, etcPercent);
					pstmt.executeUpdate();

				} catch (Exception e) {
					//out.println(e);
					ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
					ut.jsBack(out);
					return;
				} finally {
					if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				}				
			}
		}

		if (prdtNames.length > 1) {
			for (i = 1; i < prdtNames.length; i++) {
				prdtName	= ut.inject(prdtNames[i]);
				prdtType	= ut.inject(prdtTypes[i]);
				producer	= ut.inject(producers[i]);
				rawMaterial	= ut.inject(rawMaterials[i]);

				try {
					query		= "INSERT INTO ESL_GOODS_SET_ORIGIN";
					query		+= "	(SET_ID, PRDT_NAME, PRDT_TYPE, PRODUCER, RAW_MATERIALS)";
					query		+= " VALUES";
					query		+= "	(?, ?, ?, ?, ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, setId);
					pstmt.setString(2, prdtName);
					pstmt.setString(3, prdtType);
					pstmt.setString(4, producer);
					pstmt.setString(5, rawMaterial);
					pstmt.executeUpdate();

				} catch (Exception e) {
					//out.println(e);
					ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
					ut.jsBack(out);
					return;
				} finally {
					if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				}				
			}
		}

		ut.jsRedirect(out, "goods_set_list.jsp");
	} else if (mode.equals("upd")) {
		setId		= Integer.parseInt(multi.getParameter("id"));

		try {
			query		= "UPDATE ESL_GOODS_SET SET ";
			query		+= "	CATEGORY_ID		= ?,";
			query		+= "	SET_CODE		= ?,";
			query		+= "	SET_NAME		= ?,";
			query		+= "	SET_PRICE		= ?,";
			query		+= "	SET_INFO		= ?,";
			query		+= "	MAKE_DATE		= ?,";
			query		+= "	THUMB_IMG		= ?,";
			query		+= "	BIG_IMG			= ?,";
			query		+= "	BIGO			= ?,";
			query		+= "	UPDT_ID			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW()";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, cateId);
			pstmt.setString(2, setCode);
			pstmt.setString(3, setName);
			pstmt.setInt(4, setPrice);
			pstmt.setString(5, setInfo);
			pstmt.setString(6, makeDate);
			pstmt.setString(7, thumbImg);
			pstmt.setString(8, bigImg);
			pstmt.setString(9, bigo);
			pstmt.setString(10, instId);
			pstmt.setString(11, userIp);
			pstmt.setInt(12, setId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		try {
			query		= "UPDATE  ESL_GOODS_SET_CONTENT SET ";
			query		+= "	PORTION_SIZE		= ?,";
			query		+= "	CALORIE				= ?,";
			query		+= "	CARBOHYDRATE_G		= ?,";
			query		+= "	CARBOHYDRATE_P		= ?,";
			query		+= "	SUGAR_G				= ?,";
			query		+= "	SUGAR_P				= ?,";
			query		+= "	PROTEIN_G			= ?,";
			query		+= "	PROTEIN_P			= ?,";
			query		+= "	FAT_G				= ?,";
			query		+= "	FAT_P				= ?,";
			query		+= "	SATURATED_FAT_G		= ?,";
			query		+= "	SATURATED_FAT_P		= ?,";
			query		+= "	TRANS_FAT_G			= ?,";
			query		+= "	TRANS_FAT_P			= ?,";
			query		+= "	CHOLESTEROL_G		= ?,";
			query		+= "	CHOLESTEROL_P		= ?,";
			query		+= "	NATRIUM_G			= ?,";
			query		+= "	NATRIUM_P			= ?";
			query		+= " WHERE SET_ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, portionSize);
			pstmt.setString(2, calorie);
			pstmt.setString(3, carbohydrateG);
			pstmt.setString(4, carbohydrateP);
			pstmt.setString(5, sugarG);
			pstmt.setString(6, sugarP);
			pstmt.setString(7, proteinG);
			pstmt.setString(8, proteinP);
			pstmt.setString(9, fatG);
			pstmt.setString(10, fatP);
			pstmt.setString(11, saturatedFatG);
			pstmt.setString(12, saturatedFatP);
			pstmt.setString(13, transFatG);
			pstmt.setString(14, transFatP);
			pstmt.setString(15, cholesterolG);
			pstmt.setString(16, cholesterolP);
			pstmt.setString(17, natriumG);
			pstmt.setString(18, natriumP);
			pstmt.setInt(19, setId);
			pstmt.executeUpdate();

		} catch (Exception e) {
			//out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		try {
			query		= "DELETE FROM ESL_GOODS_SET_CONTENT_EXTEND WHERE SET_ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, setId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		if (etcNames.length > 1) {
			for (i = 1; i < etcNames.length; i++) {
				etcName		= ut.inject(etcNames[i]);
				etcContent	= ut.inject(etcContents[i]);
				etcPercent	= ut.inject(etcPercents[i]);

				try {
					query		= "INSERT INTO ESL_GOODS_SET_CONTENT_EXTEND";
					query		+= "	(SET_ID, ETC_NAME, ETC_CONTENT, ETC_PERCENT)";
					query		+= " VALUES";
					query		+= "	(?, ?, ?, ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, setId);
					pstmt.setString(2, etcName);
					pstmt.setString(3, etcContent);
					pstmt.setString(4, etcPercent);
					pstmt.executeUpdate();

				} catch (Exception e) {
					//out.println(e);
					ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
					ut.jsBack(out);
					return;
				} finally {
					if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				}				
			}
		}

		try {
			query		= "DELETE FROM ESL_GOODS_SET_ORIGIN WHERE SET_ID = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setInt(1, setId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
		}

		if (prdtNames.length > 1) {
			for (i = 1; i < prdtNames.length; i++) {
				prdtName	= ut.inject(prdtNames[i]);
				prdtType	= ut.inject(prdtTypes[i]);
				producer	= ut.inject(producers[i]);
				rawMaterial	= ut.inject(rawMaterials[i]);

				try {
					query		= "INSERT INTO ESL_GOODS_SET_ORIGIN";
					query		+= "	(SET_ID, PRDT_NAME, PRDT_TYPE, PRODUCER, RAW_MATERIALS)";
					query		+= " VALUES";
					query		+= "	(?, ?, ?, ?, ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, setId);
					pstmt.setString(2, prdtName);
					pstmt.setString(3, prdtType);
					pstmt.setString(4, producer);
					pstmt.setString(5, rawMaterial);
					pstmt.executeUpdate();

				} catch (Exception e) {
					//out.println(e);
					ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
					ut.jsBack(out);
					return;
				} finally {
					if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				}				
			}
		}

		ut.jsRedirect(out, "goods_set_list.jsp?"+ param);
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>