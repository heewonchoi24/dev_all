package org.ssis.pss.index.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface IndexService {
	
	/**
	 * 점검항목구간별점수 리스트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	List<ZValue> selectCheckItemSctnScoreList(ZValue zvl) throws Exception;
	
	/**
	 * 점검항목점수구분 리스트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	List<ZValue> selectCheckItemScoreSeList(ZValue zvl) throws Exception;
	
	/**
	 * 기본정보 삭제
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void deleteCheckItemScore(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 기본정보 수정
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void updateCheckItemScore(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준진단 지표 리스트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	List<ZValue> selectMngLevelIndexList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준진단 지표 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void createMngLevelIndex(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준진단 지표 수정
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void updateMngLevelIndex(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준진단 지표 삭제
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void deleteMngLevelIndex(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 현황조사 지표 리스트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminIndexList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 지표 번호 리스트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	List<ZValue> selectMngLevelIndexSeqList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 지표 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void createStatusExaminIndex(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 현황조사 지표 상세 리스트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminIndexDtlList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 지표 수정
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void updateStatusExaminIndex(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 현황조사 지표 삭제
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void deleteStatusExaminIndex(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 지표 EXCEL UPLOAD
	 * @param zvl
	 * @return zvl
	 * @throws Exception
	 */
	ZValue mIndexExcelUpload(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 지표 EXCEL UPLOAD
	 * @param zvl
	 * @return zvl
	 * @throws Exception
	 */
	ZValue sIndexExcelUpload(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectMngLevelReqstCnt(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 현황조사 평가 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectStatusExaminEvalCnt(ZValue zvl) throws Exception;
}