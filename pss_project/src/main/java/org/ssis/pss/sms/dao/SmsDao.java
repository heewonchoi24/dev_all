package org.ssis.pss.sms.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class SmsDao extends CmnSupportDAO {

	/**
	 * 문자메세지 보내기
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertSms(ZValue zvl) throws Exception {
		return (Integer) insert("sms.sendSmsL", zvl);
	}

	/**
	 * 문자메세지 보내기 - 기관 구분 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> smsInsttClCdList(ZValue zvl) {
		return (List<ZValue>) selectList("sms.smsInsttClCdList", zvl);
	}
	
	/**
	 * 문자메세지 보내기 - 기관 구분 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> smsInsttUserList(ZValue zvl) {
		return (List<ZValue>) selectList("sms.smsInsttUserList", zvl);
	}

	/**
	 * 문자메세지 보내기 - 로그 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> smsLogList(ZValue zvl) {
		return (List<ZValue>) selectList("sms.smsLogList", zvl);
	}

	/**
	 * 문자메세지 보내기 - 발송대상 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> smsSendUserList(ZValue zvl) {
		return (List<ZValue>) selectList("sms.smsSendUserList", zvl);
	}

	/**
	 * 문자메세지 보내기 - 발송대상 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int smsSendUserCnt(ZValue zvl) throws Exception {
		return selectCnt("sms.smsSendUserCnt", zvl);
	}
	
}

