package org.ssis.pss.org.service.impl;

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
import org.ssis.pss.org.dao.OrgDao;
import org.ssis.pss.org.service.OrgService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class OrgServiceImpl implements OrgService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private OrgDao orgDao;
	
	@Override
	public int orgCntThread(ZValue zvl) throws Exception {
		return orgDao.orgCnt(zvl);
	}
	
	@Override
	public List<ZValue> orgListThread(ZValue zvl) throws Exception {
		return orgDao.orgList(zvl);
	}

	@Override
	public void insertOrgList(ZValue zvl, HttpServletRequest request) throws Exception {

		try {
 	    	int seqkey = orgDao.insertOrgList(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void updateOrgList(ZValue zvl, HttpServletRequest request) throws Exception {
		
		try {
 
	    	orgDao.updateOrgList(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrgList(ZValue zvl, HttpServletRequest request) throws Exception {

		ArrayList seq = zvl.getArrayList("seq[]");
		
		try {
			for(int i=0; i < seq.size(); i++) {
		    	zvl.put( "insttCd", seq.get(i) );
		    	orgDao.deleteOrgList(zvl);
			}			    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public List<ZValue> orgInsttClCdList(ZValue zvl) throws Exception {
		return orgDao.orgInsttClCdList(zvl);
	}

	@Override
	public List<ZValue> orgInsttList(ZValue zvl) throws Exception {
		return orgDao.orgInsttList(zvl);
	}

	@Override
	public List<ZValue> orgInsttAllList(ZValue zvl) throws Exception {
		return orgDao.orgInsttAllList(zvl);
	}

	@Override
	public int orgHistCntThread(ZValue zvl) throws Exception {
		return orgDao.orgHistCnt(zvl);
	}
	
	@Override
	public List<ZValue> orgHistListThread(ZValue zvl) throws Exception {
		return orgDao.orgHistList(zvl);
	}

	@Override
	public void insertOrgHist(ZValue zvl, HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
    		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
    		
    		ArrayList insttDnCd  = zvl.getArrayList("insttDnCd[]");

    		ZValue orgInfo = orgDao.orgInfo(zvl);
	    	orgDao.insertOrgHist(orgInfo);

	    	for(int i=0; i < insttDnCd.size(); i++) {
	    		ZValue dwOgrInfo = new ZValue();
	    		dwOgrInfo.put("insttCd", insttDnCd.get(i).toString());
	    		orgInfo = orgDao.orgInfo(dwOgrInfo);	
	    		orgInfo.put("upperInsttCd", zvl.getValue("insttCd"));
	    		orgInfo.put( "user_id", userInfo.getUserId() );
	    		orgDao.insertOrgHist(orgInfo); 
	    		orgDao.updateDownOrg(orgInfo);
	    	}	    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void updateOrgHist(ZValue zvl, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
    		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
    		
    		ArrayList insttDnCd  = zvl.getArrayList("insttDnCd[]");

    		ZValue orgInfo = new ZValue();
 
    	    for(int i=0; i < insttDnCd.size(); i++) {
    	    		ZValue dwOgrInfo = new ZValue();
    	    		dwOgrInfo.put("insttCd", insttDnCd.get(i).toString()); // 입력된 기관코드들 
    	    		orgInfo = orgDao.orgInfo(dwOgrInfo); // 하위기관 정보 Insert용
    	    		
    	    		if("".equals(orgInfo.getValue("dwUpperInsttCd"))) {
	    	    		orgInfo.put("upperInsttCd", zvl.getValue("insttCd"));
	    	    		orgInfo.put( "user_id", userInfo.getUserId() );
	    	    		orgDao.insertOrgHist(orgInfo); 
	    	    		orgDao.updateDownOrg(orgInfo);
	    	    	}
    	    }	    	   			

	    	orgDao.updateOrgHist(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrgHist(ZValue zvl, HttpServletRequest request) throws Exception {

		ArrayList seq = zvl.getArrayList("seq[]");
		
		try {
			for(int i=0; i < seq.size(); i++) {
		    	zvl.put( "insttCd", seq.get(i) );

		    	ZValue orgInfo = orgDao.orgInfo(zvl);
		    	if("".equals(orgInfo.getValue("upperInsttCd"))){
		    		String tmpOrg[] =   orgInfo.getValue("insttCdDw").split(",");
		    		
		    		for(int j=0;j < tmpOrg.length; j ++){
		    			ZValue tmpOrgCd = new ZValue();
		    			tmpOrgCd.put("insttCd", tmpOrg[j]);
		    			orgDao.updateOrgMastr(zvl);
		    			orgDao.deleteOrgHist(tmpOrgCd);
		    		}
		    	}		    	
		    	orgDao.deleteOrgHist(zvl);
			}			    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Override
	public ZValue selectOrgInfo(ZValue zvl) throws Exception {
		return orgDao.selectOrgInfo(zvl);
	}
}