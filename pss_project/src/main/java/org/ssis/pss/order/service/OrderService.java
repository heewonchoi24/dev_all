package org.ssis.pss.order.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface OrderService {
	
	/**
	 * 차수 갯수 조회
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	int orderCntThread(ZValue zvl) throws Exception;
	
	/**
	 * 차수 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> orderListThread(ZValue zvl) throws Exception;
	
	/**
	 * 차수 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	ZValue selectOrderThread(ZValue zvl) throws Exception;

	/**
	 * 권한관리 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void insertOrderList(ZValue zvl, HttpServletRequest request) throws Exception;

	/**
	 * 차수관리 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void updateOrderList(ZValue zvl, HttpServletRequest request) throws Exception;
	/**
	 * 차수관리 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void deleteOrderList(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 일정관리 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> selectFyerSchdulList(ZValue zvl) throws Exception;

	/**
	 * 일정관리 등록 / 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void modifyFyerSchdul(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 일정관리 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	void deleteFyerSchdul(ZValue zvl, HttpServletRequest request) throws Exception;
}