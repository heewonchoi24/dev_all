package org.ssis.pss.mngLevelRes.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.mngLevelReq.service.MngLevelReqService;
import org.ssis.pss.mngLevelRes.service.MngLevelResService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Controller
public class MngLevelResController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private MngLevelResService mngLevelResService;

	@Autowired
	private CmnService cmnService;

	@Autowired
	private UserService UserService;
	
	@Autowired
	private MngLevelReqService MngLevelReqService;

	/**
	 * 관리수준 진단 - 실적등록 및 조회
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelRes/mngLevelSummaryList.do")
	public ModelAndView mngLevelSummaryList(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		model.addAttribute("orderList", orderList);
		
		if("2".equals(userInfo.getAuthorId())) {
			response.sendRedirect("/mngLevelRes/mngLevelModifyList.do");
			return null;
		}
		
		List<ZValue> resultList = null;

		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("order_no", orderVal.getValue("orderNo"));
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());			
		}
		
		try{
			resultList = mngLevelResService.mngLevelInsttEvlOrderList(zvl);
			model.addAttribute("mngLevelInsttEvlOrderList", resultList);
			
			resultList = mngLevelResService.mngLevelInsttClCdList(zvl);
			model.addAttribute("mngLevelInsttClCdList", resultList);
			
			resultList = mngLevelResService.mngLevelInsttList(zvl);
			model.addAttribute("mngLevelInsttList", resultList);

			resultList = mngLevelResService.mngLevelInsttSelectList(zvl);
			model.addAttribute("mngLevelInsttSelectList", resultList);

			resultList = mngLevelResService.mngLevelInsttTableList(zvl);
			model.addAttribute("mngLevelInsttTableList", resultList);
			
			resultList = mngLevelResService.mngLevelIdxList(zvl);
			model.addAttribute("mngLevelIdxList", resultList);
			
			resultList = mngLevelResService.mngLevelInsttEvlList(zvl);
			model.addAttribute("mngLevelInsttEvlList", resultList);
			
			model.addAttribute("requestZvl", zvl);
			
			/* 페이지 정보 */
			model.addAttribute("pageNum", "1");
			model.addAttribute("subNum",  "2");
			model.addAttribute("threeNum", "0");
			model.addAttribute("dep1Name", "관리수준 진단");
			model.addAttribute("dep2Name", "실적등록 및 조회");
			model.addAttribute("dep3Name", "");
			model.addAttribute("dep4Name", "");
			model.addAttribute("pageName", "실적등록 및 조회");
			
			modelAndView.setViewName( "mngLevelRes/mngLevelSummaryList" );
			
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}

	/**
	 * 관리수준 진단 - 실적등록 및 조회 - 년도 조회
	 * @param request
	 * @param response
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/mngLevelRes/mngLevelSummaryListAjax.do")
	public ModelAndView mngLevelSummaryListAjax(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		model.addAttribute("orderList", orderList);
		
		if("2".equals(userInfo.getAuthorId())) {
			response.sendRedirect("/mngLevelRes/mngLevelModifyList.do");
			return null;
		}
		
		List<ZValue> resultList = null;

		zvl.put("order_no", zvl.getValue("orderNo"));
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());			
		}
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = mngLevelResService.mngLevelInsttEvlOrderList(zvl);
			model.addAttribute("mngLevelInsttEvlOrderList", resultList);
			
			resultList = mngLevelResService.mngLevelInsttClCdList(zvl);
			model.addAttribute("mngLevelInsttClCdList", resultList);
			
			resultList = mngLevelResService.mngLevelInsttList(zvl);
			model.addAttribute("mngLevelInsttList", resultList);

			resultList = mngLevelResService.mngLevelInsttSelectList(zvl);
			model.addAttribute("mngLevelInsttSelectList", resultList);

			resultList = mngLevelResService.mngLevelInsttTableList(zvl);
			model.addAttribute("mngLevelInsttTableList", resultList);
			
			
			resultList = mngLevelResService.mngLevelIdxList(zvl);
			model.addAttribute("mngLevelIdxList", resultList);
			
			resultList = mngLevelResService.mngLevelInsttEvlList(zvl);
			model.addAttribute("mngLevelInsttEvlList", resultList);
			
			model.addAttribute("requestZvl", zvl);
			
			/* 페이지 정보 */
			model.addAttribute("pageNum", "1");
			model.addAttribute("subNum", "2");
			model.addAttribute("threeNum", "0");
			model.addAttribute("dep1Name", "관리수준 진단");
			model.addAttribute("dep2Name", "실적등록 및 조회");
			model.addAttribute("dep3Name", "");
			model.addAttribute("dep4Name", "");
			model.addAttribute("pageName", "실적등록 및 조회");
			
			modelAndView.setViewName( "mngLevelRes/mngLevelSummaryList" );
			
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}	

	/**
	 * 관리수준 진단 - 서면평가(기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/mngLevelRes/mngLevelInsttListAjax.do")
	public ModelAndView MngLevelInsttListAjax(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());			
		}
		
		try{
			resultList = mngLevelResService.MngLevelInsttListAjax(zvl);
			
			modelAndView.setViewName( "jsonView" );
			modelAndView.addObject("resultList", resultList);
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}

	/**
	 * 관리수준 지표 리스트 화면
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelRes/mngLevelSummaryListDetail.do")
	public ModelAndView mngLevelSummaryListDetail(HttpServletRequest request, HttpServletResponse response) throws Exception { 

		ModelAndView model = new ModelAndView();
		model.setViewName( "mngLevelRes/mngLevelSummaryListDetail" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		model.addObject("currentOrderNo", orderVal.getValue("orderNo"));
		
		logger.debug("###################### zvl2 ######################");  
		logger.debug(zvl);  
		logger.debug("###################### zvl2 ######################");  
		
		String tempInsttCd = zvl.getValue("instt_nm");
		
		if("5".equals(userInfo.getAuthorId())){
			zvl.put("user_id", userInfo.getUserId());			
		}

		List<ZValue> resultList = null;

		resultList = mngLevelResService.mngLevelInsttClCdList(zvl);
		model.addObject("mngLevelInsttClCdList", resultList);

		resultList = mngLevelResService.mngLevelInsttSelectList(zvl);
		model.addObject("mngLevelInsttSelectList", resultList);

		for(int i=0; i < resultList.size() ; i ++) {
			if(tempInsttCd.equals(resultList.get(i).getValue("INSTT_CD"))) {
				zvl.put("s_instt_cd"          , resultList.get(i).getValue("INSTT_CD"));
				zvl.put("s_instt_nm"          , resultList.get(i).getValue("INSTT_NM"));
			}
		}
		zvl.put("insttCd", zvl.getValue("s_instt_cd"));
		
		resultList = mngLevelResService.selectMngLevelIndexList(zvl);
		model.addObject("resultList", resultList);
		
		zvl.put("s_order_no", zvl.getValue("orderNo"));
		resultList = MngLevelReqService.selectMngLevelReqstAllFileList(zvl);
		model.addObject("mngLevelAllFileList", resultList);		
		
		zvl.put("mngLevelIdxSeq", "0");
		List<ZValue> mngLevelResultReportFile = mngLevelResService.mngLevelInsttFileList(zvl);
		model.addObject("mngLevelResultReportFile", mngLevelResultReportFile);
		
		model.addObject("instt_cl_cd",   zvl.getValue("instt_cl_cd"));
		model.addObject("s_instt_cl_nm", zvl.getValue("s_instt_cl_nm"));
		model.addObject("s_instt_cd", 	 zvl.getValue("s_instt_cd"));
		model.addObject("s_instt_nm",	 zvl.getValue("s_instt_nm"));
		
		model.addObject("requestZvl", zvl);
		
		model.addObject("pageName", "실적등록 및 조회");		
		
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
	 * 관리수준 지표 재등록 요청
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelRes/updateMngLevelResReAdd.do")
	public ModelAndView updateMngLevelResReAdd(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();

		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));
		zvl.put("status" , "RS04");
		zvl.put("updtId" , userInfo.getUserId());
		zvl.put("mngLevelIdxSeq" , zvl.getValue("indexSeq"));
		zvl.put("requstCn"       , zvl.getValue("requstCn"));
		zvl.put("requstDe"       , EgovDateUtil.getToday());
		
		try{
			mngLevelResService.updateMngLevelResStat(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.update"));
		}catch(Exception e){
			model.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 관리수준 지표 리스트 화면
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelRes/mngLevelModifyList.do")
	public ModelAndView mngLevelIndexList(HttpServletRequest request, HttpServletResponse response) throws Exception { 

		ModelAndView model = new ModelAndView();
		model.setViewName( "mngLevelRes/mngLevelModifyList" );
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));

		zvl.put("insttCd", userInfo.getInsttCd());
		List<ZValue> resultList = mngLevelResService.selectMngLevelIndexList(zvl);
		
		model.addObject("resultList", resultList);
		
		zvl.put("mngLevelIdxSeq", "0");
		ZValue rowzvl = mngLevelResService.selectMngLevelReqst(zvl);
		model.addObject("result", rowzvl);

		List<ZValue> fileList = mngLevelResService.mngLevelInsttFileList(zvl);
		model.addObject("fileList", fileList);
		
		ZValue limitFileSize = mngLevelResService.getLimitFileSize(zvl);
		model.addObject("limitFileSize", limitFileSize);
		
		model.addObject("s_instt_cd", userInfo.getInsttCd());
		model.addObject("s_instt_nm", userInfo.getInsttNm());
		
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
		
		model.addObject("pageName", "실적등록 및 조회");		
		
		return model;
	}

	/**
	 * 관리수준 지표 등록 예외여부 등록
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelRes/insertMngLevelExcpYn.do")
	public ModelAndView insertMngLevelExcpYn(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));
		
		try{
			mngLevelResService.insertMngLevelExcpYn(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
		}catch(Exception e){
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 관리수준 지표 등록
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelRes/insertMngLevelRes.do")
	public ModelAndView insertMngLevelIndex(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));
		String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
		ArrayList<String> fileList	= new ArrayList<String>();
		
		try{
			mngLevelResService.createMngLevelRes(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			if( "".equals( uploadedFilesInfo ) != true ) {
				JSONParser jsonParser = new JSONParser();
				Object obj = jsonParser.parse( uploadedFilesInfo ); 
		    	logger.debug( "updateMngLevelRes:: obj {{"+ obj +"}}" );
				JSONArray fileInfoArray = ( JSONArray )obj; 
				for( int inx = 0; inx < fileInfoArray.size(); inx++ ) {
					JSONObject jsonObject = (JSONObject)fileInfoArray.get( inx );
					String fileName = ( String )jsonObject.get( "fileName" ); 
					fileList.add( fileName );
				}								
				//zvl.put("parameter",  zvl.toString());
				//zvl.put("parameter",  fileList.toString());
				//zvl.put("conect_cd", "HC10");
				//zvl.put("crud",      "C");
				//UserService.connectHistoryInsert(zvl, request);
			}
		}catch(Exception e){
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 관리수준 지표 수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelRes/updateMngLevelRes.do")
	public ModelAndView updateMngLevelRes(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));
		String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
		ArrayList<String> fileList	= new ArrayList<String>();

		try{
			mngLevelResService.updateMngLevelRes(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.update"));
			if( "".equals( uploadedFilesInfo ) != true ) {
				//로그 이력 저장(HC10 실적파일)
				JSONParser jsonParser = new JSONParser();
				Object obj = jsonParser.parse( uploadedFilesInfo ); 
		    	logger.debug( "updateMngLevelRes:: obj {{"+ obj +"}}" );
				JSONArray fileInfoArray = ( JSONArray )obj; 
				for( int inx = 0; inx < fileInfoArray.size(); inx++ ) {
					JSONObject jsonObject = (JSONObject)fileInfoArray.get( inx );
					String fileName = ( String )jsonObject.get( "fileName" ); 
					fileList.add( fileName );
				}								
				//zvl.put("parameter",  zvl.toString());
				//zvl.put("parameter",  fileList.toString());
				//zvl.put("conect_cd", "HC10");
				//zvl.put("crud",      "C");
				//UserService.connectHistoryInsert(zvl, request);
			}
		}catch(Exception e){
			model.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 관리수준 지표 실적 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelRes/deleteMngLevelRes.do")
	public ModelAndView deleteMngLevelRes(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));
		ArrayList fileId = zvl.getArrayList("fileId[]");
		String modifiedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "modifiedFilesInfo" ) );
		ArrayList<String> fileList	= new ArrayList<String>();

		try{
			mngLevelResService.deleteMngLevelRes(zvl, request);
					
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			if( fileId.size() > 0 ) {
				//로그 이력 저장(HC10 실적파일)
				JSONParser jsonParser = new JSONParser();
				Object obj = jsonParser.parse( modifiedFilesInfo ); 
		    	logger.debug( "updateMngLevelRes:: obj {{"+ obj +"}}" );
				JSONArray fileInfoArray = ( JSONArray )obj; 
				for( int inx = 0; inx < fileInfoArray.size(); inx++ ) {
					JSONObject jsonObject = (JSONObject)fileInfoArray.get( inx );
					String fileName = ( String )jsonObject.get( "fileName" ); 
					fileList.add( fileName );
				}								
				//zvl.put("parameter",  zvl.toString());
				//zvl.put("parameter",  fileList.toString());
				//zvl.put("conect_cd", "HC10");
				//zvl.put("crud",      "D");
				//UserService.connectHistoryInsert(zvl, request);
			}
		}catch(Exception e){
					
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	/**
	 * 관리수준 지표 실적 등록 완료 확인
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelRes/checkEndMngLevelRes.do")
	public ModelAndView checkEndMngLevelRes(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		int result = 0;
		int resultRs04 = 0;
		List<ZValue> resultStat = null;
		
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));

		result = mngLevelResService.selectMngLevelReqstCnt(zvl);
		resultStat = mngLevelResService.selectCntMngLevelReqstStatus(zvl);
		
		model.setViewName( "jsonView" );
		model.addObject("result", result);
		for(int i=0; i < resultStat.size(); i++) {
			ZValue dtlZvl = new ZValue();
			dtlZvl = resultStat.get(i);
			if("RS04".equals(dtlZvl.getValue("status"))) {
				resultRs04 = dtlZvl.getInt("cnt");
			};
		}
		model.addObject("resultRs04", resultRs04);

		result = mngLevelResService.selectMngLevelIdxCnt(zvl);
		model.addObject("resultIdx", result);

		result = mngLevelResService.selectBsisSttusCnt(zvl);
		model.addObject("bsisCnt", result);
	
		return model;
	}

	/**
	 * 관리수준 지표 수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/mngLevelRes/updateMngLevelResStat.do")
	public ModelAndView updateMngLevelResStat(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();

		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));
		zvl.put("status" , "RS03");
		zvl.put("updtId" , userInfo.getUserId());
		zvl.put("preStatus", "RS04" );
		
		try{
			mngLevelResService.updateMngLevelResStat(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.update"));
		}catch(Exception e){
			model.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 관리수준 등록결과 - 실적등록(재등록 요청사유)  
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/mngLevelRes/reponsePopup.do")
	public ModelAndView reponsePopup(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		ZValue orderVal = cmnService.retrieveCurrentOrderNo();		
		zvl.put("orderNo", orderVal.getValue("orderNo"));
		
		try{
			result = mngLevelResService.selectMngLevelRergistResnAjax(zvl);
			model.addAttribute("requestZvl", zvl);
			model.addAttribute("result", result);
			modelAndView.setViewName( "mngLevelRes/popup/responsePopup" );
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 관리수준 등록결과 - 실적등록(재등록 요청사유)  
	 * @param request
	 * @param response
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/mngLevelRes/requestPopup.do")
	public ModelAndView requestPopup(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			model.addAttribute("requestZvl", zvl);
			modelAndView.setViewName( "mngLevelRes/popup/requestPopup" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}	

	/**
	 * 실적등록 파일첨부 시 변경사항 메모
	 * @param request
	 * @param response
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/mngLevelRes/fileMemoPopup.do")
	public ModelAndView fileMemoPopup(
								HttpServletRequest request, 
								HttpServletResponse response,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			model.addAttribute("requestZvl", zvl);
			modelAndView.setViewName( "mngLevelRes/popup/fileMemoPopup" );
			
		}catch(Exception e){
			logger.error( "####error : " + e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}		

}
