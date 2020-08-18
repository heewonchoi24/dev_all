package org.ssis.cjs.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface CjsBbsService {
	
	/**
	 * 게시판 공통 글목록조회
	 * @param zvl
	 * @returnList<ZValue>
	 * @throws Exception
	 */
	List<ZValue> bbsList(ZValue zvl) throws Exception;
	
	/**
	 * 게시판 글 상세 조회
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	ZValue bbsView(ZValue zvl) throws Exception;
	
	/**
	 * 게시판 글 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int bbsListCnt(ZValue zvl) throws Exception;
	
	/**
	 * 게시판 첨부파일 목록
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> bbsAttachFileList(ZValue zvl) throws Exception;
	
	/**
	 * 게시판 파일 첨부
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	ZValue bbsThreadInsert(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 게시판 파일 삭제
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void bbsFileDelete(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 게시판 삭제
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void bbsDelete(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 게시판 카운트 + 1
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	void bbsCountUpdate(ZValue zvl) throws Exception;
	
	/**
	 * 관제담당자 정보 엑셀 다운로드
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> userList(ZValue zvl) throws Exception;
}