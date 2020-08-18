package org.ssis.pss.mngLevelRst.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.mngLevelRst.service.MngLevelRstService;
import org.ssis.pss.util.Globals;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;

@Controller
public class MngLevelRstController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private MngLevelRstService mngLevelRstService;
	
	@Autowired
	private CmnService cmnService;
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	/**
	 * 관리수준 진단 - 결과조회
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelRst/mngLevelRstSummaryList.do")
	public ModelAndView mngLevelRstSummaryList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/mngLevelRst/mngLevelRstSummaryList" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		if("2".equals(userInfo.getAuthorId())){
			response.sendRedirect("/mngLevelRst/mngLevelRstSummaryDtlList.do");
			return null;
		}
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		model.addObject("orderList", orderList);
		
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
			zvl.put("orderNo", currentOrderNo.getValue("orderNo"));
		}
		zvl.put("insttUpperCd", Globals.INSTT_UPPER_CD); 				// 기관분류
		zvl.put("evalUpperCd", Globals.EVAL_STATUS_UPPER_CD); 	// 평가상태
		
		// 점검원의 경우
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("userId", userInfo.getUserId());
		}
		
		List<ZValue> resultList = mngLevelRstService.selectMngLevelResultSummaryList(zvl);
		
		model.addObject("requestZvl", zvl);
		model.addObject("orderList", orderList);
		model.addObject("resultList", resultList);
		
		/* 페이지 정보 */
		model.addObject("pageNum", "1");
		model.addObject("subNum", "4");
		model.addObject("threeNum", "0");
		model.addObject("dep1Name", "관리수준 진단");
		model.addObject("dep2Name", "수준진단 결과");
		model.addObject("dep3Name", "");
		model.addObject("dep4Name", "");
        model.addObject("pageName", "수준진단 결과");
		
		return model;
	}
	
	/**
	 * 관리수준 진단 - 결과조회 - 년도 조회
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelRst/mngLevelRstSummaryListAjax.do")
	public ModelAndView mngLevelRstSummaryListAjax(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/mngLevelRst/mngLevelRstSummaryList" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		if("2".equals(userInfo.getAuthorId())){
			response.sendRedirect("/mngLevelRst/mngLevelRstSummaryDtlList.do");
			return null;
		}
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		model.addObject("orderList", orderList);
		
		zvl.put("orderNo", zvl.getValue("orderNo"));
			
		zvl.put("insttUpperCd", Globals.INSTT_UPPER_CD); 				// 기관분류
		zvl.put("evalUpperCd", Globals.EVAL_STATUS_UPPER_CD); 	// 평가상태
		
		// 점검원의 경우
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("userId", userInfo.getUserId());
		}
		
		List<ZValue> resultList = mngLevelRstService.selectMngLevelResultSummaryList(zvl);
		
		model.addObject("requestZvl", zvl);
		model.addObject("orderList", orderList);
		model.addObject("resultList", resultList);
		
		/* 페이지 정보 */
		model.addObject("pageNum", "1");
		model.addObject("subNum", "4");
		model.addObject("threeNum", "0");
		model.addObject("dep1Name", "관리수준 진단");
		model.addObject("dep2Name", "수준진단 결과");
		model.addObject("dep3Name", "");
		model.addObject("dep4Name", "");
        model.addObject("pageName", "수준진단 결과");
		
		return model;
	}	
	
	/**
	 * 관리수준 진단 - 기관별 결과조회
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelRst/mngLevelRstSummaryDtlList.do")
	public ModelAndView mngLevelRstSummaryDtlList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/mngLevelRst/mngLevelRstSummaryDtlList" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		// 기관 사용자의 경우 자신의 기관만 조회
		if("2".equals(userInfo.getAuthorId())){
			zvl.put("insttCd", userInfo.getInsttCd());
		}
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
			zvl.put("orderNo", currentOrderNo.getValue("orderNo"));
		}
		zvl.put("insttUpperCd", Globals.INSTT_UPPER_CD); 				// 기관분류
		zvl.put("evalUpperCd", Globals.EVAL_STATUS_UPPER_CD); 	// 평가상태
		
		ZValue result = mngLevelRstService.selectMngLevelResultSummary(zvl);
		
		List<ZValue> resultList = mngLevelRstService.selectMngLevelResultList(zvl);
		
		ZValue evalYn = cmnService.retrieveEvalFromTo(zvl);
		
		model.addObject("requestZvl", zvl);
		model.addObject("orderList", orderList);
		model.addObject("result", result);
		model.addObject("resultList", resultList);
		model.addObject("evalYn", evalYn);
		
		/* 페이지 정보 */
		model.addObject("pageNum", "1");
		model.addObject("subNum", "4");
		model.addObject("threeNum", "0");
		model.addObject("dep1Name", "관리수준 진단");
		model.addObject("dep2Name", "수준진단 결과");
		model.addObject("dep3Name", "");
		model.addObject("dep4Name", "");
        model.addObject("pageName", "수준진단 결과");
        

		// READ/WRITE/DOWNLOAD 권한
		zvl.put("authorId", userInfo.getAuthorId());
		zvl.put("menuId",   session.getAttribute("cMenuId"));
		resultList = cmnService.getAuthority(zvl);
		
		userInfo.setAuthRead(resultList.get(0).getValue("authRead"));
		userInfo.setAuthWrite(resultList.get(0).getValue("authWrite"));
		userInfo.setAuthDwn(resultList.get(0).getValue("authDwn"));
		
		logger.debug("###################### auth ######################");  
		logger.debug("authRead:  " + userInfo.getAuthRead());  
		logger.debug("authWrite: " + userInfo.getAuthWrite());
		logger.debug("authDwn:   " + userInfo.getAuthDwn());  
		logger.debug("###################### auth ######################");          
		
		return model;
	}
	
	/**
	 * 관리수준 진단 - 결과 상세조회
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelRst/mngLevelRstDtl.do")
	public ModelAndView mngLevelRstDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/mngLevelRst/mngLevelRstDtl" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		// 기관 사용자의 경우 자신의 기관만 조회
		if("2".equals(userInfo.getAuthorId())){
			zvl.put("insttCd", userInfo.getInsttCd());
		}
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
		// 결과 상세
		ZValue result = mngLevelRstService.selectMngLevelResult(zvl);
		// 신청 파일
		List<ZValue> resultFile = mngLevelRstService.selectMngLevelRequestFileList(zvl);
		// 메모 파일
		List<ZValue> memoFile = mngLevelRstService.selectMngLevelEvlMemoFileList(zvl);
		// 이의신청 파일
		List<ZValue> fobjctFile = mngLevelRstService.selectMngLevelEvlFobjctFileList(zvl);
		
		String periodCd = cmnService.retrieveEvlPeriodCode();		
		zvl.put("periodCd", periodCd);
		
		model.addObject("requestZvl", zvl);
		model.addObject("orderList", orderList);
		model.addObject("result", result);
		model.addObject("resultFile", resultFile);
		model.addObject("memoFile", memoFile);
		model.addObject("fobjctFile", fobjctFile);
		
		/* 페이지 정보 */
		model.addObject("pageNum", "1");
		model.addObject("subNum", "4");
		model.addObject("threeNum", "0");
		model.addObject("dep1Name", "관리수준 진단");
		model.addObject("dep2Name", "수준진단 결과");
		model.addObject("dep3Name", "");
		model.addObject("dep4Name", "");
        model.addObject("pageName", "수준진단 결과");
        
		// READ/WRITE/DOWNLOAD 권한
		zvl.put("authorId", userInfo.getAuthorId());
		zvl.put("menuId",   session.getAttribute("cMenuId"));
		List<ZValue> resultList = cmnService.getAuthority(zvl);
		
		userInfo.setAuthRead(resultList.get(0).getValue("authRead"));
		userInfo.setAuthWrite(resultList.get(0).getValue("authWrite"));
		userInfo.setAuthDwn(resultList.get(0).getValue("authDwn"));
		
		logger.debug("###################### auth ######################");  
		logger.debug("authRead:  " + userInfo.getAuthRead());  
		logger.debug("authWrite: " + userInfo.getAuthWrite());
		logger.debug("authDwn:   " + userInfo.getAuthDwn());  
		logger.debug("###################### auth ######################");          
		
		return model;
	}
	
	/**
	 * 관리수준 진단 - 이의신청 등록
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelRst/updateMngLevelRstFobjct.do")
	public ModelAndView updateMngLevelRstFobjct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			mngLevelRstService.updateMngLevelRstFobjct(zvl, request);
			
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
	 * 관리수준 진단 - 이의신청 파일 등록
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelRst/updateMngLevelRstFobjctFile.do")
	public ModelAndView updateMngLevelRstFobjctFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			mngLevelRstService.updateMngLevelRstFobjctFile(zvl, request);
			
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
	 * 관리수준 진단 - 이의신청 파일 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelRst/deleteMngLevelRstFobjct.do")
	public ModelAndView deleteMngLevelRstFobjct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			mngLevelRstService.deleteMngLevelRstFobjct(zvl, request);
			
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
	 * 수준진단 결과 다운로드
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/mngLevelRst/mngLevelRstExcelDown.do")
	public String mIndexExcelDownload(
			Map<String, Object> ModelMap,
			HttpServletRequest request,
			HttpServletResponse response
			) throws Exception {
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
			zvl.put("orderNo", currentOrderNo.getValue("orderNo"));
		}
		zvl.put("insttUpperCd", Globals.INSTT_UPPER_CD); 				// 기관분류
		zvl.put("evalUpperCd", Globals.EVAL_STATUS_UPPER_CD); 	// 평가상태
		
		ZValue result = mngLevelRstService.selectMngLevelResultSummary(zvl);
		
		List<ZValue> resultList = mngLevelRstService.selectMngLevelResultList(zvl);
    	
		ModelMap.put("result", result);
		ModelMap.put("resultList", resultList);
		ModelMap.put("downName", "mngLevelResult");
		
		return "excelDownload";
	}
}