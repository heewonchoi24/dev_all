package org.ssis.pss.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface SystemService {
	
	/**
	 * 파일 사이즈 정보
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue selectFileSize(ZValue zvl) throws Exception;
	
	/**
	 * 파일 사이즈 리스트
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectFileSizeList(ZValue zvl) throws Exception;
	
	/**
	 * 파일 사이즈 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectFileSizeListCnt(ZValue zvl) throws Exception;
		
	/**
	 * 파일 사이즈 등록/수정
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	void modifyFileSize(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 파일 사이즈 전체 수정
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	void modifyAllFileSize(ZValue zvl, HttpServletRequest request) throws Exception;
}