package com.park.ch.user.dao;


import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.park.ch.cmn.LoginVO;
import com.park.ch.cmn.dao.CmnSupportDAO;

@Repository
public class UserDao extends CmnSupportDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(UserDao.class);

	public LoginVO userLogin(LoginVO loginVO) throws Exception { 
		return (LoginVO) selectOne("user.userLogin", loginVO);
	}
	
	public LoginVO userInfo(LoginVO loginVO) throws Exception { 
		return (LoginVO) selectOne("user.userInfo", loginVO);
	}
	
	public int idDupChk(Map<String, String> param) throws Exception { 
		return (Integer) selectCnt("user.cntId", param);
	}

	public void insertUser(Map<String, String> param) throws Exception { 
		insert("user.insertUser", param);
	}


	public void updateUser(Map<String, String> param) throws Exception { 
		update("user.updateUser", param);
		
	}

	public void deleteUser(Map<String, String> param) {
		delete("user.deleteUser", param);
		
	}

	public LoginVO userFindId(Map<String, String> param) {
		return (LoginVO) selectOne("user.userFindId", param);
	}

	public void updateUserPassword(Map<String, String> param) {
		update("user.updateUserPassword", param);
		
	}


}
