package com.park.ch.user.controller;


import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.park.ch.cmn.LoginVO;
import com.park.ch.cmn.SessionVO;
import com.park.ch.cmn.encrypt.AES256Util;
import com.park.ch.user.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService UserService;
	
	/**
	 * 로그인 
	 * @param loginVO
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/user/login.do")
	public HashMap<String, Object> login(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest req) throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		LoginVO resultVO = new LoginVO();
		SessionVO sessionVO = new SessionVO();

		String userPw = loginVO.getUserPw();
	    
		try {
			resultVO  = UserService.userInfo(loginVO);
			if (resultVO != null) {
				// 세션에 저장 
				BeanUtils.copyProperties(resultVO, sessionVO);
				req.getSession().setAttribute("userInfo", sessionVO);
		        
				userPw = AES256Util.getEncrypt(userPw, resultVO.getSalt());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//로그인 성공 체크
		if (resultVO != null && resultVO.getUserPw().equals(userPw)) {
			map.put("message", "로그인 되었습니다.");
			map.put("messageCd", "Y");
			map.put("url", "/");
		}else{
			map.put("message", "회원정보가 올바르지 않습니다.");
			map.put("messageCd", "N");
		}
        
        return map;
	}
	
	/**
	 * 회원가입
	 * @param loginVO
	 * @param req
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/user/insertUser.do")
	public ModelAndView insertUser(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest req, @RequestParam Map<String, String> param) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		SessionVO sessionVO = new SessionVO();
		LoginVO resultVO = new LoginVO();
		
		// 회원 넘버 생성 
		String randomUno = "";
	    int d = 0;
	    for (int i = 1; i <= 20; i++){
		    Random r = new Random();
		    d = r.nextInt(9);
		    randomUno = randomUno + Integer.toString(d);
	    }
		String uNo = randomUno;
		param.put("u_no", uNo);
		
		// 비밀번호 암호화 salt
		String salt = AES256Util.generateSalt();
		param.put("salt", salt);
		
		// 비밀번호 암호화 AES256Util
		String uPw = req.getParameter("u_pw");
		uPw = AES256Util.getEncrypt(uPw, salt);
		param.put("u_pw", uPw);
		
		// ip
		String clientIp = req.getRemoteAddr();
		param.put("u_ip", clientIp);
		
		try {
			UserService.insertUser(param);
			mv.setViewName("redirect:/user/finalJoinPage.do");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		loginVO.setUserId(req.getParameter("u_id"));
	    loginVO.setUserPw(uPw);
		
	    resultVO = UserService.userInfo(loginVO);
	    
	    BeanUtils.copyProperties(resultVO, sessionVO);
	    //session에 유저정보 저장
		req.getSession().setAttribute("userInfo", sessionVO);
		
		// 세션 삭제 
		HttpSession session = req.getSession();
		if(req.isRequestedSessionIdValid()){
			session.invalidate();
		}
		
		return mv;
	}
	
	/**
	 * 회원가입 수정 
	 * @param req
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/user/updateUser.do")
	public ModelAndView updateUser(HttpServletRequest req, @RequestParam Map<String, String> param) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		SessionVO sessionVO = new SessionVO();
		LoginVO resultVO = new LoginVO();
		
		// 비밀번호 암호화 salt
		String salt = AES256Util.generateSalt();
		param.put("salt", salt);
		
		// 비밀번호 암호화 AES256Util
		String uPw = req.getParameter("u_pw");
		uPw = AES256Util.getEncrypt(uPw, salt);
		param.put("u_pw", uPw);
		
		try {
			UserService.updateUser(param);
			mv.setViewName("redirect:/user/logout.do");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mv;
	}
	
	/**
	 * 회원 탈퇴 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/user/deleteUser.do")
	public ModelAndView deleteUser(@RequestParam Map<String, String> param) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		SessionVO sessionVO = new SessionVO();
		LoginVO resultVO = new LoginVO();
		
		try {
			UserService.deleteUser(param);
			mv.setViewName("redirect:/user/logout.do");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mv;
	}	
	
	/**
	 * 회원가입 화면 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/joinPage.do")
	public String joinPage() throws Exception {
		return "joinPage";
	}
	
	/**
	 * 회원가입 시 아이디 중복 체크
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/user/idDupChk.do")
	public HashMap<String, Object> idDupChk(@RequestParam Map<String, String> param) throws Exception { 
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int cntId = 0;
		
		try{
			cntId = UserService.idDupChk(param);
			
			if(cntId == 0) {
				map.put("message", "사용가능한 아이디입니다.");
				map.put("messageCd", "Y");
			}else {
				map.put("message", "사용 불가능한 아이디입니다.");
				map.put("messageCd", "N");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
			    
		return map; 	   
	}
	
	/**
	 * 회원가입 결과 페이지 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/finalJoinPage.do")
	public String finalJoinPage(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		// URL 직접 입력시 로그인 페이지로 이동
		String referer = req.getHeader("REFERER");
		if (referer == null || "".equals(referer)) {
			return "index";
		}
		
		return "finalJoinPage";
	}
	
	/**
	 * 주소 팝업
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/popup/jusoPopup.do")
	public String jusoPopup() throws Exception {
		return "/popup/jusoPopup";
	}
	
	/**
	 * 약관동의 팝업 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/popup/privacyPopup.do", method = RequestMethod.GET)
	public String privacyPopUp() throws Exception {
		return "/popup/privacyPopup";
	}
	
	/**
	 * 로그아웃
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/user/logout.do")
	public ModelAndView logout(HttpServletRequest req) throws Exception { 
		
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = req.getSession();

		if(req.isRequestedSessionIdValid()){
			session.invalidate();
		}
		
		modelAndView.setViewName("index");
		
		return modelAndView;
	}
	
	/**
	 * 마이페이지(회원정보수정)
	 * @param loginVO
	 * @param model
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/user/mypage.do")
	public ModelAndView maypage(@ModelAttribute("loginVO") LoginVO loginVO, Model model, HttpServletRequest req) throws Exception { 
		
		ModelAndView mv = new ModelAndView();
		HttpSession session = req.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		loginVO.setUserId(userInfo.getUserId());
		LoginVO result = (LoginVO) UserService.userInfo(loginVO);
		
		model.addAttribute("userId",    result.getUserId());
		model.addAttribute("userNm",    result.getUserNm());
		model.addAttribute("userTelno", result.getUserTelno());
		model.addAttribute("userEmail", result.getUserEmail());
		model.addAttribute("userAddr",  result.getUserAddr());
		model.addAttribute("agreeYn",   result.getAgreeYn());
		model.addAttribute("recUid",    result.getRecUid());

		mv.setViewName("mypage");
		
		return mv;
	}
	
	/**
	 * 아이디/비밀번호 찾기 화면 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/user/findUserInfoPage.do")
	public String findUserInfoPage() throws Exception {
		return "findUserInfoPage";
	}	
	
	/**
	 * 아이디 찾기 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/user/userFindId.do")
	public HashMap<String, Object> userFindId(@RequestParam Map<String, String> param) throws Exception { 
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
		try {
			LoginVO resultVO = (LoginVO) UserService.userFindId(param);
			
			if(resultVO != null) {
				returnMap.put("userId",    resultVO.getUserId());
				returnMap.put("messageCd", "Y");
			}else {
				returnMap.put("message",   "회원정보가 존재하지 않습니다.");
				returnMap.put("messageCd", "N");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return returnMap;
	}
		
}
