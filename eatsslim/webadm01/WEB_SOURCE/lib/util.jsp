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
	//1:1 �������� ��ȸ
	public String getCounselType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="���";break;
				case 2:
					ret="���";break;
				case 3:
					ret="��ǰ�̿�";break;
				case 4:
					ret="�ֹ�����";break;
				case 5:
					ret="���񽺰���";break;
				case 9:
					ret="��Ÿ";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//���̾�Ʈ�÷� ����
	public String getPostType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="Į�θ������Ļ�";break;
				case 2:
					ret="Į�θ��������α׷�";break;
				case 3:
					ret="Į�θ��������α׷�";break;
				case 4:
					ret="�̺�Ʈ�ı�";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//��һ��� ��ȸ
	public String getCanceReasonType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="�����ǻ����";break;
				case 2:
					ret="��ǰ �߸� �ֹ�";break;
				case 3:
					ret="��ǰ���� ����";break;
				case 4:
					ret="���� �� ��ǰ �Ҹ���";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//�̺�Ʈ ���� ��ȸ
	public String getEventType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="EVENT";break;
				case 2:
					ret="SALE";break;
				case 3:
					ret="�귣����ũ";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//������� ����� �ڵ�
	public String getBankCode(String param){
		String ret="0";
		if(param!=null && param.length()>0){
			if(param.equals("�泲")){
				ret="39";
			}else if(param.equals("����")){
				ret="06";
			}else if(param.equals("���")){
				ret="03";
			}else if(param.equals("����")){
				ret="11";
			}else if(param.equals("�뱸")){
				ret="31";
			}else if(param.equals("�λ�")){
				ret="32";
			}else if(param.equals("����")){
				ret="07";
			}else if(param.equals("����")){
				ret="26";
			}else if(param.equals("��ȯ")){
				ret="05";
			}else if(param.equals("�츮")){
				ret="20";
			}else if(param.equals("��ü��")){
				ret="71";
			}else if(param.equals("�ϳ�")){
				ret="81";
			}
		}
		return ret;
	}
	
	//�ֹ����� ��ȸ
	public String getOrderState(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 0:
					ret="�ֹ�����";break;
				case 1:
					ret="�����Ϸ�";break;
				case 2:
					ret="��ǰ�غ���";break;
				case 3:
					ret="�����";break;
				case 4:
					ret="��ۿϷ�";break;
				case 5:
					ret="�ֹ��Ϸ�";break;
				case 90:
					ret="��ҿ�û";break;
				case 901:
					ret="�κ���ҿ�û";break;
				case 91:
					ret="��ҿϷ�";break;
				case 911:
					ret="�κ���ҿϷ�";break;
				case 92:
					ret="��ǰ��û";break;
				case 921:
					ret="�κй�ǰ��û";break;
				case 93:
					ret="��ǰ�Ϸ�";break;
				case 931:
					ret="�κй�ǰ�Ϸ�";break;
				case 94:
					ret="��ȯ��û";break;
				case 941:
					ret="�κб�ȯ��û";break;
				case 95:
					ret="��ȯ�Ϸ�";break;
				case 951:
					ret="�κб�ȯ�Ϸ�";break;
				case 96:
					ret="ȯ�ҿ�û";break;
				case 97:
					ret="ȯ�ҿϷ�";break;
				case 971:
					ret="�κ�ȯ�ҿϷ�";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//FAQ ���� ��ȸ
	public String getFaqType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="��ȯ/ȯ��";break;
				case 2:
					ret="ȸ������";break;
				case 3:
					ret="�������";break;
				case 4:
					ret="��۰���";break;
				case 9:
					ret="��Ÿ";break;
				case 91:
					ret="��ҿϷ�";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//FAQ ���� ��ȸ
	public String getDevlType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="�Ϲ�";break;
				case 2:
					ret="�ù�";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//�������� ��Ī ��ȸ
	public String getPayType(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 10:
					ret="�ſ�ī��";break;
				case 20:
					ret="������ü";break;
				case 30:
					ret="�������(������)";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//����1 ��Ī ��ȸ
	public String getGubun1Name(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="Į�θ������Ļ�";break;
				case 2:
					ret="Į�θ��������α׷�";break;
				case 3:
					ret="��ɽ�";break;
				case 50:
					ret="�ǰ���ǰ";break;
				case 60:
					ret="�ǰ���ǰ";break;					
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	//����2 ��Ī ��ȸ
	public String getGubun2Name(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 11:
					ret="1��";break;
				case 12:
					ret="2��";break;
				case 13:
					ret="3��";break;
				case 14:
					ret="2��+����";break;
				case 15:
					ret="3��+����";break;
				case 16:
					ret="1��+�����";break;
				case 21:
					ret="����";break;
				case 22:
					ret="����";break;
				case 23:
					ret="FULL-STEP";break;
				case 31:
					ret="��ũ������(SS)";break;
				case 32:
					ret="�뷱������ũ";break;
				case 33:
					ret="�̴Ϲ�";break;
				case 34:
					ret="���̽�";break;
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}

	// �����ͷ� �Է������� �ڹٿ��� html �±� �� ��� ����
	private String delHtmlTag(String param){
		Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>");
		Matcher m = p.matcher(param);
		param = m.replaceAll("").trim();
		//logger.debug("��ȯ��: " + param);
		return param;
	}

	//html����
	public String convertHtmlTags(String s) {
		s = s.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""); //���Խ� �±׻���
		s = s.replaceAll("\r|\n|&nbsp;", " "); //��������
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

	//���๮�ڸ� <br>�� ����
	public String nl2br(String s){
		StringBuffer stringbuffer = new StringBuffer(s.length() + 300);
		for(int i = 0; i < s.length(); i++)
			if(s.charAt(i) == '\n')
				stringbuffer.append("<br />");
			else
				stringbuffer.append(s.charAt(i));

		return stringbuffer.toString();
	}

	//���� ���⸦ ���� content ����
	public String showContent(String s){
		s = nl2br(s);
		s = replaceString(s, "  ", "&nbsp;");
		s = replaceString(s, "\t", "&nbsp;&nbsp;");
		return s;
	}

	//�� �ڸ���...
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

	//�� �ڸ���...�ڸ� ���� �ڿ� s1 ���̱�...	
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
	
	//�ڹٽ�ũ��Ʈ alertâ ���
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

	//�ڹٽ�ũ��Ʈ ������ �̵�
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

	//�ڹٽ�ũ��Ʈ ������ �̵� history.back
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

	//SQL injection ����
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

	//SQL injection ����
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
	
	// �����϶� ��, �����϶� ����
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
	
	
	//-- ��Ű����
	public void setCook(HttpServletResponse response ,String cookie_name,String cookie_value)
	{
	    try{
	       //Cookie cookie = new Cookie(cookie_name,cookie_value);
	       Cookie cookie = new Cookie(cookie_name,java.net.URLEncoder.encode(cookie_value,"utf-8") );
	       cookie.setMaxAge(-1); //-1 �� �ζ���� ������ ��Ű�����,0 �̸� ��Ű����
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
	       cookie.setMaxAge(0); //-1 �� �ζ���� ������ ��Ű�����,0 �̸� ��Ű����
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
	// ������ ����
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