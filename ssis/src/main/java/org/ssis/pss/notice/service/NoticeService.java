package org.ssis.pss.notice.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface NoticeService {
	
	/**
	 * 게시판관리 - 게시판 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> noticeBbsList(ZValue zvl) throws Exception;
	
	/**
	 * 게시판 관리 - 게시판 목록 - 게시판 사용여부 업데이트(미사용)
	 * @param zvl
	 * @throws Exception
	 */
	void updateBbsStatus(ZValue zvl) throws Exception;
	
	/**
	 * 시스템 관리 - 게시판 관리 - 게시판별 글 삭제 AJAX
	 * @param zvl
	 * @throws Exception
	 */
	void deleteThread(ZValue zvl) throws Exception;
	
	/**
	 * 시스템 관리 - 게시판 관리 - 게시판별 글 삭제취소 AJAX
	 * @param zvl
	 * @throws Exception
	 */
	void rollbackThread(ZValue zvl) throws Exception;
	
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
	 * 게시판 답변 등록
	 * @param zvl
	 * @throws Exception
	 */
	void bbsRegistThreadAnswer(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 게시판 타입 변경
	 * @param zvl
	 * @throws Exception
	 */
	void bbsTypeUpdateThread(ZValue zvl) throws Exception;

	/**
	 * 게시판 목록 이미지 파일 등록
	 * @param zvl
	 * @throws Exception
	 */
	void bbsListImgInsertThread(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 게시판 목록 이미지 사용
	 * @param zvl
	 * @throws Exception
	 */
	void bbsImgUseYNUpdate(ZValue zvl) throws Exception;

	/**
	 * 게시판 해당 게시글 목록이미지 조회
	 * @param zvl
	 * @throws Exception
	 */
	ZValue bbsImgList(ZValue zvl) throws Exception;

	/**
	 * 게시판 게시글 목록이미지 삭제 
	 * @param zvl
	 * @throws Exception
	 */
	void bbsImgdelete(ZValue zvl) throws Exception;

	/**
	 * 게시판 목록이미지 갯수 
	 * @param zvl
	 * @throws Exception
	 */
	int bbsImgCnt(ZValue zvl) throws Exception;

	/**
	 * 게시판 게시글 목록이미지 변경 
	 * @param zvl
	 * @throws Exception
	 */
	void bbsImgUpdate(ZValue zvl) throws Exception;
}