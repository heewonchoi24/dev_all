package org.ssis.pss.qestnar.service.impl;

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
import org.ssis.pss.qestnar.dao.QestnarDao;
import org.ssis.pss.qestnar.service.QestnarService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class QestnarServiceImpl implements QestnarService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private QestnarDao qestnarDao;
	
	@Override
	public int qestnarCntThread(ZValue zvl) throws Exception {
		return qestnarDao.qestnarCnt(zvl);
	}
	
	@Override
	public List<ZValue> qestnarListThread(ZValue zvl) throws Exception {
		return qestnarDao.qestnarList(zvl);
	}

	@Override
	public void deleteQestnarList(ZValue zvl, HttpServletRequest request) throws Exception {

		ArrayList seq = zvl.getArrayList("seq[]");
		
		try {
			for(int i=0; i < seq.size(); i++) {
		    	zvl.put( "qestnarSeq", seq.get(i) );

		    	qestnarDao.deleteQestnarItem(zvl);
		    	qestnarDao.deleteQestnarList(zvl);
			}			    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public ZValue selectQestnar(ZValue zvl) throws Exception {
		return qestnarDao.selectQestnar(zvl);
	}

	@Override
	public List<ZValue> selectItemList(ZValue zvl) throws Exception {
		return qestnarDao.selectItemList(zvl);
	}

	@Override
	public List<ZValue> selectDetailList(ZValue zvl) throws Exception {
		return qestnarDao.selectDetailList(zvl);
	}

	@Override
	public void insertQestnarList(ZValue zvl, HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
    		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
    		
    		ArrayList itemCnArr        = zvl.getArrayList("item[]");
    		ArrayList itemDetailCnArr  = zvl.getArrayList("itemDetail[]");
    		ArrayList qesitmCdArr      = zvl.getArrayList("qesitmCd[]");
    		
    		qestnarDao.insertQestnarList(zvl);

	    	for(int i=0; i < itemCnArr.size(); i++) {
	    		zvl.put("qestnarSeq", zvl.getValue("seq"));
	    		zvl.put("qesitmCn"  , itemCnArr.get(i).toString());
	    		zvl.put("qesitmNo"  , i+1);
	    		zvl.put("qesitmCd"  , qesitmCdArr.get(i).toString());
	    		
	    		qestnarDao.insertQestnarItem(zvl); 
	    		
	    		if("QQ01".equals(qesitmCdArr.get(i).toString())) {
		    		String itemDetailCn =itemDetailCnArr.get(i).toString();
		    		String[]  detailNo = itemDetailCn.split(",");
		    
		    		for(int j=0; j < detailNo.length ; j++) {
			    		zvl.put("qesitmSeq" , zvl.getValue("seqItem"));
			    		zvl.put("qesitmDetailNo"  , j+1);
			    		zvl.put("qesitmDetailCn"  , detailNo[j]);
		    			qestnarDao.insertQestnarItemDetail(zvl);
		    		}
	    		}
	    	}	    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void updateQestnarList(ZValue zvl, HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
    		ArrayList itemCnArr        = zvl.getArrayList("item[]");
    		ArrayList itemDetailCnArr  = zvl.getArrayList("itemDetail[]");
    		ArrayList qesitmCdArr      = zvl.getArrayList("qesitmCd[]");
   		
    		qestnarDao.updateQestnarList(zvl);

    		qestnarDao.deleteQestnarItem(zvl);

	    	for(int i=0; i < itemCnArr.size(); i++) {
	    		zvl.put("qesitmCn"  , itemCnArr.get(i).toString());
	    		zvl.put("qesitmNo"  , i+1);
	    		zvl.put("qesitmCd"  , qesitmCdArr.get(i).toString());
	    		
	    		qestnarDao.insertQestnarItem(zvl); 
	    		
	    		if("QQ01".equals(qesitmCdArr.get(i).toString())) {
		    		String itemDetailCn =itemDetailCnArr.get(i).toString();
		    		String[]  detailNo = itemDetailCn.split(",");
		    
		    		for(int j=0; j < detailNo.length ; j++) {
			    		zvl.put("qesitmSeq" , zvl.getValue("seqItem"));
			    		zvl.put("qesitmDetailNo"  , j+1);
			    		zvl.put("qesitmDetailCn"  , detailNo[j]);
		    			qestnarDao.insertQestnarItemDetail(zvl);
		    		}
	    		}
	    	}	    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Override
	public void updateQestnarList2(ZValue zvl, HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
    		qestnarDao.updateQestnarList(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public List<ZValue> qestnarResultListAjax(ZValue zvl) throws Exception {
		return qestnarDao.qestnarResultList(zvl);
	}

	@Override
	public void saveQestnarResult(ZValue zvl, HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
    		zvl.put( "user_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
    		
    		ArrayList itemSeqArr  = zvl.getArrayList("qesitmSeq[]");
    		ArrayList itemAnsArr  = zvl.getArrayList("qesitmAns[]");
    		ArrayList itemCdArr   = zvl.getArrayList("qesitmCd[]");
    		
 	    	for(int i=1; i <= itemSeqArr.size(); i++) {
	    		zvl.put("qesitmSeq"    , itemSeqArr.get(i).toString());
	    		if("QQ01".equals(itemCdArr.get(i).toString())) {
	    			zvl.put("objctAmswer"  , itemAnsArr.get(i).toString());
	    			zvl.put("sbjctAmswer"  , "");
	    		} else {
	    			zvl.put("objctAmswer"  , "");
	    			zvl.put("sbjctAmswer"  , itemAnsArr.get(i).toString());
	    		}
	    		qestnarDao.insertQestnarResult(zvl); 	    		
	    	}	    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

}