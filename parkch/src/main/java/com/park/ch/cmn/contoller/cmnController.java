package com.park.ch.cmn.contoller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.park.ch.cmn.SessionVO;

public class cmnController {
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		// URL 직접 입력시 로그인 페이지로 이동
		String referer = request.getHeader("REFERER");
		
		if (referer == null || "".equals(referer)) {
			response.sendRedirect("/");
			return false;
		}
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		// 세션 종료
		if(null == userInfo) {
			response.sendRedirect("/login/invaliSession.do");
			return false;
		}
		
		return true;
	}	
	
	/**
	 * 메인 페이지 이동
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/login/invaliSession.do")
	public ModelAndView invaliSession(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("redirect:/");
		modelAndView.addObject("messageCd", "session");
		
		return modelAndView;
	}
}
