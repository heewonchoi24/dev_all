package org.ssis.pss.mngLevelReq.web;

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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.mngLevelReq.service.MngLevelReqService;
import org.ssis.pss.mngLevelRst.service.MngLevelRstService;
import org.ssis.pss.util.Globals;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;

@Controller
public class MngLevelReqController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private MngLevelReqService MngLevelReqService;
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private CmnService cmnService;
	
	@Autowired
	private MngLevelRstService mngLevelRstService;	
	
	/**
	 * 관리수준 진단 - 서면평가
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelReq/mngLevelDocumentEvaluation.do")
	public ModelAndView MngLevelDocumentEvaluation(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		model.addAttribute("orderList", orderList);		
		
		if(StringUtils.isEmpty(zvl.getValue("s_order_no"))) {
			ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
			zvl.put("s_order_no", currentOrderNo.getValue("orderNo"));
		}
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		resultList = MngLevelReqService.mngLevelInsttEvlOrderList(zvl);
		model.addAttribute("mngLevelInsttEvlOrderList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttClCdList(zvl);
		model.addAttribute("mngLevelInsttClCdList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttList(zvl);
		model.addAttribute("mngLevelInsttList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttSelectList(zvl);
		model.addAttribute("mngLevelInsttSelectList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttTableList(zvl);
		model.addAttribute("mngLevelInsttTableList", resultList);
		
		resultList = MngLevelReqService.mngLevelIdxList(zvl);
		model.addAttribute("mngLevelIdxList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttEvlList(zvl);
		model.addAttribute("mngLevelInsttEvlList", resultList);
		
		model.addAttribute("requestZvl", zvl);

		/* 페이지 정보 */
		model.addAttribute("pageNum", "1");
		model.addAttribute("subNum", "3");
		model.addAttribute("threeNum", "0");
		model.addAttribute("dep1Name", "관리수준 진단");
		model.addAttribute("dep2Name", "서면평가");
		model.addAttribute("dep3Name", "");
		model.addAttribute("dep4Name", "");
		model.addAttribute("pageName", "서면평가");
		
		modelAndView.setViewName( "/mngLevelReq/mngLevelDocumentEvaluation" );
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 진단 - 서면평가 - 년도 조회
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/mngLevelDocumentEvaluationAjax.do")
	public ModelAndView MngLevelDocumentEvaluationAjax(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		model.addAttribute("orderList", orderList);		
		
		zvl.put("s_order_no", zvl.getValue("s_order_no"));
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		resultList = MngLevelReqService.mngLevelInsttEvlOrderList(zvl);
		model.addAttribute("mngLevelInsttEvlOrderList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttClCdList(zvl);
		model.addAttribute("mngLevelInsttClCdList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttList(zvl);
		model.addAttribute("mngLevelInsttList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttSelectList(zvl);
		model.addAttribute("mngLevelInsttSelectList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttTableList(zvl);
		model.addAttribute("mngLevelInsttTableList", resultList);
		
		resultList = MngLevelReqService.mngLevelIdxList(zvl);
		model.addAttribute("mngLevelIdxList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttEvlList(zvl);
		model.addAttribute("mngLevelInsttEvlList", resultList);
		
		model.addAttribute("requestZvl", zvl);
		
		/* 페이지 정보 */
		model.addAttribute("pageNum", "1");
		model.addAttribute("subNum", "3");
		model.addAttribute("threeNum", "0");
		model.addAttribute("dep1Name", "관리수준 진단");
		model.addAttribute("dep2Name", "서면평가");
		model.addAttribute("dep3Name", "");
		model.addAttribute("dep4Name", "");
		model.addAttribute("pageName", "서면평가");
		
		modelAndView.setViewName( "/mngLevelReq/mngLevelDocumentEvaluation" );
		
		return modelAndView;	
	}	
	
	/**
	 * 관리수준 진단 - 서면평가(기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/mngLevelInsttListAjax.do")
	public ModelAndView MngLevelInsttListAjax(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}

		resultList = MngLevelReqService.mngLevelInsttListAjax(zvl);
		
		modelAndView.setViewName( "jsonView" );
		modelAndView.addObject("resultList", resultList);
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 상세 목록)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/mngLevelDocumentEvaluationDetail.do")
	public ModelAndView MngLevelDocumentEvaluationDetail(
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
		
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("currentOrderNo", orderVal.getValue("orderNo"));
		
		if("2".equals(userInfo.getAuthorId())){
			
			zvl.put("s_order_no", orderVal.getValue("orderNo"));
			zvl.put("s_instt_cd", userInfo.getInsttCd());
			zvl.put("s_instt_nm", userInfo.getInsttNm());
			zvl.put("instt_cl_cd","");
			zvl.put("s_instt_cl_nm", "");
			zvl.put("s_instt_cl_cd", "");
			
			resultList = MngLevelReqService.mngLevelInsttClCdList(zvl);
			model.addAttribute("mngLevelInsttClCdList", resultList);
			
			resultList = MngLevelReqService.mngLevelInsttSelectList(zvl);
			model.addAttribute("mngLevelInsttSelectList", resultList);		
	
			resultList = MngLevelReqService.mngLevelInsttList(zvl);
			model.addAttribute("mngLevelInsttList", resultList);
			
			resultList = MngLevelReqService.mngLevelInsttDetailList(zvl);
			model.addAttribute("mngLevelInsttDetailList", resultList);
			
			result = MngLevelReqService.mngLevelInsttTotalEvl(zvl);
			model.addAttribute("mngLevelInsttTotalEvl", result);
			
			resultList = MngLevelReqService.selectMngLevelReqstAllFileList(zvl);
			model.addAttribute("mngLevelAllFileList", resultList);
			
			resultList = MngLevelReqService.mngLevelResultReportFile(zvl);
			model.addAttribute("mngLevelResultReportFile", resultList);
			
			result = MngLevelReqService.mngLevelResultBeforeYear(zvl);
			model.addAttribute("mngLevelResultBeforeYear", result);
			
			model.addAttribute("s_order_no", orderVal.getValue("orderNo"));
			model.addAttribute("s_instt_cd", userInfo.getInsttCd());
			model.addAttribute("s_instt_nm", userInfo.getInsttNm());
			model.addAttribute("instt_cl_cd","");
			model.addAttribute("s_instt_cl_nm", "");
			model.addAttribute("s_instt_cl_cd", "");				
			
			model.addAttribute("pageName", "중간점수/이의신청");
		}else{

			if("5".equals(userInfo.getAuthorId())){
				zvl.put("user_id", userInfo.getUserId());
			}
			
			zvl.put("periodCode", cmnService.retrieveEvlPeriodCode());
			
			logger.debug("############## zvl ##############");
			logger.debug(zvl);
			logger.debug("############## zvl ##############");
			
			resultList = MngLevelReqService.mngLevelInsttClCdList(zvl);
			model.addAttribute("mngLevelInsttClCdList", resultList);
			
			resultList = MngLevelReqService.mngLevelInsttSelectList(zvl);
			model.addAttribute("mngLevelInsttSelectList", resultList);		
	
			resultList = MngLevelReqService.mngLevelInsttList(zvl);
			model.addAttribute("mngLevelInsttList", resultList);
			
			resultList = MngLevelReqService.mngLevelInsttDetailList(zvl);
			model.addAttribute("mngLevelInsttDetailList", resultList);
			
			result = MngLevelReqService.mngLevelInsttTotalEvl(zvl);
			model.addAttribute("mngLevelInsttTotalEvl", result);
			
			resultList = MngLevelReqService.selectMngLevelReqstAllFileList(zvl);
			model.addAttribute("mngLevelAllFileList", resultList);
			
			resultList = MngLevelReqService.mngLevelResultReportFile(zvl);
			model.addAttribute("mngLevelResultReportFile", resultList);
			
			result = MngLevelReqService.mngLevelResultBeforeYear(zvl);
			model.addAttribute("mngLevelResultBeforeYear", result);
			
			modelAndView.addAllObjects(zvl);
			
			model.addAttribute("instt_cl_cd",   zvl.getValue("instt_cl_cd"));
			model.addAttribute("s_instt_cl_nm", zvl.getValue("s_instt_cl_nm"));
			model.addAttribute("s_instt_cd", 	zvl.getValue("s_instt_cd"));
			model.addAttribute("s_instt_nm",	zvl.getValue("s_instt_nm"));
			
			model.addAttribute("pageName", "서면평가");
		}
		
		model.addAttribute("requestZvl", zvl);		
		modelAndView.setViewName( "/mngLevelReq/mngLevelDocumentEvaluationDetail" );
		
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
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 진단 - 서면평가 - 이전 서면평가 결과 보기
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/mngLevelReq/mngLevelReqExcelDown.do")
	public String mIndexExcelDownload(
			Map<String, Object> ModelMap,
			HttpServletRequest request,
			HttpServletResponse response
			) throws Exception {
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		if(StringUtils.isEmpty(zvl.getValue("s_order_no"))) {
			ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
			zvl.put("s_order_no", currentOrderNo.getValue("orderNo"));
		}
		zvl.put("insttUpperCd", Globals.INSTT_UPPER_CD); 				// 기관분류
		zvl.put("evalUpperCd", Globals.EVAL_STATUS_UPPER_CD); 	// 평가상태
		
		ZValue result = MngLevelReqService.selectMngLevelResultSummary(zvl);
		
		List<ZValue> resultList = MngLevelReqService.selectMngLevelResultList(zvl);
    	
		ModelMap.put("result", result);
		ModelMap.put("resultList", resultList);
		ModelMap.put("downName", "mngLevelResult");
		
		return "excelDownload";
	}
	
	/**
	 * 관리수준 진단 - 서면평가(최종완료)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/mngLevelDocumentEvaluationComplete.do")
	public ModelAndView mngLevelDocumentEvaluationComplete(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}
		
		zvl.put("periodCode", cmnService.retrieveEvlPeriodCode());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		result = MngLevelReqService.mngLevelInsttTotalEvl(zvl);
		model.addAttribute("mngLevelInsttTotalEvl", result);

		modelAndView.addAllObjects(zvl);
		
		/* 페이지 정보 */
		model.addAttribute("pageNum", "1");
		model.addAttribute("subNum", "3");
		model.addAttribute("threeNum", "0");
		model.addAttribute("dep1Name", "관리수준 진단");
		model.addAttribute("dep2Name", "서면평가");
		model.addAttribute("dep3Name", "");
		model.addAttribute("dep4Name", "");
		model.addAttribute("pageName", "서면평가");
		
		model.addAttribute("s_instt_cl_nm", zvl.getValue("s_instt_cl_nm"));
		
		modelAndView.setViewName( "/mngLevelReq/mngLevelDocumentEvaluationComplete" );
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 진단 - 서면평가(이의신청 사유 AJAX)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/mngLevelReq/mngLevelFobjctResnAjax.do")
	public ModelAndView mngLevelFobjctResnAjax(
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
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}

		result = MngLevelReqService.mngLevelFobjctResnAjax(zvl);
		model.addAttribute("result", result);
		
		resultList = MngLevelReqService.mngLevelFobjctResnFileAjax(zvl);
		model.addAttribute("resultList", resultList);
		
		modelAndView.setViewName( "jsonView" );
		modelAndView.addAllObjects(zvl);
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 상세 단일항목 조회)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/mngLevelDocumentEvaluationRegist.do")
	public ModelAndView mngLevelDocumentEvaluationRegist(
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
		
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("currentOrderNo", orderVal.getValue("orderNo"));
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}
		
		zvl.put("periodCode", cmnService.retrieveEvlPeriodCode());
		
		logger.debug("############## zvl1 ##############");
		logger.debug(zvl);
		logger.debug("############## zvl1 ##############");
		
		// 지표 항목, 평가의견
		result = MngLevelReqService.mngLevelDocumentEvaluationRegist(zvl);
		model.addAttribute("mngLevelInsttDetailEvlInfo", result);
		
		// 진단항목 파일 리스트
		resultList = MngLevelReqService.mngLevelInsttDetailEvlFileList(zvl);
		model.addAttribute("mngLevelInsttDetailEvlFileList", resultList);
		
		// 메모 첨부파일
		resultList = MngLevelReqService.mngLevelInsttDetailMemoFileList(zvl);
		model.addAttribute("mngLevelInsttDetailMemoFileList", resultList);
		
		// 이의신청
		result = MngLevelReqService.mngLevelFobjctResnAjax(zvl);
		model.addAttribute("mngLevelFobjctResn", result);
		
		// 이의신청 파일
		resultList = mngLevelRstService.selectMngLevelEvlFobjctFileList(zvl);		
		model.addAttribute("fobjctFileList", resultList);
		
		// 신청 파일
		//List<ZValue> resultFile = mngLevelRstService.selectMngLevelRequestFileList(zvl);
		//model.addAttribute("resultFile", resultFile);
		
		// 메모 파일
		//List<ZValue> memoFile = mngLevelRstService.selectMngLevelEvlMemoFileList(zvl);
		//model.addAttribute("memoFile", memoFile);
		
		String periodCd = cmnService.retrieveEvlPeriodCode();		
		zvl.put("periodCd", periodCd);
		
		model.addAttribute("requestZvl", zvl);
		modelAndView.addAllObjects(zvl);
		
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
		
		model.addAttribute("pageName", "중간점수/이의신청");
		modelAndView.setViewName( "/mngLevelReq/mngLevelDocumentEvaluationRegist" );
		
		logger.debug("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		logger.debug(zvl);
		logger.debug("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");		
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 상세 단일항목 평가 등록)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/mngLevelDocumentEvaluationInsertAjax.do")
	public ModelAndView mngLevelDocumentEvaluationInsert(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		zvl.put("user_id", userInfo.getUserId());
		zvl.put("periodCode", cmnService.retrieveEvlPeriodCode());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		MngLevelReqService.mngLevelDocumentEvaluationInsertAjax(zvl);
		
		modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
	
	
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 상세 단일항목 메모 파일 정보 인서트)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/mngLevelDocumentEvaluationFileInsertAjax.do")
	public ModelAndView mngLevelDocumentEvaluationFileInsertAjax(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		MngLevelReqService.mngLevelDocumentEvaluationFileInsertAjax(zvl, request);
		
		modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 상세 단일항목 메모 파일 정보 업데이트)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/mngLevelDocumentEvaluationFileUpdateAjax.do")
	public ModelAndView mngLevelDocumentEvaluationFileUpdateAjax(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		MngLevelReqService.mngLevelDocumentEvaluationFileUpdateAjax(zvl, request);
		
		modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 상세 단일항목 메모 파일 삭제)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/mngLevelDocumentEvaluationFileDeleteAjax.do")
	public ModelAndView mngLevelDocumentEvaluationFileDeleteAjax(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		MngLevelReqService.mngLevelDocumentEvaluationFileDeleteAjax(zvl, request);
		
		modelAndView.addObject("message", egovMessageSource.getMessage("success.common.delete"));
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 종합평가 등록)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelReq/mngLevelDocumentEvaluationTotalRegist.do")
	public ModelAndView mngLevelDocumentEvaluationTotalRegist(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		zvl.put("periodCode", cmnService.retrieveEvlPeriodCode());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		MngLevelReqService.mngLevelDocumentEvaluationTotalRegist(zvl, request);
		modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 진단 - 평가점수, 환산점수 등록 수정
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/updateResultTotPerScoreAjax.do")
	public ModelAndView updateResultTotPerScoreAjax(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try {
			zvl.put("periodCode", cmnService.retrieveEvlPeriodCode());
			
			MngLevelReqService.updateResultTotPerScoreAjax(zvl, request);
			modelAndView.addObject("message", "0");
		} catch(Exception e) {
			modelAndView.addObject("message", "-1");
		}
		
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
	
	
	/**
	 * 서면평가 진단항목 아이콘 클릭시 레이어팝업
	 * @param request
	 * @param response
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelReq/popState.do")
	public ModelAndView popState(HttpServletRequest request,HttpServletResponse response, ModelMap model) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		ZValue result = null;
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}
		
		zvl.put("periodCode", cmnService.retrieveEvlPeriodCode());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		result = MngLevelReqService.mngLevelDocumentEvaluationRegist(zvl);
		model.addAttribute("mngLevelInsttDetailEvlInfo", result);
		
		resultList = MngLevelReqService.mngLevelInsttDetailEvlFileList(zvl);
		model.addAttribute("mngLevelInsttDetailEvlFileList", resultList);
		
		resultList = MngLevelReqService.mngLevelInsttDetailMemoFileList(zvl);
		model.addAttribute("mngLevelInsttDetailMemoFileList", resultList);
		
		// 결과 상세
		result = MngLevelReqService.mngLevelFobjctResnAjax(zvl);
		model.addAttribute("mngLevelFobjctResn", result);
		
		// 신청 파일
		List<ZValue> resultFile = mngLevelRstService.selectMngLevelRequestFileList(zvl);
		model.addAttribute("resultFile", resultFile);
		
		// 메모 파일
		List<ZValue> memoFile = mngLevelRstService.selectMngLevelEvlMemoFileList(zvl);
		model.addAttribute("memoFile", memoFile);
		
		
		String periodCd = cmnService.retrieveEvlPeriodCode();		
		zvl.put("periodCd", periodCd);
		
		model.addAttribute("requestZvl", zvl);
		
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "/mngLevelReq/popup/popState" );
		
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
		
		return modelAndView;	
	}	
}