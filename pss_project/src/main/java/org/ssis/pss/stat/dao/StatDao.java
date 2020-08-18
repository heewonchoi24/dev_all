package org.ssis.pss.stat.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class StatDao extends CmnSupportDAO {

	/**
	 * 통계현황 공통 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> statCommonList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 통계현황 공통 셀렉트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public ZValue statCommonSelect(ZValue zvl) throws Exception {
		return (ZValue) selectOne(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 통계현황 공통 카운트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public int statCommonCnt(ZValue zvl) throws Exception {
		return selectCnt(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 통계현황 공통 인서트
	 * @param zvl
	 * @throws Exception
	 */
	public void statCommonInsert(ZValue zvl) throws Exception {
		insert(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 통계현황 공통 인서트 키 셀렉트
	 * @param zvl
	 * @throws Exception
	 */
	public int statCommonInsertSelectKey(ZValue zvl) throws Exception {
		return (int) insert(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 통계현황 공통 업데이트
	 * @param zvl
	 * @throws Exception
	 */
	public void statCommonUpdate(ZValue zvl) throws Exception {
		update(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 통계현황 공통 딜리트
	 * @param zvl
	 * @throws Exception
	 */
	public void statCommonDelete(ZValue zvl) throws Exception {
		delete(zvl.getString("sqlid"), zvl);
	}

}

