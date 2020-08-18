package org.ssis.pss.order.service.impl;

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
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.order.dao.OrderDao;
import org.ssis.pss.order.service.OrderService;

import egovframework.com.cmm.SessionVO;

@Service
public class OrderServiceImpl implements OrderService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private OrderDao orderDao;
	
	@Autowired
	private CmnService cmnService;
	
	@Override
	public int orderCntThread(ZValue zvl) throws Exception {
		return orderDao.orderCnt(zvl);
	}
	
	@Override
	public List<ZValue> orderListThread(ZValue zvl) throws Exception {
		return orderDao.orderList(zvl);
	}

	@Override
	public ZValue selectOrderThread(ZValue zvl) throws Exception {
		return orderDao.selectOrder(zvl);
	}
	
	@Override
	public void insertOrderList(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
    		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 

	    	int seqkey = orderDao.insertOrderList(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void updateOrderList(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
    		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 

	    	orderDao.updateOrderList(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrderList(ZValue zvl, HttpServletRequest request) throws Exception {

		ArrayList seq = zvl.getArrayList("seq[]");
		
		try {
			for(int i=0; i < seq.size(); i++) {
		    	zvl.put( "orderorId", seq.get(i) );

		    	orderDao.deleteOrderList(zvl);
			}			    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Override
	public List<ZValue> selectFyerSchdulList(ZValue zvl) throws Exception {
		return orderDao.selectFyerSchdulList(zvl);
	}
	
	@Override
	public void modifyFyerSchdul(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		zvl.put("registId", userInfo.getUserId());
		zvl.put("updtId", userInfo.getUserId());

		// 선택된 차수가 없는경우 현재 차수
		if(StringUtils.isEmpty(zvl.getValue("orderNo"))) {
			ZValue currentOrderNo = cmnService.retrieveCurrentOrderNo();
			zvl.put("yyyy", currentOrderNo.getValue("orderNo"));
		} else {
			zvl.put("yyyy", zvl.getValue("orderNo"));
		}
		
		if(StringUtils.isEmpty(zvl.getValue("fyerSchdulSeq"))) {
			orderDao.insertFyerSchdul(zvl);	
		} else {
			zvl.put("seq", zvl.getValue("fyerSchdulSeq"));	
			orderDao.updateFyerSchdul(zvl);
		}
	}
	
	@Override
	public void deleteFyerSchdul(ZValue zvl, HttpServletRequest request) throws Exception {
		
		ArrayList seqList = zvl.getArrayList("seq[]");
		
		for(int i=0; i < seqList.size(); i++) {
			
			String seq = seqList.get(i).toString();
			
			ZValue iZvl = new ZValue();
			
			iZvl.put("seq", seq);
			
			orderDao.deleteFyerSchdul(iZvl);
		}
	}
}