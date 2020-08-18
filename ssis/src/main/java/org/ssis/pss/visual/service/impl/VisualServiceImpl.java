package org.ssis.pss.visual.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.user.service.UserService;
import org.ssis.pss.visual.dao.VisualDao;
import org.ssis.pss.visual.service.VisualService;

import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class VisualServiceImpl implements VisualService {
	
	@Autowired 
	private VisualDao visualDao;
	
	@Autowired
	private UserService UserService;	
	
	@Autowired
	private ConnectService connectService;		

	@Override
	public List<ZValue> visualList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "visual.visualList");
		return visualDao.visualCommonList(zvl);
	}
	
	@Override
	public void visualRegistThread(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		String menu_id = "";

		zvl.put("user_id", userInfo.getUserId());
		
		try {
			String log = EgovStringUtil.nullConvert(zvl.getString("log"));
			int cnt = visualDao.selectCnt("visual.visualThreadCnt", zvl);
			
			if(cnt > 0) {
				zvl.put("sqlid", "visual.visualThreadUpdate");
				visualDao.visualCommonUpdate(zvl);
				
				if(log.equals("true")){
					// 로그 이력 저장
					zvl.put("url", 		  "/admin/contact/mainVisualList.do");					
					menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
					zvl.put("parameter",  zvl.toString());
					zvl.put("crud",       LogCrud.UPDATE);
					zvl.put("menu_id",    menu_id);
					zvl.put("session_id", request.getRequestedSessionId());
					UserService.connectHistoryInsert(zvl, request);		
				}
				
			} else {
				zvl.put("sqlid", "visual.visualThreadInsert");
				visualDao.visualCommonInsert(zvl);
				
				if(log.equals("true")){
					// 로그 이력 저장
					zvl.put("url", 		  "/admin/contact/mainVisualList.do");
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