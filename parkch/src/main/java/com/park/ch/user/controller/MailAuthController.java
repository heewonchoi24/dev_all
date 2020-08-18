package com.park.ch.user.controller;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.park.ch.cmn.LoginVO;
import com.park.ch.cmn.encrypt.AES256Util;
import com.park.ch.user.service.UserService;

@Controller
public class MailAuthController extends MailSendController {

	@Autowired
	private UserService UserService;	
	
	/**
	 * 비밀번호 찾기 - 초기화 
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sendMailtoResetUserPw.do") 
	public HashMap<String, Object> sendMailtoFindUserPw(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest req, @RequestParam Map<String, String> param) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 회원 정보 확인
		LoginVO resultVO = new LoginVO();
		loginVO.setUserId(req.getParameter("u_id"));
		
		String userEmail = req.getParameter("u_email");
		
	    try {
			resultVO = UserService.userInfo(loginVO);
			
		    if(resultVO == null || !userEmail.equals(resultVO.getUserEmail())){
				map.put("messageCd", "N");
				map.put("message", "회원 정보가 존재하지 않습니다.");
				return map;
		    }
		    
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	    
		Properties prop = System.getProperties();
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.port", "587");

		Authenticator auth = new MailAuthController();

		Session session = Session.getDefaultInstance(prop, auth);

		MimeMessage msg = new MimeMessage(session);

		String send_email = "chungheeparkcorp@gmail.com";
		String send_nm = "(사) 박정희 대통령 정신문화 선양회";

		String res_email = (String) param.get("u_email");

		try {

			// 이메일 주소 
			param.put("u_email", res_email);

			// 비밀번호 암호화 salt
			String salt = AES256Util.generateSalt();
			param.put("salt", salt);

			String tempPassword = getRamdomPassword(10);

			// 비밀번호 암호화 AES256Util
			String uPw = tempPassword.toString();
			uPw = AES256Util.getEncrypt(uPw, salt);
			param.put("u_pw", uPw);

			try {
				UserService.updateUserPassword(param);
			} catch (Exception e) {
				e.printStackTrace();
			}

			msg.setSentDate(new Date());

			msg.setFrom(new InternetAddress(send_email, send_nm));
			InternetAddress to = new InternetAddress(res_email);         
			msg.setRecipient(Message.RecipientType.TO, to);            
			msg.setSubject("비밀번호를 재설정하십시오.", "UTF-8");            
			msg.setText("안녕하세요 회원님, "
					+ "\r\n \r\n 회원님께서는 비밀번호 재설정을 진행하셨으며, 임시 비밀번호를 드리기 위해 메일을 보내드렸습니다."
					+ "\r\n \r\n " + tempPassword , "UTF-8");            

			Transport.send(msg);

			map.put("messageCd", "Y");
			map.put("message", "이메일이 발송되었습니다.");

		} catch(AddressException ae) {            
			System.out.println("AddressException : " + ae.getMessage());      
		} catch(MessagingException me) {            
			System.out.println("MessagingException : " + me.getMessage());
		} catch(UnsupportedEncodingException e) {
			System.out.println("UnsupportedEncodingException : " + e.getMessage());			
		}

		return map;

	}

	/**
	 * 회원가입 및 마이페이지 - 이메일 인증 
	 * @param param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sendMailtoCertifyEmailAddress.do") 
	public HashMap<String, Object> sendMailtoCertifyEmailAddress(@RequestParam Map<String, String> param) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		Properties prop = System.getProperties();
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.port", "587");

		Authenticator auth = new MailAuthController();

		Session session = Session.getDefaultInstance(prop, auth);

		MimeMessage msg = new MimeMessage(session);

		String send_email = "chungheeparkcorp@gmail.com";
		String send_nm = "(사) 박정희 대통령 정신문화 선양회";

		String res_mail = (String) param.get("u_email");

		StringBuffer tempAuthCode = getRandomAuthCode();

		try {

			msg.setSentDate(new Date());

			msg.setFrom(new InternetAddress(send_email, send_nm));
			InternetAddress to = new InternetAddress(res_mail);         
			msg.setRecipient(Message.RecipientType.TO, to);            
			msg.setSubject("인증코드를 입력하세요.", "UTF-8");            
			msg.setText("회원님의 이메일 인증코드는 " + tempAuthCode + "입니다.", "UTF-8");  

			Transport.send(msg);

			map.put("messageCd", "Y");
			map.put("message", "이메일이 발송되었습니다.");
			map.put("authCode", tempAuthCode);            

		} catch(AddressException ae) {            
			System.out.println("AddressException : " + ae.getMessage());    
			map.put("messageCd", "N");
			map.put("message", "이메일 발송이 실패하였습니다. 다시 시도하여 주십시오.");
		} catch(MessagingException me) {            
			System.out.println("MessagingException : " + me.getMessage());
			map.put("messageCd", "N");
			map.put("message", "이메일 발송이 실패하였습니다. 다시 시도하여 주십시오.");            
		} catch(UnsupportedEncodingException e) {
			System.out.println("UnsupportedEncodingException : " + e.getMessage());	
			map.put("messageCd", "N");
			map.put("message", "이메일 발송이 실패하였습니다. 다시 시도하여 주십시오.");            
		} 

		return map;

	}

	/**
	 * 암호 코드 랜덤 생성
	 * @return
	 */
	public static StringBuffer getRandomAuthCode() { 

		StringBuffer sb = new StringBuffer();

		Random rnd = new Random();
		for (int i = 0; i < 9; i++) {
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 1:
				// A-Z
				sb.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:
				// 0-9
				sb.append((rnd.nextInt(10)));
				break;
			}
		}

		return sb;
	}
	
	/**
	 * 임시 비밀번호 랜덤 생성 
	 * @param len
	 * @return
	 */
	public static String getRamdomPassword(int len) { 
		
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }; int idx = 0;
		
		StringBuffer sb = new StringBuffer(); 
		
		for (int i = 0; i < len; i++) { 
			idx = (int) (charSet.length * Math.random()); // 36 * 생성된 난수를 Int로 추출 (소숫점제거) 
			sb.append(charSet[idx]); 
		} 
		
		return sb.toString(); 
	}

}

