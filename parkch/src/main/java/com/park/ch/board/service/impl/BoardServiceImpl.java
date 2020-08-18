package com.park.ch.board.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.park.ch.board.dao.BoardDao;
import com.park.ch.board.service.BoardService;
import com.park.ch.cmn.contoller.Pagination;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired BoardDao BoardDao;

	@Override
	public void insertBoard(Map<String, String> param) throws Exception {
		BoardDao.insertBoard(param);
	}

	@Override
	public List<HashMap<String, Object>> boardList(Pagination pagination) throws Exception {
		return BoardDao.boardList(pagination);
	}

	@Override
	public HashMap<String, Object> boardDetail(Map<String, String> param) throws Exception {
		return BoardDao.boardDetail(param);
	}

	@Override
	public void updateBoard(Map<String, String> param) throws Exception {
		BoardDao.updateBoard(param);
	}

	@Override
	public void deleteBoard(Map<String, String> param) throws Exception {
		BoardDao.deleteBoard(param);
	}

	@Override
	public int getBoardListCnt() throws Exception {
		return BoardDao.getBoardListCnt();
	}

	@Override
	public void boardViewCntIncrease(Map<String, String> param) throws Exception {
		BoardDao.boardViewCntIncrease(param);
		
	}

	@Override
	public Object getBoardTopContent(Map<String, String> param) throws Exception {
		return BoardDao.getBoardTopContent(param);
	}

	@Override
	public Object getBoardBotContentList(Map<String, String> param) throws Exception {
		return BoardDao.getBoardBotContentList(param);
	}

}
