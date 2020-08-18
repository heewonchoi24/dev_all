package org.ssis.pss.mngLevelReq.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class MngLevelReqDao extends CmnSupportDAO {
	
	/**
	 * 관리수준 진단 list select
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> MngLevelSelectList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 관리수준 진단 single select
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public ZValue MngLevelSelectOne(ZValue zvl) throws Exception {
		return (ZValue) selectOne(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 관리수준 진단 insert
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	public void MngLevelInsert(ZValue zvl) throws Exception {
		insert(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 관리수준 진단 update 
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	public void MngLevelUpdate(ZValue zvl) throws Exception {
		update(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 관리수준 진단 delete 
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	public void MngLevelDelete(ZValue zvl) throws Exception {
		delete(zvl.getString("sqlid"), zvl);
	}
	
}
