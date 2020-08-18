package org.ssis.pss.order.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class OrderDao extends CmnSupportDAO {

	/**
	 * 차수리스트 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> orderList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("order.listThread", zvl);
	}

	/**
	 * 차수리스트 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue selectOrder(ZValue zvl) throws Exception {
		return (ZValue) selectOne("order.selectOrderNo", zvl);
	}

	/**
	 * 차수리스트 갯수 조회 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int orderCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("order.cntThread", zvl);
	}
	

	/**
	 * 차수리스트 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertOrderList(ZValue zvl) throws Exception {
		return (Integer) insert("order.registThread", zvl);
	}

	/**
	 * 차수리스트 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateOrderList(ZValue zvl) throws Exception {
		update("order.updateOrder", zvl);
	}

	/**
	 * 차수리스트 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteOrderList(ZValue zvl) throws Exception {
		delete("order.deleteOrder", zvl);
	}

	/**
	 * 일정관리 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectFyerSchdulList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("order.selectFyerSchdulList", zvl);
	}

	/**
	 * 일정관리
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue selectFyerSchdul(ZValue zvl) throws Exception {
		return (ZValue) selectOne("order.selectFyerSchdul", zvl);
	}
	
	/**
	 * 일정관리 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertFyerSchdul(ZValue zvl) throws Exception {
		return (Integer) insert("order.insertFyerSchdul", zvl);
	}
	
	/**
	 * 차수리스트 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateFyerSchdul(ZValue zvl) throws Exception {
		update("order.updateFyerSchdul", zvl);
	}

	/**
	 * 차수리스트 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteFyerSchdul(ZValue zvl) throws Exception {
		delete("order.deleteFyerSchdul", zvl);
	}
}

