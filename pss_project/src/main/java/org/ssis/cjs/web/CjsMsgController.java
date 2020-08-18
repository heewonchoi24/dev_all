package org.ssis.cjs.web;

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
import org.ssis.pss.msg.service.MsgService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class CjsMsgController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private MsgService msgService;

	/**
	 * 메시지함 - 받은 메시지함
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/receiveMsgList.do")
    public String receiveMsgList(
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

		if(!"".equals(zvl.getValue("searchTx"))){
			if("1".equals(zvl.getValue("searchGb"))) {
				zvl.put("searchSub", "%" + zvl.getValue("searchTx") + "%" );
			} else if("2".equals(zvl.getValue("searchGb"))) {
				zvl.put("searchCon", "%" + zvl.getValue("searchTx") + "%" );
			} else {
				zvl.put("searchAll", "%" + zvl.getValue("searchTx") + "%" );
			}
		}

  	logger.debug("######################################################");
  	logger.debug("zvl : \n" + zvl);
  	logger.debug("######################################################");
		
		try{
			resultList = msgService.receiveMsgListThread(zvl);
			resultListCnt = msgService.receiveMsgCntThread(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		paginationInfo.setTotalRecordCount(resultListCnt);
		
		model.addAllAttributes(zvl);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListCnt", resultListCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("requestZvl", zvl);
		
		// 보건복지부 or 관제 시스템 담당자
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId()))
			model.addAttribute("adminMenu", "Y");
		
		model.addAttribute("menuDeths", "3");
		model.addAttribute("menuDethsValue", "CBA");
		
		return "cjs/receiveMsgList";
  }

	/**
	 * 받은 메시지 상세 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/cjs/receiveMsgView.do")
    public String receiveMsgView(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		List<ZValue> fileList = null;

		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			result = msgService.receiveMsgThread(zvl);

			if(!"Y".equals(result.getValue("R_RECPTN_YN"))) {
				msgService.updateReceiveMsg(zvl);
			}
			fileList = msgService.msgFileList(zvl);
		}catch(Exception e){
			logger.error(e);
		}
    	logger.debug("######################################################");
    	logger.debug("result : \n" + result);
    	logger.debug("######################################################");

		model.addAllAttributes(zvl);
		model.addAttribute("result", result);
		model.addAttribute("fileList", fileList);
		
		// 보건복지부 or 관제 시스템 담당자
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId()))
			model.addAttribute("adminMenu", "Y");
		
		model.addAttribute("menuDeths", "3");
		model.addAttribute("menuDethsValue", "CBA");
		
		return "cjs/receiveMsgView";
    }
	
	/**
	 * 보낸 메시지함
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/cjs/trnsmitMsgList.do")
    public String trnsmitMsgList(
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

		if(!"".equals(zvl.getValue("searchTx"))){
			if("1".equals(zvl.getValue("searchGb"))) {
				zvl.put("searchSub", "%" + zvl.getValue("searchTx") + "%" );
			} else if("2".equals(zvl.getValue("searchGb"))) {
				zvl.put("searchCon", "%" + zvl.getValue("searchTx") + "%" );
			} else {
				zvl.put("searchAll", "%" + zvl.getValue("searchTx") + "%" );
			}
		}

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			resultList = msgService.trnsmitMsgListThread(zvl);
			resultListCnt = msgService.trnsmitMsgCntThread(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		paginationInfo.setTotalRecordCount(resultListCnt);
		
		model.addAllAttributes(zvl);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListCnt", resultListCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("requestZvl", zvl);
		
		// 보건복지부 or 관제 시스템 담당자
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId()))
			model.addAttribute("adminMenu", "Y");
		
		model.addAttribute("menuDeths", "3");
		model.addAttribute("menuDethsValue", "CBB");
		
		return "cjs/trnsmitMsgList";
    }

	/**
	 * 보낸 메시지 상세 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/cjs/trnsmitMsgView.do")
    public String trnmsmitMsgView(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		List<ZValue> resultList = null;
		List<ZValue> fileList = null;

		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			result = msgService.trnsmitMsgThread(zvl);
			
			resultList = msgService.trnsmitUserList(zvl);

			fileList = msgService.msgFileList(zvl);

		}catch(Exception e){
			logger.error(e);
		}
		
    	logger.debug("######################################################");
    	logger.debug("result : \n" + result);
    	logger.debug("######################################################");

		model.addAllAttributes(zvl);
		model.addAttribute("result", result);
		model.addAttribute("resultList", resultList);

		model.addAttribute("fileList", fileList);

		// 보건복지부 or 관제 시스템 담당자
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId()))
			model.addAttribute("adminMenu", "Y");
		
		model.addAttribute("menuDeths", "3");
		model.addAttribute("menuDethsValue", "CBB");
		
		return "cjs/trnsmitMsgView";
    }

	/**
	 * 메시지 보내기
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/cjs/trnsmitMsg.do")
    public ModelAndView trnmsmitMsg(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		ZValue result = null;
		zvl.put("user_id", userInfo.getUserId());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = msgService.msgInsttClCdList(zvl);
			model.addAttribute("msgInsttClCdList", resultList);
						
			resultList = msgService.msgInsttSelectList(zvl);
			model.addAttribute("msgInsttSelectList", resultList);

			resultList = msgService.msgInsttUserList(zvl);
			model.addAttribute("msgInsttUserList", resultList);

			model.addAttribute("requestZvl", zvl);

			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "cjs/trnsmitMsg" );

		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		// 보건복지부 or 관제 시스템 담당자
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId()))
			model.addAttribute("adminMenu", "Y");
		
		model.addAttribute("menuDeths", "3");
		model.addAttribute("menuDethsValue", "CBB");
		
		return modelAndView;	
    }

	/**
	 * 보낸메세지 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/deleteTrnsmitMsg.do")
	public ModelAndView deleteTrnsmitMsg(HttpServletRequest request, HttpServletResponse response) throws Exception { 
	   	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());
		
		ModelAndView model = new ModelAndView();
		
		try{
			msgService.deleteTrnsmitMsg(zvl);
					
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
		}catch(Exception e){
					
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 받은메세지 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/deleteReceiveMsg.do")
	public ModelAndView deleteReceiveMsg(HttpServletRequest request, HttpServletResponse response) throws Exception { 
	   	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());
		
		ModelAndView model = new ModelAndView();
		
		try{
			msgService.deleteReceiveMsg(zvl);
					
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
		}catch(Exception e){
					
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 메시지함 - (기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody                           
	@RequestMapping(value="/cjs/msgInsttListAjax.do")
	public ModelAndView msgInsttListAjax(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		try{
			resultList = msgService.msgInsttListAjax(zvl);
			
			modelAndView.setViewName( "jsonView" );
			modelAndView.addObject("resultList", resultList);
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}

	/**
	 * 메시지함 - (기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody                           
	@RequestMapping(value="/cjs/msgUserListAjax.do")
	public ModelAndView msgUserListAjax(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		zvl.put("user_id", userInfo.getUserId());

		try{
			resultList = msgService.msgUserListAjax(zvl);
			
			modelAndView.setViewName( "jsonView" );
			modelAndView.addObject("resultList", resultList);
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
	@RequestMapping(value="/cjs/insertTrnsmitMsg.do")
	public ModelAndView insertTrnsmitMsg(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			msgService.insertTrnsmitMsg(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 보낸메시지 첨부파일 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/deleteMsgFile.do")
	public ModelAndView deleteMsgFile(HttpServletRequest request, HttpServletResponse response) throws Exception { 
	   	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());
		
		ModelAndView model = new ModelAndView();
		
		try{
			msgService.deleteMsgFile(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

}
