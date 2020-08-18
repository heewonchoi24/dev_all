package org.ssis.pss.join.service.impl;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.SHAPasswordEncoder;
import org.ssis.pss.join.dao.JoinDao;
import org.ssis.pss.join.service.JoinService;

@Service
public class JoinServiceImpl implements JoinService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private JoinDao JoinDao;
	
	@Override
	public int idDupChk(ZValue zvl) throws Exception {
		return JoinDao.idDupChk(zvl);
	}

	@Override
	public int joinCertChk(ZValue zvl) throws Exception {
		return JoinDao.joinCertChk(zvl);
	}

	@Override
	public void userRegist(ZValue zvl) throws Exception {
		
		//암호 암호화
		String user_pw = zvl.getString("password");
		
		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);
	    user_pw = shaPasswordEncoder.encode(user_pw);
	    
    	logger.debug("######################################################");
    	logger.debug("user_pw : \n" + user_pw);
    	logger.debug("######################################################");
	    
	    zvl.setValue("password", user_pw);
	    
	    logger.debug("######################################################");
    	logger.debug("zvl : \n" + zvl);
    	logger.debug("######################################################");
	    
		JoinDao.userRegist(zvl);
		
		JoinDao.updateUserCert(zvl);
	}
	
	@Override
	public ZValue getUserStatus(ZValue zvl) throws Exception{
		zvl.put("sqlid", "getUserStatus");
		return JoinDao.joinCommonSelectOne(zvl);
	}
}