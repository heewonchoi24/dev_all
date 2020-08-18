package org.ssis.pss.statusExaminReq.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface StatusExaminReqService {

	/**
	 * 현황관리 진단 - 실적등록 - 평가항목 년도
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttEvlOrderList(ZValue zvl) throws Exception;
	
	
	/**
	 * 현황관리 진단 - 실적등록 - 기관 구분 코드
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttClCdList(ZValue zvl) throws Exception;
	
	/**
	 * 현황관리 진단 - 실적등록 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttList(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 - 실적등록 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttSelectList(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 - 실적등록 - 기관 목록(테이블용)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttTableList(ZValue zvl) throws Exception;
	
	
	/**
	 * 현황관리 진단 - 실적등록 - 평가 항목 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> statusExaminIdxList(ZValue zvl) throws Exception;
	
	/**
	 * 현황관리 진단 - 실적등록 - 평가 상태 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttEvlList(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 - 서면평가(기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttDetailList(ZValue zvl) throws Exception;
	
	/**
	 * 현황관리 진단 - 서면평가(기관별 종합평가 의견)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue statusExaminInsttTotalEvl(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 - 실적등록(기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> StatusExaminInsttListAjax(ZValue zvl) throws Exception;

	/**
	 * 현황관리 지표 리스트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	List<ZValue> selectStatusExaminIndexList(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 -  개별항목 상세(파일목록)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue statusExaminInsttDetail(ZValue zvl) throws Exception;
	
	/**
	 * 현황관리 진단 -  이전년도 종합평가(파일목록)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> statusExaminPreFileList(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 -  종합평가(파일목록)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttFileList(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 -  개별항목 상세(파일목록)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttDetailFileList(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 -  개별항목 상세(파일목록)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttIdxFileList(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 -  개별항목 상세(파일목록)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttFobjctFileList(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 -  개별항목 상세(상세목록)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> statusExaminInsttIdxDetailList(ZValue zvl) throws Exception;

	/**
	 * 현황관리 지표 등록 예외여부 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void insertStatusExaminExcpYn(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 현황관리 지표 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void createStatusExaminRes(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 현황관리 지표 수정
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void updateStatusExaminRes(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 현황관리 실적 삭제
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void deleteStatusExaminRes(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 현황관리 실적 등록 건수 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectStatusExaminCnt(ZValue zvl) throws Exception;

	/**
	 * 현황관리 실적 상태코드별 등록 건수 확인
	 * @param zvl
	 * @return zvl
	 * @throws Exception
	 */
	List<ZValue> selectCntStatusExaminReqstStatus(ZValue zvl) throws Exception;
	
	/**
	 * 현황관리 지표 등록 상태수정
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void updateStatusExaminResStat(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 현황관리 진단 - (이의신청 내용 AJAX)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue statusExaminFobjctResnAjax(ZValue zvl) throws Exception;

	/**
	 * 현황관리 진단 - (이의신청 파일 AJAX)
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> statusExaminFobjctResnFile(ZValue zvl) throws Exception;

	/**
	 * 이전 Order No 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue beforeOrderNo(ZValue zvl) throws Exception;

}