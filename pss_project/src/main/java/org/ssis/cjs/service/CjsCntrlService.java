package org.ssis.cjs.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface CjsCntrlService {
	
	/**
	 * 관제 신청 리스트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	List<ZValue> selectCntrlList(ZValue zvl) throws Exception;
	
	/**
	 * 관제 신청 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectCntrlCnt(ZValue zvl) throws Exception;
	
	/**
	 * 관제 신청 첨부파일 리스트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	List<ZValue> selectCntrlFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관제 상태 수정
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void updateCntrlStatus(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관제 신청
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	ZValue selectCntrl(ZValue zvl) throws Exception;
	
	/**
	 * 관제 신청
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void createCntrlStatus(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관제 신청 파일 삭제
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void deleteCntrlFile(ZValue zvl, HttpServletRequest request) throws Exception;
}