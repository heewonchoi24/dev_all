package org.ssis.pss.sort.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.sort.dao.SortDao;
import org.ssis.pss.sort.service.SortService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class SortServiceImpl implements SortService {
	

	@Autowired 
	private SortDao sortDao; 
	
	@Autowired
	private UserService UserService;

	@Autowired
	private ConnectService connectService;		

	Logger logger = Logger.getLogger(this.getClass());
	
	public List<ZValue> sortList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "sort.sortList");
		return sortDao.sortCommonList(zvl);
	}

	@Override
	public void sortRegistThread(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		zvl.put("user_id", userInfo.getUserId());
		
		try {
			zvl.put("sqlid", "sort.sortThreadCnt");
			int cnt = sortDao.selectSortListCnt(zvl);

			if(cnt > 0) {
				zvl.put("sqlid", "sort.sortThreadDelete");
				sortDao.sortCommonDelete(zvl);
			} 
			
			String titleArrayInfo = EgovStringUtil.nullConvert(zvl.getString("titleArrayInfo"));
			String[] titleArray = titleArrayInfo.split(",");
			
			for(String title : titleArray){
				zvl.put("title", title);
				zvl.put("sqlid", "sort.sortThreadInsert");
				sortDao.sortCommonInsert(zvl);			
			}
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/contact/mainContentsSortList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.UPDATE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}