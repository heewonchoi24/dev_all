package org.ssis.pss.msg.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class MsgDao extends CmnSupportDAO {

	/**
	 * 보낸메시지 글 갯수 조회 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int trnsmitMsgCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("msg.cntThread", zvl);
	}
	
	/**
	 * 보낸메시지 글 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> trnsmitMsgList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("msg.listThread", zvl);
	}

	/**
	 * 메시지 글 상세 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue trnsmitMsgOne(ZValue zvl) throws Exception {
		return (ZValue) selectOne("msg.tmsgOneThread", zvl);
	}

	/**
	 * 보낸메시지 수신자 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> trnsmitUserList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("msg.listTransmit", zvl);
	}

	/**
	 * 보낸메시지 글 삭제
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void deleteTrnsmitMsg(ZValue zvl) throws Exception {
		update("msg.deleteTrnsmitMsg", zvl);			
	}

	/**
	 * 보낸메시지 글 수신확인 반영
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void updateTrnsmitMsg(ZValue zvl) throws Exception {
		update("msg.updateTrnsmitMsg", zvl);			
	}

	/**
	 * 보낸메시지 글 갯수 조회 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int cntReceiveCheck(ZValue zvl) throws Exception {
		return (Integer) selectCnt("msg.cntReceiveCheck", zvl);
	}

	/**
	 * 보낸메시지 글 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertTrnsmitMsg(ZValue zvl) throws Exception {
		return (Integer) insert("msg.registThread", zvl);
	}

	/**
	 * 보낸메시지 글 상세 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertReceiveMsg(ZValue zvl) throws Exception {
		return (Integer) insert("msg.registDetailThread", zvl);
	}

	/**
	 * 받은메시지 글 수신확인 반영
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void updateReceiveMsg(ZValue zvl) throws Exception {
		update("msg.updateReceiveMsg", zvl);			
	}

	/**
	 * 받은메시지 글 갯수 조회 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int receiveMsgCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("msg.cntDetailThread", zvl);
	}
	
	/**
	 * 받은메시지 글 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> receiveMsgList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("msg.listDetailThread", zvl);
	}

	/**
	 * 받은메시지 글 상세 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue receiveMsgOne(ZValue zvl) throws Exception {
		return (ZValue) selectOne("msg.rmsgOneThread", zvl);
	}

	/**
	 * 받은메시지 글 삭제
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void deleteReceiveMsg(ZValue zvl) throws Exception {
		update("msg.deleteReceiveMsg", zvl);			
	}

	/**
	 * 메시지보내기 - (기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> msgInsttListAjax(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("msg.msgInsttList", zvl);
	}

	/**
	 * 메시지보내기 - (기관분류 select box 변경 시 User 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> msgUserListAjax(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("msg.msgInsttUserList", zvl);
	}

	/**
	 * 메시지보내기 - (기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> msgInsttList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("msg.msgInsttList", zvl);
	}
	
	/**
	 * 메시지보내기 - 기관 구분 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> msgInsttClCdList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("msg.msgInsttClCdList", zvl);
	}

	/**
	 * 메시지보내기 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> msgInsttSelectList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("msg.msgInsttSelectList", zvl);
	}

	/**
	 * 메시지보내기 - User 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> msgInsttUserList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("msg.msgInsttUserList", zvl);
	}

	/**
	 * 보낸메시지 첨부파일 삭제
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void deleteMsgFile(ZValue zvl) throws Exception {
		delete("msg.deleteMsgFile", zvl);			
	}

	/**
	 * 메시지함 - 첨부파일 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> msgFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("msg.msgFileList", zvl);
	}
	
	/**
	 * 받은메시지 글 상세 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	public ZValue msgPrevNext(ZValue zvl) throws Exception {
		return (ZValue) selectOne(zvl.getString("sqlid"), zvl);
	}

}

