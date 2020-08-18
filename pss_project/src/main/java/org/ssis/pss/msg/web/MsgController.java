package org.ssis.pss.msg.web;

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
public class MsgController {
	
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
	@RequestMapping(value="/msg/receiveMsgList.do")
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
		
		/* 페이지 정보 */
		model.addAttribute("pageName", "수신 업무");
		
		return "msg/receiveMsgList";
  }

	/**
	 * 받은 메시지 상세 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/msg/receiveMsgView.do")
    public String receiveMsgView(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;

		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());
		List<ZValue> fileList = null;

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			result = msgService.receiveMsgThread(zvl);
			model.addAttribute("result", result);

			if(!"Y".equals(result.getValue("R_RECPTN_YN"))) {
				msgService.updateReceiveMsg(zvl);
			}
			fileList = msgService.msgFileList(zvl);
			model.addAttribute("fileList", fileList);

			result = msgService.msgNext(zvl);
			model.addAttribute("msgNext", result);
			result = msgService.msgPrev(zvl);
			model.addAttribute("msgPrev", result);
			
		}catch(Exception e){
			logger.error(e);
		}
		
    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");

		model.addAllAttributes(zvl);
		
		/* 페이지 정보 */
		model.addAttribute("pageName", "수신 업무");
		
		return "msg/receiveMsgView";
    }
	
	/**
	 * 보낸 메시지함
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/msg/trnsmitMsgList.do")
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
		
		/* 페이지 정보 */
		model.addAttribute("pageName", "송신 업무");
		
		return "msg/trnsmitMsgList";
    }

	/**
	 * 보낸 메시지 상세 조회
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/msg/trnsmitMsgView.do")
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
			model.addAttribute("result", result);
			
			resultList = msgService.trnsmitUserList(zvl);
			model.addAttribute("resultList", resultList);
			
			fileList = msgService.msgFileList(zvl);
			model.addAttribute("fileList", fileList);
			
			result = msgService.msgNext(zvl);
			model.addAttribute("msgNext", result);
			result = msgService.msgPrev(zvl);
			model.addAttribute("msgPrev", result);

		}catch(Exception e){
			logger.error(e);
		}
		
		model.addAllAttributes(zvl);
		
		/* 페이지 정보 */
		model.addAttribute("pageName", "송신 업무");
		
		return "msg/trnsmitMsgView";
    }

	/**
	 * 메시지 보내기
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/msg/trnsmitMsg.do")
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
			modelAndView.setViewName( "msg/trnsmitMsg" );

		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		/* 페이지 정보 */
		model.addAttribute("pageName", "송신 업무");
		
		return modelAndView;	
    }

	/**
	 * 보낸메세지 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/msg/deleteTrnsmitMsg.do")
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
	@RequestMapping(value="/msg/deleteReceiveMsg.do")
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
	@RequestMapping(value="/msg/msgInsttListAjax.do")
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
	@RequestMapping(value="/msg/msgUserListAjax.do")
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

		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
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
	@RequestMapping(value="/msg/insertTrnsmitMsg.do")
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
	@RequestMapping(value="/msg/deleteMsgFile.do")
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
