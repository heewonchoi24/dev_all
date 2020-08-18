package org.ssis.pss.msg.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface MsgService {
	
	/**
	 * 보낸메시지 글 갯수 조회
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int trnsmitMsgCntThread(ZValue zvl) throws Exception;
	
	/**
	 * 보낸메시지 글 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> trnsmitMsgListThread(ZValue zvl) throws Exception;

	/**
	 * 보낸메시지 글 상세 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue trnsmitMsgThread(ZValue zvl) throws Exception;

	/**
	 * 보낸메시지 수신자 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> trnsmitUserList(ZValue zvl) throws Exception;

	/**
	 * 받은메시지 글 갯수 조회
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int receiveMsgCntThread(ZValue zvl) throws Exception;
	
	/**
	 * 받은메시지 글 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */          
	List<ZValue> receiveMsgListThread(ZValue zvl) throws Exception; 

	
	/**
	 * 받은메시지 글 상세 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */          
	ZValue receiveMsgThread(ZValue zvl) throws Exception;

	/**
	 * 보낸메시지 글 삭제 
	 * @param zvl
	 * @throws Exception
	 */
	void deleteTrnsmitMsg(ZValue zvl) throws Exception; 

	/**
	 * 받은메시지 글 삭제 
	 * @param zvl
	 * @throws Exception
	 */
	void deleteReceiveMsg(ZValue zvl) throws Exception; 

	/**
	 * 받은메시지 글 수신반영 
	 * @param zvl
	 * @throws Exception
	 */
	void updateReceiveMsg(ZValue zvl) throws Exception; 

	/**
	 * 메시지보내기 - (기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> msgInsttListAjax(ZValue zvl) throws Exception;

	/**
	 * 메시지보내기 - (기관분류 select box 변경 시 User 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> msgUserListAjax(ZValue zvl) throws Exception;

	/**
	 * 메시지보내기 - 기관 구분 코드
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> msgInsttClCdList(ZValue zvl) throws Exception;

	/**
	 * 메시지보내기 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> msgInsttSelectList(ZValue zvl) throws Exception;

	/**
	 * 메시지보내기 - User 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> msgInsttUserList(ZValue zvl) throws Exception;

	/**
	 * 메시지보내기 - transmit
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void insertTrnsmitMsg(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 보낸메시지 첨부파일 삭제
	 * @param zvl
	 * @throws Exception
	 */
	void deleteMsgFile(ZValue zvl) throws Exception; 

	/**
	 * 메시지함 - 파일 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> msgFileList(ZValue zvl) throws Exception;

	/**
	 * 메시지 상세 - 이전 글
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue msgPrev(ZValue zvl) throws Exception;
	
	/**
	 * 메시지 상세 - 이전 글
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue msgNext(ZValue zvl) throws Exception;

}