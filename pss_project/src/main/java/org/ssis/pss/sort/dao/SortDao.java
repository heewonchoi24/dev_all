package org.ssis.pss.sort.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class SortDao extends CmnSupportDAO {

	/**
	 * 컨텐츠 관리 - 메인 컨텐츠 순서 공통 리스트
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> sortCommonList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 컨텐츠 관리 - 메인 컨텐츠 순서 공통 인서트
	 * @param zvl
	 * @throws Exception
	 */
	public void sortCommonInsert(ZValue zvl) throws Exception {
		insert(zvl.getString("sqlid"), zvl);
	}

	/**
	 * 컨텐츠 관리 - 메인 컨텐츠 순서 공통 딜리트
	 * @param zvl
	 * @throws Exception
	 */
	public void sortCommonDelete(ZValue zvl) throws Exception {
		delete(zvl.getString("sqlid"), zvl);
	}	

	/**
	 * 컨텐츠 관리 - 메인 컨텐츠 순서 공통 카운트
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	public int selectSortListCnt(ZValue zvl) throws Exception {
		return selectCnt(zvl.getString("sqlid"), zvl);
	}
	
}