<%
/**
 * @file : util.jsp
 * @date : 2013-08-20
 * @author : Kim Hyungseok
 */
%>
<%@ page language="java" pageEncoding="EUC-KR"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.util.regex.*"%>
<%
class Util {
	//1:1 문의유형 조회
	public String getCounselType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="기업";break;
				case 2:
					ret="배송";break;
				case 3:
					ret="제품이용";break;
				case 4:
					ret="주문결제";break;
				case 5:
					ret="서비스관리";break;
				case 9:
					ret="기타";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//다이어트컬럼 구분
	public String getPostType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="칼로리조절식사";break;
				case 2:
					ret="칼로리조절프로그램";break;
				case 3:
					ret="칼로리조절프로그램";break;
				case 4:
					ret="이벤트후기";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//취소사유 조회
	public String getCanceReasonType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="구매의사취소";break;
				case 2:
					ret="상품 잘못 주문";break;
				case 3:
					ret="상품정보 상이";break;
				case 4:
					ret="서비스 및 상품 불만족";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//이벤트 구분 조회
	public String getEventType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="EVENT";break;
				case 2:
					ret="SALE";break;
				case 3:
					ret="브랜드위크";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//가상계좌 은행사 코드
	public String getBankCode(String param){
		String ret="0";
		if(param!=null && param.length()>0){
			if(param.equals("경남")){
				ret="39";
			}else if(param.equals("국민")){
				ret="06";
			}else if(param.equals("기업")){
				ret="03";
			}else if(param.equals("농협")){
				ret="11";
			}else if(param.equals("대구")){
				ret="31";
			}else if(param.equals("부산")){
				ret="32";
			}else if(param.equals("수협")){
				ret="07";
			}else if(param.equals("신한")){
				ret="26";
			}else if(param.equals("외환")){
				ret="05";
			}else if(param.equals("우리")){
				ret="20";
			}else if(param.equals("우체국")){
				ret="71";
			}else if(param.equals("하나")){
				ret="81";
			}
		}
		return ret;
	}
	
	//주문상태 조회
	public String getOrderState(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 0:
					ret="주문접수";break;
				case 1:
					ret="결제완료";break;
				case 2:
					ret="상품준비중";break;
				case 3:
					ret="배송중";break;
				case 4:
					ret="배송완료";break;
				case 5:
					ret="주문완료";break;
				case 90:
					ret="취소요청";break;
				case 901:
					ret="부분취소요청";break;
				case 91:
					ret="취소완료";break;
				case 911:
					ret="부분취소완료";break;
				case 92:
					ret="반품요청";break;
				case 921:
					ret="부분반품요청";break;
				case 93:
					ret="반품완료";break;
				case 931:
					ret="부분반품완료";break;
				case 94:
					ret="교환요청";break;
				case 941:
					ret="부분교환요청";break;
				case 95:
					ret="교환완료";break;
				case 951:
					ret="부분교환완료";break;
				case 96:
					ret="환불요청";break;
				case 97:
					ret="환불완료";break;
				case 971:
					ret="부분환불완료";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//FAQ 구분 조회
	public String getFaqType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="교환/환불";break;
				case 2:
					ret="회원관련";break;
				case 3:
					ret="결재관련";break;
				case 4:
					ret="배송관련";break;
				case 9:
					ret="기타";break;
				case 91:
					ret="취소완료";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//FAQ 구분 조회
	public String getDevlType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="일배";break;
				case 2:
					ret="택배";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//결제수단 명칭 조회
	public String getPayType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 10:
					ret="신용카드";break;
				case 20:
					ret="계좌이체";break;
				case 30:
					ret="가상계좌(무통장)";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//구분1 명칭 조회
	public String getGubun1Name(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="칼로리조절식사";break;
				case 2:
					ret="칼로리조절프로그램";break;
				case 3:
					ret="기능식";break;
				case 50:
					ret="건강식품";break;
				case 60:
					ret="건강식품";break;					
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//구분2 명칭 조회
	public String getGubun2Name(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 11:
					ret="1식";break;
				case 12:
					ret="2식";break;
				case 13:
					ret="3식";break;
				case 14:
					ret="2식+간식";break;
				case 15:
					ret="3식+간식";break;
				case 16:
					ret="1식+간편식";break;
				case 21:
					ret="감량";break;
				case 22:
					ret="유지";break;
				case 23:
					ret="FULL-STEP";break;
				case 31:
					ret="시크릿스프(SS)";break;
				case 32:
					ret="밸런스쉐이크";break;
				case 33:
					ret="미니밀";break;
				case 34:
					ret="라이스";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	// 에디터로 입력했을때 자바에서 html 태그 을 모두 제거
	private String delHtmlTag(String param){
		Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>");
		Matcher m = p.matcher(param);
		param = m.replaceAll("").trim();
		//logger.debug("변환후: " + param);
		return param;
	}

	//html제거
	public String convertHtmlTags(String s) {
		s = s.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""); //정규식 태그삭제
		s = s.replaceAll("\r|\n|&nbsp;", " "); //엔터제거
		return s;
	} 

	//Replace String
	public String replaceString(String s, String s1, String s2){
		if( s == null || s1 == null || s2 == null || s1.length() == 0 ){
			return s;
		}
		
		int idx = -1;
		String re = "";
		while( ( idx = s.indexOf(s1)) != -1 ){
			re += s.substring(0,idx) + s2;
			if( idx+s1.length() > s.length() ){
				s = "";
			}else{
				s = s.substring(idx+s1.length());
			}
		}
		return re+s;
	}

	//개행문자를 <br>로 변경
	public String nl2br(String s){
		StringBuffer stringbuffer = new StringBuffer(s.length() + 300);
		for(int i = 0; i < s.length(); i++)
			if(s.charAt(i) == '\n')
				stringbuffer.append("<br />");
			else
				stringbuffer.append(s.charAt(i));

		return stringbuffer.toString();
	}

	//내용 보기를 위해 content 수정
	public String showContent(String s){
		s = nl2br(s);
		s = replaceString(s, "  ", "&nbsp;");
		s = replaceString(s, "\t", "&nbsp;&nbsp;");
		return s;
	}

	//글 자르기...
	public String cutString(int i, String s){
		StringBuffer stringbuffer = new StringBuffer(s.length() + 300);
		int j = 0;
		for(int k = 0; k < s.length(); k++)	{
			stringbuffer.append(s.charAt(k));
			if(Character.getType(s.charAt(k)) == 5)
				j += 2;
			else
				j++;
			if(s.charAt(k) == '\r' || s.charAt(k) == '\n')
				j = 0;
			if(k + 1 < s.length() && s.charAt(k + 1) != '\r' && j >= i)	{
				stringbuffer.append('\n');
				j = 0;
			}
		}
		return stringbuffer.toString();
	}

	//글 자르기...자른 글자 뒤에 s1 붙이기...	
	public String cutString(int i, String s, String s1){
		if(s == null || s.length() == 0)
			return "";
		int j = 0;
		int k = 0;
		int l = 0;
		for(int i1 = 0; i1 < s1.length(); i1++)
			k += s1.charAt(i1) <= '\377' ? 1 : 2;
	
		for(int j1 = 0; j1 < s.length() && j <= i; j1++){
			j += s.charAt(j1) <= '\377' ? 1 : 2;
			l = j + k > i ? l : j1 + 1;
		}
	
		if(j <= i)
			return s;
		else
			return s.substring(0, l) + s1;
	}
	
	//자바스크립트 alert창 띄움
	public boolean jsAlert(javax.servlet.jsp.JspWriter out, String alert) {
		try {
			out.println("<script type='text/javascript'>");
			out.println("<!--");
			out.println("alert('" + alert + "');");
			out.println("//-->");
			out.println("</script>");
			return true;
		} catch(Exception e) {
			return false;
		}
	}

	//자바스크립트 페이지 이동
	public boolean jsRedirect(javax.servlet.jsp.JspWriter out, String url) {
		try {
			out.println("<script type='text/javascript'>");
			out.println("<!--");
			out.println("location.replace('" + url + "');");
			out.println("//-->");
			out.println("</script>");
			return true;
		} catch(Exception e) {
			return false;
		}
	}

	//자바스크립트 페이지 이동 history.back
	public boolean jsBack(javax.servlet.jsp.JspWriter out) {
		try {
			out.println("<script type='text/javascript'>");
			out.println("<!--");
			out.println("history.back();");
			out.println("//-->");
			out.println("</script>");
			return true;
		} catch(Exception e) {
			return false;
		}
	}

	public String isnull(String param){
		String ret="";
		if(param==null || param.length()==0){ret="";}else{ret=param;}
		return ret;
	}

	public String setDateFormat(String param,int len){
		String ret="&nbsp;";
		if(param!=null && param.length()>0){
			ret=param.substring(0,len);
		}
		return ret;
	}

	public String setDateFormat(String param){
		String ret="&nbsp;";
		if(param!=null && param.length()>0){
			ret=param.substring(0,10);
		}
		return ret;
	}

	//SQL injection 방지
	public String inject(String ret) {
		if (ret!= null && ret.length()>0) {	
			ret=ret.replaceAll("alert","");
			ret=ret.replace("'","''");
			//ret=ret.replaceAll("\'","\'\'");
			/*ret=ret.replaceAll("\"","&quot;");
			ret=ret.replaceAll("&dbqua;","&quot;");
			ret=ret.replaceAll("<","&lt;");
			ret=ret.replaceAll(">","&gt;");*/
			ret=ret.replaceAll("script","s-cript");
			ret=ret.replaceAll("drop","");
			ret=ret.replaceAll("update","");
			ret=ret.replaceAll("select","");
			//ret=ret.replaceAll("delete","");
			ret=ret.replaceAll("insert","");
			ret=ret.replaceAll("\\\\","");
			return ret;
		} else {
			return "";
		}
	}

	//SQL injection 방지
	public String inject2(String ret) {
		if (ret!= null && ret.length()>0) {		
			ret=ret.replaceAll("onmouseover","");
			ret=ret.replaceAll("alert","");
			ret=ret.replace("'","''");
			//ret=ret.replaceAll("\'","\'\'");
			ret=ret.replaceAll("\"","");
			ret=ret.replaceAll("&dbqua;","&quot;");
			ret=ret.replaceAll("<","&lt;");
			ret=ret.replaceAll(">","&gt;");
			ret=ret.replaceAll("script","s-cript");
			ret=ret.replaceAll("drop","");
			ret=ret.replaceAll("update","");
			ret=ret.replaceAll("select","");
			//ret=ret.replaceAll("delete","");
			ret=ret.replaceAll("insert","");
			ret=ret.replaceAll("\\\\","");
			ret=ret.replaceAll("=","");
			return ret;
		} else {
			return "";
		}
	}
	
	// 숫자일때 참, 문자일때 거짓
	public boolean isNaN(String str) {
		boolean check = true;
		for (int i = 0; i < str.length(); i++) {
			if (!Character.isDigit(str.charAt(i))) {
				check = false;
				break;
			} // end if
		} //end for
		return check;
	}
	
	
	//-- 쿠키관련
	public void setCook(HttpServletResponse response ,String cookie_name,String cookie_value)
	{
	    try{
	       //Cookie cookie = new Cookie(cookie_name,cookie_value);
	       Cookie cookie = new Cookie(cookie_name,java.net.URLEncoder.encode(cookie_value,"utf-8") );
	       cookie.setMaxAge(-1); //-1 은 부라우져 닫을때 쿠키사라짐,0 이면 쿠키삭제
	       cookie.setPath("/");
	       response.addCookie(cookie);
	    }catch (Exception e){
	    //  e.printStackTrace();
	    }
	}
	public void delCook(HttpServletResponse response ,String cookie_name,String cookie_value)
	{
	    try{
	       //Cookie cookie = new Cookie(cookie_name,cookie_value);
	       Cookie cookie = new Cookie(cookie_name,java.net.URLEncoder.encode(cookie_value,"utf-8") );
	       cookie.setMaxAge(0); //-1 은 부라우져 닫을때 쿠키사라짐,0 이면 쿠키삭제
	       cookie.setPath("/");
	       response.addCookie(cookie);
	    }catch (Exception e){
	    //  e.printStackTrace();
	    }
	}
	public String getCook(HttpServletRequest request , String cookie_name ){
		String cookie_value = "";
		Cookie cookie[] = request.getCookies();
		if (cookie != null){
			for (int i = 0; i < cookie.length; i++) {
				if (cookie[i].getName().equals(cookie_name)){
					//cookie_value= (String)cookie[i].getValue() ;
					cookie_value= java.net.URLDecoder.decode(cookie[i].getValue());
					//System.out.println("<br>cookie_value=" + cookie_value);
					break;
				}
			}
		}
	    return cookie_value;
	}

	public String getComma(int comma){
		java.text.NumberFormat countComma = java.text.NumberFormat.getInstance();
		String commaS="";

		commaS = countComma.format(comma);
		return commaS;
	}

	public String getComma(String comma){
		if(isNaN(comma) ) return getComma(Integer.parseInt(comma));
		else return "";
	}
	
	public String getTimeStamp(int iMode) {
		String sFormat;
		if (iMode == 1) sFormat = "yyyy-MM-dd";
		else if (iMode == 2) sFormat = "yyyy";
		else if (iMode == 3) sFormat = "MM";
		else if (iMode == 4) sFormat = "dd";
		else if (iMode == 5) sFormat = "yyyyMMdd";
		else if (iMode == 6) sFormat = "HH";
		else if (iMode == 7) sFormat = "mm";
		else if (iMode == 8) sFormat = "ss";
		else if (iMode == 9) sFormat = "yyyyMMddHHmmss";
		else if (iMode == 10) sFormat = "HHmmss";
		else if(iMode == 11) sFormat = "yyyy-MM-dd HH:mm:ss";
        else if(iMode == 12) sFormat = "yyyy-MM-dd HH:mm:ss.SSSZ";
        else if(iMode == 13) sFormat = "E MMM dd HH:mm:ss z yyyy";// Wed Feb 03 15:26:32 GMT+09:00 1999
        else if(iMode == 14) sFormat = "yyyyMM";
		else sFormat = "yyyy-MM-dd";

		Locale locale = new Locale("en", "EN");
		SimpleDateFormat formatter = new SimpleDateFormat(sFormat, locale);

		return formatter.format(new Date());
	}


	//<!----------------------------------------------------------------------------------------
	// 임의의 숫자
	//<!----------------------------------------------------------------------------------------
    public String randomNumber(int rnd_length) {
        String possible = "0123456789";
        String str = "";
        Random rnd = new Random();
        int rnd_pos ;
        while(str.length()< rnd_length)  {
            rnd_pos = (int)(rnd.nextDouble()*possible.length());
            str = str + possible.substring(rnd_pos, rnd_pos+1);
        }
        return str;
    }	
}
%>