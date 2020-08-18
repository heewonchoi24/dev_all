package org.ssis.pss.index.web;

import java.io.File;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.index.service.IndexService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.LogCrud;

@Controller
public class IndexController {

	protected Log log = LogFactory.getLog(this.getClass());

	protected Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private EgovMessageSource egovMessageSource;

	@Autowired
	private IndexService indexService;

	@Autowired
	private CmnService cmnService;

	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;	
	
	/**
	 * 관리수준 지표 리스트 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/mngLevelIndexList.do") 
	public ModelAndView mngLevelIndexList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();
		model.setViewName("index/mngLevelIndexList");

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		List<ZValue> orderList = cmnService.retrieveOrderNoList();

		if (StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
			zvl.put("orderNo", currentOrderNo.getValue("orderNo"));
		}
		zvl.put("mngLevelCd", "ML01");

		List<ZValue> checkList = indexService.selectCheckItemScoreSeList(zvl);
		if (null == checkList || 0 == checkList.size()) { // checkList가 없을때
			model.addObject("resultCheck", "Y");
		} else {
			ZValue checkZvl = checkList.get(0);
			model.addObject("resultCheck", checkZvl.getValue("scoreSe"));
		}

		List<ZValue> resultList = indexService.selectMngLevelIndexList(zvl);
		
		// 관리수준 진단 등록 카운트
		String modifyFlag = "Y";
		String addFlag = "Y";
		
		/*if(0 < indexService.selectMngLevelReqstCnt(zvl)) modifyFlag = "N";*/
		/*if (0 < indexService.selectMngLevelReqstCnt(zvl) || !zvl.getValue("orderNo").equals(String.valueOf(Calendar.getInstance().get(Calendar.YEAR)))) modifyFlag = "N";*/
		/*if (!zvl.getValue("orderNo").equals(String.valueOf(Calendar.getInstance().get(Calendar.YEAR)))) modifyFlag = "N";*/
		if (Integer.parseInt(zvl.getValue("orderNo")) < Calendar.getInstance().get(Calendar.YEAR)) modifyFlag = "N";
		if(0 < indexService.selectMngLevelReqstCnt(zvl)) addFlag = "N";
		
		model.addObject("modifyFlag", modifyFlag);	 
		model.addObject("addFlag", addFlag);

		model.addObject("requestZvl", zvl);
		model.addObject("orderList", orderList);
		model.addObject("resultList", resultList);
		
		//화면Sidebar정보
		model.addObject("pageLevel1", "diagnosis");
		model.addObject("pageLevel2", "3");
		model.addObject("pageName", "관리수준 지표관리");

		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/index/mngLevelIndexList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);	

		return model;
	}

	/**
	 * 기본정보 등록 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/createDefaultIndex.do")
	public ModelAndView createDefaultIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();
		model.setViewName("index/createDefaultIndex");

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		List<ZValue> sctnScoreList = indexService.selectCheckItemSctnScoreList(zvl);

		List<ZValue> scoreList = indexService.selectCheckItemScoreSeList(zvl);

		if (null != scoreList && 0 == scoreList.size()) {
			model.addObject("resultCheck", "Y");
		} else {
			ZValue checkZvl = scoreList.get(0);
			model.addObject("resultCheck", checkZvl.getValue("scoreSe"));
		}
		
		// 관리수준 진단, 관리수준 현황조사 등록 카운트
		String modifyFlag = "Y";
		/*if(Globals.MNG_LEVEL_CD.equals(zvl.getValue(""))) {
			if(0 < indexService.selectMngLevelReqstCnt(zvl))
				modifyFlag = "N";
		} else {
			if(0 < indexService.selectStatusExaminEvalCnt(zvl))
				modifyFlag = "N";
		}*/
		
		String flag = (String) request.getParameter("mngLevelCd");
		model.addObject("pageLevel1", "diagnosis");
		
		if (flag.equals("ML01")){ // 지표에대해 등록한 기관이 있으면 modifyFlag = 'N'
			if(0 < indexService.selectMngLevelReqstCnt(zvl)) modifyFlag = "N";
			model.addObject("pageLevel2", "3");
			model.addObject("pageName", "관리수준 지표관리");
		}else if(flag.equals("ML02")){
			if(0 < indexService.selectStatusExaminEvalCnt(zvl)) modifyFlag = "N";
			model.addObject("pageLevel2", "4");
			model.addObject("pageName", "현황조사 지표관리");
		}
		
		model.addObject("modifyFlag", modifyFlag);	 

		model.addObject("sctnScoreList", sctnScoreList);
		model.addObject("scoreList", scoreList);
		model.addObject("zvl", zvl);
		
		return model;
	}

	/**
	 * 기본정보 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/deleteDefaultIndex.do")
	public ModelAndView deleteDefaultIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		try {
			indexService.deleteCheckItemScore(zvl, request);

			model.addObject("message",
					egovMessageSource.getMessage("success.common.delete"));
		} catch (Exception e) {

			model.addObject("message",
					egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
		}

		model.setViewName("jsonView");

		return model;
	}

	/**
	 * 기본정보 수정
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/modifyDefaultIndex.do")
	public ModelAndView modifyDefaultIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		try {
			indexService.updateCheckItemScore(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.update"));
			
		} catch (Exception e) {
			model.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
		}

		model.setViewName("jsonView");

		return model;
	}

	/**
	 * 관리수준 지표 등록 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/createMngLevelIndex.do")
	public ModelAndView createMngLevelIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		ModelAndView model = new ModelAndView();
		model.setViewName("index/createMngLevelIndex");

		model.addObject("requestZvl", zvl);
		
		model.addObject("pageLevel1", "diagnosis");
		model.addObject("pageLevel2", "3");
		model.addObject("pageName", "관리수준 지표관리");
		
		return model;
	}

	/**
	 * 관리수준 지표 수정 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/modifyMngLevelIndex.do")
	public ModelAndView modifyMngLevelIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();
		model.setViewName("index/modifyMngLevelIndex");

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		List<ZValue> resultList = indexService.selectMngLevelIndexList(zvl);

		model.addObject("requestZvl", zvl);
		model.addObject("resultList", resultList);
		
		model.addObject("pageLevel1", "diagnosis");
		model.addObject("pageLevel2", "3");
		model.addObject("pageName", "관리수준 지표관리");

		return model;
	}

	/**
	 * 관리수준 지표 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/insertMngLevelIndex.do")
	public ModelAndView insertMngLevelIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		try {
			indexService.createMngLevelIndex(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/index/mngLevelIndexList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.INSERT);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);			
			
		} catch (Exception e) {
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
			
		}

		model.setViewName("jsonView");

		return model;
	}

	/**
	 * 관리수준 지표 수정
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/updateMngLevelIndex.do")
	public ModelAndView updateMngLevelIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		try {
			indexService.updateMngLevelIndex(zvl, request);

			model.addObject("message", egovMessageSource.getMessage("success.common.update"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/index/mngLevelIndexList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.UPDATE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);	
			
		} catch (Exception e) {
			model.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
		}

		model.setViewName("jsonView");

		return model;
	}

	/**
	 * 관리수준 지표 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/deleteMngLevelIndex.do")
	public ModelAndView deleteMngLevelIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		try {
			indexService.deleteMngLevelIndex(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/index/mngLevelIndexList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.DELETE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);	
			
		} catch (Exception e) {
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
			
		}

		model.setViewName("jsonView");

		return model;
	}

	/**
	 * 관리수준 현황조사 지표 리스트 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/statusExaminIndexList.do")
	public ModelAndView statusExaminIndexList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();
		model.setViewName("index/statusExaminIndexList");

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		List<ZValue> orderList = cmnService.retrieveOrderNoList();

		if (StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
			zvl.put("orderNo", currentOrderNo.getValue("orderNo"));
		}

		zvl.put("mngLevelCd", "ML02");

		List<ZValue> checkList = indexService.selectCheckItemScoreSeList(zvl);
		if (null != checkList && 0 == checkList.size()) {
			model.addObject("resultCheck", "Y");
		} else {
			ZValue checkZvl = checkList.get(0);
			model.addObject("resultCheck", checkZvl.getValue("scoreSe"));
		}

		List<ZValue> resultList = indexService.selectStatusExaminIndexList(zvl);
		
		// 관리수준 현황조사 등록 카운트
		String modifyFlag = "Y";
		String addFlag = "Y";
		/*if(0 < indexService.selectStatusExaminEvalCnt(zvl)) modifyFlag = "N";*/
		/*if (0 < indexService.selectStatusExaminEvalCnt(zvl) || !zvl.getValue("orderNo").equals(String.valueOf(Calendar.getInstance().get(Calendar.YEAR)))) modifyFlag = "N";*/
		/*if (!zvl.getValue("orderNo").equals(String.valueOf(Calendar.getInstance().get(Calendar.YEAR)))) modifyFlag = "N";*/
		if (Integer.parseInt(zvl.getValue("orderNo")) < Calendar.getInstance().get(Calendar.YEAR)) modifyFlag = "N";
		if(0 < indexService.selectStatusExaminEvalCnt(zvl)) addFlag = "N";
		
		model.addObject("modifyFlag", modifyFlag);
		model.addObject("addFlag", addFlag);
		
		model.addObject("requestZvl", zvl);
		model.addObject("orderList", orderList);
		model.addObject("resultList", resultList);
		
		model.addObject("pageLevel1", "diagnosis");
		model.addObject("pageLevel2", "4");
		model.addObject("pageName", "현황조사 지표관리");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/index/statusExaminIndexList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);				
		
		return model;
	}

	/**
	 * 관리수준 현황조사 지표 등록 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/createStatusExaminIndex.do")
	public ModelAndView createStatusExaminIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();
		model.setViewName("index/createStatusExaminIndex");

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> seqList = indexService.selectMngLevelIndexSeqList(zvl);

		model.addObject("seqList", seqList);
		model.addObject("requestZvl", zvl);

		model.addObject("pageLevel1", "diagnosis");
		model.addObject("pageLevel2", "4");
		model.addObject("pageName", "현황조사 지표관리");
		
		return model;
	}

	/**
	 * 관리수준 현황조사 지표 등록
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/insertStatusExaminIndex.do")
	public ModelAndView insertStatusExaminIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		try {
			indexService.createStatusExaminIndex(zvl, request);
			model.addObject("message",egovMessageSource.getMessage("success.common.insert"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/index/statusExaminIndexList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.INSERT);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);	
			
		} catch (Exception e) {
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
			
		}

		model.setViewName("jsonView");

		return model;
	}

	/**
	 * 관리수준 현황조사 지표 수정 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/modifyStatusExaminIndex.do")
	public ModelAndView modifyStatusExaminIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();
		model.setViewName("index/modifyStatusExaminIndex");

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		List<ZValue> resultList = indexService.selectStatusExaminIndexDtlList(zvl);

		List<ZValue> seqList = indexService.selectMngLevelIndexSeqList(zvl);

		model.addObject("requestZvl", zvl);
		model.addObject("resultList", resultList);
		model.addObject("seqList", seqList);
		
		model.addObject("pageLevel1", "diagnosis");
		model.addObject("pageLevel2", "4");
		model.addObject("pageName", "현황조사 지표관리");
		
		return model;
	}

	/**
	 * 관리수준 현황조사 지표 수정
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/updateStatusExaminIndex.do")
	public ModelAndView updateStatusExaminIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		try {
			indexService.updateStatusExaminIndex(zvl, request);
			model.addObject("message",egovMessageSource.getMessage("success.common.update"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/index/statusExaminIndexList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.UPDATE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);		
			
		} catch (Exception e) {
			model.addObject("message",egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
			
		}

		model.setViewName("jsonView");

		return model;
	}

	/**
	 * 관리수준 현황조사 지표 삭제
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/deleteStatusExaminIndex.do")
	public ModelAndView deleteStatusExaminIndex(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ModelAndView model = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		try {
			indexService.deleteStatusExaminIndex(zvl, request);
			model.addObject("message",egovMessageSource.getMessage("success.common.delete"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/index/statusExaminIndexList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.DELETE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);	
			
		} catch (Exception e) {
			model.addObject("message",egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
			
		}

		model.setViewName("jsonView");

		return model;
	}

	/**
	 * 관리수준 진단 지표 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/admin/index/mIndexExcelDownload.do")
	public String mIndexExcelDownload(Map<String, Object> ModelMap,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		List<ZValue> resultList = indexService.selectMngLevelIndexList(zvl);

		ModelMap.put("resultList", resultList);
		ModelMap.put("downName", "mngLevelIndex");

		return "excelDownload";
	}

	/**
	 * 현황조사 진단 지표 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/admin/index/sIndexExcelDownload.do")
	public String sIndexExcelDownload(Map<String, Object> ModelMap,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		List<ZValue> resultList = indexService.selectStatusExaminIndexDtlList(zvl);

		ModelMap.put("resultList", resultList);
		ModelMap.put("downName", "statusExaminIndex");

		return "excelDownload";
	}

	/**
	 * 관리수준 진단 지표 엑셀 업로드
	 * 
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/mIndexExcelUpload.do", method = RequestMethod.POST)
	public ModelAndView mIndexExcelUpload(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		ModelAndView model = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		String excelUploadPath = EgovProperties
				.getProperty("excel.upload.path");
		MultipartFile excelFile = request.getFile("excelFile");

		File temp = File.createTempFile("temp_excel-", ".xlsx");

		excelFile.transferTo(temp);

		ZValue resultList = null;

		zvl.put("tempExcelFilePath", temp.getAbsolutePath());
		zvl.put("excelUploadPath", excelUploadPath);
		zvl.put("registId", userInfo.getUserId());

		try {
			resultList = indexService.mIndexExcelUpload(zvl);
			model.addObject("message", "등록 되었습니다");
		} catch (Exception e) {
			model.addObject("message", "엑셀 업로드 오류가 발생하였습니다.");
			logger.error(e);
		}

		temp.deleteOnExit();

		model.setViewName("jsonView");

		return model;
	}

	/**
	 * 관리수준 현황조사 지표 엑셀 업로드
	 * 
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/index/sIndexExcelUpload.do", method = RequestMethod.POST)
	public ModelAndView sIndexExcelUpload(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		ModelAndView model = new ModelAndView();

		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		String excelUploadPath = EgovProperties
				.getProperty("excel.upload.path");
		MultipartFile excelFile = request.getFile("excelFile");

		File temp = File.createTempFile("temp_excel-", ".xlsx");

		excelFile.transferTo(temp);

		ZValue resultList = null;

		zvl.put("tempExcelFilePath", temp.getAbsolutePath());
		zvl.put("excelUploadPath", excelUploadPath);
		zvl.put("registId", userInfo.getUserId());

		try {
			resultList = indexService.sIndexExcelUpload(zvl);
			model.addObject("message", "등록 되었습니다");
		} catch (Exception e) {
			model.addObject("message", "엑셀 업로드 오류가 발생하였습니다.");
			logger.error(e);
		}

		temp.deleteOnExit();

		model.setViewName("jsonView");

		return model;
	}
}
