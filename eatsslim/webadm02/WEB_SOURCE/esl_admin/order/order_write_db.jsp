<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="jxl.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
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
String devlWeek			= "";
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
		Workbook workbook	= Workbook.getWorkbook(new File(savePath + upfile));
		Sheet sheet			= workbook.getSheet(0);

		cnt		= 1;
		for (int rowIndex = 1; rowIndex < sheet.getRows(); rowIndex++) {
			if (rowIndex < 10) {
				num		= "00" + Integer.toString(rowIndex);
			} else if (rowIndex < 100) {
				num		= "0" + Integer.toString(rowIndex);
			} else {
				num		= Integer.toString(rowIndex);
			}
			tmpNum		= dt1.format(new Date()) + num;
			orderNum	= "ESS" + tmpNum;
			customerNum	= sheet.getCell(0, rowIndex).getContents().trim();
			memberId	= sheet.getCell(1, rowIndex).getContents().trim();
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

			orderName		= sheet.getCell(2, rowIndex).getContents().trim();
			devlType		= sheet.getCell(17, rowIndex).getContents().trim();
			if (devlType.equals("0001")) {
				rcvName			= sheet.getCell(3, rowIndex).getContents().trim();
				rcvZipcode		= sheet.getCell(4, rowIndex).getContents().trim();
				rcvZipcode		= rcvZipcode.replace("-", "");
				rcvAddr1		= sheet.getCell(5, rowIndex).getContents().trim();
				rcvAddr2		= sheet.getCell(6, rowIndex).getContents().trim();
				rcvHp			= sheet.getCell(7, rowIndex).getContents().trim();
				rcvTel			= sheet.getCell(8, rowIndex).getContents().trim();
				if (rcvTel.equals("") || rcvTel == null) {
					rcvTel			= "--";
				}
				rcvRequest		= sheet.getCell(9, rowIndex).getContents().trim();
				tagName			= "";
				tagZipcode		= "";
				tagAddr1		= "";
				tagAddr2		= "";
				tagHp			= "--";
				tagTel			= "--";
				tagRequest		= "";
			} else {
				rcvName			= "";
				rcvZipcode		= "";
				rcvAddr1		= "";
				rcvAddr2		= "";
				rcvHp			= "--";
				rcvTel			= "--";
				rcvRequest		= "";
				tagName			= sheet.getCell(3, rowIndex).getContents().trim();
				tagZipcode		= sheet.getCell(4, rowIndex).getContents().trim();
				tagZipcode		= tagZipcode.replace("-", "");
				tagAddr1		= sheet.getCell(5, rowIndex).getContents().trim();
				tagAddr2		= sheet.getCell(6, rowIndex).getContents().trim();
				tagHp			= sheet.getCell(7, rowIndex).getContents().trim();
				tagTel			= sheet.getCell(8, rowIndex).getContents().trim();
				if (tagTel.equals("") || tagTel == null) {
					tagTel			= "--";
				}
				tagRequest		= sheet.getCell(9, rowIndex).getContents().trim();
			}

			if (devlType.equals("0001") || devlType.equals("0002")) {
				goodsPrice		= Integer.parseInt(sheet.getCell(10, rowIndex).getContents().trim());
				devlPrice		= Integer.parseInt(sheet.getCell(11, rowIndex).getContents().trim());
				couponTprice	= Integer.parseInt(sheet.getCell(12, rowIndex).getContents().trim());
				payPrice		= Integer.parseInt(sheet.getCell(13, rowIndex).getContents().trim());

				payType			= sheet.getCell(14, rowIndex).getContents().trim();
				orderDate		= sheet.getCell(15, rowIndex).getContents().trim();
				if (orderDate.length() == 8) {
					orderDate		= orderDate.substring(0, 4) +"-"+ orderDate.substring(4, 6) +"-"+ orderDate.substring(6, 8) +" 00:00:00";
				} else {
					orderDate		= orderDate +"00:00:00";
				}
				groupCode		= sheet.getCell(16, rowIndex).getContents().trim();
				devlType		= sheet.getCell(17, rowIndex).getContents().trim();
				orderCnt		= Integer.parseInt(sheet.getCell(18, rowIndex).getContents().trim());
				devlDate		= sheet.getCell(19, rowIndex).getContents().trim();
				if (devlDate.length() == 8) {
					devlDate		= devlDate.substring(0, 4) +"-"+ devlDate.substring(4, 6) +"-"+ devlDate.substring(6, 8);
				} else {
					devlDate		= devlDate;
				}
				devlDay			= sheet.getCell(20, rowIndex).getContents().trim();
				devlWeek		= sheet.getCell(21, rowIndex).getContents().trim();
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
				price			= (devlDay.equals("0") || devlDay.equals("0"))? groupPrice : groupPrice * Integer.parseInt(devlDay) * Integer.parseInt(devlWeek);
				buyBagYn		= sheet.getCell(22, rowIndex).getContents().trim();
				ssType			= sheet.getCell(23, rowIndex).getContents().trim();
				outOrderNum		= sheet.getCell(24, rowIndex).getContents().trim();
				if (outOrderNum.equals("") || outOrderNum == null) {
					outOrderNum		= "EXP" + tmpNum;
				}
				shopType		= sheet.getCell(25, rowIndex).getContents().trim();

				if (groupId > 0 && groupPrice > 0) {
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

		if (cnt == sheet.getRows()) {
			cnt			= cnt - 1;
			ut.jsAlert(out, "총 "+ cnt +"건의 데이타가 등록되었습니다.");
			ut.jsRedirect(out, "outmall_upload.jsp");
		} else {
			errorCnt	= sheet.getRows() - cnt;
			cnt			= cnt - 1;
			ut.jsAlert(out, "정상처리 : "+ cnt +"건, 오류 : "+ errorCnt + "건");
			ut.jsRedirect(out, "outmall_upload.jsp");
		}
	}
}
%>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>