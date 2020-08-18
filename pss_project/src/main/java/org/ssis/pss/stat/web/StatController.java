package org.ssis.pss.stat.web;

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
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.stat.service.StatService;
import org.ssis.pss.util.Globals;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;

@Controller
public class StatController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private StatService statService;
	
	@Autowired
	private CmnService cmnService;
	
	/**
	 * 통계현황 - 기관별현황
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/stat/institutionStat.do")
	public ModelAndView institutionStat(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "/stat/institutionStat" );
		ZValue zvl = WebFactoryUtil.getAttributesInit(request); 

		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			zvl.put("orderNo", cmnService.retrieveCurrentOrderNo().getValue("orderNo"));
		}
		
		mav.addObject("currentOrderNo", zvl.getValue("orderNo"));
		mav.addObject("orderList", orderList);
		return mav;
	}
	
	/**
	 * 통계현황 - 지표별현황
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/stat/indexStat.do")
	public ModelAndView indexStat(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "/stat/indexStat" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
			zvl.put("orderNo", currentOrderNo.getValue("orderNo"));
		}
		
		zvl.put("uppercode", Globals.INSTT_UPPER_CD);
		List<ZValue> codeList = cmnService.retrieveCommCdList(zvl);
		
		mav.addObject("orderNo", zvl.getValue("orderNo"));
		mav.addObject("codeList", codeList);
		mav.addObject("orderList", orderList);
		
		return mav;
	}
	
	/**
	 * 통계현황 - 기초현황
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/stat/bsisStatus.do")
	public ModelAndView bsisStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "/stat/bsisStatus" );
		ZValue zvl = WebFactoryUtil.getAttributesInit(request); 

		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			zvl.put("orderNo", cmnService.retrieveCurrentOrderNo().getValue("orderNo"));
		}
		
		mav.addObject("currentOrderNo", zvl.getValue("orderNo"));
		mav.addObject("orderList", orderList);
		return mav;
	}
	
	/**
	 * 통계현황 - 기초현황 그래프 데이터 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/stat/bsisStatusDataList.do")
	public ModelAndView bsisStatusDataList(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "jsonView" );
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		zvl.put("authorId", userInfo.getAuthorId());
		zvl.put("insttCd", userInfo.getInsttCd());
		
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			zvl.put("orderNo", cmnService.retrieveCurrentOrderNo().getValue("orderNo"));
		}
		mav.addObject("orderNo", zvl.getValue("orderNo"));
		
		try {
			resultList = statService.bsisStatusDataList(zvl);
			mav.addObject("bsisStatusDataList", resultList);
		}catch(Exception e){
			mav.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return mav;
	}
	
	/**
	 * 통계현황 - 지표별 그래프 데이터 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/stat/indexStatDataList.do")
	public ModelAndView indexStatDataList(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "jsonView" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> resultList1 = null;
		List<ZValue> resultList2 = null;
		
		try {
			if("2".equals(userInfo.getAuthorId())){
				zvl.put("insttCd", userInfo.getInsttCd());
				resultList1 = statService.indexInstitutionMngStatList(zvl);
				resultList2 = statService.indexInstitutionStatusStatList(zvl);
			} else {
				resultList1 = statService.indexMngStatList(zvl);
				resultList2 = statService.indexStatusStatList(zvl);
			}
			mav.addObject("resultList1", resultList1);
			mav.addObject("resultList2", resultList2);
			mav.addObject("auth", userInfo.getAuthorId());
		}catch(Exception e){
			mav.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return mav;
	}
	
	/**
	 * 통계현황 - 기관별 현황 그래프 데이터 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/stat/institutionStatDataList.do")
	public ModelAndView institutionStatDataList(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "jsonView" );
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		zvl.put("authorId", userInfo.getAuthorId());
		zvl.put("insttCd", userInfo.getInsttCd());
		
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			zvl.put("orderNo", cmnService.retrieveCurrentOrderNo().getValue("orderNo"));
		}
		mav.addObject("orderNo", zvl.getValue("orderNo"));
		
		try {
			if("2".equals(userInfo.getAuthorId())){
				resultList = statService.insttStatOrgEvlList(zvl);
				mav.addObject("insttStatOrgEvlList", resultList);
			}else{
				resultList = statService.insttStatManageLevelEvlList(zvl);
				mav.addObject("insttStatManageLevelEvlList", resultList);
				
				resultList = statService.insttStatStatusExaminList(zvl);
				mav.addObject("insttStatStatusExaminList", resultList);
			}
		}catch(Exception e){
			mav.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return mav;
	}
	
	
	/**
	 * 통계현황 - 접속통계 현황
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/stat/conectHistStat.do")
	public ModelAndView conectHistStat(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "/stat/conectHistStat" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		return mav;
	}
	
	/**
	 * 통계현황 - 접속통계 데이터 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/stat/conectHistDataList.do")
	public ModelAndView conectHistDataList(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName( "jsonView" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> resultList = null;
		
		try {
			resultList = statService.conectHistDataList(zvl);
			mav.addObject("resultList", resultList);
		}catch(Exception e){
			mav.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		return mav;
	}
}