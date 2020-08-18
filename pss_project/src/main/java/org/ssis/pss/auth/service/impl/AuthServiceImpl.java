package org.ssis.pss.auth.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.auth.dao.AuthDao;
import org.ssis.pss.auth.service.AuthService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class AuthServiceImpl implements AuthService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private AuthDao authDao;
	
	@Override
	public int authCntThread(ZValue zvl) throws Exception {
		return authDao.authCnt(zvl);
	}
	
	@Override
	public List<ZValue> authListThread(ZValue zvl) throws Exception {
		return authDao.authList(zvl);
	}

	@Override
	public void insertAuthList(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
    		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 

	    	int seqkey = authDao.insertAuthList(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void updateAuthList(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
    		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 

	    	authDao.updateAuthList(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void deleteAuthList(ZValue zvl, HttpServletRequest request) throws Exception {

		ArrayList seq = zvl.getArrayList("seq[]");
		
		try {
			for(int i=0; i < seq.size(); i++) {
		    	zvl.put( "authorId", seq.get(i) );

		    	authDao.deleteAuthList(zvl);
			}			    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public List<ZValue> authListThreadDetail(ZValue zvl) throws Exception {
		return authDao.authListDetail(zvl);
	}
	
	@Override
	public List<ZValue> getAuthList(ZValue zvl) throws Exception {
		return authDao.getAuthList(zvl);
	}
	
	@Override
	public void mergeAuthDetail(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		zvl.put( "user_id", userInfo.getUserId() );
		
		ArrayList menuIdArr = zvl.getArrayList("menuIdArr[]");
		String menuId = "";
		
		try {
			for(int i=0; i < menuIdArr.size(); i++) {
				
		    	zvl.setValue("menuId", String.valueOf(menuIdArr.get(i)));
		    	menuId = zvl.getValue("menuId");
		    	zvl.setValue("authRead", (zvl.getValue(menuId+"_read")));
		    	zvl.setValue("authWrite", (zvl.getValue(menuId+"_write")));
		    	zvl.setValue("authDownload", (zvl.getValue(menuId+"_download")));
		    	
		    	authDao.mergeAuthDetail(zvl);
			}			    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
}