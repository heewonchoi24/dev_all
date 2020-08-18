package org.ssis.pss.system.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.system.dao.SystemDao;
import org.ssis.pss.system.service.SystemService;

import egovframework.com.cmm.SessionVO;

@Service
public class SystemServiceImpl implements SystemService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private SystemDao systemDao;

	
	@Override
	public ZValue selectFileSize(ZValue zvl) throws Exception {
		zvl.put("sqlid", "system.selectFileSize");
		return systemDao.commonOne(zvl);
	}
	
	@Override
	public List<ZValue> selectFileSizeList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "system.selectFileSizeList");
		return systemDao.commonList(zvl);
	}
	
	@Override
	public int selectFileSizeListCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "system.selectFileSizeListCnt");
		return systemDao.commonCnt(zvl);
	}
	
	@Override
	public void modifyFileSize(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		zvl.put("userId", userInfo.getUserId());
		
		if("I".equals(zvl.getValue("modeFlag"))) {
			zvl.put("sqlid", "system.insertFileSize");
			systemDao.commonInsert(zvl);
		} else {
			zvl.put("sqlid", "system.updateFileSize");
			systemDao.commonUpdate(zvl);
		}
		
	}
	
	@Override
	public void modifyAllFileSize(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		zvl.put("userId", userInfo.getUserId());
		zvl.put("sqlid", "system.updateAllFileSize");
		
		systemDao.commonUpdate(zvl);
	}
}