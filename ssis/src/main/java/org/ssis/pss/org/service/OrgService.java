package org.ssis.pss.org.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface OrgService {
	
	/**
	 * 기관 갯수 조회
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int orgCntThread(ZValue zvl) throws Exception;
	
	/**
	 * 기관 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> orgListThread(ZValue zvl) throws Exception;

	/**
	 * 기관관리 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void insertOrgList(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 기관관리 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void updateOrgList(ZValue zvl, HttpServletRequest request) throws Exception;
	/**
	 * 기관관리 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void deleteOrgList(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 기관관리 - 기관 구분 코드
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> orgInsttClCdList(ZValue zvl) throws Exception;

	/**
	 * 기관관리 - 통폐합용 기관 코드
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> orgInsttList(ZValue zvl) throws Exception;

	/**
	 * 기관관리 - 통폐합용 기관 코드
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> orgInsttAllList(ZValue zvl) throws Exception;

	/**
	 * 기관 통폐합갯수 조회
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int orgHistCntThread(ZValue zvl) throws Exception;
	
	/**
	 * 기관 통폐합 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> orgHistListThread(ZValue zvl) throws Exception;

	/**
	 * 기관 통폐합관리 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void insertOrgHist(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 기관 통폐합관리 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void updateOrgHist(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 기관 통폐합관리 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void deleteOrgHist(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 기관 정보 상세조회 
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue selectOrgInfo(ZValue zvl) throws Exception;

}