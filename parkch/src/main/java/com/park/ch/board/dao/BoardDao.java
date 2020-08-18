package com.park.ch.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.park.ch.cmn.contoller.Pagination;
import com.park.ch.cmn.dao.CmnSupportDAO;

@Repository
public class BoardDao extends CmnSupportDAO {

	public void insertBoard(Map<String, String> param) throws Exception { 
		insert("board.insertBoard", param);
	}

	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> boardList(Pagination pagination) {
		return (List<HashMap<String, Object>>) selectList("board.boardList", pagination);
	}

	@SuppressWarnings("unchecked")
	public HashMap<String, Object> boardDetail(Map<String, String> param) {
		return (HashMap<String, Object>) selectOne("board.boardDetail", param);
	}

	public void updateBoard(Map<String, String> param) {
		update("board.updateBoard", param);
	}

	public void deleteBoard(Map<String, String> param) {
		delete("board.deleteBoard", param);
	}

	public int getBoardListCnt() {
		return (int) selectOne("board.getBoardListCnt");
	}

	public void boardViewCntIncrease(Map<String, String> param) {
		update("board.boardViewCntIncrease", param);
		
	}

	public Object getBoardTopContent(Map<String, String> param) {
		return selectOne("board.getBoardTopContent", param);
		
	}

	public Object getBoardBotContentList(Map<String, String> param) {
		return selectList("board.getBoardBotContentList", param);
	}

}
