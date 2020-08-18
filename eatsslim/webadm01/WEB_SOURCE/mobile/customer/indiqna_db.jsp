<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_tbr.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String savePath			= uploadDir + "board/"; // ������ ���丮 (������)
int sizeLimit			= 10 * 1024 * 1024 ; // ȭ�Ͽ뷮����
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_COUNSEL";
String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
String mode				= ut.inject(multi.getParameter("mode"));
String counselID		= ut.inject(multi.getParameter("counselID"));
String counselType		= ut.inject(multi.getParameter("counsel_type"));
String name				= ut.inject(multi.getParameter("name"));
String hp				= ut.inject(multi.getParameter("hp"));
String hp1				= "";
String hp2				= "";
String hp3				= "";
String[] tmp			= new String[]{};
String hpTmp			= "";

hpTmp = hp.replace("-","");
if ( hpTmp.length() == 11 ) {
	hp1		= hpTmp.substring(0, 3);
	hp2		= hpTmp.substring(3, 4);
	hp3		= hpTmp.substring(7);
} else {
	hp1		= hpTmp.substring(0, 3);
	hp2		= hpTmp.substring(3, 3);
	hp3		= hpTmp.substring(6);
}

String email			= ut.inject(multi.getParameter("email"));
String title			= ut.inject(multi.getParameter("title"));
String content			= ut.inject(multi.getParameter("content"));
String upFile			= "";
String userIp			= request.getRemoteAddr();
int counselId			= 0;
String customerNum		= "";
String hdBcode			= "";
String hdScode			= "";
String claimGubun		= "";
String ecs_cate1		= ut.inject(multi.getParameter("ecs_type1"));
String ecs_cate2		= ut.inject(multi.getParameter("ecs_type2"));
String ecs_cate3		= ut.inject(multi.getParameter("ecs_type3"));
//===============================��¥
Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //����
String cDate=(new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());

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

		Enumeration formNames = multi.getFileNames();  // ���� �̸� ��ȯ
		while (formNames.hasMoreElements()) {
			String formName		= (String)formNames.nextElement();
			String ufileName	= multi.getFilesystemName(formName); // ������ �̸� ���
			if (ufileName != null) {
				dot	= ufileName.lastIndexOf(".");
				if (dot != -1) {
					ext = ufileName.substring(dot);
				} else {
					ext = "";
				}
				f1	= new File(savePath +"/"+ ufileName);

				if(formName.equals("up_file")){					
					newFileName = "counsel_" + rndText + ext;                    
                    if (f1.exists()) {
						newFile = new File(savePath + "/"+ newFileName);
						f1.renameTo(newFile); //���ϸ��� ����
					}
					upFile	= newFileName;
				}
			}
		}
	} catch(Exception e) {
		out.print("���� ���ε� ����..! "+e+"<br>");
	}

	query1		= "SELECT CUSTOMER_NUM FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
	try {
		rs1	= stmt.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	if (rs1.next()) {
		customerNum		= rs1.getString("CUSTOMER_NUM");
	}
/*
	switch(Integer.parseInt(counselType)){
		case 1:
			hdBcode		= "00036";
			hdScode		= "00001";
			claimGubun	= "00001";break;
		case 2:
			hdBcode		= "00033";
			hdScode		= "00001";
			claimGubun	= "00001";break;
		case 3:
			hdBcode		= "00034";
			hdScode		= "00001";
			claimGubun	= "00001";break;
		case 4:
			hdBcode		= "00032";
			hdScode		= "00001";
			claimGubun	= "00001";break;
		case 5:
			hdBcode		= "00035";
			hdScode		= "00001";
			claimGubun	= "00001";break;
		case 9:
			hdBcode		= "00031";
			hdScode		= "00001";
			claimGubun	= "00001";break;
		default:
			hdBcode		= "&nbsp;";
			hdScode		= "&nbsp;";
			claimGubun	= "&nbsp;";break;
	}
*/
	if ( mode.equals("ins") ) {
		query		= "INSERT INTO "+ table;
		query		+= "	(MEMBER_ID, COUNSEL_TYPE, NAME, HP, EMAIL, TITLE, CONTENT, UP_FILE, INST_IP, INST_DATE, ECS_CATE1, ECS_CATE2, ECS_CATE3)";
		query		+= " VALUES";
		query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?)";
		pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		pstmt.setString(1, eslMemberId);
		pstmt.setString(2, counselType);
		pstmt.setString(3, name);
		pstmt.setString(4, hp);
		pstmt.setString(5, email);
		pstmt.setString(6, title);
		pstmt.setString(7, content);
		pstmt.setString(8, upFile);
		pstmt.setString(9, userIp);
		pstmt.setString(10, ecs_cate1);
		pstmt.setString(11, ecs_cate2);
		pstmt.setString(12, ecs_cate3);
		pstmt.executeUpdate();
		try {
			rs			= pstmt.getGeneratedKeys();
			if (rs.next()) {
				counselId		= rs.getInt(1);
			}			
		} catch (Exception e) {
			//out.println(e+"=>"+query);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		query		= "INSERT INTO TBITF_VOICE_IF";
		query		+= "	(RECEIPT_ROOT, BOARD_DIV, BOARD_SEQ, CUSTOMER_NUM, CUSTOMER_NAME, CUSTOMER_PHONEAREA, CUSTOMER_PHONEFIRST, CUSTOMER_PHONESECOND,";
		query		+= "	CUSTOMER_EMAIL, HD_BCODE, HD_SCODE, CLAIM_GUBUN, COUNSEL_DESC, RECEIPT_DATE, PRCS_YN, DEL_YN, ITEM_NAME, SEC_CODE)";
		query		+= " VALUES";
		query		+= "	('10011', '1:1 ����', "+ counselId +", '"+ customerNum +"', '"+ name +"', '"+ hp1 +"', '"+ hp2 +"', '"+ hp3 +"',";
		query		+= "	'"+ email +"', '"+ ecs_cate1 +"', '"+ ecs_cate2 +"', '"+ ecs_cate3 +"', '"+ content +"', '"+ cDate +"', 'N', 'N', '�ս���', '953')";
		try {
			stmt_tbr.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}

		ut.jsAlert(out, "��ϵǾ����ϴ�.");
		ut.jsRedirect(out, "/mobile/shop/mypage/myqna.jsp");
	}
	else if ( mode.equals("mod") ) {
		try {
			query  = "UPDATE "+ table +" SET ";
			query += " counsel_type	= ?, ";
			query += " name			= ?, ";
			query += " hp			= ?, ";
			query += " email		= ?, ";
			query += " title		= ?, ";
			query += " content		= ?, ";
			query += " inst_ip		= ?, ";
			query += " ecs_cate1	= ?, ";
			query += " ecs_cate2	= ?, ";
			query += " ecs_cate3	= ?  ";			
			query += " WHERE id = ?";

			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, counselType);
			pstmt.setString(2, name);
			pstmt.setString(3, hp);
			pstmt.setString(4, email);
			pstmt.setString(5, title);
			pstmt.setString(6, content);
			pstmt.setString(7, userIp);
			pstmt.setString(8, ecs_cate1);
			pstmt.setString(9, ecs_cate2);
			pstmt.setString(10, ecs_cate3);					
			pstmt.setString(11, counselID);
			pstmt.executeUpdate();
		} catch (Exception e) {
			//out.println(e+"=>"+query);
			ut.jsAlert(out, "��ְ� �߻��Ͽ����ϴ�.\\n��� �� �ٽ� �̿��� �ֽʽÿ�.");
			ut.jsBack(out);
			return;
		}

		query  = "UPDATE TBITF_VOICE_IF SET ";
		query += " CUSTOMER_NAME		= '"+ name +"',";
		query += " CUSTOMER_PHONEAREA	= '"+ hp1 +"',";
		query += " CUSTOMER_PHONEFIRST	= '"+ hp2 +"',";
		query += " CUSTOMER_PHONESECOND	= '"+ hp3 +"',";
		query += " CUSTOMER_EMAIL		= '"+ email +"',";
		query += " HD_BCODE				= '"+ ecs_cate1 +"',";
		query += " HD_SCODE				= '"+ ecs_cate2 +"',";
		query += " CLAIM_GUBUN			= '"+ ecs_cate3 +"',";
		query += " COUNSEL_DESC			= '"+ content +"'";
		query += " WHERE BOARD_SEQ = '"+ counselID +"' AND RECEIPT_ROOT = '10011'";
		
		try {
			stmt_tbr.executeUpdate(query);
		} catch (Exception e) {
			out.println(e+"=>"+query);
			if (true) return;
		}

		ut.jsAlert(out, "1:1 ���� ������ �Ϸ�Ǿ����ϴ�.");
		ut.jsRedirect(out, "/mobile/shop/mypage/myqna.jsp");
	}

}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_tbr.jsp"%>