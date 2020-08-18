package org.ssis.pss.footer.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.footer.dao.FooterDAO;
import org.ssis.pss.footer.service.FooterService;

@Service
public class FooterServiceImpl implements FooterService {

	protected Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private FooterDAO FooterDAO;
	
	public ZValue selectFooterText(ZValue zvl) throws Exception {
		zvl.put("sqlid", "footer.selectFooterText");
		return FooterDAO.selectFooterText(zvl);
	}	
	
	@Override
	public void insertFooterText(ZValue zvl, HttpServletRequest request) throws Exception {
		FooterDAO.insertFooterText(zvl);
	}

	public void updateFooterText(ZValue zvl, HttpServletRequest request) throws Exception {
		FooterDAO.updateFooterText(zvl);
	}

}
