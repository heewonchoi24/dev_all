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
<%@ include file="/lib/dbconn_bm.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
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

String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));
String upfile			= "";
SimpleDateFormat dt1	= new SimpleDateFormat("yyMMddHHmmss");
String num				= "";
String orderNum			= "";
String customerNum		= "";
String memberId			= "";
String orderName		= "";
// 일배 배송 정보
String rcvName			= "";
String rcvHp			= "";
String rcvTel			= "";
String rcvZipcode		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvPassYn		= "";
String rcvPass			= "";
String rcvRequest		= "";
// 택배 배송 정보
String tagName			= "";
String tagHp			= "";
String tagTel			= "";
String tagZipcode		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
int payPrice			= 0;
int goodsPrice			= 0;
int devlPrice			= 0;
int couponTprice		= 0;
String payType			= "";
String orderDate		= "";
String groupCode		= "";
String devlType			= "";
int orderCnt			= 0;
String devlDate			= "";
String devlDay			= "";
String devlHoliday		= "0";
String devlWeek			= "";
String devlWeekEnd	= "0";
String buyBagYn			= "";
String ssType			= "";
String outOrderNum		= "";
String shopType			= "";
int groupId				= 0;
int groupPrice			= 0;
int price				= 0;
int errorCnt			= 0;
String tmpNum			= "";
String userIp			= request.getRemoteAddr();
int rows				= 0;
int ordChkCnt			= 0;

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
					newFileName = "upexcel_" + rndText + ext;                    
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
		POIFSFileSystem fileSystem	= new POIFSFileSystem(new FileInputStream(new File(savePath + upfile)));
		HSSFWorkbook wb				= new HSSFWorkbook(fileSystem);
		HSSFSheet sheet				= wb.getSheetAt(0);

		cnt		= 1;
		rows	= sheet.getPhysicalNumberOfRows();

		for (int rowIndex = 1; rowIndex < rows; rowIndex++) {
			HSSFRow row		= sheet.getRow(rowIndex);
			HSSFCell cell	= null;

			if (rowIndex < 10) {
				num		= "00" + Integer.toString(rowIndex);
			} else if (rowIndex < 100) {
				num		= "0" + Integer.toString(rowIndex);
			} else {
				num		= Integer.toString(rowIndex);
			}
			tmpNum		= dt1.format(new Date()) + num;
			orderNum	= "ESS" + tmpNum;

			if (rowIndex < 10) {
				num		= "00" + Integer.toString(rowIndex);
			} else if (rowIndex < 100) {
				num		= "0" + Integer.toString(rowIndex);
			} else {
				num		= Integer.toString(rowIndex);
			}
			tmpNum		= dt1.format(new Date()) + num;
			orderNum	= "ESS" + tmpNum;

			if (row.getCell(0) != null) {
				customerNum	= getCellContents(row.getCell(0));
			}
			if (row.getCell(1) != null) {
				memberId	= getCellContents(row.getCell(1));
			}
			memberId	= (memberId.equals(""))? "0" : memberId;
			if (memberId.equals("0")) {
				customerNum		= "0";
			} else if (!customerNum.equals("") && customerNum != null) {
				customerNum		= customerNum;
			} else {
				query		= "SELECT CUSTOMER_NUM FROM ESL_MEMBER WHERE MEM_ID = '"+ memberId +"'";
				try {
					rs = stmt.executeQuery(query);
				}catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				i	= 0;
				if (rs.next()) {
					customerNum		= rs.getString("CUSTOMER_NUM");
					i++;
				}
				rs.close();

				customerNum		= (i > 0)? customerNum : "0";
			}

			orderName		= getCellContents(row.getCell(2));
			devlType		= getCellContents(row.getCell(17));
			if (devlType.equals("0001")) {
				rcvName			= getCellContents(row.getCell(3));
				rcvZipcode		= getCellContents(row.getCell(4));
				rcvZipcode		= rcvZipcode.replace("-", "");
				rcvAddr1		= getCellContents(row.getCell(5));
				rcvAddr2		= getCellContents(row.getCell(6));
				rcvHp			= getCellContents(row.getCell(7));
				rcvTel			= getCellContents(row.getCell(8));
				if (rcvHp.equals("") || rcvHp == null) {
					rcvHp			= "--";
				}
				if (rcvTel.equals("") || rcvTel == null) {
					rcvTel			= "--";
				}
				rcvRequest		= (row.getCell(9) != null)? ut.inject(getCellContents(row.getCell(9))) : "";
				tagName			= "";
				tagZipcode		= "";
				tagAddr1		= "";
				tagAddr2		= "";
				tagHp			= "";
				tagTel			= "";
				tagRequest		= "";
			} else {
				rcvName			= "";
				rcvZipcode		= "";
				rcvAddr1		= "";
				rcvAddr2		= "";
				rcvHp			= "";
				rcvTel			= "";
				rcvRequest		= "";
				tagName			= getCellContents(row.getCell(3));
				tagZipcode		= getCellContents(row.getCell(4));
				tagZipcode		= tagZipcode.replace("-", "");
				tagAddr1		= getCellContents(row.getCell(5));
				tagAddr2		= getCellContents(row.getCell(6));
				tagHp			= getCellContents(row.getCell(7));
				tagTel			= getCellContents(row.getCell(8));
				if (tagHp.equals("") || tagHp == null) {
					tagHp			= "--";
				}
				if (tagTel.equals("") || tagTel == null) {
					tagTel			= "--";
				}
				tagRequest		= (row.getCell(9) != null)? ut.inject(getCellContents(row.getCell(9))) : "";
			}

			if (devlType.equals("0001") || devlType.equals("0002")) {
				goodsPrice		= Integer.parseInt(getCellContents(row.getCell(10)));
				devlPrice		= Integer.parseInt(getCellContents(row.getCell(11)));
				couponTprice	= Integer.parseInt(getCellContents(row.getCell(12)));
				payPrice		= Integer.parseInt(getCellContents(row.getCell(13)));

				payType			= getCellContents(row.getCell(14));
				orderDate		= getCellContents(row.getCell(15));
				if (orderDate.length() == 8) {
					orderDate		= orderDate.substring(0, 4) +"-"+ orderDate.substring(4, 6) +"-"+ orderDate.substring(6, 8) +" 00:00:00";
				} else {
					orderDate		= orderDate +"00:00:00";
				}
				groupCode		= getCellContents(row.getCell(16));
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
				devlType		= getCellContents(row.getCell(17));
				orderCnt		= Integer.parseInt(getCellContents(row.getCell(18)));
				devlDate		= getCellContents(row.getCell(19));
				if (devlDate.length() == 8) {
					devlDate		= devlDate.substring(0, 4) +"-"+ devlDate.substring(4, 6) +"-"+ devlDate.substring(6, 8);
				} else {
					devlDate		= devlDate;
				}
				devlDay			= getCellContents(row.getCell(20));
				devlWeek		= getCellContents(row.getCell(21));
				
				if (row.getCell(26) != null) {
					devlWeekEnd		= getCellContents(row.getCell(26));
				}
				query			= "SELECT ID, GROUP_PRICE FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ groupCode +"'";
				try {
					rs = stmt.executeQuery(query);
				}catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs.next()) {
					groupId		= rs.getInt("ID");
					groupPrice	= rs.getInt("GROUP_PRICE");
				} else {
					groupId		= 0;
					groupPrice	= 0;
				}
				rs.close();
				if (groupCode.equals("02244") || groupCode.equals("02252") || groupCode.equals("02261") || groupCode.equals("0300978") || groupCode.equals("02271") || groupCode.equals("02282") || groupCode.equals("02294") || groupCode.equals("02411") || groupCode.equals("02422") || groupCode.equals("02434") || groupCode.equals("02444")) {
					price			= groupPrice;
				} else {
					price			= (devlDay.equals("0") || devlDay.equals("0"))? groupPrice : groupPrice * Integer.parseInt(devlDay) * Integer.parseInt(devlWeek);
				}
				buyBagYn		= getCellContents(row.getCell(22));
				ssType			= (row.getCell(23) != null)? getCellContents(row.getCell(23)) : "";
				outOrderNum		= getCellContents(row.getCell(24));
				if (outOrderNum.equals("") || outOrderNum == null) {
					outOrderNum		= "EXP" + tmpNum;
				}
				shopType		= getCellContents(row.getCell(25));

				if (groupId > 0) {
					query		= "INSERT INTO ESL_ORDER SET ";
					query		+= "	ORDER_NUM		= '"+ orderNum +"'";
					query		+= "	,CUSTOMER_NUM	= '"+ customerNum +"'";
					query		+= "	,MEMBER_ID		= '"+ memberId +"'";
					query		+= "	,ORDER_NAME		= '"+ orderName +"'";
					query		+= "	,RCV_NAME		= '"+ rcvName +"'";
					query		+= "	,RCV_ZIPCODE	= '"+ rcvZipcode +"'";
					query		+= "	,RCV_ADDR1		= '"+ rcvAddr1 +"'";
					query		+= "	,RCV_ADDR2		= '"+ rcvAddr2 +"'";
					query		+= "	,RCV_HP			= '"+ rcvHp +"'";
					query		+= "	,RCV_TEL		= '"+ rcvTel +"'";
					query		+= "	,RCV_TYPE		= '01'";
					query		+= "	,RCV_PASS_YN	= 'N'";
					query		+= "	,RCV_PASS		= ''";
					query		+= "	,RCV_REQUEST	= '"+ rcvRequest +"'";
					query		+= "	,TAG_NAME		= '"+ tagName +"'";
					query		+= "	,TAG_ZIPCODE	= '"+ tagZipcode +"'";
					query		+= "	,TAG_ADDR1		= '"+ tagAddr1 +"'";
					query		+= "	,TAG_ADDR2		= '"+ tagAddr2 +"'";
					query		+= "	,TAG_HP			= '"+ tagHp +"'";
					query		+= "	,TAG_TEL		= '"+ tagTel +"'";
					query		+= "	,TAG_TYPE		= '01'";
					query		+= "	,TAG_REQUEST	= '"+ tagRequest +"'";
					query		+= "	,GOODS_PRICE	= '"+ goodsPrice +"'";
					query		+= "	,DEVL_PRICE		= '"+ devlPrice +"'";
					query		+= "	,COUPON_PRICE	= '"+ couponTprice +"'";
					query		+= "	,PAY_PRICE		= '"+ payPrice +"'";
					query		+= "	,PAY_TYPE		= '"+ payType +"'";
					query		+= "	,PAY_YN			= 'Y'";
					query		+= "	,PAY_DATE		= '"+ orderDate +"'";
					query		+= "	,ORDER_DATE		= '"+ orderDate +"'";
					query		+= "	,ORDER_STATE	= '01'";
					query		+= "	,ORDER_ENV		= 'P'";
					query		+= "	,ORDER_IP		= '"+ userIp +"'";
					query		+= "	,ORDER_LOG		= ''";
					query		+= "	,SHOP_TYPE		= '"+ shopType +"'";
					query		+= "	,OUT_ORDER_NUM	= '"+ outOrderNum +"'";
					try {
						stmt.executeUpdate(query);
					} catch(Exception e) {
						out.println(e+"=>"+query);
						if(true)return;
					}

					query		= "INSERT INTO ESL_ORDER_GOODS SET ";
					query		+= "	ORDER_NUM		= '"+ orderNum +"'";
					query		+= "	,GROUP_ID		= "+ groupId;
					query		+= "	,DEVL_TYPE		= '"+ devlType +"'";
					query		+= "	,ORDER_CNT		= '"+ orderCnt +"'";
					query		+= "	,DEVL_DATE		= '"+ devlDate +"'";
					query		+= "	,DEVL_DAY		= '"+ devlDay +"'";
					query		+= "	,DEVL_WEEK		= '"+ devlWeek +"'";
					query		+= "	,DEVL_WEEKEND		= '"+ devlWeekEnd +"'";
					query		+= "	,PRICE			= '"+ price +"'";
					query		+= "	,BUY_BAG_YN		= '"+ buyBagYn +"'";
					query		+= "	,COUPON_NUM		= ''";
					query		+= "	,COUPON_PRICE	= 0";
					query		+= "	,ORDER_STATE	= '01'";
					query		+= "	,SS_TYPE		= '"+ ssType +"'";
					try {
						stmt.executeUpdate(query);				
					} catch(Exception e) {
						out.println(e+"=>"+query);
						if(true)return;
					}
%>
<%@ include file="outmall_phi.jsp"%>
<%
					cnt++;
				}
			}
		}

		if (cnt == rows) {
			cnt			= cnt - 1;
			ut.jsAlert(out, "총 "+ cnt +"건 테이타 등록. 확인필요 " + ordChkCnt +"건");
			ut.jsRedirect(out, "outmall_upload.jsp");
		} else {
			errorCnt	= rows - cnt;
			cnt			= cnt - 1;
			ut.jsAlert(out, "정상처리 : "+ cnt +"건, 오류 : "+ errorCnt + "건");
			ut.jsRedirect(out, "outmall_upload.jsp");
		}
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_bm.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>