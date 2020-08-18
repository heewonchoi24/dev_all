package org.ssis.pss.quickMenu.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.quickMenu.dao.QuickMenuDao;
import org.ssis.pss.quickMenu.service.QuickMenuService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class QuickMenuServiceImpl implements QuickMenuService {

	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired 
	private QuickMenuDao quickMenuDao; 	
	
	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;		
	
	@Override
	public List<ZValue> quickMenuList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "qm.quickMenuList");
		return quickMenuDao.quickMenuCommonList(zvl);
	}	

	@Override
	public void quickMenuRegistThread(ZValue zvl, HttpServletRequest request) {

		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		String menu_id = "";
		
		zvl.put("user_id", userInfo.getUserId());
		int cnt;

		try {
			String log = EgovStringUtil.nullConvert(zvl.getString("log"));
			zvl.put("sqlid", "qm.quickMenuThreadSeqCnt");
			cnt = quickMenuDao.quickMenuThreadSeqCnt(zvl);
			
			if(cnt > 0) {
				zvl.put("sqlid", "qm.quickMenuThreadUpdate");
				quickMenuDao.quickMenuCommonUpdate(zvl);
				
				if(log.equals("true")){
					// 로그 이력 저장
					zvl.put("url", 		  "/admin/contact/quickMenuList.do");					
					menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
					zvl.put("parameter",  zvl.toString());
					zvl.put("crud",       LogCrud.UPDATE);
					zvl.put("menu_id",    menu_id);
					zvl.put("session_id", request.getRequestedSessionId());
					UserService.connectHistoryInsert(zvl, request);		
				}				
						
			} else {
				zvl.put("sqlid", "qm.quickMenuThreadInsert");
				quickMenuDao.quickMenuCommonInsert(zvl);
				
				if(log.equals("true")){
					// 로그 이력 저장
					zvl.put("url", 		  "/admin/contact/quickMenuList.do");					
					menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
					zvl.put("parameter",  zvl.toString());
					zvl.put("crud",       LogCrud.INSERT);
					zvl.put("menu_id",    menu_id);
					zvl.put("session_id", request.getRequestedSessionId());
					UserService.connectHistoryInsert(zvl, request);		
				}		
			}		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}