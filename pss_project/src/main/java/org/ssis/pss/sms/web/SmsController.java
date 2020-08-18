package org.ssis.pss.sms.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.sms.service.SmsService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class SmsController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private SmsService smsService;
	
	@Autowired
	private ConnectService connectService;		
	
	@Autowired
	private UserService UserService;
	
	/**
	 * SMS 페이지
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/sms/smsPageList.do")
    public ModelAndView receiveMsgList(
							HttpServletRequest request
							) throws Exception {
  	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
  	ModelAndView model = new ModelAndView();

	if(zvl.get("instt_cl_cd") == null || zvl.get("instt_cl_cd").equals("")) {
		zvl.put("instt_cl_cd", "IC01");
		zvl.put("smsTemplateIni", SmsStringTemplate.smsTemplate1);
		zvl.put("smsSubjectIni", SmsStringTemplate.smsTemplate1Subject);
	}
	
	List<ZValue> resultList = null;

	try {
		resultList = smsService.smsInsttClCdList(zvl);
		model.addObject("smsInsttClCdList", resultList);

	} catch(Exception e) {
		logger.error(e);
	}
	
  	logger.debug("######################################################");
  	logger.debug("zvl : \n" + zvl);
  	logger.debug("######################################################");
  	
	model.addObject("requestZvl", zvl);
	
	model.setViewName( "/sms/userSmsSend");
	
	// 화면 Sidebar 정보
	model.addObject("pageLevel1", "account");
	model.addObject("pageLevel2", "9");
	model.addObject("pageName", "SMS 발송");
	
	// 로그 이력 저장
	String menu_id = "";
	zvl.put("url", 		  "/admin/sms/smsPageList.do");
	menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
	zvl.put("parameter",  zvl.toString());
	zvl.put("crud",       LogCrud.READ );
	zvl.put("menu_id",    menu_id);
	zvl.put("session_id", request.getRequestedSessionId());
	UserService.connectHistoryInsert(zvl, request);			
	
	return model;
  }

	/**
	 * SMS 로그 페이지
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/sms/smsLogList.do")
    public String smsLogList(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
    	
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());

    	//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	zvl.put("pageSize", 10);
    	
    	//페이징 설정 참고용
        /** 현재페이지 */
        int pageIndex = 1;
        /** 페이지갯수 */
        int pageUnit = 10;
        /** 페이지사이즈 */
        int pageSize = 10;
        /** 첫페이지 인덱스 */
        int firstIndex = 1;
        /** 마지막페이지 인덱스 */
        int lastIndex = 1;
        /** 페이지당 레코드 개수 */
        int recordCountPerPage = 10;
    	
		List<ZValue> resultList = null;
		int resultListCnt = 0;
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));

		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			resultList = smsService.smsLogList(zvl);
			resultListCnt = smsService.smsSendUserCnt(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		paginationInfo.setTotalRecordCount(resultListCnt);
		
		model.addAllAttributes(zvl);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListCnt", resultListCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("requestZvl", zvl);
		
		/* jsp화면 Sidebar 정보 */
		model.addAttribute("pageLevel1", "account");
		model.addAttribute("pageLevel2", "10");
		model.addAttribute("pageName", "SMS 발송 이력");
		
		return "sms/userSmsList";
    }
	
	/**
	 * SMS 로그 유저 리스트
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/sms/smsSendUserList.do")
    public ModelAndView smsSendUserList(
    						HttpServletRequest request
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
    	ModelAndView modelAndView = new ModelAndView();
		List<ZValue> resultList = null;
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			resultList = smsService.smsSendUserList(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		modelAndView.setViewName( "jsonView" );
		modelAndView.addObject("userList", resultList);

		return modelAndView;
    }
	
	/**
	 * 템플릿 설정 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/admin/sms/smsTemplateSet.do")
	public ModelAndView smsTemplateSet(HttpServletRequest request
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "jsonView" );
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			// sms 템플릿 설정
			if("1".equals(zvl.get("sms_template"))){
				modelAndView.addObject("smsTemplate", SmsStringTemplate.smsTemplate1);
				modelAndView.addObject("smsSubject", SmsStringTemplate.smsTemplate1Subject);
			} else if("2".equals(zvl.get("sms_template"))){
				modelAndView.addObject("smsTemplate", SmsStringTemplate.smsTemplate2);
				modelAndView.addObject("smsSubject", SmsStringTemplate.smsTemplate2Subject);
			} else if("3".equals(zvl.get("sms_template"))){
				modelAndView.addObject("smsTemplate", SmsStringTemplate.smsTemplate3);
				modelAndView.addObject("smsSubject", SmsStringTemplate.smsTemplate3Subject);
			} else if("4".equals(zvl.get("sms_template"))){
				modelAndView.addObject("smsTemplate", SmsStringTemplate.smsTemplate4);
				modelAndView.addObject("smsSubject", SmsStringTemplate.smsTemplate4Subject);
			}
			
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		return modelAndView;
	}
	
	/**
	 * 배정 기관 목록 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/admin/sms/smsInsttUserList.do")
	public ModelAndView insctrInsttList(HttpServletRequest request
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "jsonView" );
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			
			resultList = smsService.smsInsttUserList(zvl);
			modelAndView.addObject("smsInsttUserList", resultList);
			
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		return modelAndView;
	}
	
	
	/**
	 * 메시지 보내기 등록
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/sms/insertSms.do")
	public ModelAndView insertSms(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		int rv = 0;
		String userTelNo = "";
		try{
			
			if(zvl.getString("user_telno_arr") != null && !"".equals(zvl.getString("user_telno_arr"))){
				String telno_arr[] = zvl.getString("user_telno_arr").split(",");
				for(int i=1; i<telno_arr.length; i++){
					userTelNo = telno_arr[i];
					zvl.put("user_telno", userTelNo);
					rv += smsService.insertSms(zvl);
				}
				model.addObject("message", rv + "건이 발송 되었습니다.");
			} else {
				rv += smsService.insertSms(zvl);
				model.addObject("message", "메세지가 발송 되었습니다.");
			}
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/sms/smsPageList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.INSERT);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);			
			
		}catch(Exception e){
			model.addObject("message", "메세지 발송이 실패하였습니다.");
			logger.error(e);
			
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

}
