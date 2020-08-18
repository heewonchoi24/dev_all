package org.ssis.pss.statusExaminRst.web;

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
import org.ssis.pss.statusExaminRst.service.StatusExaminRstService;
import org.ssis.pss.util.Globals;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;

@Controller
public class StatusExaminRstController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private StatusExaminRstService statusExaminRstService;
	
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
	@RequestMapping(value="/statusExaminRst/statusExaminRstSummaryList.do")
	public ModelAndView statusExaminRstSummaryList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/statusExaminRst/statusExaminRstSummaryList" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		// 기관사용자의 경우 기관상세 페이지로 이동한다.
		if("2".equals(userInfo.getAuthorId())){
			response.sendRedirect("/statusExaminRst/statusExaminRstSummaryDtlList.do");
			return null;
		}
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
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
		
		List<ZValue> resultList = statusExaminRstService.selectStatusExaminRstSummaryList(zvl);
		
		ZValue checkItem = new ZValue();
		checkItem.put("mngLevelUpperCd", Globals.MNG_LEVEL_UPPER_CD);
		checkItem.put("mngLevelCd", Globals.STATUS_EXAMIN_CD);
		checkItem.put("orderNo", zvl.getValue("orderNo"));
		List<ZValue> scoreSeList = cmnService.retrieveCheckItemScoreSeList(checkItem);
		if(null != scoreSeList  && 0 < scoreSeList.size()) {
			ZValue temp = scoreSeList.get(0);
			if(Globals.EVAL_TYPE_SCORE_SE.equals(temp.getValue("scoreSe"))) {
				model.addObject("evalType", Globals.EVAL_TYPE_SCORE_SE);
			} else {
				model.addObject("evalType", Globals.EVAL_TYPE_SCORE);
			}
		} else {
			model.addObject("evalType", Globals.EVAL_TYPE_SCORE);
		}
		List<ZValue> sctnScoreList = cmnService.retrieveCheckItemSctnScoreList(checkItem);
		
		model.addObject("requestZvl", zvl);
		model.addObject("scoreSeList", scoreSeList);
		model.addObject("sctnScoreList", sctnScoreList);
		model.addObject("orderList", orderList);
		model.addObject("resultList", resultList);
		
		/* 페이지 정보 */
		model.addObject("pageName", "점검결과 조회");
		
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
	@RequestMapping(value="/statusExaminRst/statusExaminRstSummaryDtlList.do")
	public ModelAndView statusExaminRstSummaryDtlList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/statusExaminRst/statusExaminRstSummaryDtlList" );
		
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
		
		ZValue result = statusExaminRstService.selectStatusExaminRstSummary(zvl);
		
		List<ZValue> resultFile = statusExaminRstService.selectStatusExaminRstSummaryFileList(zvl);
		
		List<ZValue> resultList = statusExaminRstService.selectStatusExaminRstList(zvl);
		
		List<ZValue> resultDtlList = statusExaminRstService.selectStatusExaminRstDtlAllList(zvl);
		
		List<ZValue> resultDtlSum = statusExaminRstService.selectStatusExaminRstDtlSum(zvl);
		
		ZValue checkItem = new ZValue();
		checkItem.put("mngLevelUpperCd", Globals.MNG_LEVEL_UPPER_CD);
		checkItem.put("mngLevelCd", Globals.STATUS_EXAMIN_CD);
		checkItem.put("orderNo", zvl.getValue("orderNo"));
		List<ZValue> scoreSeList = cmnService.retrieveCheckItemScoreSeList(checkItem);
		if(null != scoreSeList  && 0 < scoreSeList.size()) {
			ZValue temp = scoreSeList.get(0);
			if(Globals.EVAL_TYPE_SCORE_SE.equals(temp.getValue("scoreSe"))) {
				model.addObject("evalType", Globals.EVAL_TYPE_SCORE_SE);
			} else {
				model.addObject("evalType", Globals.EVAL_TYPE_SCORE);
			}
		} else {
			model.addObject("evalType", Globals.EVAL_TYPE_SCORE);
		}
		List<ZValue> sctnScoreList = cmnService.retrieveCheckItemSctnScoreList(checkItem);
		
		ZValue evalYn = cmnService.retrieveEvalFromTo(zvl);
		
		model.addObject("scoreSeList", scoreSeList);
		model.addObject("sctnScoreList", sctnScoreList);
		model.addObject("requestZvl", zvl);
		model.addObject("orderList", orderList);
		model.addObject("result", result);
		model.addObject("resultFile", resultFile);
		model.addObject("resultList", resultList);
		model.addObject("resultDtlList", resultDtlList);
		model.addObject("resultDtlSum", resultDtlSum);
		model.addObject("evalYn", evalYn);
		
		/* 페이지 정보 */
		model.addObject("pageName", "점검결과 조회");
		
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
	@RequestMapping(value="/statusExaminRst/statusExaminRstDtl.do")
	public ModelAndView statusExaminRstDtl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/statusExaminRst/statusExaminRstDtl" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		// 기관 사용자의 경우 자신의 기관만 조회
		if("2".equals(userInfo.getAuthorId())){
			zvl.put("insttCd", userInfo.getInsttCd());
		}
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
		// 결과
		ZValue result = statusExaminRstService.selectStatusExaminRst(zvl);
		// 결과 상세		
		List<ZValue> resultDtlList = statusExaminRstService.selectStatusExaminRstDtlList(zvl);
		// 신청 파일
		List<ZValue> resultFile = statusExaminRstService.selectStatusExaminRstFileList(zvl);
		// 메모 파일
		List<ZValue> memoFile = statusExaminRstService.selectStatusExaminEvlMemoFileList(zvl);
		// 이의신청 파일
		List<ZValue> fobjctFile = statusExaminRstService.selectStatusExaminEvlFobjctFileList(zvl);
		
		ZValue checkItem = new ZValue();
		checkItem.put("mngLevelUpperCd", Globals.MNG_LEVEL_UPPER_CD);
		checkItem.put("mngLevelCd", Globals.STATUS_EXAMIN_CD);
		checkItem.put("orderNo", zvl.getValue("orderNo"));
		List<ZValue> scoreSeList = cmnService.retrieveCheckItemScoreSeList(checkItem);
		if(null != scoreSeList  && 0 < scoreSeList.size()) {
			ZValue temp = scoreSeList.get(0);
			if(Globals.EVAL_TYPE_SCORE_SE.equals(temp.getValue("scoreSe"))) {
				model.addObject("evalType", Globals.EVAL_TYPE_SCORE_SE);
			} else {
				model.addObject("evalType", Globals.EVAL_TYPE_SCORE);
			}
		} else {
			model.addObject("evalType", Globals.EVAL_TYPE_SCORE);
		}
		List<ZValue> sctnScoreList = cmnService.retrieveCheckItemSctnScoreList(checkItem);
		
		String periodCd = cmnService.retrieveEvlPeriodCode();		
		zvl.put("periodCd", periodCd);
		
		model.addObject("scoreSeList", scoreSeList);
		model.addObject("sctnScoreList", sctnScoreList);
		model.addObject("requestZvl", zvl);
		model.addObject("orderList", orderList);
		model.addObject("result", result);
		model.addObject("resultDtlList", resultDtlList);		
		model.addObject("resultFile", resultFile);
		model.addObject("memoFile", memoFile);
		model.addObject("fobjctFile", fobjctFile);
		
		/* 페이지 정보 */
		model.addObject("pageName", "점검결과 조회");
		
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
	@RequestMapping(value="/statusExaminRst/updateStatusExaminRstFobjct.do")
	public ModelAndView updateStatusExaminRstFobjct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			statusExaminRstService.updateStatusExaminRstFobjct(zvl, request);
			
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
	@RequestMapping(value="/statusExaminRst/updateStatusExaminRstFobjctFile.do")
	public ModelAndView updateStatusExaminRstFobjctFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			statusExaminRstService.updateStatusExaminEvlFobjctFile(zvl, request);
			
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
	@RequestMapping(value="/statusExaminRst/deleteStatusExaminRstFobjct.do")
	public ModelAndView deleteStatusExaminRstFobjct(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			statusExaminRstService.deleteStatusExaminEvlFobjctFile(zvl, request);
			
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
	@RequestMapping("/statusExaminRst/statusExaminRstExcelDown.do")
	public String statusExaminRstExcelDown(
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
		
		ZValue result = statusExaminRstService.selectStatusExaminRstSummary(zvl);
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		// 기관 사용자의 경우 상세는 보여주지 않는다
		if("2".equals(userInfo.getAuthorId())){
			List<ZValue> resultList = statusExaminRstService.selectStatusExaminRstList(zvl);
			
			ZValue checkItem = new ZValue();
			checkItem.put("mngLevelUpperCd", Globals.MNG_LEVEL_UPPER_CD);
			checkItem.put("mngLevelCd", Globals.STATUS_EXAMIN_CD);
			checkItem.put("orderNo", zvl.getValue("orderNo"));
			List<ZValue> sctnScoreList = cmnService.retrieveCheckItemSctnScoreList(checkItem);
			
			ModelMap.put("resultList", resultList);
			ModelMap.put("sctnScoreList", sctnScoreList);
			ModelMap.put("downName", "statusExaminResult");
		} else {
			List<ZValue> resultList = statusExaminRstService.selectStatusExaminExcelDtlList(zvl);
			ModelMap.put("resultList", resultList);
			ModelMap.put("downName", "statusExaminDtlResult");
		}
    	
		ModelMap.put("result", result);
		
		return "excelDownload";
	}
}