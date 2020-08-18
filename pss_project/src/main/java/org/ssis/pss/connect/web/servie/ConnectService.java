package org.ssis.pss.connect.web.servie;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface ConnectService {
	
	/**
	 * 계정관리 - 접속이력 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> connectHistDataAdminList(ZValue zvl) throws Exception;

	/**
	 * 계정관리 - 접속이력 총 갯수 조회
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int connectHistDataAdminCnt(ZValue zvl) throws Exception;

	/**
	 * 계정관리 - 접속이력 상세 조회
	 * @param zvl
	 * @param request
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> connectViewThread(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 계정관리 - 접속URL의 메뉴ID 조회
	 * @param zvl
	 * @return String
	 * @throws Exception
	 */
	String getConnectHistDataAdminMenuId(ZValue zvl) throws Exception;
}