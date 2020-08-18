package com.park.ch.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.park.ch.cmn.LoginVO;
import com.park.ch.user.service.UserService;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class PhoneAuthController {
	
	@Autowired
	private UserService UserService;	
	
	private String api_key = "NCSOOYGPE7KS1MGX";
	private String api_secret = "XXAULPASTD6RV2BG8I5TOA9MKMFQMOKI";
	
	HashMap<String, Object> returnMap = new HashMap<String, Object>();
	HashMap<String, String> params = new HashMap<String, String>();

	/**
	 * 휴대폰 인증번호 발송
	 * @param loginVO
	 * @param req
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sendPHAuthCode.do") 
	public HashMap<String, Object> sendSmsToIdentifyPersonal(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest req, @RequestParam Map<String, String> param) {
	    
		String telNo = req.getParameter("u_telno");
		String authCode = getRamdomAuthCode(5);
		
	    Message coolsms = new Message(api_key, api_secret);

	    params.put("to", telNo);
	    params.put("from", "01055759893");
	    params.put("type", "SMS");
	    params.put("text", "[(사) 박정희 대통령 정신문화 선양회] 인증번호["+ authCode +"]를 입력해주세요." );
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	      
	      returnMap.put("authCode",  authCode);
	      returnMap.put("messageCd", "Y");
	      returnMap.put("message",   "인증번호가 발송되었습니다.");	      
	      
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	      
	      returnMap.put("authCode",  authCode);
	      returnMap.put("messageCd", "N");
	      returnMap.put("message",   "인증번호가 발송이 실패했습니다. 다시 시도해주십시오.");	    	      
	    }
	    
	    return  returnMap;
	}
	
	/**
	 * 비밀번호 찾기 - 비밀번호 재설정 
	 * @param loginVO
	 * @param req
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sendSmsToResetUserPw.do") 
	public HashMap<String, Object> sendSmsToResetUserPw(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest req, @RequestParam Map<String, String> param) {
		
		// 회원 정보 확인
		LoginVO resultVO = new LoginVO();
		loginVO.setUserId(req.getParameter("u_id"));
		String userTelno = req.getParameter("u_telno");
		
	    try {
			resultVO = UserService.userInfo(loginVO);
			
			if(resultVO == null || !userTelno.equals(resultVO.getUserTelno())){
				returnMap.put("messageCd", "N");
				returnMap.put("message", "회원정보가 존재하지 않습니다.");
				return returnMap;
		    }
		
			String authCode = getRamdomPassword(7);
		    Message coolsms = new Message(api_key, api_secret);

		    params.put("to",   userTelno);
		    params.put("from", "01055759893");
		    params.put("type", "SMS");
		    params.put("text", "[(사) 박정희 대통령 정신문화 선양회] 임시 비밀번호["+ authCode +"]" );
		    params.put("app_version", "test app 1.2"); // application name and version
		    
		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		      
		      returnMap.put("authCode",  authCode);
		      returnMap.put("messageCd", "Y");
		      returnMap.put("message",   "문자가 발송되었습니다.");	      
		      
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
		    
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	    
		return returnMap;

	}
	
	/**
	 * 휴대폰 인증번호 생성 
	 * @param len
	 * @return
	 */
	public static String getRamdomAuthCode(int len) { 
		
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' }; 
		int idx = 0;
		StringBuffer sb = new StringBuffer(); 
		
		for (int i = 0; i < len; i++) { 
			idx = (int) (charSet.length * Math.random());
			sb.append(charSet[idx]); 
		} 
		
		return sb.toString(); 
	}
	
	/**
	 * 임시 비밀번호 생성 
	 * @param len
	 * @return
	 */
	public static String getRamdomPassword(int len) { 
		
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }; 
		int idx = 0;
		StringBuffer sb = new StringBuffer(); 
		
		for (int i = 0; i < len; i++) { 
			idx = (int) (charSet.length * Math.random());
			sb.append(charSet[idx]); 
		} 
		
		return sb.toString(); 
	}	
	
}

