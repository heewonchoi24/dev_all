package org.ssis.pss.sms.service;

import java.util.List;

import org.ssis.pss.cmn.model.ZValue;


public interface SmsService {
	
	/**
	 * 문자 메세지 발송
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	int insertSms(ZValue zvl) throws Exception;

	/**
	 * 문자 메세지 발송 - 기관 구분 코드
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> smsInsttClCdList(ZValue zvl) throws Exception;

	/**
	 * 문자 메세지 발송 - User 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> smsInsttUserList(ZValue zvl) throws Exception;

	/**
	 * 문자 메세지 발송 - User 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> smsSendUserList(ZValue zvl) throws Exception;
	
	/**
	 * 문자 메세지 발송 - 로그 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> smsLogList(ZValue zvl) throws Exception;

	/**
	 * 문자 메세지 발송 - 로그 카운트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	int smsSendUserCnt(ZValue zvl) throws Exception;
	
}