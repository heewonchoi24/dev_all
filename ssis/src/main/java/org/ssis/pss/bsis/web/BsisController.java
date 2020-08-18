package org.ssis.pss.bsis.web;

import java.lang.reflect.Field;
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
import org.ssis.pss.bsis.service.BsisService;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.pinn.service.PinnService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;

@Controller
public class BsisController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private BsisService bsisService;
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private CmnService cmnService;
	
	@Autowired
	private PinnService pinnService;
	
	/**
	 * 기초현황 - 기관정보
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/bsis/institution.do")
	public ModelAndView institution(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/bsis/institution" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
		ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			zvl.put("orderNo", currentOrderNo.getValue("orderNo"));
		}
		
		ZValue result = bsisService.selectInstitution(zvl);
		
		List<ZValue> resultList = bsisService.selectInstitutionUserList(zvl);
		
		List<ZValue> orgBoxClList = pinnService.selectInsttClSelectBoxList(zvl);

		List<ZValue> orgBoxList = pinnService.selectInsttSelectBoxList(zvl);
		
		String periodCd = cmnService.retrieveEvlPeriodCode();
		model.addObject("periodCd", periodCd);
		
		model.addObject("requestZvl", zvl);
		model.addObject("currentOrderNo", currentOrderNo.getValue("orderNo"));
		model.addObject("orderList", orderList);
		model.addObject("result", result);
		model.addObject("resultList", resultList);
		model.addObject("orgBoxClList", orgBoxClList);
		model.addObject("orgBoxList", orgBoxList);
		
		//웹표준준수 title
		model.addObject("pageName", "기초현황");
		
		if("2".equals(userInfo.getAuthorId())){
			response.sendRedirect( "/bsis/institutionDetail.do" );
		}
		

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
	 * 기초현황 - 기관정보 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/bsis/modifyInstitution.do")
	public ModelAndView modifyInstitution(HttpServletRequest request) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try {
			bsisService.modifyInstitution(zvl, request);
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		modelAndView.setViewName( "jsonView" );
		
		//웹표준준수 title
		modelAndView.addObject("pageName", "기초현황");		
		
		return modelAndView;
	}
	
	
	/**
	 * 기초현황 - 개인정보보호 교육 등록/수정 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/bsis/modifySttusEdc.do")
	public ModelAndView modifySttusEdc(HttpServletRequest request) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try {
			bsisService.modifySttusEdc(zvl, request);
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
	 * 기초현황 - 개인정보 파일 등록/수정 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/bsis/modifySttusFile.do")
	public ModelAndView modifySttusFile(HttpServletRequest request) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try {
			bsisService.modifySttusFile(zvl, request);
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
	 * 기초현황 - 개인정보 위탁관리 등록/수정 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/bsis/modifySttusCnsgn.do")
	public ModelAndView modifySttusCnsgn(HttpServletRequest request) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try {
			bsisService.modifySttusCnsgn(zvl, request);
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
	 * 기초현황 - 개인정보처리시스템 현황 등록/수정 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/bsis/modifySttusSys.do")
	public ModelAndView modifySttusSys(HttpServletRequest request) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try {
			bsisService.modifySttusSys(zvl, request);
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
	 * 기초현황 - 영상정보처리기기 운영현황 등록/수정 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/bsis/modifySttusVideo.do")
	public ModelAndView modifySttusVideo(HttpServletRequest request) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try {
			bsisService.modifySttusVideo(zvl, request);
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
	 * 기관 / 사용자 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/bsis/institutionExcelDownload.do")
	public String institutionExcelDownload(Map<String, Object> ModelMap,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> resultList = bsisService.selectInstitutionExcel(zvl);
		
		ModelMap.put("resultList", resultList);
		ModelMap.put("downName", "institutionUser");

		return "excelDownload";
	}
	
	/**
	 * 기초현황 - 기관정보
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/bsis/institutionDetail.do")
	public ModelAndView institutionDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/bsis/institutionDetail" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
		ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
		
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			zvl.put("orderNo", currentOrderNo.getValue("orderNo"));
		}
		
		if("2".equals(userInfo.getAuthorId())){
			zvl.put("insttCd",       userInfo.getInsttCd());
			zvl.put("insttNm", 	     userInfo.getInsttNm());
			zvl.put("searchInsttNm", userInfo.getInsttNm());
		}
		
		ZValue result = bsisService.selectInstitution(zvl);
		
		// 기관구분 select box
		List<ZValue> orgBoxClList = pinnService.selectInsttClSelectBoxList(zvl);

		// 기관구분 select box
		List<ZValue> orgBoxList = pinnService.selectInsttSelectBoxList(zvl);
		
		String periodCd = cmnService.retrieveEvlPeriodCode();
		
		model.addObject("periodCd", periodCd);
		model.addObject("requestZvl", zvl);
		model.addObject("currentOrderNo", currentOrderNo.getValue("orderNo"));
		model.addObject("orderList", orderList);
		model.addObject("result", result);
		model.addObject("orgBoxClList", orgBoxClList);
		model.addObject("orgBoxList", orgBoxList);
		
		// 담당자
		List<ZValue> resultList =  bsisService.selectInstitutionUserList(zvl);
		// 개인정보 파일
		List<ZValue> resultList2 = bsisService.selectSttusFileList(zvl);
		// 개인정보처리시스템 현황
		List<ZValue> resultList3 = bsisService.selectSttusSysList(zvl);
		// 영상정보처리기기 운영현황
		List<ZValue> resultList4 = bsisService.selectSttusVideoList(zvl);
		
		model.addObject("resultList",  resultList);
		model.addObject("resultList2", resultList2);
		model.addObject("resultList3", resultList3);
		model.addObject("resultList4", resultList4);
		
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
		
		//웹표준준수 title
		model.addObject("pageName", "기초현황");
		
		return model;	
	}	
	
	/**
	 * 기초현황 - 기관정보 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/bsis/modifyInstitutionAll.do")
	public ModelAndView modifyInstitutionAll(HttpServletRequest request) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try {
			
			bsisService.modifyInstitution(zvl, request);
			
			if(zvl.getString("gubun").equals("all")){
				bsisService.modifySttusFile(zvl, request);
				bsisService.modifySttusSys(zvl, request);
				bsisService.modifySttusVideo(zvl, request);
			}
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}

	
}