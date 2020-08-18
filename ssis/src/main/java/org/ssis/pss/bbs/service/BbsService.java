package org.ssis.pss.bbs.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface BbsService {

	/**
	 * 게시판 이름 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue bbsNm(ZValue zvl) throws Exception;
	
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
	 * 게시판 글 삭제
	 * @param zvl
	 * @throws Exception
	 */
	void deleteThread(ZValue zvl) throws Exception;
	
	/**
	 * 게시판 글 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int bbsListCnt(ZValue zvl) throws Exception;
	
	/**
	 * 게시판 조회수 증가
	 * @param zvl
	 * @throws Exception
	 */
	void bbsViewCntIncrease(ZValue zvl) throws Exception;
	
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
	 * 게시판 파일 갱신
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void bbsThreadUpdate(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 게시판 파일 삭제
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void bbsFileDelete(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 게시판 글 등록
	 * @param zvl
	 * @throws Exception
	 */
	void bbsRegistThread(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 게시판 파일 첨부
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	ZValue bbsAnswerFileInsert(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 댓글 첨부파일 목록 조회
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> bbsAnswerFileList(ZValue zvl) throws Exception;

	/**
	 * 게시판 타입 불러오기
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	ZValue bbsType(ZValue zvl) throws Exception;

	/**
	 * 게시판 목록 이미지 불러오기
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	List<ZValue> bbsImgList(ZValue zvl) throws Exception;

	/**
	 * 게시판 이전 글
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	ZValue bbsPrev(ZValue zvl) throws Exception;
	
	/**
	 * 게시판 다음 글
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	ZValue bbsNext(ZValue zvl) throws Exception;
	
}