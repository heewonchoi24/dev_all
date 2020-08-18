package org.ssis.pss.bbs.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
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
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.bbs.service.BbsService;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;

//import com.mysql.jdbc.StringUtils;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BbsController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private BbsService bbsService;
	
	@Autowired
	private CmnService cmnService; 
	
	/**
	 * 게시판 공통 이동
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/bbs/bbsList.do")
	public ModelAndView bbsList(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("userId", userInfo.getUserId());
		
		ZValue result, bbsType = null;
		List<ZValue> resultList = null;
		int bbsTotalCnt = 0; 
		int totalPageCnt = 0;
		String bbsCode = "";
		
		// 게시판 타입 체크
		bbsType = bbsService.bbsType(zvl);
		if("T".equals(bbsType.get("BBS_TYPE"))){
			modelAndView.setViewName( "bbs/bbsTblList" );
		} else if("G".equals(bbsType.get("BBS_TYPE"))){
			modelAndView.setViewName( "bbs/bbsGallery" );
		} else if("I".equals(bbsType.get("BBS_TYPE"))){
			modelAndView.setViewName( "bbs/bbsImgList" );
		}
		
		//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	// 앨범형 게시판인 경우 한 페이징 당 12개
    	if("G".equals(bbsType.get("BBS_TYPE"))) zvl.put("pageUnit", 12); 
    	zvl.put("pageSize", 10);
    	    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));
		
		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		bbsCode = String.valueOf(zvl.get("bbsCd")) ;
		
		result = bbsService.bbsNm(zvl);
		modelAndView.addAllObjects(result);
		
		resultList = bbsService.bbsList(zvl);
		modelAndView.addObject("bbsList", resultList);
		
		resultList = bbsService.bbsAttachFileList(zvl);
		modelAndView.addObject("bbsAttachFileList", resultList);
		
		resultList = bbsService.bbsImgList(zvl);
		modelAndView.addObject("imgList", resultList);
		
		bbsTotalCnt = bbsService.bbsListCnt(zvl);
		totalPageCnt = (int) Math.ceil((double)bbsTotalCnt/(double)10);
		
		logger.debug("############## zvl ##############");
		logger.debug(totalPageCnt);
		logger.debug("############## zvl ##############");
		
		modelAndView.addObject("bbsTotalCnt", bbsTotalCnt);
		modelAndView.addObject("totalPageCnt", totalPageCnt);
		
		paginationInfo.setTotalRecordCount(bbsTotalCnt);
		
		modelAndView.addAllObjects(zvl);
		modelAndView.addObject("paginationInfo", paginationInfo);
		
		/* 페이지 정보 */
		if(bbsCode.equals("BN01")) modelAndView.addObject("pageName", "공지사항");
		if(bbsCode.equals("BN02")) modelAndView.addObject("pageName", "자주하는 질문");
		if(bbsCode.equals("BN03")) modelAndView.addObject("pageName", "질의 응답");
		if(bbsCode.equals("BN04")) modelAndView.addObject("pageName", "자료실");
		if(bbsCode.equals("BN05")) modelAndView.addObject("pageName", "개인정보 동향");
		if(bbsCode.equals("BN06")) modelAndView.addObject("pageName", "우수사례 자료실");
		
		return modelAndView;
	}
	
	/**
	 * 게시판 글쓰기 페이지
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/bbs/bbsWrite.do")
	public ModelAndView bbsWrite(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		List<ZValue> resultList = null;
		String bbsSeq = zvl.getString("bbsSeq");
	
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		String chkUserId = userInfo.getUserId();
		
		result = bbsService.bbsNm(zvl);
		modelAndView.addAllObjects(result);
		
		if(bbsSeq != null && !bbsSeq.isEmpty()){
			result = bbsService.bbsView(zvl);
			/* 웹 취약점 점검 불충분한 인가 조치 
			 *  작성자와 session 저장된 Id 다르면 에러페이지로 return (2019-10-30)  */
			if ( !chkUserId.equals(result.get("REGIST_ID")) ){
				modelAndView.setViewName("redirect:/exception/error.do");
				return modelAndView;
			}
			modelAndView.addObject("bbsView", result);
			
			resultList = bbsService.bbsAttachFileList(zvl);
			modelAndView.addObject("bbsAttachFileList", resultList);
		}
		
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "bbs/bbsWrite" );
		
		/* 페이지 정보 */
		modelAndView.addObject("pageName", "질의 응답");
		
		return modelAndView;
	}
	
	
	/**
	 * 게시판 글 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/bbs/deleteThread.do")
	public ModelAndView deleteThread(HttpServletRequest request, HttpServletResponse response
										) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("adminId", userInfo.getUserId());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		bbsService.deleteThread(zvl);		
		
		modelAndView.addObject("message", egovMessageSource.getMessage("success.common.delete"));
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	
	/** 게시판 파일 첨부
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bbs/bbsFileInsert.do")
	public ModelAndView bbsFileInsert(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		

		try{
			zvl = bbsService.bbsThreadInsert(zvl, request);
			
			logger.debug("############## zvl ##############");
			logger.debug(zvl);
			logger.debug("############## zvl ##############");
			
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 게시판 파일 갱신
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bbs/bbsFileUpdate.do")
	public ModelAndView bbsFileUpdate(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			bbsService.bbsThreadUpdate(zvl, request);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 게시판 파일 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bbs/bbsFileDelete.do")
	public ModelAndView bbsFileDelete(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			bbsService.bbsFileDelete(zvl, request);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 게시판 글쓰기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/bbs/bbsRegistThread.do")
	public ModelAndView bbsWriteThread(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		/* XSS 제목 부분 조치 */
		zvl.put("subject", zvl.get("subject").toString()
				.replace("<", "&amp;lt").replace(">", "&amp;gt").replace("\"", "&amp;quot"));
		zvl.put("subject", zvl.get("subject").toString().replace("&amp;quot", "\""));

		/* 웹 취약점 점검 XSS 크로스사이트 스크립팅 조치 
		 *  꺽쇠부호 치환 (2019-10-30) 							
		zvl.put("contents", zvl.get("contents").toString()
				.replace("<", "&amp;lt").replace(">", "&amp;gt").replace("\"", "&amp;quot")); */
		/* 허용태그 설정 
		zvl.put("contents", zvl.get("contents").toString()
				.replace("&amp;ltp&amp;gt", "<p>").replace("&amp;ltp", "<p").replace("&amp;lt/p&amp;gt", "</p>")
				.replace("&amp;ltbr&amp;gt", "<br>").replace("&amp;quot", "\"")
				.replace("&amp;ltb&amp;gt", "<b>").replace("&amp;lt/b&amp;gt", "</b>")
				.replace("&amp;ltspan&amp;gt", "<span>").replace("&amp;ltspan", "<span").replace("&amp;lt/span&amp;gt", "</span>"));
		* 스마트에디터로 에디터 변경 후 xss 조치 확인 필요
		*/
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			bbsService.bbsRegistThread(zvl, request);
			
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;
	}
	
	/**
	 * 게시판 상세보기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bbs/bbsView.do")
	public ModelAndView bbsView(
						HttpServletRequest request,
						HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		String bbsCode = "";
		
		zvl.put("userId", userInfo.getUserId());
		
		ZValue result = null;
		List<ZValue> resultList = null;
		
		if(!zvl.containsKey("pageIndex")) 
    		zvl.put("pageIndex", 1);
		
		logger.debug("############## zvl2 ##############");
		logger.debug(zvl);
		logger.debug("############## zvl2 ##############");
		
		
		bbsCode = (String) zvl.get("bbsCd");
		if(zvl.containsKey("seq"))
			zvl.setValue("bbsSeq", zvl.getString("seq"));

		Cookie cookies[] = request.getCookies();
		Map map = new HashMap();
		if(request.getCookies() != null){
			for(int i=0;i<cookies.length;i++){
				Cookie obj = cookies[i];
				map.put(obj.getName(), obj.getValue());
			}
		}
		String readCount = (String) map.get("read_count"+zvl.getValue("bbsSeq"));
		if(StringUtils.isEmpty(readCount)){
			Cookie cookie = new Cookie("read_count"+zvl.getValue("bbsSeq"), readCount + zvl.getValue("bbsSeq"));
			response.addCookie(cookie);
			bbsService.bbsViewCntIncrease(zvl);
		}
		
		result = bbsService.bbsView(zvl);
		modelAndView.addObject("bbsView", result);
	
		zvl.put("uppercode", "CT00");
		resultList = cmnService.retrieveCommCdList(zvl);
		modelAndView.addObject("bbsCategoryList", resultList);
		
		resultList = bbsService.bbsAttachFileList(zvl);
		modelAndView.addObject("bbsAttachFileList", resultList);
		
		resultList = bbsService.bbsAnswerFileList(zvl);
		modelAndView.addObject("bbsAnswerFileList", resultList);
		
		result = bbsService.bbsNext(zvl);
		modelAndView.addObject("bbsNext", result);
		result = bbsService.bbsPrev(zvl);
		modelAndView.addObject("bbsPrev", result);
		
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "bbs/bbsView" );
		
		/* 페이지 정보 */
		if(bbsCode.equals("BN01")) modelAndView.addObject("pageName", "공지사항");
		if(bbsCode.equals("BN02")) modelAndView.addObject("pageName", "자주하는 질문");
		if(bbsCode.equals("BN03")) modelAndView.addObject("pageName", "질의 응답");
		if(bbsCode.equals("BN04")) modelAndView.addObject("pageName", "자료실");
		if(bbsCode.equals("BN05")) modelAndView.addObject("pageName", "개인정보 동향");
		if(bbsCode.equals("BN06")) modelAndView.addObject("pageName", "우수사례 자료실");
		
		return modelAndView;
	}
	
	/** 게시판 파일 첨부
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/bbs/bbsAnswerFileInsert.do")
	public ModelAndView bbsAnswerFileInsert(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			zvl = bbsService.bbsAnswerFileInsert(zvl, request);
			
			logger.debug("############## zvl ##############");
			logger.debug(zvl);
			logger.debug("############## zvl ##############");
			
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
}
