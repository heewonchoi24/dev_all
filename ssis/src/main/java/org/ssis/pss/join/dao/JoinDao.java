package org.ssis.pss.join.dao;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class JoinDao extends CmnSupportDAO {

	/**
	 * 가입 시 아이디 중복 체크 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int idDupChk(ZValue zvl) throws Exception {
		return (Integer) selectCnt("join.cntId", zvl);
	}

	/**
	 * 가입 시 사용자등록 여부 체크
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int joinCertChk(ZValue zvl) throws Exception {
		return (Integer) selectCnt("join.joinCertChk", zvl);
	}

	/**
	 * 사용자등록 정보 수정
	 * @param LoginVO
	 * @return LoginVO
	 * @throws Exception
	 */
	public void updateUserCert(ZValue zvl) throws Exception {
		update("join.updateUserCertificationStatus", zvl);
	}

	/**
	 * 회원 가입 신청
	 * @param zvl
	 * @throws Exception
	 */
	public void userRegist(ZValue zvl) throws Exception {
		insert("join.userRegist", zvl);
	}
	
	/**
	 * 회원 가입 공통 셀렉트
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	public ZValue joinCommonSelectOne(ZValue zvl) throws Exception{
		return (ZValue) selectOne(zvl.getString("sqlid"), zvl);
	}
}
