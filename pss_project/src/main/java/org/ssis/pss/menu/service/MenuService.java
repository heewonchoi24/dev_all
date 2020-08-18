package org.ssis.pss.menu.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface MenuService {
	
	/**
	 * 메뉴 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectMenuList(ZValue zvl) throws Exception;
	
	/**
	 * 메뉴
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue selectMenu(ZValue zvl) throws Exception;
	
	/**
	 * 메뉴 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectMenuTotalCnt(ZValue zvl) throws Exception;
	
	/**
	 * 메뉴 등록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	void insertMenu(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 메뉴 수정
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	void updateMenu(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 메뉴 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectDistinctAuthorId(ZValue zvl) throws Exception;
	
	/**
	 * 상위 메뉴 ID
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int selectUpperMenuId(ZValue zvl) throws Exception;
	
	/**
	 * 메뉴 삭제
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	void deleteMenu(ZValue zvl, HttpServletRequest request) throws Exception;
}