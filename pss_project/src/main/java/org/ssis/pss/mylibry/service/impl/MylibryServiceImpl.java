package org.ssis.pss.mylibry.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

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
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.mylibry.dao.MylibryDao;
import org.ssis.pss.mylibry.service.MylibryService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class MylibryServiceImpl implements MylibryService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private MylibryDao myLibryDao;
	
	@Override
	public List<ZValue> mylibryBbsFileList(ZValue zvl) throws Exception {
		return myLibryDao.mylibryBbsFileList(zvl);
	}
	
	@Override
	public List<ZValue> mylibryBbsList(ZValue zvl) throws Exception {
		return myLibryDao.mylibryBbsList(zvl);
	}
	
	@Override
	public List<ZValue> mylibryAttachFileList(ZValue zvl) throws Exception {
		return myLibryDao.mylibryAttachFileList(zvl);
	}

	@Override
	public ZValue mylibryAttachFile(ZValue zvl) throws Exception {
		return myLibryDao.mylibryFile(zvl);
	}
	
	@Override
	public List<ZValue> mylibryBbsImg(ZValue zvl) throws Exception {
		return myLibryDao.mylibryBbsImg(zvl);
	}
	
	@Override
	public ZValue mylibryThreadInsert(ZValue zvl,  HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		ArrayList<String> fileIdList	= new ArrayList<String>();
		String uploadedFilesInfo = EgovStringUtil.nullConvert(zvl.getString("uploadedFilesInfo"));
		zvl.put("user_id", userInfo.getUserId()); 
		zvl.put("user_nm", userInfo.getUserNm()); 
		zvl.put("instt_cd", userInfo.getInsttCd());
		zvl.put("instt_nm", userInfo.getInsttNm());
		
		if("".equals(uploadedFilesInfo) != true) {
			JSONParser jsonParser = new JSONParser();
			Object obj = jsonParser.parse(uploadedFilesInfo); 
			JSONArray fileInfoArray = (JSONArray)obj; 
			for(int inx = 0; inx < fileInfoArray.size(); inx++) {
				JSONObject jsonObject = (JSONObject)fileInfoArray.get(inx);
				String fileId = (String)jsonObject.get("fileId"); 
				Boolean isSaved = Boolean.parseBoolean((String)jsonObject.get("isSaved")); 
				if(isSaved == false)
					continue;
				fileIdList.add(fileId);
			}
		}
		
		zvl.put("file_ids", fileIdList);
		
		myLibryDao.mylibryFileInsert(zvl);
		
		logger.debug("############## mylibryThreadInsert ##############");
		logger.debug(zvl);
		logger.debug("############## mylibryThreadInsert ##############");
		
		return zvl;
	}
	
	@Override
	public void mylibryFileDelete(ZValue zvl, HttpServletRequest request) throws Exception {
		String filePath = zvl.get("filePath").toString();
    	String crossuploaderFilePath = Globals.CROSSUPLOADER_FILE_PATH;
    	String deleleFilePath = crossuploaderFilePath;
    	
		deleleFilePath = crossuploaderFilePath + filePath;
 
		File temp = new File(EgovWebUtil.filePathWhiteList(deleleFilePath));

    	logger.info( "mylibryFileDelete: "+ deleleFilePath );
    	
		if (!temp.exists()) {
	    	logger.info( "mylibryFileDelete "+ deleleFilePath );
		} else {
			temp.delete();
	    	logger.info( "mylibryFileDelete "+ deleleFilePath );
		}
    	myLibryDao.mylibryFileDelete(zvl);
		
		logger.debug("############  bbsAttachFileDeleteId  ############");
		logger.debug("zvl : " + zvl);
		logger.debug("############  bbsAttachFileDeleteId  ############");
		
	}
	
	@Override
	public ZValue mylibryBsisSttusCnt(ZValue zvl) throws Exception {
		return myLibryDao.mylibryBsisSttusCnt(zvl);
	}

	@Override
	public ZValue selectMngLevelResult(ZValue zvl) throws Exception {
		return myLibryDao.selectMngLevelResult(zvl);
	}
	
}