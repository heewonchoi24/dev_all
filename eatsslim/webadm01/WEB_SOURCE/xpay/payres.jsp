<%@ page contentType="text/html; charset=EUC-KR" %>
<%//테스트용
request.setCharacterEncoding("euc-kr");
    /*
     * [ 결제결과 화면페이지]
     */

    String LGD_TID                 = request.getParameter("LGD_TID");			//LG유플러스 거래번호
    String LGD_OID                 = request.getParameter("LGD_OID");			//주문번호
    String LGD_PAYTYPE             = request.getParameter("LGD_PAYTYPE");		//결제수단
    String LGD_PAYDATE    		   = request.getParameter("LGD_PAYDATE");		//결제일자
    String LGD_FINANCECODE         = request.getParameter("LGD_FINANCECODE");	//결제기관코드
    String LGD_FINANCENAME         = request.getParameter("LGD_FINANCENAME");	//결제기관이름
    String LGD_FINANCEAUTHNUM      = request.getParameter("LGD_FINANCEAUTHNUM");//결제사승인번호
    String LGD_ACCOUNTNUM          = request.getParameter("LGD_ACCOUNTNUM");	//입금할 계좌 (가상계좌)
    String LGD_BUYER               = request.getParameter("LGD_BUYER");			//구매자명
    String LGD_PRODUCTINFO         = request.getParameter("LGD_PRODUCTINFO");	//상품명
    String LGD_AMOUNT              = request.getParameter("LGD_AMOUNT");		//결제금액
    String LGD_RESPCODE            = request.getParameter("LGD_RESPCODE");		//결과코드
    String LGD_RESPMSG             = request.getParameter("LGD_RESPMSG");		//결과메세지
        
    if (("0000".equals(LGD_RESPCODE))) { 	//결제성공시
    	out.println("* Xpay-lite (화면)결과리턴페이지 예제입니다." + "<p>");

    	out.println("결과코드 : " + LGD_RESPCODE + "<br>");
    	out.println("결과메세지 : " + LGD_RESPMSG + "<br>");
    	out.println("거래번호 : " + LGD_TID + "<br>");
    	out.println("주문번호 : " + LGD_OID + "<br>");
    	out.println("구매자 : " + LGD_BUYER + "<br>");
    	out.println("상품명 : " + LGD_PRODUCTINFO + "<br>");
    	out.println("결제금액 : " + LGD_AMOUNT + "<br>");
    	out.println("결제수단 : " + LGD_PAYTYPE + "<br>");
    	out.println("결제일시 : " + LGD_PAYDATE + "<br>");
    	out.println("결제사코드 : " + LGD_FINANCECODE + "<br>");
        
        if (("SC0010".equals(LGD_PAYTYPE))) {			//신용카드 결제시		
        	out.println("카드사명 : " + LGD_FINANCENAME + "<br>");
        	out.println("승인번호 : " + LGD_FINANCEAUTHNUM + "<br>");
        } 
        else if (("SC0030".equals(LGD_PAYTYPE))) {		//계좌이체 결제시
        	out.println("결제은행 : " + LGD_FINANCENAME + "<br>");
        }
        else if (("SC0040".equals(LGD_PAYTYPE))) {		//가상계좌 결제시 (할당)
        	out.println("입금은행 : " + LGD_FINANCENAME + "<br>");
        	out.println("입금계좌번호 : " + LGD_ACCOUNTNUM + "<br>");
        } 
        else {											//기타 결제시
        	out.println("결제사명 : " + LGD_FINANCENAME + "<br>");
        	out.println("결제사승인번호 : " + LGD_FINANCEAUTHNUM + "<br>");
        }
    } else {	 //결제실패시
    	out.println("결제가 실패되었습니다." + "<p>");
    	out.println("결과코드 : " + LGD_RESPCODE + "<br>");
    	out.println("결과메세지 : " + LGD_RESPMSG + "<br>");
    }
 
%>
