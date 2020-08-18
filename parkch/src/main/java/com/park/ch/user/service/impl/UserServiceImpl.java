package com.park.ch.user.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.park.ch.cmn.LoginVO;
import com.park.ch.user.dao.UserDao;
import com.park.ch.user.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired 
	private UserDao UserDao;

	@Override
	public LoginVO userLogin(LoginVO loginVO) throws Exception {
		LoginVO result = (LoginVO) UserDao.userLogin(loginVO);
		return result;
	}

	@Override
	public LoginVO userInfo(LoginVO loginVO) throws Exception {
		LoginVO result = (LoginVO) UserDao.userInfo(loginVO);
		return result;
	}

	@Override
	public int idDupChk(Map<String, String> param) throws Exception {
		return UserDao.idDupChk(param);
	}

	@Override
	public void updateUser(Map<String, String> param) throws Exception {
		UserDao.updateUser(param);
		
	}
	
	@Override
	public void insertUser(Map<String, String> param) throws Exception {
		UserDao.insertUser(param);
	}

	@Override
	public void deleteUser(Map<String, String> param) throws Exception {
		UserDao.deleteUser(param);
		
	}

	@Override
	public LoginVO userFindId(Map<String, String> param) throws Exception {
		LoginVO result = (LoginVO) UserDao.userFindId(param);
		return result;
	}

	@Override
	public void updateUserPassword(Map<String, String> param) throws Exception {
		UserDao.updateUserPassword(param);
		
	}

}
