package org.ssis.pss.qestnar.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface QestnarService {
	
	/**
	 * 설문 갯수 조회
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int qestnarCntThread(ZValue zvl) throws Exception;
	
	/**
	 * 설문 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> qestnarListThread(ZValue zvl) throws Exception;

	/**
	 * 설문관리 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void insertQestnarList(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 설문관리 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void updateQestnarList(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 설문관리 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void updateQestnarList2(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 설문관리 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void deleteQestnarList(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 설문마스터 단건 조회
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue selectQestnar(ZValue zvl) throws Exception;

	/**
	 * 설문항목 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectItemList(ZValue zvl) throws Exception;

	/**
	 * 설문보기 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectDetailList(ZValue zvl) throws Exception;

	/**
	 * 설문 주관식 응답 결과 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> qestnarResultListAjax(ZValue zvl) throws Exception;

	/**
	 * 설문관리 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void saveQestnarResult(ZValue zvl, HttpServletRequest request) throws Exception;

}