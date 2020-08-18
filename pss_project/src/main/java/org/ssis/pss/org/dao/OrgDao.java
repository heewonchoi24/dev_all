package org.ssis.pss.org.dao;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class OrgDao extends CmnSupportDAO {
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	/**
	 * 기관리스트 갯수 조회 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int orgCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("org.cntThread", zvl);
	}
	
	/**
	 * 기관리스트 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> orgList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("org.listThread", zvl);
	}

	/**
	 * 기관리스트 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertOrgList(ZValue zvl) throws Exception {
		return (Integer) insert("org.registThread", zvl);
	}

	/**
	 * 기관리스트 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateOrgList(ZValue zvl) throws Exception {
		update("org.updateOrg", zvl);
	}

	/**
	 * 기관리스트 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteOrgList(ZValue zvl) throws Exception {
		update("org.deleteOrg", zvl);
	}

	/**
	 * 기관리스트 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> orgInsttClCdList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("org.orgInsttClCdList", zvl);
	}

	/**
	 * 기관 통폐합리스트용 기관 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> orgInsttList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("org.orgInsttList", zvl);
	}

	/**
	 * 기관 통폐합리스트용 전체기관 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> orgInsttAllList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("org.orgInsttAllList", zvl);
	}

	/**
	 * 기관 통폐합리스트 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> orgHistList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("org.histListThread", zvl);
	}

	/**
	 * 기관 통폐합리스트 갯수 조회 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int orgHistCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("org.histCntThread", zvl);
	}

	/**
	 * 기관 통폐합리스트 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertOrgHist(ZValue zvl) throws Exception {
		return (Integer) insert("org.registHist", zvl);
	}

	/**
	 * 기관 통폐합리스트 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateOrgHist(ZValue zvl) throws Exception {
		update("org.updateHist", zvl);
	}

	/**
	 * 기관 정보 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue orgInfo(ZValue zvl) throws Exception {
		return (ZValue) selectOne("org.orgInfo", zvl);
	}

	/**
	 * 기관 통폐합리스트 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteOrgHist(ZValue zvl) throws Exception {
		delete("org.deleteHist", zvl);
	}

	/**
	 * 기관 통폐합정보 반영
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateDownOrg(ZValue zvl) throws Exception {
		update("org.updateDownOrg", zvl);
	}
	
	/**
	 * 기관 정보 상세조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public ZValue selectOrgInfo(ZValue zvl) throws Exception {
		return (ZValue) selectOne("org.selectOrgInfo", zvl);
	}

	/**
	 * 기관 통폐합리스트 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateOrgMastr(ZValue zvl) throws Exception {
		update("org.updateOrgMastr", zvl);
	}
}

