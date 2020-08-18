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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.cjs.service.CjsCntrlService;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.WebFactoryUtil;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class CjsCntrlController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private CjsCntrlService cjsCntrlService;
	
	/**
	 * 관제 소개 및 신청
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/cjs/intrcnRegist.do")
	public ModelAndView intrcnRegist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("cjs/intrcnRegist");
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		// 보건복지부 or 관제 시스템 담당자
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId()))
			modelAndView.addObject("adminMenu", "Y");
		
		modelAndView.addObject("menuDeths", "1");
		modelAndView.addObject("menuDethsValue", "A");
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		zvl.put("insttCd", userInfo.getInsttCd());
		
		ZValue result= cjsCntrlService.selectCntrl(zvl);
		modelAndView.addObject("result", result);
		
		List<ZValue> resultList = cjsCntrlService.selectCntrlFileList(zvl);
		modelAndView.addObject("fileList", resultList);
		
		/* 페이지 정보 */
		modelAndView.addObject("pageNum", "9");
		modelAndView.addObject("subNum", "0");
		modelAndView.addObject("threeNum", "0");
		modelAndView.addObject("dep1Name", "관제소개 및 신청");
		modelAndView.addObject("dep2Name", "관제소개 및 신청");
		modelAndView.addObject("dep3Name", "");
		modelAndView.addObject("dep4Name", "");
		modelAndView.addObject("pageName", "관제소개 및 신청");		
		
		return modelAndView;
	}
	
	/**
	 * 관제 신청 관리
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/cjs/cntrlRegistMngList.do")
	public ModelAndView cntrlRegistMngList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("cjs/cntrlRegistMngList");
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		// 보건복지부 or 관제 시스템 담당자
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId()))
			modelAndView.addObject("adminMenu", "Y");
		else
			return null;
		
		modelAndView.addObject("menuDeths", "1");
		modelAndView.addObject("menuDethsValue", "D");
		
		List<ZValue> resultList = null;
		int totalCnt = 0; 
		int totalPageCnt = 0;
		
		//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) 
    		zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	zvl.put("pageSize", 10);
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));
		
		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		
		resultList = cjsCntrlService.selectCntrlList(zvl);
		modelAndView.addObject("resultList", resultList);
		
		resultList = cjsCntrlService.selectCntrlFileList(zvl);
		modelAndView.addObject("fileList", resultList);
		
		totalCnt = cjsCntrlService.selectCntrlCnt(zvl);
		totalPageCnt = (int) Math.ceil((double)totalCnt/(double)10);
		
		modelAndView.addObject("totalCnt", totalCnt);
		modelAndView.addObject("totalPageCnt", totalPageCnt);
		
		paginationInfo.setTotalRecordCount(totalCnt);
		
		modelAndView.addAllObjects(zvl);
		modelAndView.addObject("paginationInfo", paginationInfo);
		
		/* 페이지 정보 */
		modelAndView.addObject("pageNum",  "11");
		modelAndView.addObject("subNum",   "0");
		modelAndView.addObject("threeNum", "0");
		modelAndView.addObject("dep1Name", "관제 신청관리");
		modelAndView.addObject("dep2Name", "관제 신청관리");
		modelAndView.addObject("dep3Name", "");
		modelAndView.addObject("dep4Name", "");
		modelAndView.addObject("pageName", "관제 신청관리");	
		
		return modelAndView;
	}
	
	/**
	 * 관제 신청 승인 / 반려
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/modifyCntrlStatus.do")
	public ModelAndView modifyCntrlStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			cjsCntrlService.updateCntrlStatus(zvl, request);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error( e );
			e.printStackTrace();
		}
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	/**
	 * 관제 신청
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/createCntrlFile.do")
	public ModelAndView createCntrlFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			cjsCntrlService.createCntrlStatus(zvl, request);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	/**
	 * 관제 신청 삭제
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/deleteCntrlFile.do")
	public ModelAndView deleteCntrlFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			cjsCntrlService.deleteCntrlFile(zvl, request);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.delete"));
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error( e );
			e.printStackTrace();
		}
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}

	/**
	 * 관제 반려 팝업
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/companionPopup.do")
	public ModelAndView companionPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			modelAndView.addObject("requestZvl", zvl);
			modelAndView.setViewName( "cjs/popup/companionPopup" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}	
}