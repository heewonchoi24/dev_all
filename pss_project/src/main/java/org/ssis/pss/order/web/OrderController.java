package org.ssis.pss.order.web;

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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.order.service.OrderService;
import org.ssis.pss.user.service.UserService;
import org.ssis.pss.util.Globals;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class OrderController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private EgovMessageSource egovMessageSource;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CmnService cmnService;
	
	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;		

	
	/**
	 *  차수 리스트
	 * @param requesta
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/order/orderList.do")
    public String orderList(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
    	
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());

    	//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	zvl.put("pageSize", 10);
    	
    	//페이징 설정 참고용
        /** 현재페이지 */
        int pageIndex = 1;
        /** 페이지갯수 */
        int pageUnit = 10;
        /** 페이지사이즈 */
        int pageSize = 10;
        /** 첫페이지 인덱스 */
        int firstIndex = 1;
        /** 마지막페이지 인덱스 */
        int lastIndex = 1;
        /** 페이지당 레코드 개수 */
        int recordCountPerPage = 10;
    	
		List<ZValue> resultList = null;
		int resultListCnt = 0;
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));

		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			resultList = orderService.orderListThread(zvl);
			resultListCnt = orderService.orderCntThread(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		paginationInfo.setTotalRecordCount(resultListCnt);
		
		model.addAllAttributes(zvl);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListCnt", resultListCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("requestZvl", zvl);
		
		// 화면 Sidebar 정보
		model.addAttribute("pageLevel1", "diagnosis");
		model.addAttribute("pageLevel2", "1");
		model.addAttribute("pageName", "차수 관리");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/order/orderList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);				
		
		return "order/orderList";
    }

	/**
	 *  차수 등록/수정 페이지
	 * @param requesta
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/order/orderWrite.do")
    public String orderWrite(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
    	
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());

		ZValue result = null;

		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			result = orderService.selectOrderThread(zvl);
		}catch(Exception e){
			logger.error(e);
		}
		
		model.addAllAttributes(zvl);
		model.addAttribute("orderList", orderList);
		model.addAttribute("resultList", result);
		model.addAttribute("requestZvl", zvl);
		
		// 화면 Sidebar 정보
		model.addAttribute("pageLevel1", "diagnosis");
		model.addAttribute("pageLevel2", "1");
		model.addAttribute("pageName", "차수 관리");
		
		return "order/orderWrite";
    }

	/**
	 * 차수 등록/수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/order/orderModify.do")
	public ModelAndView insertorder(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		String gubun = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) );  
		
    	logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
		
		try{
			if("I".equals(gubun)) {
				orderService.insertOrderList(zvl, request);
				model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/order/orderList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);	
				
			} else {
				orderService.updateOrderList(zvl, request);
				model.addObject("message", egovMessageSource.getMessage("success.common.update"));
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/order/orderList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.UPDATE);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);					
			}			
		}catch(Exception e){			
			model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 차수 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/order/deleteOrder.do")
	public ModelAndView deleteorder(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			orderService.deleteOrderList(zvl, request);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 *  연간일정 리스트
	 * @param requesta
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/order/fyerSchdulList.do")
    public ModelAndView fyerSchdulList(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
		ModelAndView model = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
    	
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
    	
		List<ZValue> orderList = cmnService.retrieveOrderNoList();
		
		// 선택된 차수가 없는경우 현재 차수
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
			zvl.put("yyyy", currentOrderNo.getValue("orderNo"));
		} else {
			zvl.put("yyyy", zvl.getValue("orderNo"));
		}
		
		// 선택된 관리수준 구분이 없는경우 관리수준진단(ML01)
		if(StringUtils.isEmpty(zvl.getValue("mngLevelCd")) || Globals.MNG_LEVEL_CD.equals(zvl.getValue("mngLevelCd"))) {
			zvl.put("mngLevelCd", Globals.MNG_LEVEL_CD);
			model.setViewName( "order/fyerSchdulList01" );
		}  else if(Globals.STATUS_EXAMIN_CD.equals(zvl.getValue("mngLevelCd"))) {
			model.setViewName( "order/fyerSchdulList02" );
		}  else {
			model.setViewName( "order/fyerSchdulList03" );
		}

		List<ZValue> resultList = orderService.selectFyerSchdulList(zvl);
		
		model.addObject("requestZvl", zvl);
		model.addObject("orderList", orderList);
		model.addObject("resultList", resultList);
		
		// 화면 Sidebar 정보
		model.addObject("pageLevel1", "diagnosis");
		model.addObject("pageLevel2", "2");
		model.addObject("pageName", "일정 관리");		
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/order/fyerSchdulList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);			
		
		return model;
    }
	
	/**
	 * 일정 등록 / 수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/order/modifyFyerSchdul.do")
	public ModelAndView modifyFyerSchdul(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		String save = zvl.getValue("fyerSchdulSeq");
		
		String menu_id = "";
		
		try{
			orderService.modifyFyerSchdul(zvl, request);
			if(StringUtils.isEmpty(save)){
				model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			
				// 로그 이력 저장
				zvl.put("url", 		  "/admin/order/fyerSchdulList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);	
			
			}else {
				model.addObject("message", egovMessageSource.getMessage("success.common.update"));
			
				// 로그 이력 저장
				zvl.put("url", 		  "/admin/order/fyerSchdulList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.UPDATE);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);	
				
			}
			
		}catch(Exception e){
			if(StringUtils.isEmpty(save))
				model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			else
				model.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 일정 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/order/deleteFyerSchdul.do")
	public ModelAndView deleteFyerSchdul(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
				
		try{
			orderService.deleteFyerSchdul(zvl, request);
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/order/fyerSchdulList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.DELETE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);	
			
		}catch(Exception e){
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
			
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 연간일정 상세
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/admin/order/fyerSchdul.do")
	public ModelAndView selectBoxInsttList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "jsonView" );
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		List<ZValue> resultList = orderService.selectFyerSchdulList(zvl);

		modelAndView.addObject("mngLevelCd", zvl.getValue( "mngLevelCd" ));
		modelAndView.addObject("resultList", resultList);
		modelAndView.addObject("pageLevel1", "diagnosis");
		modelAndView.addObject("pageLevel2", "2");
		modelAndView.addObject("pageName", "일정 관리");
		modelAndView.setViewName( "order/fyerSchdulListView" );
		
		return modelAndView;	
	}
}
