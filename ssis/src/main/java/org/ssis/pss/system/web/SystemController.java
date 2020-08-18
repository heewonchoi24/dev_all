package org.ssis.pss.system.web;

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
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.pinn.service.PinnService;
import org.ssis.pss.system.service.SystemService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class SystemController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private SystemService systemService;
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private CmnService cmnService;
	
	@Autowired
	private PinnService pinnService;
	
	@Autowired
	private ConnectService connectService;		
	
	@Autowired
	private UserService UserService;
	
	/**
	 * 기관별 파일 용량관리
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/system/fileSizeList.do")
	public ModelAndView fileSizeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView model = new ModelAndView();
		model.setViewName( "/system/fileSizeList");
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
		ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
		if(StringUtils.isEmpty(zvl.getValue("searchOrderNo"))) {
			zvl.put("searchOrderNo", currentOrderNo.getValue("orderNo"));
		}
		zvl.put("orderNo", zvl.getValue("searchOrderNo"));
		
		int totalCnt = 0; 
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
		
		totalCnt = systemService.selectFileSizeListCnt(zvl);
		totalPageCnt = (int) Math.ceil((double)totalCnt/(double)10);
		paginationInfo.setTotalRecordCount(totalCnt);
		
		model.addObject("totalCnt", totalCnt);
		model.addObject("totalPageCnt", totalPageCnt);
		
		List<ZValue> resultList = systemService.selectFileSizeList(zvl);
		
		// 기관구분 select box
		List<ZValue> orgBoxClList = pinnService.selectInsttClSelectBoxList(zvl);

		// 기관구분 select box
		List<ZValue> orgBoxList = pinnService.selectInsttSelectBoxList(zvl);
		
		model.addObject("requestZvl", zvl);
		model.addObject("orderList", orderList);
		model.addObject("resultList", resultList);
		model.addObject("orgBoxClList", orgBoxClList);
		model.addObject("orgBoxList", orgBoxList);
		model.addObject("paginationInfo", paginationInfo);
		
		// 화면 Sidebar 정보
		model.addObject("pageLevel1", "account");
		model.addObject("pageLevel2", "8");
		model.addObject("pageName", "파일용량관리");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/system/fileSizeList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);			
		
		return model;	
	}
	
	/**
	 * 기관별 파일 용량관리 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/system/modifyFileSize.do")
	public ModelAndView modifyFileSize(HttpServletRequest request) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try {
			systemService.modifyFileSize(zvl, request);
			if("I".equals(zvl.getValue("modeFlag"))) {
				modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/system/fileSizeList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);			
				
			} else {
				modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/system/fileSizeList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.UPDATE);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);			
				
			}
			
		}catch(Exception e){
			if("I".equals(zvl.getValue("modeFlag"))) {
				modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			} else {
				modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			}
			logger.error( e );
			e.printStackTrace();
		}
		
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	/**
	 * 기관별 파일 용량관리 전체 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/system/modifyAllFileSize.do")
	public ModelAndView modifyAllFileSize(HttpServletRequest request) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try {
			systemService.modifyAllFileSize(zvl, request);
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/system/fileSizeList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.UPDATE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);		
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error( e );
			e.printStackTrace();
			
		}
		
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
}