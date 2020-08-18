package org.ssis.pss.connect.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.util.LogCrud;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
public class ConnectController {

	private static final int String = 0;

	protected Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private EgovMessageSource egovMessageSource;

	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;		

	/**
	 * 계정관리 - 접속이력 조회
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/account/connectList.do")
	public ModelAndView connectList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
    	
	/*	HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		zvl.put("user_id", userInfo.getUserId());*/

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
		
		try{
			resultList = connectService.connectHistDataAdminList(zvl);
			resultListCnt = connectService.connectHistDataAdminCnt(zvl);
			
			paginationInfo.setTotalRecordCount(resultListCnt);
			
			modelAndView.addObject("resultList", resultList);
			modelAndView.addObject("resultListCnt", resultListCnt);
			modelAndView.addObject("paginationInfo", paginationInfo);

		}catch(Exception e){
			logger.error(e);
		}    	
		
		modelAndView.addObject("sdtp", zvl.getString("sdtp"));
		modelAndView.addObject("edtp", zvl.getString("edtp"));
		
		modelAndView.addObject("pageLevel1", "account");
		modelAndView.addObject("pageLevel2", "6");
		modelAndView.addObject("pageName", "접속이력");	
		modelAndView.setViewName( "account/connectList" );
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/account/connectList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);			
		
		return modelAndView;

	}
	
	/**
	 * 계정관리 - 접속이력 상세 조회
	 * @param request
	 * @param response
	 * @param model
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/account/connectViewThread.do", method=RequestMethod.GET)
	public ModelAndView connectViewThread(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> connectViewList = null;
		
		zvl.put("seq", request.getParameter("seq"));
		connectViewList = connectService.connectViewThread(zvl, request);
		modelAndView.addObject("connectViewList", connectViewList);
		modelAndView.setViewName( "account/connectView" );

		return modelAndView;
		
	}

}
