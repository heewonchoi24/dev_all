package org.ssis.pss.mngLevelRes.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface MngLevelResService {

	/**
	 * 관리수준 진단 - 실적등록 - 평가항목 년도
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttEvlOrderList(ZValue zvl) throws Exception;
	
	
	/**
	 * 관리수준 진단 - 실적등록 - 기관 구분 코드
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttClCdList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 실적등록 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttList(ZValue zvl) throws Exception;

	/**
	 * 관리수준 진단 - 실적등록 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttSelectList(ZValue zvl) throws Exception;

	/**
	 * 관리수준 진단 - 실적등록 - 기관 목록(테이블용)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttTableList(ZValue zvl) throws Exception;
	
	
	/**
	 * 관리수준 진단 - 실적등록 - 평가 항목 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelIdxList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 실적등록 - 평가 상태 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttEvlList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 실적등록(기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> MngLevelInsttListAjax(ZValue zvl) throws Exception;

	/**
	 * 관리수준진단 지표 리스트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	List<ZValue> selectMngLevelIndexList(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 지표 등록 예외여부 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void insertMngLevelExcpYn(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 관리수준진단 지표 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void createMngLevelRes(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 관리수준진단 지표 수정
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void updateMngLevelRes(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준진단 실적 삭제
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void deleteMngLevelRes(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 관리수준진단 실적 등록용 지표 건수 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectMngLevelIdxCnt(ZValue zvl) throws Exception;

	/**
	 * 관리수준진단 실적 등록 건수 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectMngLevelReqstCnt(ZValue zvl) throws Exception;

	/**
	 * 관리수준진단 실적 상태코드별 등록 건수 확인
	 * @param zvl
	 * @return zvl
	 * @throws Exception
	 */
	List<ZValue> selectCntMngLevelReqstStatus(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준진단 지표 등록 상태수정
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void updateMngLevelResStat(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 관리수준 등록결과 - 실적등록(재등록 요청사유 AJAX)  
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue selectMngLevelRergistResnAjax(ZValue zvl) throws Exception;

	/**
	 * 관리수준 등록결과 - 실적등록(재등록 요청사유 AJAX)  
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue selectMngLevelReqst(ZValue zvl) throws Exception;

	/**
	 * 관리수준진단 실적 상태코드별 등록 건수 확인
	 * @param zvl
	 * @return zvl
	 * @throws Exception
	 */
	List<ZValue> mngLevelInsttFileList(ZValue zvl) throws Exception;

	/**
	 * 관리수준진단 결과 등록완료 여부 확인용 기초현황 등록 건수 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectBsisSttusCnt(ZValue zvl) throws Exception;
	
	/**
	 * 관리수준 진단 - 실정등록 및 조회 - 최대 업로드 가능 파일 사이즈
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue getLimitFileSize(ZValue zvl) throws Exception;
}