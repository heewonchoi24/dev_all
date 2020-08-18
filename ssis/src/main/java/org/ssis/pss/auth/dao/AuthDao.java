package org.ssis.pss.auth.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class AuthDao extends CmnSupportDAO {

	/**
	 * 권한리스트 갯수 조회 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int authCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("auth.cntThread", zvl);
	}
	
	/**
	 * 권한리스트 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> authList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("auth.listThread", zvl);
	}
	
	/**
	 * 권한리스트 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> authListDetail(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("auth.listThreadDetail", zvl);
	}

	/**
	 * 권한리스트 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertAuthList(ZValue zvl) throws Exception {
		return (Integer) insert("auth.registThread", zvl);
	}

	/**
	 * 권한리스트 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateAuthList(ZValue zvl) throws Exception {
		update("auth.updateAuth", zvl);
	}

	/**
	 * 권한리스트 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteAuthList(ZValue zvl) throws Exception {
		delete("auth.deleteAuth", zvl);
	}
	
	/**
	 * 권한리스트 얻기
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> getAuthList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("auth.getAuthList", zvl);
	}
	
	/**
	 * 권한관리 업데이트/수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */           
	public void mergeAuthDetail(ZValue zvl) {
		insert("auth.mergeAuthDetail", zvl);
	}
}

