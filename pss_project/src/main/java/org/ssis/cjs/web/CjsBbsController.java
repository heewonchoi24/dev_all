package org.ssis.cjs.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.cjs.service.CjsBbsService;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;

//import com.mysql.jdbc.StringUtils;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class CjsBbsController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private CjsBbsService cjsBbsService;
	
	@Autowired
	private CmnService PssCommonService;
	
	/**
	 * 관제 공지사항
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/bbsList.do")
	public ModelAndView bbsList(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId())) {
			modelAndView.addObject("writeYn", "Y");
			modelAndView.addObject("adminMenu", "Y");
		} else {
			modelAndView.addObject("writeYn", "N");
		}
		
		modelAndView.addObject("menuDeths", "1");
		modelAndView.addObject("menuDethsValue", "B");
		
		List<ZValue> resultList = null;
		int bbsTotalCnt = 0; 
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
			
		resultList = cjsBbsService.bbsList(zvl);
		modelAndView.addObject("bbsList", resultList);
		
		resultList = cjsBbsService.bbsAttachFileList(zvl);
		modelAndView.addObject("bbsAttachFileList", resultList);
		
		bbsTotalCnt = cjsBbsService.bbsListCnt(zvl);
		totalPageCnt = (int) Math.ceil((double)bbsTotalCnt/(double)10);
		
		modelAndView.addObject("bbsTotalCnt", bbsTotalCnt);
		modelAndView.addObject("totalPageCnt", totalPageCnt);
		
		paginationInfo.setTotalRecordCount(bbsTotalCnt);
		
		modelAndView.addAllObjects(zvl);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName( "cjs/bbsList" );
		
		/* 페이지 정보 */
		modelAndView.addObject("pageNum",  "10");
		modelAndView.addObject("subNum",   "0");
		modelAndView.addObject("threeNum", "0");
		modelAndView.addObject("dep1Name", "관제 알림마당");
		modelAndView.addObject("dep2Name", "관제 알림마당");
		modelAndView.addObject("dep3Name", "");
		modelAndView.addObject("dep4Name", "");
		modelAndView.addObject("pageName", "관제 알림마당");			
			
		return modelAndView;
	}
	
	/**
	 * 게시판 글쓰기 페이지
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/bbsWrite.do")
	public ModelAndView bbsWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId())) {
			modelAndView.addObject("writeYn", "Y");
			modelAndView.addObject("adminMenu", "Y");
		} else {
			modelAndView.addObject("writeYn", "N");
		}
		
		modelAndView.addObject("menuDeths", "1");
		modelAndView.addObject("menuDethsValue", "B");
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		List<ZValue> resultList = null;
		String seq = zvl.getString("seq");
			
		if(seq != null && !seq.isEmpty()){
			result = cjsBbsService.bbsView(zvl);
			modelAndView.addObject("bbsView", result);
			
			resultList = cjsBbsService.bbsAttachFileList(zvl);
			modelAndView.addObject("bbsAttachFileList", resultList);
		}
		
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "cjs/bbsWrite" );
		
		/* 페이지 정보 */
		modelAndView.addObject("pageNum",  "10");
		modelAndView.addObject("subNum",   "0");
		modelAndView.addObject("threeNum", "0");
		modelAndView.addObject("dep1Name", "관제 알림마당");
		modelAndView.addObject("dep2Name", "관제 알림마당");
		modelAndView.addObject("dep3Name", "");
		modelAndView.addObject("dep4Name", "");
		modelAndView.addObject("pageName", "관제 알림마당");				
		
		return modelAndView;
	}
	
	/**
	 * 게시판 글쓰기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/bbsRegistThread.do")
	public ModelAndView bbsWriteThread(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		/* 웹 취약점 점검 XSS 크로스사이트 스크립팅 조치 
		 *  꺽쇠부호 치환 (2019-10-30) 							*/
		zvl.put("subject", zvl.get("subject").toString()
				.replace("<", "&amp;lt").replace(">", "&amp;gt").replace("\"", "&amp;quot"));
		zvl.put("contents", zvl.get("contents").toString()
				.replace("<", "&amp;lt").replace(">", "&amp;gt").replace("\"", "&amp;quot"));
		/* 허용태그 설정 */
		zvl.put("subject", zvl.get("subject").toString()
				.replace("&amp;ltp&amp;gt", "<p>").replace("&amp;lt/p&amp;gt", "</p>").replace("&amp;quot", "\""));
		zvl.put("contents", zvl.get("contents").toString()
				.replace("&amp;ltp&amp;gt", "<p>").replace("&amp;lt/p&amp;gt", "</p>")
				.replace("&amp;ltbr&amp;gt", "<br>").replace("&amp;quot", "\""));
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			cjsBbsService.bbsThreadInsert(zvl, request);
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			modelAndView.addAllObjects(zvl);
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	/**
	 * 게시판 상세보기
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/bbsView.do")
	public ModelAndView bbsView(
						HttpServletRequest request,
						HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId())) {
			modelAndView.addObject("writeYn", "Y");
			modelAndView.addObject("adminMenu", "Y");
		} else {
			modelAndView.addObject("writeYn", "N");
		}
		
		modelAndView.addObject("menuDeths", "1");
		modelAndView.addObject("menuDethsValue", "B");
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		List<ZValue> resultList = null;
		
		Cookie cookies[] = request.getCookies();
		Map map = new HashMap();
		if(request.getCookies() != null){
			for(int i=0;i<cookies.length;i++){
				Cookie obj = cookies[i];
				map.put(obj.getName(), obj.getValue());
			}
		}
		
		String readCount = (String) map.get("read_count_cjs"+zvl.getValue("seq"));
		
		if(StringUtils.isEmpty(readCount)){
			Cookie cookie = new Cookie("read_count_cjs"+zvl.getValue("seq"), readCount + zvl.getValue("seq"));
			response.addCookie(cookie);
			cjsBbsService.bbsCountUpdate(zvl);
		}
		
		if(!zvl.containsKey("pageIndex")) 
    		zvl.put("pageIndex", 1);
		
		result = cjsBbsService.bbsView(zvl);
		modelAndView.addObject("bbsView", result);
		
		resultList = cjsBbsService.bbsAttachFileList(zvl);
		modelAndView.addObject("bbsAttachFileList", resultList);
		
		modelAndView.addAllObjects(zvl);
		modelAndView.setViewName( "cjs/bbsView" );
		
		return modelAndView;
	}
	
	/**
	 * 게시판 파일 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/cjs/bbsFileDelete.do")
	public ModelAndView bbsFileDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			cjsBbsService.bbsFileDelete(zvl, request);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			modelAndView.addAllObjects(zvl);
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error( e );
			e.printStackTrace();
		}
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
	
	/**
	 * 게시판 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/cjs/bbsDelete.do")
	public ModelAndView bbsDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			cjsBbsService.bbsDelete(zvl, request);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			modelAndView.addAllObjects(zvl);
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error( e );
			e.printStackTrace();
		}
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;	
	}
	
	/**
	 * 관제담당자 정보 엑셀 다운로드
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/cjs/cjsUserExcelDown.do")
	public String mIndexExcelDownload(
			Map<String, Object> ModelMap,
			HttpServletRequest request,
			HttpServletResponse response
			) throws Exception {
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		zvl.put("excelFlag", "E");
		
		List<ZValue> resultList = cjsBbsService.userList(zvl);
		
		List<ZValue> chrgDutyList = PssCommonService.retrieveChrgDutyList(zvl);
    	
		ModelMap.put("chrgDutyList", chrgDutyList);
		ModelMap.put("resultList", resultList);
		ModelMap.put("downName", "userExcelDown");
		
		return "excelDownload";
	}
}