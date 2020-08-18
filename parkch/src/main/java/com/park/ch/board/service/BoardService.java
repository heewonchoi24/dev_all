package com.park.ch.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.park.ch.board.dao.BoardDao;
import com.park.ch.cmn.contoller.Pagination;

public interface BoardService {

	void insertBoard(Map<String, String> param) throws Exception;

	List<HashMap<String, Object>> boardList(Pagination pagination) throws Exception;

	HashMap<String, Object> boardDetail(Map<String, String> param) throws Exception;

	void updateBoard(Map<String, String> param) throws Exception;

	void deleteBoard(Map<String, String> param) throws Exception;

	int getBoardListCnt() throws Exception;

	void boardViewCntIncrease(Map<String, String> param) throws Exception;

	Object getBoardTopContent(Map<String, String> param) throws Exception;

	Object getBoardBotContentList(Map<String, String> param)  throws Exception;

	
}
