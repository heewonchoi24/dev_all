package org.ssis.pss.menu.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.menu.dao.MenuDao;
import org.ssis.pss.menu.service.MenuService;

import egovframework.com.cmm.SessionVO;

@Service
public class MenuServiceImpl implements MenuService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private MenuDao menuDao;
	
	@Override
	public List<ZValue> selectMenuList(ZValue zvl) throws Exception {
		return menuDao.selectMenuList(zvl);
	}

	@Override
	public ZValue selectMenu(ZValue zvl) throws Exception {
		return menuDao.selectMenu(zvl);
	}
	
	@Override
	public int selectMenuTotalCnt(ZValue zvl) throws Exception {
		return menuDao.selectMenuTotalCnt(zvl);
	}
	
	@Override
	public List<ZValue> selectDistinctAuthorId(ZValue zvl) throws Exception {
		return menuDao.selectDistinctAuthorId(zvl);
	}
	
	@Override
	public void insertMenu(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		String menuNm = zvl.getValue("menuNm");
		String description = zvl.getValue("description");
		String url = zvl.getValue("url");
		String level = zvl.getValue("level");
		String indictYn = zvl.getValue("indictYn");
		String upperMenuId = zvl.getValue("upperMenuId");
		String menuId = "";
		
		ArrayList menuIdList = zvl.getArrayList("menuId[]");
		ArrayList authList = zvl.getArrayList("auth[]");
		
		// 메뉴 등록/수정
		for(int i=0; i < menuIdList.size(); i++) {
			
			String id = menuIdList.get(i).toString();
			
			ZValue iZvl = new ZValue();
			iZvl.put("outputOrdr", i+1);
			iZvl.put("registId", userInfo.getUserId());
			if(StringUtils.isEmpty(id)) {
				iZvl.put("menuNm", menuNm);
				iZvl.put("description", description);
				iZvl.put("url", url);
				iZvl.put("indictYn", indictYn);
				iZvl.put("upperMenuId", upperMenuId);
				menuDao.insertMenu(iZvl);
				menuId = iZvl.getValue("menuId");
			} else {
				iZvl.put("menuId",id);
				menuDao.updateMenu(iZvl);
			}
		}
		
		// 메뉴 권한 메핑 등록
		for(int i=0; i < authList.size(); i++) {
			String auth = authList.get(i).toString();
			ZValue iZvl = new ZValue();
			iZvl.put("registId", userInfo.getUserId());
			iZvl.put("menuId", menuId);
			iZvl.put("authorId", auth);
			menuDao.insertAuthorMenuMap(iZvl);
		}
	}
	
	@Override
	public void updateMenu(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		String menuNm = zvl.getValue("menuNm");
		String description = zvl.getValue("description");
		String url = zvl.getValue("url");
		String indictYn = zvl.getValue("indictYn");
		String menuId = zvl.getValue("menuId");
		
		ArrayList menuIdList = zvl.getArrayList("menuIdList[]");
		ArrayList authList = zvl.getArrayList("auth[]");
		
		// 메뉴 수정
		for(int i=0; i < menuIdList.size(); i++) {
			
			String id = menuIdList.get(i).toString();
			
			ZValue iZvl = new ZValue();
			iZvl.put("outputOrdr", i+1);
			iZvl.put("registId", userInfo.getUserId());
			iZvl.put("menuId", id);
			if(menuId.equals(id)) {
				iZvl.put("menuNm", menuNm);
				iZvl.put("description", description);
				iZvl.put("url", url);
				iZvl.put("indictYn", indictYn);
			}
			menuDao.updateMenu(iZvl);
		}
		/*menuDao.deleteAuthorMenuMap(zvl);
		
		// 메뉴 권한 메핑 등록
		for(int i=0; i < authList.size(); i++) {
			String auth = authList.get(i).toString();
			ZValue iZvl = new ZValue();
			iZvl.put("registId", userInfo.getUserId());
			iZvl.put("menuId", menuId);
			iZvl.put("authorId", auth);
			menuDao.insertAuthorMenuMap(iZvl);
		}*/
	}
	
	@Override
	public void deleteMenu(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put("registId", userInfo.getUserId());
		
		menuDao.deleteMenu(zvl);
	}
	
	@Override
	public int selectUpperMenuId(ZValue zvl) throws Exception {
		return menuDao.selectUpperMenuId(zvl);
	}
}