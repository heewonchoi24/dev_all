package org.ssis.pss.sort.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.sort.service.SortService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.util.LogCrud;


@Controller
public class SortController {

	protected Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private EgovMessageSource egovMessageSource;

	@Autowired
	private SortService sortService;
	
	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;		
	
	/**
	 *  컨텐츠 관리 - 메인 컨텐츠 순서 목록 조회
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/contact/mainContentsSortList.do")
	public ModelAndView mainContentsSortList(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;

		resultList = sortService.sortList(zvl);
		modelAndView.addObject("resultList", resultList);
		
		modelAndView.addObject("pageLevel1", "contact");
		modelAndView.addObject("pageLevel2", "2");
		modelAndView.addObject("pageName", "메인 비주얼 관리");
		modelAndView.setViewName( "contact/mainContentsSortList" );

		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/contact/mainContentsSortList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);	
		
		return modelAndView;

	}

	/**
	 * 컨텐츠 관리 - 메인 컨텐츠 순서 전체 삭제 후 등록
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/admin/contact/mainContentsSortRegistThread.do")
	public ModelAndView mainContentsSortRegistThread(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			sortService.sortRegistThread(zvl, request);

			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}			

		return modelAndView;
	}
}
