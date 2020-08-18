package egovframework.com.cmm.interceptor;

import java.lang.reflect.Field;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;

import egovframework.com.cmm.SessionVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;

public class AuthenticInterceptor extends HandlerInterceptorAdapter {
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private CmnService CmnService;
	
	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		// URL 직접 입력시 로그인 페이지로 이동
		String referer = request.getHeader("REFERER");
		
		if (referer == null || "".equals(referer)) {
			response.sendRedirect("/login/login.do");
			return false;
		}
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		// 세션 종료
		if(null == userInfo) {
			response.sendRedirect("/login/invaliSession.do");
			return false;
		}
		
		if(null != request.getParameter("sUrl")){
			ZValue zvl = new ZValue();
			zvl.put("url", request.getParameter("sUrl"));
			zvl = CmnService.getMenuId(zvl);
			
			ZValue zvl1 = WebFactoryUtil.getAttributesInit(request);
			logger.debug("###################### preHandle zvl1 ######################");
			logger.debug(zvl1);
			logger.debug("###################### preHandle zvl1 ######################");
			
			if(zvl!=null) session.setAttribute("cMenuId", zvl.getValue("menuId"));
			else session.setAttribute("cMenuId",  EgovStringUtil.nullConvert(  zvl1.getValue("sMenuId") ));
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		
		//ajax 처리 시에는 권한 별 메뉴 조회 생략
		if(null != modelAndView && !"jsonView".equals(modelAndView.getViewName()) && modelAndView.getViewName().indexOf("cjs/") != 0){
			
			HttpSession session = request.getSession();
			SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
			List<ZValue> resultList = null;

			logger.debug("###################### postHandle userInfo ######################");
			Object obj = userInfo;
			for(Field field : obj.getClass().getDeclaredFields()){
				field.setAccessible(true);
				Object value = field.get(obj);
				logger.debug(field.getName() + " : " + value);
			}
			logger.debug("###################### postHandle userInfo ######################");
			
			logger.debug("###################### cMenuId ######################");
			logger.debug("current menu no : " + session.getAttribute("cMenuId"));
			logger.debug("###################### cMenuId ######################");
			
			resultList = CmnService.retrieveMenuList(userInfo.getAuthorId());
			modelAndView.addObject("menuList", resultList);
			
			String periodCd = CmnService.retrieveEvlPeriodCode();
			modelAndView.addObject("headerPeriodCd", periodCd);
			
			if(modelAndView.getViewName().equals("main/main")){
				modelAndView.addObject("cMenuId", "0");
			}else{
				modelAndView.addObject("cMenuId", session.getAttribute("cMenuId"));
			}
		}
	}
}
