package com.park.ch.user.service;

import java.util.Map;

import com.park.ch.cmn.LoginVO;

public interface UserService {

	LoginVO userInfo(LoginVO loginVO) throws Exception;

	LoginVO userLogin(LoginVO loginVO) throws Exception;

	void insertUser(Map<String, String> param) throws Exception;

	int idDupChk(Map<String, String> param) throws Exception;

	void updateUser(Map<String, String> param) throws Exception;

	void deleteUser(Map<String, String> param) throws Exception;

	LoginVO userFindId(Map<String, String> param) throws Exception;

	void updateUserPassword(Map<String, String> param) throws Exception;

}
