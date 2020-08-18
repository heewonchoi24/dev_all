package org.ssis.pss.sms.service.impl;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.sms.dao.SmsDao;
import org.ssis.pss.sms.service.SmsService;

@Service
public class SmsServiceImpl implements SmsService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private SmsDao smsDao;
	
	@Override
	public int insertSms(ZValue zvl) throws Exception {
		return smsDao.insertSms(zvl);
	}
	
	@Override
	public List<ZValue> smsInsttClCdList(ZValue zvl) throws Exception {
		return smsDao.smsInsttClCdList(zvl);
	}
	
	@Override
	public List<ZValue> smsInsttUserList(ZValue zvl) throws Exception {
		return smsDao.smsInsttUserList(zvl);
	}

	@Override
	public List<ZValue> smsSendUserList(ZValue zvl) throws Exception {
		return smsDao.smsSendUserList(zvl);
	}
	
	@Override
	public int smsSendUserCnt(ZValue zvl) throws Exception {
		return smsDao.smsSendUserCnt(zvl);
	}
	
	@Override
	public List<ZValue> smsLogList(ZValue zvl) throws Exception {
		return smsDao.smsLogList(zvl);
	}
}