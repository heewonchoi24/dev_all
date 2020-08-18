package org.ssis.pss.mylibry.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface MylibryService {
	
	/**
	 * 마이 라이브러리 - 자료실 게시판 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mylibryBbsList(ZValue zvl) throws Exception;
	
	/**
	 * 마이 라이브러리 - 자료실 게시판 파일 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mylibryBbsFileList(ZValue zvl) throws Exception;

	/**
	 * 마이 라이브러리 - 파일 단건
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue mylibryAttachFile(ZValue zvl) throws Exception;
	
	/**
	 * 마이 라이브러리 - 파일 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mylibryAttachFileList(ZValue zvl) throws Exception;

	/**
	 * 마이 라이브러리 - 개인정보 보유 현황 CNT
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> mylibryBbsImg(ZValue zvl) throws Exception;
	
	/**
	 * 마이 라이브러리 - 파일 Insert
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue mylibryThreadInsert(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 마이 라이브러리 - 파일 Delete
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	void mylibryFileDelete(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 마이 라이브러리 - 개인정보 보유 현황 CNT
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue mylibryBsisSttusCnt(ZValue zvl) throws Exception;

	/**
	 * 마이 라이브러리 - 관리수준 진단 중간결과/최종결과
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	ZValue selectMngLevelResult(ZValue zvl) throws Exception;


}