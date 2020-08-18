package org.ssis.pss.connect.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.connect.dao.ConnectDao;
import org.ssis.pss.connect.web.servie.ConnectService;

@Service
public class ConnectServiceImpl implements ConnectService  {
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private ConnectDao connectDao;

	@Override
	public List<ZValue> connectHistDataAdminList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "connect.connectHistDataAdminList");
		return connectDao.connectCommonList(zvl);
	}

	@Override
	public int connectHistDataAdminCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "connect.connectHistDataAdminCnt");
		return connectDao.connectCommonCnt(zvl);
	}

	@Override
	public List<ZValue> connectViewThread(ZValue zvl, HttpServletRequest request) throws Exception {
		zvl.put("sqlid", "connect.connectHistDataAdminListView");
		return connectDao.connectCommonList(zvl);
	}

	@Override
	public String getConnectHistDataAdminMenuId(ZValue zvl) throws Exception {
		zvl.put("sqlid", "connect.getConnectHistDataAdminMenuId");
		return connectDao.connectCommonSelect(zvl);
	}
}