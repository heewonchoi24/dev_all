package org.ssis.pss.mngLevelRst.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface MngLevelRstService {
	
	/**
	 * 관리수준 진단 - 종합 결과조회 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectMngLevelResultSummaryList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 종합 결과조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue selectMngLevelResultSummary(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 결과 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectMngLevelResultList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 결과
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue selectMngLevelResult(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 신청 파일 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectMngLevelRequestFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 결과 메모 파일 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectMngLevelEvlMemoFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 결과 이의신청 파일list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectMngLevelEvlFobjctFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 결과 이의신청 등록
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void updateMngLevelRstFobjct(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 진단 - 결과 이의신청 파일 등록
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void updateMngLevelRstFobjctFile(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 진단 - 결과 이의신청 파일 삭제
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void deleteMngLevelRstFobjct(ZValue zvl, HttpServletRequest request) throws Exception;
}