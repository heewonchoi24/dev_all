package org.ssis.pss.cmn.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.ssis.pss.cmn.model.ZValue;


public interface CmnService {
	
	/**
	 * 공통 List count 조회 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int retrieveCommonListCnt(ZValue zvl) throws Exception;
	
	/**
	 * 공통 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> retrieveCommonList(ZValue zvl) throws Exception;
	
	/**
	 * 공통 상세 조회 
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue retrieveCommonDetail(ZValue zvl) throws Exception; 
		
	/**
	 * 공통 수정 처리 
	 * @param zvl
	 * @throws Exception
	 */
	void modifyCommonInfo(ZValue zvl) throws Exception; 
	
	/**
	 * 공통 등록 처리 
	 * @param zvl
	 * @throws Exception
	 */
	void createCommonInfo(ZValue zvl) throws Exception; 
		
	/**
	 * 공통 처리 
	 * @param zvl
	 * @throws Exception
	 */
	void removeCommonInfo(ZValue zvl) throws Exception; 
	 
	/**
	 * 공통 코드 테이블 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> retrieveChrgDutyList(ZValue zvl) throws Exception;
	
	/**
	 * 공통 코드 테이블 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> retrieveCommCdList(ZValue zvl) throws Exception;
	
	/**
	 * 공통 기관 코드 테이블 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> retrieveInstCodeList() throws Exception;
	
	/**
	 * 권한별 메뉴 리스트 조회
	 * @param zvl
	 * @return	List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> retrieveMenuList(String author_id) throws Exception;
	
	/**
	 * 현재 차수 조회
	 * @param 
	 * @return	String
	 * @throws Exception
	 */
	ZValue retrieveCurrentOrderNo() throws Exception;
	
	/**
	 * 차수 리스트 조회
	 * @param zvl
	 * @return	List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> retrieveOrderNoList() throws Exception;
	
	/**
	 * 평가기간 코드 조회
	 * @param 
	 * @return	char
	 * @throws Exception
	 */
	String retrieveEvlPeriodCode() throws Exception;
	
	/**
	 * 점검항목 점수 구분조회
	 * @param zvl
	 * @return	List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> retrieveCheckItemScoreSeList(ZValue zvl) throws Exception;
	
	/**
	 * 점검항목 구간별 점수 조회
	 * @param zvl
	 * @return	List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> retrieveCheckItemSctnScoreList(ZValue zvl) throws Exception;
	
	/**
	 * 메인 - 주요일정
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> mainMonthlySchedule(ZValue zvl) throws Exception;
	
	/**
	 * 메인 - 공지사항, 자료실, 개인정보 소식 미니 게시판
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mainBbsNoticeList(ZValue zvl) throws Exception;
	
	/**
	 * 메인 - 주요일정 팝업
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mainYearScheduleDtlList(ZValue zvl) throws Exception;
	
	/**
	 * 메인 - 공지사항, 자료실, 개인정보 소식 미니 게시판
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mainBbsResourceList(ZValue zvl) throws Exception;
	
	/**
	 * 메인 - 공지사항, 자료실, 개인정보 소식 미니 게시판
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mainBbsIndvdlLawList(ZValue zvl) throws Exception;
	
	/**
	 * 권한 List 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> retrieveAuthorList() throws Exception;
	
	/**
	 * 메인 - 받은 메시지 알림 카운트
	 * @return
	 * @throws Exception
	 */
	ZValue recptnMsgListCnt(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 메인 - 받은 메시지 알림
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> recptnMsgList(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 메인 - 메뉴아이디 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue getMenuId(ZValue zvl) throws Exception;
	
	/**
	 * 메인 - 설문조사 대상 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	List<ZValue> getQestnrSeq(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 평가 종료 여부
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue retrieveEvalFromTo(ZValue zvl) throws Exception;
	
	/**
	 * 현재 등록되어있는 차수 마지막 년도 조회
	 * @param 
	 * @return
	 * @throws Exception
	 */
	ZValue retrieveMaxOrderNo() throws Exception;

	/**
	 * READ/WRITE/DOWNLOAD 권한
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> getAuthority(ZValue zvl) throws Exception;
}