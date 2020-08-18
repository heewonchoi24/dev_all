package org.ssis.pss.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class SystemDao extends CmnSupportDAO {

	/**
	 * 공통 One
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public ZValue commonOne(ZValue zvl) throws Exception {
		return (ZValue) selectOne(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> commonList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 카운트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public int commonCnt(ZValue zvl) throws Exception {
		return selectCnt(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 인서트
	 * @param zvl
	 * @throws Exception
	 */
	public void commonInsert(ZValue zvl) throws Exception {
		insert(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 업데이트
	 * @param zvl
	 * @throws Exception
	 */
	public void commonUpdate(ZValue zvl) throws Exception {
		update(zvl.getString("sqlid"), zvl);
	}
}
