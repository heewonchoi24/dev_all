package org.ssis.pss.stat.service.impl;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.stat.dao.StatDao;
import org.ssis.pss.stat.service.StatService;

@Service
public class StatServiceImpl implements StatService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private StatDao statDao;
	
	@Override
	public List<ZValue> bsisStatusDataList(ZValue zvl) throws Exception {
		String bsisCd = zvl.getString("bsisCd");
		String authorId = zvl.getString("authorId");
		
		if("1".equals(authorId) || "4".equals(authorId)){
			if("S1".equals(bsisCd)){
				zvl.put("sqlid", "stat.bsisStatusFileList");
			}else if("S2".equals(bsisCd)){
				zvl.put("sqlid", "stat.bsisStatusCnsgnList");
			}else if("S3".equals(bsisCd)){
				zvl.put("sqlid", "stat.bsisStatusSysList");
			}else if("S4".equals(bsisCd)){
				zvl.put("sqlid", "stat.bsisStatusVideoList");
			}else{
				zvl.put("sqlid", "stat.bsisStatusFileList");
			}
		}else{
			zvl.put("sqlid", "stat.bsisStatusInsttTotalList");
		}
		
		return statDao.statCommonList(zvl);
	}

	@Override
	public List<ZValue> indexInstitutionMngStatList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "stat.indexInstitutionMngStatList");
		return statDao.statCommonList(zvl);
	}
	
	@Override
	public List<ZValue> indexMngStatList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "stat.indexMngStatList");
		return statDao.statCommonList(zvl);
	}
	
	@Override
	public List<ZValue> indexInstitutionStatusStatList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "stat.indexInstitutionStatusStatList");
		return statDao.statCommonList(zvl);
	}
	
	@Override
	public List<ZValue> indexStatusStatList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "stat.indexStatusStatList");
		return statDao.statCommonList(zvl);
	}
	
	@Override
	public List<ZValue> insttStatManageLevelEvlList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "stat.insttStatManageLevelEvlList");
		return statDao.statCommonList(zvl);
	}
	
	@Override
	public List<ZValue> insttStatOrgEvlList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "stat.insttStatOrgEvlList");
		return statDao.statCommonList(zvl);
	}
	
	@Override
	public List<ZValue> insttStatStatusExaminList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "stat.insttStatStatusExaminList");
		return statDao.statCommonList(zvl);
	}
	
	@Override
	public List<ZValue> conectHistDataList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "stat.conectHistDataList");
		return statDao.statCommonList(zvl);
	}
}