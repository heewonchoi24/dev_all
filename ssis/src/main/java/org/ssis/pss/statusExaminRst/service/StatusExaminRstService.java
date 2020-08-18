package org.ssis.pss.statusExaminRst.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface StatusExaminRstService {
	
	/**
	 * 관리수준 현황조사- 종합 결과조회 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminRstSummaryList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사- 종합 결과조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue selectStatusExaminRstSummary(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 최종결과 파일 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminRstSummaryFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminRstList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminRstDtlSum(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과 상세 전체 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminRstDtlAllList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과 상세 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminRstDtlList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue selectStatusExaminRst(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 신청 파일 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminRstFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과 메모 파일 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminEvlMemoFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과 이의신청 파일list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminEvlFobjctFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과 이의신청 등록
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void updateStatusExaminRstFobjct(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과 이의신청 파일 등록
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void updateStatusExaminEvlFobjctFile(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과 이의신청 파일 삭제
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void deleteStatusExaminEvlFobjctFile(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 현황조사 - 결과 전체 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminExcelDtlList(ZValue zvl) throws Exception;
}