package org.ssis.pss.connect.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class ConnectDao extends CmnSupportDAO {

	/**
	 * 공통 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> connectCommonList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 카운트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public int connectCommonCnt(ZValue zvl) throws Exception {
		return selectCnt(zvl.getString("sqlid"), zvl);
	}

	/**
	 * 공통 셀렉트
	 * @param zvl
	 * @return String
	 */
	public String connectCommonSelect(ZValue zvl) {
		return (String) selectOne(zvl.getString("sqlid"), zvl);
	}

}

