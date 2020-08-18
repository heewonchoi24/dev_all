<%
/**
 * @file : util.jsp
 * @date : 2013-09-11
 * @author : Kim Hyungseok
 */
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
class GoodsUtil {
	//구분1 명칭 조회
	public String getGubun1Name(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="식사다이어트";break;
				case 2:
					ret="프로그램다이어트";break;
				case 3:
					ret="타입별다이어트";break;
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
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}
}

GoodsUtil gu				= new GoodsUtil();
%>