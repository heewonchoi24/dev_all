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
	//����1 ��Ī ��ȸ
	public String getGubun1Name(String param){
		String ret="";
		if(param!=null && param.length()>0){
			switch(Integer.parseInt(param)){
				case 1:
					ret="�Ļ���̾�Ʈ";break;
				case 2:
					ret="���α׷����̾�Ʈ";break;
				case 3:
					ret="Ÿ�Ժ����̾�Ʈ";break;
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
				default:
					ret="&nbsp;";break;
			}
		}
		return ret;
	}
}

GoodsUtil gu				= new GoodsUtil();
%>