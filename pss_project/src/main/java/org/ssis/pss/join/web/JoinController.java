package org.ssis.pss.join.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.SHAPasswordEncoder;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.join.service.JoinService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.SessionVO;

@Controller
public class JoinController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private JoinService JoinService;
	
	@Autowired
	private UserService UserService;
	
	@Autowired
	private CmnService PssCommonService;
	
	/**
	 * 회원가입 약관 화면
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/join/join01.do")
	public ModelAndView join01(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		try{
			modelAndView.setViewName( "join/join01" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 회원가입 정보입력
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/join/join02.do")
	public ModelAndView join02(
								HttpServletRequest request,
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "join/join02" );
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		List<ZValue> resultList = null;
		
		//정보수정인 경우 user_id로 사용자 정보를 조회
		if(!"".equals(zvl.getValue("userId"))){
			zvl.put("user_id", zvl.getValue("userId"));
			result = UserService.userInfo(zvl);
			modelAndView.addObject("resultUserInfo", result);
			modelAndView.addObject("isModify", "Y");
		}
		
		resultList = PssCommonService.retrieveChrgDutyList(zvl);
		modelAndView.addObject("resultChrgDutyList", resultList);
		
		resultList = PssCommonService.retrieveInstCodeList();
		modelAndView.addObject("resultInstList", resultList);

		return modelAndView;	
	}
	
	/**
	 * 회원가입 상태확인
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/join/join03.do", method=RequestMethod.POST)
	public ModelAndView join03(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();			
		ZValue zvl =  WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		
		zvl.put("user_id", zvl.getValue("userId"));
		result = JoinService.getUserStatus(zvl);
		
		modelAndView.addObject("userStatus", result);
		modelAndView.addObject("userId", zvl.getValue("userId"));
		
		modelAndView.setViewName( "join/join03" );
		
		return modelAndView;	
	}
	
	/**
	 * 회원가입 가입완료(공인인증서 등록)
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/join/join04.do", method=RequestMethod.POST)
	public ModelAndView join04(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		request.getSession().setAttribute("tempUserId", zvl.getValue("userId"));
		
		modelAndView.addObject("userId", zvl.getValue("userId"));
		modelAndView.setViewName( "join/join04" );
		
		return modelAndView;	
	}
	
	/**
	 * 가입 시 아이디 중복 체크
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/join/idDupChk.do")
	public ModelAndView idDupChk(
			HttpServletRequest request, 
			HttpServletResponse response
			) throws Exception { 
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ModelAndView modelAndView = new ModelAndView();
		int cntId = 0;
		
		try{
			cntId = JoinService.idDupChk(zvl);
		}catch(Exception e){
			logger.error(e);
		}
			    
		try{
			modelAndView.setViewName( "jsonView" );
			modelAndView.addObject( "zvl", zvl );
			modelAndView.addObject( "cntId", cntId );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView; 	   
	}
	
	/**
	 * 회원 가입 신청
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/join/join.do", method=RequestMethod.POST)
	public ModelAndView userRegist(
			HttpServletRequest request, 
			@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletResponse response
			) throws Exception { 
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ModelAndView modelAndView = new ModelAndView();
		LoginVO resultVO = new LoginVO();
		SessionVO sessionVO = new SessionVO();
		
		/*  웹 취약점 불충분한 인가 조치 
		 * 회원가입 시 join02.jsp에서 스크립트 상 파라미터 변조 조치 */
		int cntUser = 0;
		
		cntUser = JoinService.joinCertChk(zvl);
		if( cntUser == 11 ) {
			modelAndView.addObject("message", "공문을 통해 신청된 사용자만 회원가입이 가능합니다.\n관리자에게 문의하세요.");
			modelAndView.addObject("url", "/login/login.do");

		} else if ( cntUser != 0 && !zvl.getValue("isModify").equals("Y")) {
			modelAndView.addObject("message", "이미 등록된 사용자 입니다.");
			modelAndView.addObject("url", "/login/login.do");

		} else { // cntUser가 0인 경우

			JoinService.userRegist(zvl);
	
			loginVO.setUserId(zvl.getString("user_id"));
			
			String user_pw = loginVO.getPassword();
			
			SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
		    shaPasswordEncoder.setEncodeHashAsBase64(true);
		    user_pw = shaPasswordEncoder.encode(user_pw);
		    loginVO.setPassword(user_pw);
			
			resultVO  = UserService.userLogin(loginVO);
	
			BeanUtils.copyProperties(resultVO, sessionVO);
		    //session에 유저정보 저장
			request.getSession().setAttribute("userInfo", sessionVO);
	
			//로그 이력 저장(HC01 회원가입)
/*			zvl.put("conect_cd", "HC01");
			zvl.put("crud",      "C");
			UserService.connectHistoryInsert(zvl, request);*/
			
			logger.debug("############################# userRegist zvl ############################");
			logger.debug(zvl);
			logger.debug("############################# userRegist zvl ############################");
			
			String isModify = zvl.getValue("isModify");
			
			
			if("Y".equals(isModify )){
				modelAndView.addObject("message", "수정이 완료되었습니다.");
			}else{
				modelAndView.addObject("message", "가입이 완료되었습니다.");
			}
			modelAndView.addObject("url", "/join/join03.do");
		}
		modelAndView.setViewName("jsonView");
		return modelAndView;
		
	}

	/**
	 * 가입 시 사용자등록 여부 체크
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/join/joinCertChk.do")
	public ModelAndView joinCertChk(
			HttpServletRequest request, 
			HttpServletResponse response
			) throws Exception { 
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ModelAndView modelAndView = new ModelAndView();
		int cntUser = 0;
		
		try{
			cntUser = JoinService.joinCertChk(zvl);
		}catch(Exception e){
			logger.error(e);
		}
			    
		try{
			modelAndView.setViewName( "jsonView" );
			modelAndView.addObject( "zvl", zvl );
			modelAndView.addObject( "cntUser", cntUser );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView; 	   
	}

}