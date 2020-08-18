package org.ssis.pss.join.service;

import java.util.List;

import org.ssis.pss.cmn.model.ZValue;


public interface JoinService {
	
	/**
	 * 회원 가입 시 아이디 중복 체크
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int idDupChk(ZValue zvl) throws Exception;
	
	/**
	 * 회원 가입 시 사용자등록 여부 체크
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int joinCertChk(ZValue zvl) throws Exception;
	
	/**
	 * 회원 가입 신청
	 * @param zvl
	 * @throws Exception
	 */
	void userRegist(ZValue zvl) throws Exception; 
	
	/**
	 * 가입 상태 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue getUserStatus(ZValue zvl) throws Exception;
}