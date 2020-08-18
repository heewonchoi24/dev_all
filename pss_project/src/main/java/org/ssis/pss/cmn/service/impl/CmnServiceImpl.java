package org.ssis.pss.cmn.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.dao.CmnDAO;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;

import egovframework.com.cmm.SessionVO;

@Service
public class CmnServiceImpl extends CmnSupportDAO implements CmnService  {
	
	 
	@Autowired 
	private CmnDAO CmnDAO;
	
	@Override
	public int retrieveCommonListCnt(ZValue zvl) throws Exception {
		return CmnDAO.retrieveCommonListCnt(zvl);
	}
	
	@Override
	public List<ZValue> retrieveCommonList(ZValue zvl) throws Exception {
		return CmnDAO.retrieveCommonList(zvl);
	}
	
	@Override
	public 	ZValue retrieveCommonDetail(ZValue zvl) throws Exception {
		return CmnDAO.retrieveCommonDetail(zvl);
	}
		
	@Override
	public void createCommonInfo(ZValue zvl) throws Exception {
		CmnDAO.createCommonInfo(zvl);
	}
	
	@Override
	public void modifyCommonInfo(ZValue zvl) throws Exception {
		CmnDAO.modifyCommonInfo(zvl);
	}
		
	@Override
	public 	void removeCommonInfo(ZValue zvl) throws Exception {
		CmnDAO.removeCommonInfo(zvl);
	}
	
	@Override
	public List<ZValue> retrieveChrgDutyList(ZValue zvl) throws Exception {
		zvl.put("uppercode", "IJ00");
		return CmnDAO.retrieveChrgDutyList(zvl);
	}
	
	@Override
	public List<ZValue> retrieveCommCdList(ZValue zvl) throws Exception {
		return CmnDAO.retrieveChrgDutyList(zvl);
	}
	
	@Override
	public List<ZValue> retrieveInstCodeList() throws Exception {
		return CmnDAO.retrieveInstCodeList();
	}
	
	@Override
	public List<ZValue> retrieveMenuList(String author_id) throws Exception {
		return CmnDAO.retrieveMenuList(author_id);
	}
	
	@Override
	public ZValue retrieveCurrentOrderNo() throws Exception {
		return CmnDAO.retrieveCurrentOrderNo();
	}
	
	@Override
	public List<ZValue> retrieveOrderNoList() throws Exception {
		return CmnDAO.retrieveOrderNoList();
	}
	
	@Override
	public String retrieveEvlPeriodCode() throws Exception {
		return CmnDAO.retrieveEvlPeriodCode();
	}
	
	@Override
	public List<ZValue> retrieveCheckItemScoreSeList(ZValue zvl) throws Exception {
		return CmnDAO.retrieveCheckItemScoreSeList(zvl);
	}
	
	@Override
	public List<ZValue> retrieveCheckItemSctnScoreList(ZValue zvl) throws Exception {
		return CmnDAO.retrieveCheckItemSctnScoreList(zvl);
	}
	
	@Override
	public List<ZValue> mainBbsNoticeList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cmn.mainBbsNoticeList");
		return CmnDAO.retrieveCommonList(zvl);
	}
	
	@Override
	public List<ZValue> mainBbsResourceList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cmn.mainBbsResourceList");
		return CmnDAO.retrieveCommonList(zvl);
	}
	
	@Override
	public List<ZValue> mainBbsIndvdlLawList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cmn.mainBbsIndvdlLawList");
		return CmnDAO.retrieveCommonList(zvl);
	}
	
	@Override
	public List<ZValue> mainYearScheduleDtlList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cmn.mainYearScheduleDtlList");
		return CmnDAO.retrieveCommonList(zvl);
	}
	
	@Override
	public List<ZValue> mainMonthlySchedule(ZValue zvl) throws Exception {
		if(!zvl.containsKey("yyyyMM")){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String yyyyMM = sdf.format(new Date());
			zvl.put("yyyyMM", yyyyMM);
		}
		zvl.put("sqlid", "cmn.mainYearSchedule");
		return CmnDAO.retrieveCommonList(zvl);
	}
	
	@Override
	public List<ZValue> retrieveAuthorList() throws Exception {
		return CmnDAO.retrieveAuthorList();
	}
	
	@Override
	public ZValue recptnMsgListCnt(ZValue zvl, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put("user_id", userInfo.getUserId());
		zvl.put("sqlid", "cmn.recptnMsgListCnt");
		
		return CmnDAO.retrieveCommonDetail(zvl);
	}
	
	@Override
	public List<ZValue> recptnMsgList(ZValue zvl, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put("user_id", userInfo.getUserId());
		zvl.put("sqlid", "cmn.recptnMsgList");
		
		return CmnDAO.retrieveCommonList(zvl);
	}
	
	@Override
	public ZValue getMenuId(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cmn.getMenuId");
		return CmnDAO.retrieveCommonDetail(zvl);
	}

	@Override
	public List<ZValue> getQestnrSeq(ZValue zvl, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put("user_id", userInfo.getUserId());
		
		zvl.put("sqlid", "cmn.getQestnrSeq");
		return CmnDAO.retrieveCommonList(zvl);
	}
	
	@Override
	public 	ZValue retrieveEvalFromTo(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cmn.evalFromTo");
		return CmnDAO.retrieveCommonDetail(zvl);
	}

	@Override
	public ZValue retrieveMaxOrderNo() throws Exception {
		return CmnDAO.retrieveMaxOrderNo();
	}

	@Override
	public List<ZValue> getAuthority(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cmn.getAuthority");
		return CmnDAO.retrieveAuthority(zvl);
	}
}