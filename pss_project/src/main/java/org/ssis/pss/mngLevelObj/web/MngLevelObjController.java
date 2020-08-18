package org.ssis.pss.mngLevelObj.web;

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
public class MngLevelObjController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private MngLevelReqService MngLevelReqService;
	
	@Autowired
	private CmnService cmnService;
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	/**
	 * 관리수준 진단 - 이의신청
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelObj/mngLevelObjectList.do")
	public ModelAndView mngLevelObjectList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
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
		model.addAttribute("subNum", "5");
		model.addAttribute("threeNum", "0");
		model.addAttribute("dep1Name", "관리수준 진단");
		model.addAttribute("dep2Name", "이의신청");
		model.addAttribute("dep3Name", "");
		model.addAttribute("dep4Name", "");
		model.addAttribute("pageName", "이의신청");
		
		modelAndView.setViewName( "/mngLevelObj/mngLevelObjectList" );
		
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
	@RequestMapping(value="/mngLevelObj/mngLevelObjectDetail.do")
	public ModelAndView mngLevelObjectDetail(
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
		model.addAttribute("s_instt_cd", 	 zvl.getValue("s_instt_cd"));
		model.addAttribute("s_instt_nm",	 zvl.getValue("s_instt_nm"));
		
		model.addAttribute("requestZvl", zvl);		
		
		/* 페이지 정보 */
		model.addAttribute("pageNum", "1");
		model.addAttribute("subNum", "5");
		model.addAttribute("threeNum", "0");
		model.addAttribute("dep1Name", "관리수준 진단");
		model.addAttribute("dep2Name", "이의신청");
		model.addAttribute("dep3Name", "");
		model.addAttribute("dep4Name", "");
		model.addAttribute("pageName", "이의신청");
		
		modelAndView.setViewName( "/mngLevelObj/mngLevelObjectDetail" );
		
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
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelObj/mngLevelObjectDetailView.do")
	public ModelAndView mngLevelObjectDetailView(
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
		
		modelAndView.addAllObjects(zvl);
		
		/* 페이지 정보 */
		model.addAttribute("pageNum", "1");
		model.addAttribute("subNum", "5");
		model.addAttribute("threeNum", "0");
		model.addAttribute("dep1Name", "관리수준 진단");
		model.addAttribute("dep2Name", "이의신청");
		model.addAttribute("dep3Name", "");
		model.addAttribute("dep4Name", "");
		model.addAttribute("pageName", "이의신청");
		
		modelAndView.setViewName( "/mngLevelObj/mngLevelObjectDetailView" );
		
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
	@RequestMapping(value="/mngLevelObj/mngLevelObjectDetailAjax.do")
	public ModelAndView mngLevelObjectDetailAjax(
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
		model.addAttribute("subNum", "5");
		model.addAttribute("threeNum", "0");
		model.addAttribute("dep1Name", "관리수준 진단");
		model.addAttribute("dep2Name", "이의신청");
		model.addAttribute("dep3Name", "");
		model.addAttribute("dep4Name", "");
		model.addAttribute("pageName", "이의신청");
		
		modelAndView.setViewName( "/mngLevelObj/mngLevelObjectList" );
		
		return modelAndView;	
	}	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelObj/mngLevelObjectRegist.do")
	public ModelAndView mngLevelObjectRegist(
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
		
		resultList = MngLevelReqService.mngLevelInsttDetailList(zvl);
		model.addAttribute("mngLevelInsttDetailList", resultList);			
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());
		}

		result = MngLevelReqService.mngLevelFobjctResnAjax(zvl);
		model.addAttribute("mngLevelFobjctResn", result);
		
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "/mngLevelObj/mngLevelObjectRegist" );
		
		model.addAttribute("pageName", "이의신청");		
		
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