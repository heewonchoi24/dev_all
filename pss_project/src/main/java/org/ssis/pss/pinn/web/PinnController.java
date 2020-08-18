package org.ssis.pss.pinn.web;

import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.pinn.service.PinnService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Controller
public class PinnController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private PinnService pinnService;
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private CmnService cmnService;
	
	/**
	 * 서면점검 실적등록 종합 [보건복지부(author_id=1)가 보는 화면]
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/pinn/pinnSummaryList.do")
	public ModelAndView pinnSummaryList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/pinn/pinnSummaryList" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		if("2".equals(userInfo.getAuthorId())){
			response.sendRedirect("/pinn/pinnInsttDtlList.do");
			return null;
		}
		
		// 기관구분 select box
		List<ZValue> yyyyList = pinnService.selectFyerSchdulSelectBoxList();
		// 현재 차수 조회
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();
		if(StringUtils.isEmpty(zvl.getValue("searchYyyy"))) {
			if(null != yyyyList && 0 < yyyyList.size()) {
				zvl.put("searchYyyy", orderVal.getValue("orderNo"));
			}
		}
		zvl.put("order_no", orderVal.getValue("orderNo"));
		
		// 기관별 종합 상태
		List<ZValue> resultList = pinnService.selectPinnSummaryList(zvl);
		
		// 기관 그룹
		List<ZValue> orgList = pinnService.selectInsttGroupList(zvl);
		
		// 기관구분 select box
		List<ZValue> orgBoxClList = pinnService.selectInsttClSelectBoxList(zvl);

		// 기관구분 select box
		List<ZValue> orgBoxList = pinnService.selectInsttSelectBoxList(zvl);
		
		model.addObject("requestZvl", zvl);
		model.addObject("yyyyList", yyyyList);
		model.addObject("resultList", resultList);
		model.addObject("orgList", orgList);
		model.addObject("orgBoxClList", orgBoxClList);
		model.addObject("orgBoxList", orgBoxList);

		/* 페이지 정보 */
		model.addObject("pageName", "서면점검 실적등록 및 조회");
		
		return model;	
	}
	
	/**
	 * 서면점검 (기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/pinn/selectBoxInsttList.do")
	public ModelAndView selectBoxInsttList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "jsonView" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> orgBoxList = pinnService.selectInsttSelectBoxList(zvl);

		modelAndView.addObject("orgBoxList", orgBoxList);
		
		return modelAndView;	
	}
	
	/**
	 * 서면점검 실적 평가 [보건복지부(author_id=1)가 보는 화면]
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/pinn/pinnDtlList.do")
	public ModelAndView pinnDtlList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/pinn/pinnDtlList" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		// 기관구분 select box
		List<ZValue> yyyyList = pinnService.selectFyerSchdulSelectBoxList();
		
		// 기관별 상세 list
		List<ZValue> resultList = pinnService.selectPinnReqEvalDtlList(zvl);
		
		// 기관별 상세 flie list
		List<ZValue> fileList = pinnService.selectPinnReqFileList(zvl);
		
		// 기관별 상세 평가 flie list
		List<ZValue> evalFileList = pinnService.selectPinnEvalFileList(zvl);
		
		// 기관 그룹
		List<ZValue> orgList = pinnService.selectInsttGroupList(zvl);
		
		// 기관구분 select box
		List<ZValue> orgBoxClList = pinnService.selectInsttClSelectBoxList(zvl);

		// 기관구분 select box
		List<ZValue> orgBoxList = pinnService.selectInsttSelectBoxList(zvl);
		
		model.addObject("requestZvl", zvl);
		model.addObject("fileList", fileList);
		model.addObject("evalFileList", evalFileList);
		model.addObject("yyyyList", yyyyList);
		model.addObject("resultList", resultList);
		model.addObject("orgList", orgList);
		model.addObject("orgBoxClList", orgBoxClList);
		model.addObject("orgBoxList", orgBoxList);
		
		/* 페이지 정보 */
		model.addObject("pageName", "서면점검 실적등록 및 조회");

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
	 * 서면점검 실적등록 [기관담당자(author_id=2)가 보는 화면]
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/pinn/pinnInsttDtlList.do")
	public ModelAndView pinnInsttDtlList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/pinn/pinnInsttDtlList" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		// 기관구분 select box
		List<ZValue> yyyyList = pinnService.selectFyerSchdulSelectBoxList();
		// 현재 차수 조회
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();
		if(StringUtils.isEmpty(zvl.getValue("searchYyyy"))) {
			if(null != yyyyList && 0 < yyyyList.size()) {
				zvl.put("searchYyyy", orderVal.getValue("orderNo"));
			}
		}
		zvl.put("order_no", orderVal.getValue("orderNo"));
		
		zvl.put("searchInsttCd", userInfo.getInsttCd());
		zvl.put("insttCd", userInfo.getInsttCd());
		zvl.put("insttNm", userInfo.getInsttNm());
		zvl.put("insttClCd", userInfo.getInsttClCd());
		
		// 기관별 상세 list
		List<ZValue> resultList = pinnService.selectPinnReqEvalDtlList(zvl);
		
		// 기관별 상세 flie list
		List<ZValue> fileList = pinnService.selectPinnReqFileList(zvl);
		
		// 기관별 상세 평가 flie list
		List<ZValue> evalFileList = pinnService.selectPinnEvalFileList(zvl);
		
		// 기관구분 select box
		List<ZValue> orgBoxClList = pinnService.selectInsttClSelectBoxList(zvl);

		// 기관구분 select box
		List<ZValue> orgBoxList = pinnService.selectInsttSelectBoxList(zvl);
		
		model.addObject("requestZvl", zvl);
		model.addObject("fileList", fileList);
		model.addObject("evalFileList", evalFileList);
		model.addObject("yyyyList", yyyyList);
		model.addObject("resultList", resultList);
		model.addObject("orgBoxClList", orgBoxClList);
		model.addObject("orgBoxList", orgBoxList);
		
		/* 페이지 정보 */
		model.addObject("pageName", "서면점검 실적등록 및 조회");
		
		return model;	
	}
	
	/**
	 * 서면점검 등록 / 수정
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pinn/updatePinnReqst.do")
	public ModelAndView updatePinnReqst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		String atchmnflId = EgovStringUtil.nullConvert( zvl.getString("atchmnfl_id"));
		
		try{
			pinnService.modifyPinnReqst(zvl, request);
			if(StringUtils.isEmpty(atchmnflId))
				modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			else
				modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
		}catch(Exception e){
			if(StringUtils.isEmpty(atchmnflId))
				modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			else
				modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error( e );
			e.printStackTrace();
		}
		
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
	
	/**
	 * 서면점검 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pinn/deletePinnReqst.do")
	public ModelAndView deletePinnReqst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			pinnService.deletePinnReqst(zvl, request);
			
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
	 * 서면점검 평가 수정
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pinn/updatePinnEval.do")
	public ModelAndView updatePinnEval(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		String atchmnflId = EgovStringUtil.nullConvert( zvl.getString("atchmnfl_id"));
		
		try{
			pinnService.modifyPinnEval(zvl, request);
			if(StringUtils.isEmpty(atchmnflId))
				modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			else
				modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
		}catch(Exception e){
			if(StringUtils.isEmpty(atchmnflId))
				modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			else
				modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error( e );
			e.printStackTrace();
		}
		
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
	
	/**
	 * 서면점검 평가 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pinn/deletePinnEval.do")
	public ModelAndView deletePinnEval(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			pinnService.deletePinnEval(zvl, request);
			
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
	 * 서면점검 상태 update
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/pinn/updatePinnEvalStatus.do")
	public ModelAndView updatePinnEvalStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			pinnService.updatePinnEvalStatus(zvl, request);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error( e );
			e.printStackTrace();
		}
		
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
}