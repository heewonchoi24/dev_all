package org.ssis.pss.auth.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface AuthService {
	
	/**
	 * 권한관리 갯수 조회
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int authCntThread(ZValue zvl) throws Exception;
	
	/**
	 * 권한관리 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> authListThread(ZValue zvl) throws Exception;

	/**
	 * 권한관리 상세 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> authListThreadDetail(ZValue zvl) throws Exception;
	
	/**
	 * 권한관리 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void insertAuthList(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 권한관리 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void updateAuthList(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 권한관리 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void deleteAuthList(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 권한관리 얻기
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> getAuthList(ZValue zvl) throws Exception;
	
	/**
	 * 권한관리 업데이트/수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void mergeAuthDetail(ZValue zvl, HttpServletRequest request) throws Exception;
}