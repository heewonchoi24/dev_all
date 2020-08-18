package org.ssis.pss.user.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;

import egovframework.com.cmm.LoginVO;


public interface UserService {
	
	/**
	 * 사용자 정보 조회 
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue userInfo(ZValue zvl) throws Exception;
	
	/**
	 * 아이디/패스워드 로그인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	 LoginVO userLogin(LoginVO loginVO) throws Exception;
	 
	/**
	 * 로그인 - 공인인증서 로그인 시리얼 값으로 유저정보 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	LoginVO certLogin(ZValue zvl) throws Exception;
	
	/**
	 * 회원가입 - 공인인증서 등록
	 * @param zvl
	 * @return 
	 * @throws Exception
	 */
	void certRegist(ZValue zvl) throws Exception;
	
	/**
	 * 회원 정보 수정
	 * @param zvl
	 * @throws Exception
	 */
	void userUpdate(ZValue zvl) throws Exception;
	
	/**
	 * 접속 이력
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void connectHistoryInsert(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 최종 로그인 일시
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void lastConnectDtUpdate(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 로그인 암호 오류 횟수 증가
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void passwordErrorCntUpdate(LoginVO loginVO) throws Exception;
	
	/**
	 * 로그인 암호 오류, 일시 초기화
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void passwordErrorCntDtReset(LoginVO loginVO) throws Exception;
	
	/**
	 * 비밀번호 수정
	 * @param zvl
	 * @throws Exception
	 */
	String passUpdate(ZValue zvl) throws Exception; 
	
	/**
	 * 사용자 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> userList(ZValue zvl) throws Exception;
	
	/**
	 * 사용자 리스트 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int userListCnt(ZValue zvl) throws Exception;
	
	/**
	 * 점검원 배정 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> insctrInsttList(ZValue zvl) throws Exception;
	
	/**
	 * 점검원 EXCEL LIST
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> insctrInsttExcelList(ZValue zvl) throws Exception;
	
	/**
	 * 점검원 기관 배정
	 * @param zvl
	 * @throws Exception
	 */
	void setInsctrInstt(ZValue zvl) throws Exception;
	
	
	/**
	 * 점검원 일괄 등록
	 * @param zvl
	 * @throws Exception
	 */
	void createInsctr(ZValue zvl) throws Exception;
	
	/**
	 * 점검원 수정
	 * @param zvl
	 * @throws Exception
	 */
	void updateInsctr(ZValue zvl) throws Exception;
	
	/**
	 * 점검원 비밀번호 초기화
	 * @param zvl
	 * @throws Exception
	 */
	void updateInsctrPasswd(ZValue zvl) throws Exception;
	
	/**
	 * 점검원 삭제
	 * @param zvl
	 * @throws Exception
	 */
	void deleteInsctr(ZValue zvl) throws Exception;
	
	/**
	 * 사용자 비밀번호 초기화
	 * @param zvl
	 * @throws Exception
	 */
	String resetPassword(ZValue zvl) throws Exception;
	
	/**
	 * 시스템 관리 - 사용자 관리 - 사용자 삭제
	 * @param zvl
	 * @throws Exception
	 */
	void userDelete(ZValue zvl) throws Exception;
	
	/**
	 * 시스템 관리 - 사용자 관리 - 사용자 수정 - 수정
	 * @param zvl
	 * @throws Exception
	 */
	void userInfoModify(ZValue zvl) throws Exception;

	/**
	 * 아이디찾기
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue findUserId(ZValue zvl) throws Exception;

	/**
	 * 점검원 최초 로그인 시 비밀번호 변경
	 * @param zvl
	 * @throws Exception
	 */
	void firstLoginChangePassword(ZValue zvl) throws Exception;
	/**
	 * 사용자 인증 관리 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectUserCertificationList(ZValue zvl) throws Exception;
	
	/**
	 * 사용자 인증 관리 count
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	int selectUserCertificationCnt(ZValue zvl) throws Exception;
	
	/**
	 * 사용자 인증 등록
	 * @param zvl
	 * @throws Exception
	 */
	void insertUserCertification(ZValue zvl) throws Exception;
	
	/**
	 * 사용자 인증 수정
	 * @param zvl
	 * @throws Exception
	 */
	void updateUserCertification(ZValue zvl) throws Exception;
	
	/**
	 * 사용자 인증 삭제
	 * @param zvl
	 * @throws Exception
	 */
	void deleteUserCertification(ZValue zvl) throws Exception;

	/**
	 * 사용자 인증 체크
	 * @param zvl
	 * @return <ZValue>
	 * @throws Exception
	 */
	int selectUserCertificationCheck(ZValue zvl) throws Exception;
	
	/**
	 * 사용자 로그 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectUserLogList(ZValue zvl) throws Exception;
	
	/**
	 * 사용자 로그 count
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	int selectUserLogCnt(ZValue zvl) throws Exception;
	
	/**
	 * 사용자 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectUserInsctrList(ZValue zvl) throws Exception;
	
	/**
	 * 사용자 리스트 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectUserInsctrCnt(ZValue zvl) throws Exception;

	
	/**
	 * 비밀번호 변경 여부
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	String passwordChangeDtYN(LoginVO loginVO) throws Exception;
	
	/**
	 * 마지막 로그인 일자 업데이트
	 * @param LoginVO
	 * @return void
	 * @throws Exception
	 */
	void updateLastLoginDt(LoginVO loginVO) throws Exception;
	
}