<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String savePath			= uploadDir + "board/"; // 저장할 디렉토리 (절대경로)
int sizeLimit			= 2 * 1024 * 1024 ; // 화일용량제한
MultipartRequest multi	= new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
//out.println("savePath="+savePath);if(true)return;

String table			= "ESL_EVENT_REPLY";
String query			= "";
String mode				= ut.inject(multi.getParameter("mode"));
int noticeId			= 0;
noticeId				= Integer.parseInt(multi.getParameter("id"));
String m_id				= ut.inject(multi.getParameter("m_id"));
String m_name			= ut.inject(multi.getParameter("m_name"));
String content			= ut.inject(multi.getParameter("content"));
String goodsName		= ut.inject(multi.getParameter("goods_name"));
int reply_idx			= 0;
if (multi.getParameter("reply_idx") != null && multi.getParameter("reply_idx").length() > 0) {
	reply_idx = Integer.parseInt(multi.getParameter("reply_idx"));
}
String userIp			= request.getRemoteAddr();
String param			= "";
String keyword			= "";
String iPage			= ut.inject(multi.getParameter("page"));
String pgsize			= ut.inject(multi.getParameter("pgsize"));
String schCate			= ut.inject(multi.getParameter("sch_cate"));
String field			= ut.inject(multi.getParameter("field"));
String p_gubun			= ut.inject(multi.getParameter("p_gubun"));
String pressUrl			= "";
int HIT_CNT				= 0;
String login_stat_str	= "";
int couponCnt			= 0;
String couponNum		= "";
String dw_yn			= ut.inject(multi.getParameter("dw_yn"));
String coupon_num_p1	= ut.inject(multi.getParameter("coupon_num_p1"));
String coupon_num_p2	= ut.inject(multi.getParameter("coupon_num_p2"));
String coupon_num_p3	= ut.inject(multi.getParameter("coupon_num_p3"));
int repleCnt			= 0;
System.out.println("dw_yn: " + dw_yn);
System.out.println("coupon_num_p1: " + coupon_num_p1);
System.out.println("coupon_num_p2: " + coupon_num_p2);
System.out.println("coupon_num_p3: " + coupon_num_p3);

if (request.getParameter("keyword") != null) {
	keyword				= ut.inject(request.getParameter("keyword"));
	keyword				= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param					= "&amp;page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword+"&p_gubun="+p_gubun+"&id="+noticeId;

if (mode != null) {
	if (mode.equals("write")) {
		if ( noticeId == 399 ) {
			query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
			//query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.COUPON_NAME like '%50일다이어트-식사 8주구매시%'";
			query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ m_id +"' AND C.ID in (4106)";
			try {
				rs		= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			if (rs.next()) {
				couponCnt	= rs.getInt(1);
			}
			rs.close();

			if (couponCnt > 0) {

				try {
					query		= "INSERT INTO "+ table;
					query		+= "	(ID, M_ID, M_NAME, CONTENT, INST_IP, INST_DATE, GOODS_NAME)";
					query		+= " VALUES";
					query		+= "	(?, ?, ?, ?, ?, NOW(), ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, noticeId);
					pstmt.setString(2, m_id);
					pstmt.setString(3, m_name);
					pstmt.setString(4, content);
					pstmt.setString(5, userIp);
					pstmt.setString(6, goodsName);
					pstmt.executeUpdate();
				} catch (Exception e) {
					out.println(e+"=>"+query);

					if(true)return;
					ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
					ut.jsBack(out);
					return;
				}

				out.print("<script>alert('등록되었습니다');location.href='eventView.jsp?"+param+"';</script>");
			} else {

				try {
					query		= "INSERT INTO "+ table;
					query		+= "	(ID, M_ID, M_NAME, CONTENT, INST_IP, INST_DATE, GOODS_NAME)";
					query		+= " VALUES";
					query		+= "	(?, ?, ?, ?, ?, NOW(), ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, noticeId);
					pstmt.setString(2, m_id);
					pstmt.setString(3, m_name);
					pstmt.setString(4, content);
					pstmt.setString(5, userIp);
					pstmt.setString(6, goodsName);
					pstmt.executeUpdate();
				} catch (Exception e) {
					out.println(e+"=>"+query);

					if(true)return;
					ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
					ut.jsBack(out);
					return;
				}

				SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
				couponNum		= "ET" + dt.format(new Date());

				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (4106,'"+ couponNum + "001" +"','"+ m_id +"','N',NOW())";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e);
					if(true)return;
				}
/*
				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3504,'"+ couponNum + "002" + "','"+ m_id +"','N',NOW())";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e);
					if(true)return;
				}

				query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
				query		+= " VALUES (3505,'"+ couponNum + "003" +"','"+ m_id +"','N',NOW())";
				try {
					stmt.executeUpdate(query);
				} catch (Exception e) {
					out.println(e);
					if(true)return;
				}
*/
				out.print("<script>alert('쿠폰 발급이 완료되었습니다. 쿠폰은 마이페이지에서 확인하실 수 있습니다.');location.href='eventView.jsp?"+param+"';</script>");
			}			
			
		} else {
			if(dw_yn.equals("RDW")){// 댓글 등록 시 쿠폰 발급의 경우

				System.out.println("coupon_num_p1: " + coupon_num_p1);
				System.out.println("coupon_num_p2: " + coupon_num_p2);
				System.out.println("coupon_num_p3: " + coupon_num_p3);

				query        = "SELECT COUNT(ID) REPLE_CNT FROM ESL_EVENT_REPLY";
				query        += " WHERE ID = '" + noticeId + "' AND M_ID = '" +  m_id + "'";
				try {
					rs    = stmt.executeQuery(query);
				} catch(Exception e) {
					out.println(e);
					if(true)return;
				}

				if (rs.next()) {
					repleCnt        = rs.getInt("REPLE_CNT");
				}
				rs.close();

				System.out.println("repleCnt: " + repleCnt);

				if(repleCnt < 1){
					try {
						query		= "INSERT INTO "+ table;
						query		+= "	(ID, M_ID, M_NAME, CONTENT, INST_IP, INST_DATE, GOODS_NAME)";
						query		+= " VALUES";
						query		+= "	(?, ?, ?, ?, ?, NOW(), ?)";
						pstmt		= conn.prepareStatement(query);
						pstmt.setInt(1, noticeId);
						pstmt.setString(2, m_id);
						pstmt.setString(3, m_name);
						pstmt.setString(4, content);
						pstmt.setString(5, userIp);
						pstmt.setString(6, goodsName);
						pstmt.executeUpdate();
					} catch (Exception e) {
						out.println(e+"=>"+query);

						if(true)return;
						ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
						ut.jsBack(out);
						return;
					}

					SimpleDateFormat dt    = new SimpleDateFormat("yyMMddHHmmss");
					couponNum        = "ET" + dt.format(new Date());

					if(!coupon_num_p1.equals("")){
						try {
							query        = "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
							query        += " VALUES ('" + coupon_num_p1 + "', '"+ couponNum + "001" +"', '" + m_id + "', 'N', NOW())";
							stmt.executeUpdate(query);

						} catch (Exception e) {
							out.println(e);
							if(true)return;
						}
					}
					if(!coupon_num_p2.equals("")){
						try {
							query        = "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
							query        += " VALUES ('" + coupon_num_p2 + "', '"+ couponNum + "001" +"', '" + m_id + "', 'N', NOW())";
							stmt.executeUpdate(query);

						} catch (Exception e) {
							out.println(e);
							if(true)return;
						}
					}
					if(!coupon_num_p3.equals("")){
						try {
							query        = "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
							query        += " VALUES ('" + coupon_num_p3 + "', '"+ couponNum + "001" +"', '" + m_id + "', 'N', NOW())";
							stmt.executeUpdate(query);

						} catch (Exception e) {
							out.println(e);
							if(true)return;
						}
					}
					out.print("<script>alert('쿠폰 발급이 완료되었습니다. 쿠폰은 마이페이지에서 확인하실 수 있습니다.');location.href='eventView.jsp?"+param+"';</script>");
				}
				else{

					try {
						query		= "INSERT INTO "+ table;
						query		+= "	(ID, M_ID, M_NAME, CONTENT, INST_IP, INST_DATE, GOODS_NAME)";
						query		+= " VALUES";
						query		+= "	(?, ?, ?, ?, ?, NOW(), ?)";
						pstmt		= conn.prepareStatement(query);
						pstmt.setInt(1, noticeId);
						pstmt.setString(2, m_id);
						pstmt.setString(3, m_name);
						pstmt.setString(4, content);
						pstmt.setString(5, userIp);
						pstmt.setString(6, goodsName);
						pstmt.executeUpdate();
					} catch (Exception e) {
						out.println(e+"=>"+query);

						if(true)return;
						ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
						ut.jsBack(out);
						return;
					}
				   out.print("<script>alert('댓글이 등록되었습니다');location.href='eventView.jsp?"+param+"';</script>");
				}
			}
			else{// 무조건 쿠폰 발급의 경우
				try {
					query		= "INSERT INTO "+ table;
					query		+= "	(ID, M_ID, M_NAME, CONTENT, INST_IP, INST_DATE, GOODS_NAME)";
					query		+= " VALUES";
					query		+= "	(?, ?, ?, ?, ?, NOW(), ?)";
					pstmt		= conn.prepareStatement(query);
					pstmt.setInt(1, noticeId);
					pstmt.setString(2, m_id);
					pstmt.setString(3, m_name);
					pstmt.setString(4, content);
					pstmt.setString(5, userIp);
					pstmt.setString(6, goodsName);
					pstmt.executeUpdate();
				} catch (Exception e) {
					out.println(e+"=>"+query);

					if(true)return;
					ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
					ut.jsBack(out);
					return;
				}
				out.print("<script>alert('댓글이 등록되었습니다');location.href='eventView.jsp?"+param+"';</script>");
			}
		}

	}else if(mode.equals("edit")) {

		try {
			query		= "UPDATE "+ table +" SET ";
			query		+= "	CONTENT			= ?,";
			query		+= "	UPDT_IP			= ?,";
			query		+= "	UPDT_DATE		= NOW(),";
			query		+= "	GOODS_NAME		= ?";
			query		+= " WHERE IDX = ?";
			pstmt		= conn.prepareStatement(query);
			pstmt.setString(1, content);
			pstmt.setString(2, userIp);
			pstmt.setString(3, goodsName);
			pstmt.setInt(4, reply_idx);
			pstmt.executeUpdate();

		} catch (Exception e) {
			out.println(e);
			ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
			ut.jsBack(out);
			return;
		}

		out.print("<script>alert('수정되었습니다');location.href='eventView.jsp?"+param+"';</script>");

	}else if(mode.equals("del")) {

		if(dw_yn.equals("RDW")){// 댓글 등록 시 쿠폰 발급의 경우

			query        = "SELECT COUNT(ID) REPLE_CNT FROM ESL_EVENT_REPLY";
			query        += " WHERE ID = '" + noticeId + "' AND M_ID = '" +  m_id + "'";
			try {
				rs    = stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}

			if (rs.next()) {
				repleCnt        = rs.getInt("REPLE_CNT");
			}
			rs.close();

			System.out.println("repleCnt: " + repleCnt);

			if(repleCnt <= 1){// 댓글 경험이 없을 경우(댓글을 모두 삭제 하였을 경우)

				try {
					query        = "DELETE FROM ESL_COUPON_MEMBER WHERE MEMBER_ID = '" + m_id + "' AND COUPON_ID IN ('" + coupon_num_p1 + "', '" + coupon_num_p2 + "', '" + coupon_num_p3 + "')";
					pstmt        = conn.prepareStatement(query);
					System.out.println("query11: "+query );
					pstmt.executeUpdate();

				} catch (Exception e) {
					out.println(e);
					ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
					ut.jsBack(out);
					return;
				}
			}

			try {
				query		= "DELETE FROM "+ table +" WHERE IDX IN ("+ reply_idx +") and M_ID='"+m_id+"'";
				pstmt		= conn.prepareStatement(query);
				pstmt.executeUpdate();

			} catch (Exception e) {
				out.println(e);
				ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
				ut.jsBack(out);
				return;
			}

			out.print("<script>alert('삭제되었습니다');location.href='eventView.jsp?"+param+"';</script>");
		}else{
		
			try {
				query		= "DELETE FROM "+ table +" WHERE IDX IN ("+ reply_idx +") and M_ID='"+m_id+"'";
				pstmt		= conn.prepareStatement(query);
				pstmt.executeUpdate();

			} catch (Exception e) {
				out.println(e);
				ut.jsAlert(out, "장애가 발생하였습니다.\\n잠시 후 다시 이용해 주십시오.");
				ut.jsBack(out);
				return;
			}
			out.print("<script>alert('삭제되었습니다');location.href='eventView.jsp?"+param+"';</script>");
		}
	}

}
%>
<%@ include file="../lib/dbclose.jsp" %>