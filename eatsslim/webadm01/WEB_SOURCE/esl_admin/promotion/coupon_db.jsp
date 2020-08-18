<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.lang.reflect.Method"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../lib/dbconn_mssql.jsp"%>
<%!
public String getCellContents(HSSFCell cell) {
    String str = "";
    switch(cell.getCellType()) {
        case HSSFCell.CELL_TYPE_STRING :
            str = cell.getStringCellValue();
            break;
        case HSSFCell.CELL_TYPE_NUMERIC :
            str = Integer.toString((int)cell.getNumericCellValue()).trim();
            break;
        case HSSFCell.CELL_TYPE_BOOLEAN :
            str	= (cell.getBooleanCellValue()+"").trim();
            break;
        case HSSFCell.CELL_TYPE_FORMULA :
            str = cell.getCellFormula().trim();
            break;
        default:
            str = "";
    }
    return str;
}
%>
<%
request.setCharacterEncoding("euc-kr");

String savePath			= uploadDir + "excel/"; // 저장할 디렉토리 (절대경로)
int sizeLimit			= 2 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_COUPON";
String query			= "";
String query1			= "";
Statement stmt1			= null;
stmt1					= conn.createStatement();
String mode				= ut.inject(multi.getParameter("mode"));
int couponId			= 0;
String memberYn			= ut.inject(multi.getParameter("member_yn"));
String memberType		= ut.inject(multi.getParameter("member_type"));
String memberIds[]		= multi.getParameterValues("sel_member");
String memberId			= "";
String couponName		= ut.inject(multi.getParameter("coupon_name"));
String couponType		= ut.inject(multi.getParameter("coupon_type"));
String kwpYn			= ut.inject(multi.getParameter("kwp_yn"));
String stdate			= ut.inject(multi.getParameter("stdate"));
String ltdate			= ut.inject(multi.getParameter("ltdate"));
String vendor			= ut.inject(multi.getParameter("vendor"));
String saleType			= ut.inject(multi.getParameter("sale_type"));
int salePrice1			= 0;
int salePrice2			= 0;
int salePrice			= 0;
String saleUseYn		= ut.inject(multi.getParameter("sale_use_yn"));
int useLimitCnt			= 0;
int useLimitPrice		= 0;
String useGoods			= ut.inject(multi.getParameter("use_goods"));
String[] groupArr;
String groupCodes[]		= multi.getParameterValues("group_code");
String groupCode		= "";
String groupNames[]		= multi.getParameterValues("group_name");
String groupName		= "";
int maxCoponCnt			= 0;
String randNumType = multi.getParameter("rand_type");
String imsinum			= "";
int chkCnt				= 0;
SimpleDateFormat dt		= new SimpleDateFormat("yyMMddHHmmss");
String num				= "";
String couponNum		= "";
String tmpNum			= "";
String param			= ut.inject(multi.getParameter("param"));
String delIds			= "";
String upfile			= "";
String instId			= (String)session.getAttribute("esl_admin_id");
int rows				= 0;
String userIp			= request.getRemoteAddr();
if (multi.getParameter("sale_price1") != null && multi.getParameter("sale_price1").length()>0)
	salePrice1		= Integer.parseInt(multi.getParameter("sale_price1"));
if (multi.getParameter("sale_price2") != null && multi.getParameter("sale_price2").length()>0)
	salePrice2		= Integer.parseInt(multi.getParameter("sale_price2"));
salePrice		= (saleType.equals("P"))? salePrice1 : salePrice2;
if (multi.getParameter("use_limit_cnt") != null && multi.getParameter("use_limit_cnt").length()>0)
	useLimitCnt		= Integer.parseInt(multi.getParameter("use_limit_cnt"));
if (multi.getParameter("use_limit_price") != null && multi.getParameter("use_limit_price").length()>0)
	useLimitPrice	= Integer.parseInt(multi.getParameter("use_limit_price"));
if (multi.getParameter("max_coupon_cnt") != null && multi.getParameter("max_coupon_cnt").length()>0)
	maxCoponCnt		= Integer.parseInt(multi.getParameter("max_coupon_cnt"));

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

				if(formName.equals("upfile")){
					newFileName = "eventExcel_" + rndText + ext;
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //파일명을 변경
					}
					upfile	= newFileName;
				}
			}
		}
	} catch(Exception e) {
		out.print("파일 업로드 에러..! "+e+"<br>");
	}
	
	if (mode.equals("ins")) {
		query		= "INSERT INTO "+ table;
		query		+= "	(COUPON_NAME, COUPON_TYPE, STDATE, LTDATE, VENDOR, SALE_TYPE, SALE_PRICE, SALE_USE_YN, USE_LIMIT_CNT,";
		query		+= "	USE_LIMIT_PRICE, USE_GOODS, MAX_COUPON_CNT, INST_ID, INST_IP, INST_DATE, RAND_NUM_TYPE)";
		query		+= " VALUES";
		query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";
		pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		pstmt.setString(1, couponName);
		pstmt.setString(2, couponType);
		pstmt.setString(3, stdate);
		pstmt.setString(4, ltdate);
		pstmt.setString(5, vendor);
		pstmt.setString(6, saleType);
		pstmt.setInt(7, salePrice);
		pstmt.setString(8, saleUseYn);
		pstmt.setInt(9, useLimitCnt);
		pstmt.setInt(10, useLimitPrice);
		pstmt.setString(11, useGoods);
		pstmt.setInt(12, maxCoponCnt);
		pstmt.setString(13, instId);
		pstmt.setString(14, userIp);
		pstmt.setString(15, randNumType);
		pstmt.executeUpdate();		
		try {
			rs			= pstmt.getGeneratedKeys();
			if (rs.next()) {
				couponId		= rs.getInt(1);
			}
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}
		rs.close();

		if (couponType.equals("01")) {
			if (memberYn.equals("Y")) {
				if (kwpYn.equals("Y")) {
					query		= "DELETE FROM EM_SITE_NO WHERE SITE_NO = '0002400000'";
					try {
						stmt_mssql.executeUpdate(query);
					} catch(Exception e) {
						out.println(e+"=>"+query);
						if(true)return;
					}
					if (stmt_mssql != null) try { stmt_mssql.close(); } catch (Exception e) {}
				}

				if (memberType.equals("1")) {
					cnt		= 1;
					for (i = 0; i < memberIds.length; i++) {
						if (i < 10) {
							num		= "00" + Integer.toString(cnt);
						} else if (i < 100) {
							num		= "0" + Integer.toString(cnt);
						} else {
							num		= Integer.toString(cnt);
						}
						tmpNum		= dt.format(new Date()) + num;
						couponNum	= "ET" + tmpNum;

						memberId	= memberIds[i];

						query		= "INSERT INTO "+ table +"_MEMBER ";
						query		+= "	(COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
						query		+= " VALUES";
						query		+= "	("+ couponId +", '"+ couponNum +"', '"+ memberId +"', 'N', NOW())";
						try {
							stmt.executeUpdate(query);
						} catch (Exception e) {
							out.println(e+"=>"+query);
							if (true) return;
						}

						if (kwpYn.equals("Y")) {
							query		= "INSERT INTO EM_SITE_NO (MEM_ID, SITE_NO, REG_DATE) VALUES (?,'0002400000',GETDATE())";
							pstmt_mssql	= conn.prepareStatement(query);
							pstmt_mssql.setString(1, memberId);
							pstmt_mssql.executeUpdate();
							if (pstmt_mssql != null) try { pstmt_mssql.close(); } catch (Exception e) {}
						}
						cnt++;
					}
				} else if (memberType.equals("2")) {
					POIFSFileSystem fileSystem	= new POIFSFileSystem(new FileInputStream(new File(savePath + upfile)));
					HSSFWorkbook wb				= new HSSFWorkbook(fileSystem);
					HSSFSheet sheet				= wb.getSheetAt(0);

					cnt		= 1;
					rows	= sheet.getPhysicalNumberOfRows();

					for (int rowIndex = 1; rowIndex < rows; rowIndex++) {
						HSSFRow row		= sheet.getRow(rowIndex);
						HSSFCell cell	= null;

						if (i < 10) {
							num		= "00" + Integer.toString(cnt);
						} else if (i < 100) {
							num		= "0" + Integer.toString(cnt);
						} else {
							num		= Integer.toString(cnt);
						}
						tmpNum		= dt.format(new Date()) + num;
						couponNum	= "ET" + tmpNum;

						memberId	= getCellContents(row.getCell(0)).trim();

						query		= "INSERT INTO "+ table +"_MEMBER ";
						query		+= "	(COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
						query		+= " VALUES";
						query		+= "	("+ couponId +", '"+ couponNum +"', '"+ memberId +"', 'N', NOW())";
						try {
							stmt.executeUpdate(query);
						} catch (Exception e) {
							out.println(e+"=>"+query);
							if (true) return;
						}

						if (kwpYn.equals("Y")) {
							query		= "INSERT INTO EM_SITE_NO (MEM_ID, SITE_NO, REG_DATE) VALUES (?,'0002400000',GETDATE())";
							pstmt_mssql	= conn.prepareStatement(query);
							pstmt_mssql.setString(1, memberId);
							pstmt_mssql.executeUpdate();
							if (pstmt_mssql != null) try { pstmt_mssql.close(); } catch (Exception e) {}
						}
						cnt++;
					}
				}
			}			
		} else {
			loops:
			for (i = 0; i < maxCoponCnt; i++) {
				imsinum		= ut.getrndnum(16);
				query		= "SELECT COUNT(ID) FROM ESL_COUPON_RANDNUM WHERE RAND_NUM = '"+ imsinum +"'";
				try {
					rs		= stmt.executeQuery(query);
				} catch (Exception e) {
					out.println(e+"=>"+query);
					if (true) return;
				}

				if (rs.next()) {
					chkCnt		= rs.getInt(1);
				}

				if (chkCnt > 0) {
					break loops;
				} else {
					query		= "INSERT INTO ESL_COUPON_RANDNUM (COUPON_ID, RAND_NUM, RAND_NUM_TYPE, USE_YN)";
					query		+= " VALUES ("+ couponId +", '"+ imsinum +"', '"+ randNumType +"', 'N')";
					try {
						stmt.executeUpdate(query);
					} catch (Exception e) {
						out.println(e+"=>"+query);
						if (true) return;
					}
				}
			}
		}

		if (useGoods.equals("02")) {
			for (i = 0; i < groupCodes.length; i++) {
				groupArr	= groupCodes[i].trim().split(",");
				groupCode	= groupArr[0];
				groupName	= groupArr[1];

				query		= "INSERT INTO "+ table +"_GOODS ";
				query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
				query		+= " VALUES";
				query		+= "	("+ couponId +", '"+ groupCode +"', '"+ groupName +"')";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e+"=>"+query);
					if (true) return;
				}
			}
		} else if (useGoods.equals("03")) {
			query		= "SELECT GROUP_CODE, GROUP_NAME FROM ESL_GOODS_GROUP";
			query		+= " WHERE ID NOT IN (15, 16, 17, 18) AND USE_YN = 'Y'";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if (true) return;
			}

			while (rs.next()) {
				groupCode	= rs.getString("GROUP_CODE");
				groupName	= rs.getString("GROUP_NAME");

				query1		= "INSERT INTO "+ table +"_GOODS ";
				query1		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
				query1		+= " VALUES";
				query1		+= "	("+ couponId +", '"+ groupCode +"', '"+ groupName +"')";
				try {
					stmt1.executeUpdate(query1);
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if (true) return;
				}
			}
		} else if (useGoods.equals("04")) {
			query		= "INSERT INTO "+ table +"_GOODS ";
			query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
			query		+= " VALUES";
			query		+= "	("+ couponId +", '0300578', '밸런스쉐이크')";
			try {
				stmt.executeUpdate(query);
			} catch (Exception e) {
				out.println(e+"=>"+query);
				if (true) return;
			}
		}		

		ut.jsRedirect(out, "coupon_list.jsp");
	} else if (mode.equals("upd")) {
		couponId		= Integer.parseInt(multi.getParameter("id"));

		try {		
			query		= "UPDATE "+ table +" SET ";
			query		+= " COUPON_NAME = ?,";
			query		+= "	COUPON_TYPE		= ?,";
			query		+= "	LTDATE		= ?,";
			query		+= "	LTDATE		= ?,";
			query		+= "	VENDOR		= ?,";
			query		+= "	SALE_TYPE		= ?,";
			query		+= "	SALE_PRICE		= ?,";
			query		+= "	SALE_USE_YN		= ?,";
			query		+= "	USE_LIMIT_CNT		= ?,";
			query		+= "	USE_LIMIT_PRICE		= ?,";
			query		+= "	USE_GOODS		= ?,";
			query		+= "	MAX_COUPON_CNT		= ?,";
			query		+= "	UPDT_ID		= ?,";
			query		+= "	UPDT_IP		= ?,";
			query		+= "	UPDT_DATE		= NOW(),";
			query		+= "	RAND_NUM_TYPE		= ?";
			query		+= " WHERE ID = ?";
			pstmt		= conn.prepareStatement(query);

			pstmt.setString(1, couponName);
			pstmt.setString(2, couponType);
			pstmt.setString(3, stdate);
			pstmt.setString(4, ltdate);
			pstmt.setString(5, vendor);
			pstmt.setString(6, saleType);
			pstmt.setInt(7, salePrice);
			pstmt.setString(8, saleUseYn);
			pstmt.setInt(9, useLimitCnt);
			pstmt.setInt(10, useLimitPrice);
			pstmt.setString(11, useGoods);
			pstmt.setInt(12, maxCoponCnt);
			pstmt.setString(13, instId);
			pstmt.setString(14, userIp);
			pstmt.setString(15, randNumType);
			pstmt.setInt(16, couponId);

			pstmt.executeUpdate();
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}
		//rs.close();

		if (couponType.equals("01")) {
			if (memberYn.equals("Y")) {
				if (kwpYn.equals("Y")) {
					query		= "DELETE FROM EM_SITE_NO WHERE SITE_NO = '0002400000'";
					try {
						stmt_mssql.executeUpdate(query);
					} catch(Exception e) {
						out.println(e+"=>"+query);
						if(true)return;
					}
					if (stmt_mssql != null) try { stmt_mssql.close(); } catch (Exception e) {}
				}

				if (memberType.equals("1")) {
					cnt		= 1;
					if (memberIds != null ) {
						for (i = 0; i < memberIds.length; i++) {
							if (i < 10) {
								num		= "00" + Integer.toString(cnt);
							} else if (i < 100) {
								num		= "0" + Integer.toString(cnt);
							} else {
								num		= Integer.toString(cnt);
							}
							tmpNum		= dt.format(new Date()) + num;
							couponNum	= "ET" + tmpNum;

							memberId	= memberIds[i];

							query		= "INSERT INTO "+ table +"_MEMBER ";
							query		+= "	(COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
							query		+= " VALUES";
							query		+= "	("+ couponId +", '"+ couponNum +"', '"+ memberId +"', 'N', NOW())";
							try {
								stmt.executeUpdate(query);
							} catch (Exception e) {
								out.println(e+"=>"+query);
								if (true) return;
							}

							if (kwpYn.equals("Y")) {
								query		= "INSERT INTO EM_SITE_NO (MEM_ID, SITE_NO, REG_DATE) VALUES (?,'0002400000',GETDATE())";
								pstmt_mssql	= conn.prepareStatement(query);
								pstmt_mssql.setString(1, memberId);
								pstmt_mssql.executeUpdate();
								if (pstmt_mssql != null) try { pstmt_mssql.close(); } catch (Exception e) {}
							}
							cnt++;
						}
					}
				} else if (memberType.equals("2")) {
					POIFSFileSystem fileSystem	= new POIFSFileSystem(new FileInputStream(new File(savePath + upfile)));
					HSSFWorkbook wb				= new HSSFWorkbook(fileSystem);
					HSSFSheet sheet				= wb.getSheetAt(0);

					cnt		= 1;
					rows	= sheet.getPhysicalNumberOfRows();

					for (int rowIndex = 1; rowIndex < rows; rowIndex++) {
						HSSFRow row		= sheet.getRow(rowIndex);
						HSSFCell cell	= null;

						if (i < 10) {
							num		= "00" + Integer.toString(cnt);
						} else if (i < 100) {
							num		= "0" + Integer.toString(cnt);
						} else {
							num		= Integer.toString(cnt);
						}
						tmpNum		= dt.format(new Date()) + num;
						couponNum	= "ET" + tmpNum;

						memberId	= getCellContents(row.getCell(0)).trim();

						query		= "INSERT INTO "+ table +"_MEMBER ";
						query		+= "	(COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
						query		+= " VALUES";
						query		+= "	("+ couponId +", '"+ couponNum +"', '"+ memberId +"', 'N', NOW())";
						try {
							stmt.executeUpdate(query);
						} catch (Exception e) {
							out.println(e+"=>"+query);
							if (true) return;
						}

						if (kwpYn.equals("Y")) {
							query		= "INSERT INTO EM_SITE_NO (MEM_ID, SITE_NO, REG_DATE) VALUES (?,'0002400000',GETDATE())";
							pstmt_mssql	= conn.prepareStatement(query);
							pstmt_mssql.setString(1, memberId);
							pstmt_mssql.executeUpdate();
							if (pstmt_mssql != null) try { pstmt_mssql.close(); } catch (Exception e) {}
						}
						cnt++;
					}
				}
			}			
		} else {
			/*
			loops:
			for (i = 0; i < maxCoponCnt; i++) {
				imsinum		= ut.getrndnum(16);
				query		= "SELECT COUNT(ID) FROM ESL_COUPON_RANDNUM WHERE RAND_NUM = '"+ imsinum +"'";
				try {
					rs		= stmt.executeQuery(query);
				} catch (Exception e) {
					out.println(e+"=>"+query);
					if (true) return;
				}

				if (rs.next()) {
					chkCnt		= rs.getInt(1);
				}

				if (chkCnt > 0) {
					break loops;
				} else {
					query		= "INSERT INTO ESL_COUPON_RANDNUM (COUPON_ID, RAND_NUM, RAND_NUM_TYPE, USE_YN)";
					query		+= " VALUES ("+ couponId +", '"+ imsinum +"', '"+ randNumType +"', 'N')";
					try {
						stmt.executeUpdate(query);
					} catch (Exception e) {
						out.println(e+"=>"+query);
						if (true) return;
					}
				}
			}
			*/
		}

		if (useGoods.equals("02")) {
			
			query		= "DELETE FROM "+ table +"_GOODS ";
			query		+= "	WHERE COUPON_ID = '" + couponId +"'";
			try {
				stmt.executeUpdate(query);
			} catch (Exception e) {
				out.println(e+"=>"+query);
				if (true) return;
			}
			
			for (i = 0; i < groupCodes.length; i++) {
				groupArr	= groupCodes[i].trim().split(",");
				groupCode	= groupArr[0];
				groupName	= groupArr[1];

				query		= "INSERT INTO "+ table +"_GOODS ";
				query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
				query		+= " VALUES";
				query		+= "	("+ couponId +", '"+ groupCode +"', '"+ groupName +"')";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e+"=>"+query);
					if (true) return;
				}
			}
		} else if (useGoods.equals("03")) {
			query		= "SELECT GROUP_CODE, GROUP_NAME FROM ESL_GOODS_GROUP";
			query		+= " WHERE ID NOT IN (15, 16, 17, 18) AND USE_YN = 'Y'";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if (true) return;
			}

			while (rs.next()) {
				groupCode	= rs.getString("GROUP_CODE");
				groupName	= rs.getString("GROUP_NAME");

				query1		= "INSERT INTO "+ table +"_GOODS ";
				query1		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
				query1		+= " VALUES";
				query1		+= "	("+ couponId +", '"+ groupCode +"', '"+ groupName +"')";
				try {
					stmt1.executeUpdate(query1);
				} catch (Exception e) {
					out.println(e+"=>"+query1);
					if (true) return;
				}
			}
		} else if (useGoods.equals("04")) {
			query		= "INSERT INTO "+ table +"_GOODS ";
			query		+= "	(COUPON_ID, GROUP_CODE, GROUP_NAME)";
			query		+= " VALUES";
			query		+= "	("+ couponId +", '0300578', '밸런스쉐이크')";
			try {
				stmt.executeUpdate(query);
			} catch (Exception e) {
				out.println(e+"=>"+query);
				if (true) return;
			}
		}		

		ut.jsRedirect(out, "coupon_list.jsp");		
		
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="../lib/dbclose_mssql.jsp" %>