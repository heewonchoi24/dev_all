package org.ssis.pss.popup.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class PopupDao extends CmnSupportDAO {

	/**
	 * 컨텐츠 관리 - 팝업 관리 목록 공통 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> popCommonList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}

	/**
	 * 컨텐츠 관리 - 팝업 관리 공통 인서트
	 * @param zvl
	 * @throws Exception
	 */
	public void popupCommonInsert(ZValue zvl) throws Exception {
		insert(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 컨텐츠 관리 - 팝업 관리 공통 업데이트
	 * @param zvl
	 * @throws Exception
	 */
	public void popupCommonUpdate(ZValue zvl) throws Exception {
		update(zvl.getString("sqlid"), zvl);
	}

}
