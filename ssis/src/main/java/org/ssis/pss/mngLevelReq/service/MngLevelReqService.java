package org.ssis.pss.mngLevelReq.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface MngLevelReqService {
	
	
	/**
	 * 관리수준 진단 - 서면평가 - 평가항목 년도
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttEvlOrderList(ZValue zvl) throws Exception;
	
	
	/**
	 * 관리수준 진단 - 서면평가 - 기관 구분 코드
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttClCdList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttSelectList(ZValue zvl) throws Exception;
	
	
	/**
	 * 관리수준 진단 - 서면평가 - 기관 목록(테이블용)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttTableList(ZValue zvl) throws Exception;
	
	
	/**
	 * 관리수준 진단 - 서면평가 - 평가 항목 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelIdxList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가 - 평가 상태 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttEvlList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttListAjax(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttDetailList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가 - 이전 결과조회 엑셀 다운로드
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue selectMngLevelResultSummary(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가 - 이전 결과조회 엑셀 다운로드
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectMngLevelResultList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 종합평가 의견)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue mngLevelInsttTotalEvl(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(이의신청 내용 AJAX)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue mngLevelFobjctResnAjax(ZValue zvl) throws Exception;
	
	
	/**
	 * 관리수준 진단 - 서면평가(이의신청 내용 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelFobjctResnFileAjax(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(등록)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue mngLevelDocumentEvaluationRegist(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가 개별항목 상세(파일목록)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttDetailEvlFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가 개별항목 상세(파일목록)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttDetailMemoFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 상세 단일항목 평가 등록)
	 * @param zvl
	 * @return 
	 * @throws Exception
	 */
	void mngLevelDocumentEvaluationInsertAjax(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 상세 단일항목 메모 파일 인서트)
	 * @param zvl
	 * @return 
	 * @throws Exception
	 */
	void mngLevelDocumentEvaluationFileInsertAjax(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 상세 단일항목 메모 파일 업데이트)
	 * @param zvl
	 * @return 
	 * @throws Exception
	 */
	void mngLevelDocumentEvaluationFileUpdateAjax(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(기관별 상세 단일항목 메모 파일 삭제)
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void mngLevelDocumentEvaluationFileDeleteAjax(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(관리수준 진단 - 서면평가(기관별 종합평가 등록)
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	void mngLevelDocumentEvaluationTotalRegist(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(전체 등록 파일 리스트)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectMngLevelReqstAllFileList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 서면평가(결과보고서 파일)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelResultReportFile(ZValue zvl) throws Exception;
	
	/** 
	 * 관리수준 진단 - 서면평가 - 최근 평가 년도
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	ZValue mngLevelResultBeforeYear(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 평가점수, 환산점수 등록 수정
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	void updateResultTotPerScoreAjax(ZValue zvl, HttpServletRequest request) throws Exception;
}