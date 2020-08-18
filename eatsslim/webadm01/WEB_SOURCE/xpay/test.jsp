<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="/inc/dbconn.jsp" %>
<%@ include file="/inc/common.jsp"%>
<%@ include file="config.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

//#######################################################
//##################무통장일때만 호출함##################
//#######################################################
    /*
     * [상점 결제결과처리(DB) 페이지]
     *
     * 1) 위변조 방지를 위한 hashdata값 검증은 반드시 적용하셔야 합니다.
     *
     */

    String LGD_RESPCODE = "";           // 응답코드: 0000(성공) 그외 실패
    String LGD_RESPMSG = "";            // 응답메세지
    /*String LGD_MID = "";                // 상점아이디 
    String LGD_OID = "";                // 주문번호
    String LGD_AMOUNT = "";             // 거래금액
	*/
    String LGD_TID = "";                // LG유플러스에서 부여한 거래번호
    String LGD_PAYTYPE = "";            // 결제수단코드
    String LGD_PAYDATE = "";            // 거래일시(승인일시/이체일시)
    String LGD_HASHDATA = "";           // 해쉬값
    String LGD_FINANCECODE = "";        // 결제기관코드(은행코드)
    String LGD_FINANCENAME = "";        // 결제기관이름(은행이름)
    String LGD_ESCROWYN = "";           // 에스크로 적용여부
    //String LGD_TIMESTAMP = "";          // 타임스탬프
    String LGD_ACCOUNTNUM = "";         // 계좌번호(무통장입금) 
    String LGD_CASTAMOUNT = "";         // 입금총액(무통장입금)
    String LGD_CASCAMOUNT = "";         // 현입금액(무통장입금)
    String LGD_CASFLAG = "";            // 무통장입금 플래그(무통장입금) - 'R':계좌할당, 'I':입금, 'C':입금취소 
    String LGD_CASSEQNO = "";           // 입금순서(무통장입금)
    String LGD_CASHRECEIPTNUM = "";     // 현금영수증 승인번호
    String LGD_CASHRECEIPTSELFYN = "";  // 현금영수증자진발급제유무 Y: 자진발급제 적용, 그외 : 미적용
    String LGD_CASHRECEIPTKIND = "";    // 현금영수증 종류 0: 소득공제용 , 1: 지출증빙용
    String LGD_PAYER = "";    			// 임금자명
    
    /*
     * 구매정보
     */
    String LGD_BUYER = "";              // 구매자
    String LGD_PRODUCTINFO = "";        // 상품명
    String LGD_BUYERID = "";            // 구매자 ID
    String LGD_BUYERADDRESS = "";       // 구매자 주소
    String LGD_BUYERPHONE = "";         // 구매자 전화번호
    String LGD_BUYEREMAIL = "";         // 구매자 이메일
    String LGD_BUYERSSN = "";           // 구매자 주민번호
    String LGD_PRODUCTCODE = "";        // 상품코드
    String LGD_RECEIVER = "";           // 수취인
    String LGD_RECEIVERPHONE = "";      // 수취인 전화번호
    String LGD_DELIVERYINFO = "";       // 배송지

    LGD_RESPCODE            = request.getParameter("LGD_RESPCODE");
    LGD_RESPMSG             = request.getParameter("LGD_RESPMSG");
    LGD_MID                 = request.getParameter("LGD_MID");
    LGD_OID                 = request.getParameter("LGD_OID");
    LGD_AMOUNT              = request.getParameter("LGD_AMOUNT");
    LGD_TID                 = request.getParameter("LGD_TID");
    LGD_PAYTYPE             = request.getParameter("LGD_PAYTYPE");
    LGD_PAYDATE             = request.getParameter("LGD_PAYDATE");
    LGD_HASHDATA            = request.getParameter("LGD_HASHDATA");
    LGD_FINANCECODE         = request.getParameter("LGD_FINANCECODE");
    LGD_FINANCENAME         = request.getParameter("LGD_FINANCENAME");
    LGD_ESCROWYN            = request.getParameter("LGD_ESCROWYN");
    LGD_TIMESTAMP           = request.getParameter("LGD_TIMESTAMP");
    LGD_ACCOUNTNUM          = request.getParameter("LGD_ACCOUNTNUM");
    LGD_CASTAMOUNT          = request.getParameter("LGD_CASTAMOUNT");
    LGD_CASCAMOUNT          = request.getParameter("LGD_CASCAMOUNT");
    LGD_CASFLAG             = request.getParameter("LGD_CASFLAG");
    LGD_CASSEQNO            = request.getParameter("LGD_CASSEQNO");
    LGD_CASHRECEIPTNUM      = request.getParameter("LGD_CASHRECEIPTNUM");
    LGD_CASHRECEIPTSELFYN   = request.getParameter("LGD_CASHRECEIPTSELFYN");
    LGD_CASHRECEIPTKIND     = request.getParameter("LGD_CASHRECEIPTKIND");
    LGD_PAYER     			= request.getParameter("LGD_PAYER");
    
    LGD_BUYER               = request.getParameter("LGD_BUYER");
    LGD_PRODUCTINFO         = request.getParameter("LGD_PRODUCTINFO");
    LGD_BUYERID             = request.getParameter("LGD_BUYERID");
    LGD_BUYERADDRESS        = request.getParameter("LGD_BUYERADDRESS");
    LGD_BUYERPHONE          = request.getParameter("LGD_BUYERPHONE");
    LGD_BUYEREMAIL          = request.getParameter("LGD_BUYEREMAIL");
    LGD_BUYERSSN            = request.getParameter("LGD_BUYERSSN");
    LGD_PRODUCTCODE         = request.getParameter("LGD_PRODUCTCODE");
    LGD_RECEIVER            = request.getParameter("LGD_RECEIVER");
    LGD_RECEIVERPHONE       = request.getParameter("LGD_RECEIVERPHONE");
    LGD_DELIVERYINFO        = request.getParameter("LGD_DELIVERYINFO");

	 String resultMSG = "결제결과 상점 DB처리(LGD_CASNOTEURL) 결과값을 입력해 주시기 바랍니다.";  


 	            /*
    	         * 무통장 입금취소 성공 결과 상점 처리(DB) 부분
        	     * 상점 결과 처리가 정상이면 "OK"
            	 */    
            	//if( 무통장 입금취소  성공 상점처리결과 성공 ) resultMSG = "OK";

				//당일취소만 가능.
				resultMSG = "OK";
				out.println(resultMSG.toString());

				if(LGD_CASCAMOUNT==null)LGD_CASCAMOUNT="0";
				sql="update gd_order set cdt=now(),state='91',settlelog=CONCAT(settlelog,'\nPG사 무통장입금취소(금액:"+LGD_CASCAMOUNT+") ',now()) where ordno='"+LGD_OID+"'";
				try{stmt.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

				sql="update gd_order_item set istate='91' where ordno='"+LGD_OID+"'";
				try{stmt.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

				//=========취소 기타 처리
				String m_no="";
				sql="insert into gd_order_cancel set sno=null,ordno="+LGD_OID+",state=91,reason='1',reason_etc='무통장입금취소',feedback='',regdt=now()";
				sql+=",rprice='"+LGD_CASCAMOUNT+"'";
				try{stmt2.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

				//쿠폰 환급
				sql="select couponcd,(select m_no from gd_order where ordno=oi.ordno) as m_no from gd_order_item oi where ordno='"+LGD_OID+"' and couponcd>0";
				try{rs = stmt.executeQuery(sql);}catch(Exception e){out.println(e);if(true)return;}
				while(rs.next()){
					m_no=rs.getString("m_no");
					sql="update gd_coupon_download set isUse='N' where couponcd='"+rs.getString("couponcd")+"' and m_no='"+m_no+"'"; //사용가능하도록 수정
					try{stmt2.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}
				}
				rs.close();
				sql="delete from gd_coupon_order where ordno='"+LGD_OID+"'";
				try{stmt.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}

				//취소완료시 적립예정인 마일리지 삭제(부분포함)
				sql="delete from gd_mileage_log where m_no='"+m_no+"' and ordno='"+LGD_OID+"'";
				try{stmt2.executeUpdate(sql);	}catch(Exception e){out.println(e);if(true)return;}


    

%>
<%@ include file="/inc/dbclose.jsp" %>
