package org.ssis.pss.footer.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class FooterDAO extends CmnSupportDAO {
	
	/**
	 * 푸터 텍스트 조회
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	public ZValue selectFooterText(ZValue zvl) throws Exception {
		return (ZValue) selectOne(zvl.getString("sqlid"), zvl);
	}	
	
	/**
	 * 푸터 텍스트 등록
	 * @param zvl
	 * @throws Exception
	 */
	public void insertFooterText(ZValue zvl) throws Exception {
		insert("footer.insertFooterText", zvl);
		
	}
	
	/**
	 * 푸터 텍스트 수정
	 * @param zvl
	 * @throws Exception
	 */
	public void updateFooterText(ZValue zvl) throws Exception {
		update("footer.updateFooterText", zvl);
	}

}
