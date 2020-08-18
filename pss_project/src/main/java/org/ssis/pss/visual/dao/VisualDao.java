package org.ssis.pss.visual.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class VisualDao extends CmnSupportDAO {

	/**
	 * 컨텐츠 관리 - 메인 비주얼 관리 공통 리스트
	 * @param zvl
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> visualCommonList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 컨텐츠 관리 - 메인 비주얼 관리 공통 인서트
	 * @param zvl
	 * @throws Exception
	 */
	public void visualCommonInsert(ZValue zvl)  throws Exception {
		insert(zvl.getString("sqlid"), zvl);
	}	
	
	/**
	 * 컨텐츠 관리 - 메인 비주얼 관리 공통 업데이트
	 * @param zvl
	 * @throws Exception
	 */
	public void visualCommonUpdate(ZValue zvl) throws Exception {
		update(zvl.getString("sqlid"), zvl);
	}
}