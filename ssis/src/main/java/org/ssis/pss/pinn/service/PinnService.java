package org.ssis.pss.pinn.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface PinnService {
	
	
	/**
	 * 서면점검 종합 list
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectPinnSummaryList(ZValue zvl) throws Exception;
	
	/**
	 * 기관 그룹 종합 list
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectInsttGroupList(ZValue zvl) throws Exception;
	
	/**
	 * 기관 그룹 selectbox list
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectInsttClSelectBoxList(ZValue zvl) throws Exception;
	
	/**
	 * 기관 selectbox list
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectInsttSelectBoxList(ZValue zvl) throws Exception;
	
	/**
	 * 서면점검 스케즐 연도 selectbox list
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectFyerSchdulSelectBoxList() throws Exception;
	
	/**
	 * 서면점검 상세 리스트
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectPinnReqEvalDtlList(ZValue zvl) throws Exception;
	
	/**
	 * 서면점검 등록 파일 리스트
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectPinnReqFileList(ZValue zvl) throws Exception;
	
	/**
	 * 서면점검 결과 파일 리스트
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectPinnEvalFileList(ZValue zvl) throws Exception;
	
	/**
	 * 서면점검 등록 / 수정 (기관)
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	void modifyPinnReqst(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 서면점검 삭제 (기관)
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	void deletePinnReqst(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 서면점검 평가
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	void modifyPinnEval(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 서면점검 평가 삭제
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	void deletePinnEval(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 서면점검 평가 상태 update
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	void updatePinnEvalStatus(ZValue zvl, HttpServletRequest request) throws Exception;
}