package org.ssis.pss.dashboard.service.impl;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.dashboard.dao.DashboardDao;
import org.ssis.pss.dashboard.service.DashboardService;


@Service
public class DashboardServiceImpl implements DashboardService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private DashboardDao dashboardDao;
}