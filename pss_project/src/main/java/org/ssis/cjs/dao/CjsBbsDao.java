package org.ssis.cjs.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class CjsBbsDao extends CmnSupportDAO {

	/**
	 * 게시판 공통 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> bbsCommonList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 게시판 공통 셀렉트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public ZValue bbsCommonSelect(ZValue zvl) throws Exception {
		return (ZValue) selectOne(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 게시판 공통 카운트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public int bbsCommonCnt(ZValue zvl) throws Exception {
		return selectCnt(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 게시판 공통 인서트
	 * @param zvl
	 * @throws Exception
	 */
	public void bbsCommonInsert(ZValue zvl) throws Exception {
		insert(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 게시판 공통 인서트 키 셀렉트
	 * @param zvl
	 * @throws Exception
	 */
	public int bbsCommonInsertSelectKey(ZValue zvl) throws Exception {
		return (int) insert(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 게시판 공통 업데이트
	 * @param zvl
	 * @throws Exception
	 */
	public void bbsCommonUpdate(ZValue zvl) throws Exception {
		update(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 게시판 공통 딜리트
	 * @param zvl
	 * @throws Exception
	 */
	public void bbsCommonDelete(ZValue zvl) throws Exception {
		delete(zvl.getString("sqlid"), zvl);
	}
}
