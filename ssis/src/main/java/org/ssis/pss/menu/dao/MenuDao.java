package org.ssis.pss.menu.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class MenuDao extends CmnSupportDAO {
	
	/**
	 * 메뉴 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectMenuList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("menu.selectMenuList", zvl);
	}
	
	/**
	 * 메뉴
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue selectMenu(ZValue zvl) throws Exception {
		return (ZValue) selectOne("menu.selectMenu", zvl);
	}
	
	/**
	 * 메뉴 카운트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public int selectMenuTotalCnt(ZValue zvl) throws Exception {
		return selectCnt("menu.selectMenuTotalCnt", zvl);
	}
	
	/**
	 * 메뉴 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public int insertMenu(ZValue zvl) throws Exception {
		return (Integer) insert("menu.insertMenu", zvl);
	}
	
	/**
	 * 메뉴 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public int updateMenu(ZValue zvl) throws Exception {
		return (Integer) update("menu.updateMenu", zvl);
	}
	
	/**
	 * 메뉴 권한 메핑 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public int insertAuthorMenuMap(ZValue zvl) throws Exception {
		return (Integer) insert("menu.insertAuthorMenuMap", zvl);
	}
	
	/**
	 * 권한 ID 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectDistinctAuthorId(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("menu.selectDistinctAuthorId", zvl);
	}
	
	/**
	 * 상위 메뉴 ID
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public int selectUpperMenuId(ZValue zvl) throws Exception {
		return selectCnt("menu.selectUpperMenuId", zvl);
	}
	
	/**
	 * 권한 메뉴 매핑 삭제
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void deleteAuthorMenuMap(ZValue zvl) throws Exception {
		delete("menu.deleteAuthorMenuMap", zvl);
	}
	
	/**
	 * 메뉴 삭제
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void deleteMenu(ZValue zvl) throws Exception {
		update("menu.deleteMenu", zvl);
	}
}
