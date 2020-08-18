package org.ssis.pss.quickMenu.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class QuickMenuDao extends CmnSupportDAO {

	/**
	 * 컨텐츠 관리 - 퀵메뉴 관리 목록 공통 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")	
	public List<ZValue> quickMenuCommonList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 컨텐츠 관리 - 퀵메뉴 관리 목록 공통 인서트 
	 * @param zvl
	 * @throws Exception
	 */
	public void quickMenuCommonInsert(ZValue zvl) throws Exception {
		insert(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 컨텐츠 관리 - 퀵메뉴 관리 목록 공통 업데이트
	 * @param zvl
	 * @throws Exception
	 */
	public void quickMenuCommonUpdate(ZValue zvl) throws Exception {
		update(zvl.getString("sqlid"), zvl);
	}

	/**
	 * 컨텐츠 관리 - 퀵메뉴 관리 SEQ 공통 카운트
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	public int quickMenuThreadSeqCnt(ZValue zvl) throws Exception {
		return selectCnt(zvl.getString("sqlid"), zvl);
	}

}
