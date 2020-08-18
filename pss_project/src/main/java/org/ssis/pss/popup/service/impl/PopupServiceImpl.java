package org.ssis.pss.popup.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.popup.dao.PopupDao;
import org.ssis.pss.popup.service.PopupService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class PopupServiceImpl implements PopupService {
	
	@Autowired 
	private PopupDao popupDao; 	
	
	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;		

	@Override
	public List<ZValue> popupList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "popup.popupList");
		return popupDao.popCommonList(zvl);
	}

	@Override
	public void popupRegistThread(ZValue zvl, MultipartHttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		String menu_id = "";
		
		zvl.put("user_id", userInfo.getUserId());
		
		try {
			String log = EgovStringUtil.nullConvert(zvl.getString("log"));
			int cnt = popupDao.selectCnt("popup.popupThreadCnt", zvl);
			
			if(cnt > 0) {
				zvl.put("sqlid", "popup.popupThreadUpdate");
				popupDao.popupCommonUpdate(zvl);
				
				if(log.equals("true")){
					// 로그 이력 저장
					zvl.put("url", 		  "/admin/contact/popupList.do");					
					menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
					zvl.put("parameter",  zvl.toString());
					zvl.put("crud",       LogCrud.UPDATE);
					zvl.put("menu_id",    menu_id);
					zvl.put("session_id", request.getRequestedSessionId());
					UserService.connectHistoryInsert(zvl, request);		
				}				
			} else {
				zvl.put("sqlid", "popup.popupThreadInsert");
				popupDao.popupCommonInsert(zvl);
				
				if(log.equals("true")){
					// 로그 이력 저장
					zvl.put("url", 		  "/admin/contact/popupList.do");					
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
