package com.park.ch;


import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.park.ch.board.service.BoardService;
import com.park.ch.cmn.SessionVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	BoardService BoardService;
	
	/**
	 * 메인 화면 
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest req, Model model, @RequestParam Map<String, String> param) {// 세션을 가져온다. (가져올 세션이 없다면 생성한다.)
		HttpSession session = req.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		 
		if(userInfo != null) {
			model.addAttribute("userinfo", userInfo);
		}
		
		try {
			model.addAttribute("boardTopContent", BoardService.getBoardTopContent(param));
			model.addAttribute("boardBotContentList", BoardService.getBoardBotContentList(param));
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return "index";
	}
	
	/**
	 * 소개 메뉴 
	 * @param locale
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/aboutus.do")
	public String aboutus(Locale locale, Model model) throws Exception {
		return "aboutus";
	}
	
	/**
	 * 갤러리 메뉴 
	 * @param locale
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/gallery.do")
	public String gallery(Locale locale, Model model) throws Exception {
		return "gallery";
	}	
	/**
	 * 오시는 길 메뉴 
	 * @param locale
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/contactus.do")
	public String contactus(Locale locale, Model model) throws Exception {
		return "contactus";
	}
	
	/**
	 * 메인 화면 팝업 공지 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/popup/noticePopup.do")
	public ModelAndView popNotice(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		
		try{
			mv.setViewName( "popup/noticePopup" );
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return mv;	
	}		
	
}
