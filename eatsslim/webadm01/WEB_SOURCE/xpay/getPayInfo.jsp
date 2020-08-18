<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file="config.jsp" %>
<%//해쉬키 생성용
request.setCharacterEncoding("euc-kr");
	String LGD_CLOSEDATE = "20991231240000";
   
    LGD_OID = request.getParameter("LGD_OID"); //주문번호(상점정의 유니크한 주문번호를 입력하세요)
	LGD_AMOUNT = request.getParameter("LGD_AMOUNT"); //결제금액("," 를 제외한 결제금액을 입력하세요)
	//LGD_CLOSEDATE = request.getParameter("LGD_CLOSEDATE");

	String omemId = request.getParameter("OMEMBERID"); //결제아이디

    /*
     * 3. hashdata 암호화 (수정하지 마세요)
	 * 기본 파라미터만 예시되어 있으며, 별도로 필요하신 파라미터는 연동메뉴얼을 참고하시어 추가하시기 바랍니다. 
     * hashdata 암호화는 거래 위변조를 막기위한 방법입니다. 
     *
     * hashdata 암호화 적용( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
     * LGD_MID : 상점아이디
     * LGD_OID : 주문번호
     * LGD_AMOUNT : 금액 
     * LGD_TIMESTAMP : 타임스탬프
     * LGD_MERTKEY : 상점키(mertkey)
     *
     * hashdata 검증을 위한 
     * LG유플러스에서 발급한 상점키(MertKey)를 반드시 입력해 주시기 바랍니다.
     */  
    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
    sb.append(LGD_TIMESTAMP);
    sb.append(LGD_MERTKEY);

    byte[] bNoti = sb.toString().getBytes();
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] digest = md.digest(bNoti);
	int i=0;

    StringBuffer strBuf = new StringBuffer();
    for (i=0 ; i < digest.length ; i++) {
        int c = digest[i] & 0xff;
        if (c <= 15){
            strBuf.append("0");
        }
        strBuf.append(Integer.toHexString(c));
    }

    String LGD_HASHDATA = strBuf.toString();
%>

<script type="text/javascript">
var f=parent.document.LGD_PAYINFO;
f.LGD_OID.value="<%=LGD_OID%>";
f.LGD_AMOUNT.value="<%=LGD_AMOUNT%>";
f.LGD_TIMESTAMP.value="<%=LGD_TIMESTAMP%>";
f.LGD_HASHDATA.value="<%=LGD_HASHDATA%>";
f.LGD_CLOSEDATE.value="<%=LGD_CLOSEDATE%>";

<% if ( omemId.equals("test0517") ) { %>
parent.doAnsimKeyin();
<% } else { %>
parent.doPay_ActiveX('<%=platform%>');
<% } %>
</script>
