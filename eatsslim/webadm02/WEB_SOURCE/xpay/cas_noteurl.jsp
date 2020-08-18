<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_bm.jsp" %>
<%@ include file="/lib/dbconn_phi.jsp" %>
<%@ include file="config.jsp" %>
<%//무통장 입금이 완료되면 이 페이지를 PG사에서 호출하게 된다.
request.setCharacterEncoding("euc-kr");

String query		= "";

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

    /*
     * hashdata 검증을 위한 mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다. 
     * LG유플러스에서 발급한 상점키로 반드시변경해 주시기 바랍니다.
     */  
    //String LGD_MERTKEY = ""; //mertkey

    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
    sb.append(LGD_RESPCODE);
    sb.append(LGD_TIMESTAMP);
    sb.append(LGD_MERTKEY);

    byte[] bNoti = sb.toString().getBytes();
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] digest = md.digest(bNoti);

    StringBuffer strBuf = new StringBuffer();
    for (int ii=0 ; ii < digest.length ; ii++) {
        int c = digest[ii] & 0xff;
        if (c <= 15){
            strBuf.append("0");
        }
        strBuf.append(Integer.toHexString(c));
    }

    String LGD_HASHDATA2 = strBuf.toString();  //상점검증 해쉬값  
    
    /*
     * 상점 처리결과 리턴메세지
     *
     * OK  : 상점 처리결과 성공
     * 그외 : 상점 처리결과 실패
     *
     * ※ 주의사항 : 성공시 'OK' 문자이외의 다른문자열이 포함되면 실패처리 되오니 주의하시기 바랍니다.
     */    
    String resultMSG = "결제결과 상점 DB처리(LGD_CASNOTEURL) 결과값을 입력해 주시기 바랍니다.";  
    
    if (LGD_HASHDATA2.trim().equals(LGD_HASHDATA)) { //해쉬값 검증이 성공이면
        if ( ("0000".equals(LGD_RESPCODE.trim())) ){ //결제가 성공이면
			query="";
        	if( "R".equals( LGD_CASFLAG.trim() ) ) {
                /*
                 * 무통장 할당 성공 결과 상점 처리(DB) 부분
                 * 상점 결과 처리가 정상이면 "OK"
                 */    
                //if( 무통장 할당 성공 상점처리결과 성공 ) resultMSG = "OK";
				resultMSG = "OK";
				out.println(resultMSG.toString());
				
        		
        	}else if( "I".equals( LGD_CASFLAG.trim() ) ) {
 	            /*
    	         * 무통장 입금 성공 결과 상점 처리(DB) 부분
        	     * 상점 결과 처리가 정상이면 "OK"
            	 */    
            	//if( 무통장 입금 성공 상점처리결과 성공 ) resultMSG = "OK";
				resultMSG = "OK";
				out.println(resultMSG.toString());

				if(LGD_CASCAMOUNT==null)LGD_CASCAMOUNT="0";
				if(LGD_CASTAMOUNT==null)LGD_CASTAMOUNT="0";
				if(!LGD_CASCAMOUNT.equals("0")){
					if(LGD_CASCAMOUNT.equals(LGD_CASTAMOUNT)){ //총액과 입금액이 같은면 완납
						query="UPDATE ESL_ORDER SET PAY_DATE=NOW(),ORDER_STATE='01',PAY_YN='Y', PG_TID = '"+ LGD_TID +"',ORDER_LOG=CONCAT(ORDER_LOG,'\nPG사 무통장입금완료(총액:"+LGD_CASTAMOUNT+",입금액:"+LGD_CASCAMOUNT+") ',NOW()) WHERE ORDER_NUM='"+LGD_OID+"'";
						try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

%>
<%@ include file="/lib/phi_insert.jsp"%>
<%

						query="UPDATE ESL_ORDER_GOODS SET ORDER_STATE='01' WHERE ORDER_NUM='"+LGD_OID+"'";
						try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
					}else{
						query="UPDATE ESL_ORDER SET ORDER_LOG=CONCAT(ORDER_LOG,'\nPG사 무통장부분입금완료(총액:"+LGD_CASTAMOUNT+",입금액:"+LGD_CASCAMOUNT+") ',NOW()) WHERE ORDER_NUM='"+LGD_OID+"'";
						try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
					}
				}else{
					query="UPDATE ESL_ORDER SET ORDER_LOG=CONCAT(ORDER_LOG,'\nPG사 무통장입금(총액:"+LGD_CASTAMOUNT+",입금액:"+LGD_CASCAMOUNT+") ',NOW()) WHERE ORDER_NUM='"+LGD_OID+"'";
					try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
				}
				

        	}else if( "C".equals( LGD_CASFLAG.trim() ) ) {
 	            /*
    	         * 무통장 입금취소 성공 결과 상점 처리(DB) 부분
        	     * 상점 결과 처리가 정상이면 "OK"
            	 */    
            	//if( 무통장 입금취소  성공 상점처리결과 성공 ) resultMSG = "OK";

				//당일취소만 가능.
				resultMSG = "OK";
				out.println(resultMSG.toString());

				if(LGD_CASCAMOUNT==null)LGD_CASCAMOUNT="0";
				query="UPDATE ESL_ORDER SET PAY_DATE=NOW(),ORDER_STATE='91',ORDER_LOG=CONCAT(ORDER_LOG,'\nPG사 무통장입금취소(총액:"+LGD_CASTAMOUNT+",입금액:"+LGD_CASCAMOUNT+") ',NOW()) WHERE ORDER_NUM='"+LGD_OID+"'";
				try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

				query="UPDATE ESL_ORDER_GOODS SET ORDER_STATE='91' WHERE ORDER_NUM='"+LGD_OID+"'";
				try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

				query		= "UPDATE PHIBABY.P_ORDER_MALL_PHI_ITF SET INTERFACE_FLAG_YN = 'Y' WHERE ORD_NO = '"+ LGD_OID +"'";
				try {
					stmt_phi.executeUpdate(query);
				} catch(Exception e) {
					out.println(e);
					if(true)return;
				}

				int ordSeq			= 0;
				SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
				String instDate		= dt.format(new Date());

				// 시퀀스 조회
				query		= "SELECT MAX(ORD_SEQ) FROM PHIBABY.P_ORDER_MALL_PHI_ITF";
				try {
					rs_phi		= stmt_phi.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs_phi.next()) {
					ordSeq		= rs_phi.getInt(1) + 1;
				}
				rs_phi.close();

				query		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
				query		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM)";
				query		+= "	VALUES";
				query		+= "	("+ ordSeq +", '"+ instDate +"', '"+ LGD_OID +"', '00000000', 'D', '취소', '취소', '111111', '취소', '취소', '00000000000', '00000000000', 'cancel', 0, 0, 0, 0, '30', '0001', '', '', 1, '"+ instDate +"', '000000', 0, 0, 0, SYSDATE)";
				try {
					stmt_phi.executeUpdate(query);
				} catch(Exception e) {
					out.println(e);
					if(true)return;
				}
/*
				//=========취소 기타 처리
				String m_no="";
				query="insert into ESL_ORDER_cancel SET sno=null,ORDER_NUM="+LGD_OID+",state=91,reason='1',reason_etc='무통장입금취소',feedback='',regdt=NOW()";
				query+=",rprice='"+LGD_CASCAMOUNT+"'";
				try{stmt2.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

				//쿠폰 환급
				query="select couponcd,(select m_no from ESL_ORDER WHERE ORDER_NUM=oi.ORDER_NUM) as m_no from ESL_ORDER_item oi WHERE ORDER_NUM='"+LGD_OID+"' and couponcd>0";
				try{rs = stmt.executeQuery(query);}catch(Exception e){out.println(e);if(true)return;}
				while(rs.next()){
					m_no=rs.getString("m_no");
					query="UPDATE gd_coupon_download SET isUse='N' WHERE couponcd='"+rs.getString("couponcd")+"' and m_no='"+m_no+"'"; //사용가능하도록 수정
					try{stmt2.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
				}
				rs.close();
				query="delete from gd_coupon_order WHERE ORDER_NUM='"+LGD_OID+"'";
				try{stmt.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}

				//취소완료시 적립예정인 마일리지 삭제(부분포함)
				query="delete from gd_mileage_log WHERE m_no='"+m_no+"' and ORDER_NUM='"+LGD_OID+"'";
				try{stmt2.executeUpdate(query);	}catch(Exception e){out.println(e);if(true)return;}
*/


        	}   
			
        } else { //결제가 실패이면
            /*
             * 거래실패 결과 상점 처리(DB) 부분
             * 상점결과 처리가 정상이면 "OK"
             */  
           //if( 결제실패 상점처리결과 성공 ) resultMSG = "OK";   
			 resultMSG = "alert('결제 오류가 발생하였습니다. 오류코드="+LGD_RESPCODE.toString()+"');";
			 out.println("<script>"+resultMSG.toString()+"</script>");
        }
    } else { //해쉬값이 검증이 실패이면
        /*
         * hashdata검증 실패 로그를 처리하시기 바랍니다. 
         */      
        resultMSG = "alert('결제결과 상점 DB처리(LGD_CASNOTEURL) 해쉬값 검증이 실패하였습니다.');";
  	    out.println("<script>"+resultMSG.toString()+"</script>");
    }
    

%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_bm.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>