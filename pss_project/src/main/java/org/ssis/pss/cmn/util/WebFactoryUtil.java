
package org.ssis.pss.cmn.util;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.ParseException;
import org.ssis.pss.cmn.model.ZValue;

/**
 * WebFactoryUtil.java Class title
 * 
 * <p><ul><li>The WebFactoryUtil.java description.</li></ul>
 *
 * @version 1.0.0
 * @since 2013. 11. 12.
 */

public class WebFactoryUtil {

	protected static Log log = LogFactory.getLog(WebFactoryUtil.class); 

	// 디비 스키마명
	//private static String cuser = EgovProperties.getProperty("db.cuser");
	
	@SuppressWarnings("rawtypes")
	public static ZValue getAttributes(HttpServletRequest request) {
		ZValue zvl = new ZValue();
		String name = "";
		Enumeration e = request.getParameterNames();
		while (e.hasMoreElements()) {
			name = (String) e.nextElement();
			
			String value = request.getParameter(name);
			String[] values = request.getParameterValues(name);

			if (values != null && values.length > 1){
				zvl.put(name, values);
			}else{
				zvl.put(name, value);
			}
			
		}
		return zvl; 
	}
	
	public static String getReXSSFilter(String setValue) {

		setValue = setValue.replaceAll("&amp;", "&");
		setValue = setValue.replaceAll("&amp;", "&");
		setValue = setValue.replaceAll("&lt;", "<");
		setValue = setValue.replaceAll("&gt;", ">");
		setValue = setValue.replaceAll("&quot;", "\"");
		setValue = setValue.replaceAll("&apos;", "'");
		
		return setValue;
	}
	
	@SuppressWarnings("rawtypes")
	public static ZValue getAllAttributes(HttpServletRequest request) {
		ZValue zvl = new ZValue();
		String name = "";
		Enumeration e = request.getParameterNames();
		String temp_param_url = ""; // 항상 가지고 다녀야 할 파라미터들...
		while (e.hasMoreElements()) {
			name = (String) e.nextElement();
			if (name.indexOf("tsch")>-1 || name.indexOf("ttxt")>-1 || name.indexOf("parent")>-1){
				if (temp_param_url.length()>0){ 
					temp_param_url+="&";
				}
				temp_param_url+= name + "=" + request.getParameter(name);
			}
			
			String value = request.getParameter(name);
			value = getReXSSFilter(value);
			String[] values = request.getParameterValues(name);
			
			
			
				/* 캐릭터셋 설정 관련 디버그 모드 */
				/*
				try {
				log.debug("utf-8 -> euc-kr        : " + new String(value.getBytes("utf-8"), "euc-kr"));
				log.debug("utf-8 -> ksc5601       : " + new String(value.getBytes("utf-8"), "ksc5601"));
				log.debug("utf-8 -> x-windows-949 : " + new String(value.getBytes("utf-8"), "x-windows-949"));
				log.debug("utf-8 -> iso-8859-1    : " + new String(value.getBytes("utf-8"), "iso-8859-1"));

				log.debug("iso-8859-1 -> euc-kr        : " + new String(value.getBytes("iso-8859-1"), "euc-kr"));
				log.debug("iso-8859-1 -> ksc5601       : " + new String(value.getBytes("iso-8859-1"), "ksc5601"));
				log.debug("iso-8859-1 -> x-windows-949 : " + new String(value.getBytes("iso-8859-1"), "x-windows-949"));
				log.debug("iso-8859-1 -> utf-8         : " + new String(value.getBytes("iso-8859-1"), "utf-8"));

				log.debug("euc-kr -> utf-8         : " + new String(value.getBytes("euc-kr"), "utf-8"));
				log.debug("euc-kr -> ksc5601       : " + new String(value.getBytes("euc-kr"), "ksc5601"));
				log.debug("euc-kr -> x-windows-949 : " + new String(value.getBytes("euc-kr"), "x-windows-949"));
				log.debug("euc-kr -> iso-8859-1    : " + new String(value.getBytes("euc-kr"), "iso-8859-1"));

				log.debug("ksc5601 -> euc-kr        : " + new String(value.getBytes("ksc5601"), "euc-kr"));
				log.debug("ksc5601 -> utf-8         : " + new String(value.getBytes("ksc5601"), "utf-8"));
				log.debug("ksc5601 -> x-windows-949 : " + new String(value.getBytes("ksc5601"), "x-windows-949"));
				log.debug("ksc5601 -> iso-8859-1    : " + new String(value.getBytes("ksc5601"), "iso-8859-1"));

				log.debug("x-windows-949 -> euc-kr     : " + new String(value.getBytes("x-windows-949"), "euc-kr"));
				log.debug("x-windows-949 -> utf-8      : " + new String(value.getBytes("x-windows-949"), "utf-8"));
				log.debug("x-windows-949 -> ksc5601    : " + new String(value.getBytes("x-windows-949"), "ksc5601"));
				log.debug("x-windows-949 -> iso-8859-1 : " + new String(value.getBytes("x-windows-949"), "iso-8859-1"));
				
				} catch (UnsupportedEncodingException ex) {
					ex.printStackTrace();
				}
				*/
			
//			if (request.getParameter("encoding")!=null && !request.getParameter("encoding").equals("")){
//				
//				try {
//					//value = new String(value.getBytes(request.getParameter("encoding")),"utf-8");
//					
//					if (request.getMethod().equals("GET") || request.getMethod().equals("get")) {
//						value = new String(value.getBytes("iso-8859-1"),"utf-8");
//
//						for (int idx=0; values != null && idx<values.length; idx++){
//							values[idx] = new String(values[idx].getBytes("iso-8859-1"),"utf-8");
//						}
//					} 
//					
//					
//				} catch (UnsupportedEncodingException e1) {
//					e1.printStackTrace();
//				}
				
				
//			}
			
			// zvl.put(name, request.getParameter(name));
			
			if (values != null && values.length > 1){
				zvl.put(name, values);
			}else{
				zvl.put(name, value);
			}
				
				
		} 
		zvl.put("params", temp_param_url);
		return zvl; 
	}
	
	public static String getID(HttpServletRequest request){
		String id = "";
		String return_id = null;
		String url = request.getRequestURI();
		if (url.indexOf("/crm/")>-1){
			String[] temp = url.split("/");
			if (temp.length>2){
				return_id = temp[2];
			}
		} else {
			id = url.substring(url.lastIndexOf("/")+1, url.length()) ;
			String[] temp = id.split("[.]");
			if (temp.length>0){
				return_id = temp[0];
			}
		}
		return return_id;
	}

	public static ZValue getAttributesInit(HttpServletRequest request) {
		ZValue zvl = getAllAttributes(request);
		zvl.put("uBeanId", getID(request)); 

		return zvl; 
	} 
	
	
	public static ArrayList<Object> getAttributesArrayInit(HttpServletRequest request) throws ParseException {
		ArrayList<Object> retVal = new ArrayList<Object>();
		
		ZValue zvl = getAllAttributes(request);
		zvl.put("uBeanId", getID(request)); 	
		JSONArray jsonArray = (JSONArray)JSONValue.parseWithException( zvl.getString("paramObjArray").replaceAll("&quot;", "\\\"") );		
		JSONObject jsonObject = null;
		
		List<ZValue> lstzvl = new ArrayList<ZValue>();
		for(int i=0; i<jsonArray.size(); i++){
			jsonObject = (JSONObject)jsonArray.get(i);
			Iterator<?> iter = jsonObject.keySet().iterator();
			ZValue nzvl = new ZValue();
			while(iter.hasNext()){
				String key = (String)iter.next();
				log.debug( "key : " + key + " value : " + String.valueOf(jsonObject.get(key)) );
				
				nzvl.put(key, String.valueOf(jsonObject.get(key)));
			}
			lstzvl.add( nzvl );
		}
		
		retVal.add(zvl);
		retVal.add(lstzvl);
		return retVal; 
	} 
	
	
	
	public static void printHtml(
			HttpServletResponse response, String msg,String forwardUrl
		) throws Exception {
		 
		response.setContentType("text/html;charset=utf-8"); 
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html>");
		out.println("<head>");		
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
        out.println("<meta http-equiv=\"refresh\" content=\"1;url=" + forwardUrl + " \">");
		out.println("<script type=\"text/javascript\">");
		if (msg!=null && !msg.equals("")){
		out.println("alert('" + msg + "');");
		}
		out.println("location.href='" + forwardUrl + "';");
		out.println("</script><noscript>");
		out.println("새로운 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/>1초 후 자동으로 이동합니다.");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
	}
	 
	
	
}