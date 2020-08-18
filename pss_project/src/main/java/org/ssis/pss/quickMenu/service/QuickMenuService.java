package org.ssis.pss.quickMenu.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;

public interface QuickMenuService {

	/**
	 * 컨텐츠 관리 - 퀵메뉴 관리 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> quickMenuList(ZValue zvl) throws Exception;
	
	/**
	 * 컨텐츠 관리 - 퀵메뉴 관리 등록/수정
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void quickMenuRegistThread(ZValue zvl, HttpServletRequest request) throws Exception;

}
