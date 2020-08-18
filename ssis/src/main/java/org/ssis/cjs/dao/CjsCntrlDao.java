package org.ssis.cjs.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class CjsCntrlDao extends CmnSupportDAO {

	/**
	 * 공통 List
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> cntrlCommonList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 SelectOne
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public ZValue cntrlCommonSelect(ZValue zvl) throws Exception {
		return (ZValue) selectOne(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 Count
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public int cntrlCommonCnt(ZValue zvl) throws Exception {
		return selectCnt(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 Insert
	 * @param zvl
	 * @throws Exception
	 */
	public void cntrlCommonInsert(ZValue zvl) throws Exception {
		insert(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 Insert Key
	 * @param zvl
	 * @throws Exception
	 */
	public int cntrlCommonInsertSelectKey(ZValue zvl) throws Exception {
		return (int) insert(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 Update
	 * @param zvl
	 * @throws Exception
	 */
	public void cntrlCommonUpdate(ZValue zvl) throws Exception {
		update(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 Delete
	 * @param zvl
	 * @throws Exception
	 */
	public void cntrlCommonDelete(ZValue zvl) throws Exception {
		delete(zvl.getString("sqlid"), zvl);
	}
}
