package org.ssis.cjs.service.impl;

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
import org.ssis.cjs.dao.CjsBbsDao;
import org.ssis.cjs.service.CjsBbsService;
import org.ssis.pss.cmn.model.ZValue;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class CjsBbsServiceImpl implements CjsBbsService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private CjsBbsDao cjsBbsDao;
	
	@Override
	public List<ZValue> bbsList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cjsBbs.bbsList");
		return cjsBbsDao.bbsCommonList(zvl);
	}
	
	@Override
	public ZValue bbsView(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cjsBbs.bbsView");
		return cjsBbsDao.bbsCommonSelect(zvl);
	}
	
	@Override
	public int bbsListCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cjsBbs.bbsListCnt");
		return cjsBbsDao.bbsCommonCnt(zvl);
	}
	
	@Override
	public List<ZValue> bbsAttachFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cjsBbs.bbsAttachFileList");
		return cjsBbsDao.bbsCommonList(zvl);
	}
	
	@Override
	public ZValue bbsThreadInsert(ZValue zvl,  HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		ArrayList<String> fileIdList	= new ArrayList<String>();
		String uploadedFilesInfo = EgovStringUtil.nullConvert(zvl.getString("uploadedFilesInfo"));
		String seq = zvl.getValue("seq");
		
		zvl.put("registId", userInfo.getUserId()); 
		
		if(uploadedFilesInfo.length() > 0) {
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
				
				String atchmnflId = EgovStringUtil.nullConvert(zvl.getString("atchmnfl_id"));
				
				logger.debug("############## 1bbsatchmnfl_id ##############");
				logger.debug(atchmnflId);
				logger.debug("############## bbsatchmnfl_id ##############");	
				
				if("".equals(atchmnflId)) {
					atchmnflId = (fileIdList.size() > 0) ? UUID.randomUUID().toString() : "";
				}
				zvl.put("atchmnfl_id", atchmnflId);
				zvl.put("file_ids", fileIdList);
	
			}
			logger.debug("############## uploadedFilesInfo.length() > 0 ##############");
			logger.debug("uploadedFilesInfo.length() > 0");
			logger.debug("############## uploadedFilesInfo.length() > 0 ##############");		
	
		}

		if("".equals(seq)) {
			zvl.put("sqlid", "cjsBbs.bbsThreadInsert");
			cjsBbsDao.bbsCommonInsert(zvl);
			logger.debug("############## bbsCommonInsertSelectKey ##############");
			logger.debug(zvl);
			logger.debug("############## bbsCommonInsertSelectKey ##############");
		} else {
			zvl.put("sqlid", "cjsBbs.bbsThreadUpdate");
			cjsBbsDao.bbsCommonUpdate(zvl);
		}
		
		return zvl;
	}
	
	@Override
	public void bbsFileDelete(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		ArrayList atchmnflId = zvl.getArrayList("atchmnfl_id[]");
		ArrayList fileId = zvl.getArrayList("file_id[]");
		ArrayList filePath = zvl.getArrayList("filePath[]");
		
    	String crossuploaderFilePath = Globals.CROSSUPLOADER_FILE_PATH;

    	String deleleFilePath = crossuploaderFilePath;

		for(int i=0; i < fileId.size(); i++) {
			deleleFilePath = crossuploaderFilePath + filePath.get(i).toString();
 
			File temp = new File(EgovWebUtil.filePathWhiteList(deleleFilePath));

			if (!temp.exists()) {
		    	logger.info( "bbsFileDelete:deleleFilePath:NotFound "+ deleleFilePath );
			} else {
				temp.delete();
		    	logger.info( "bbsFileDelete:deleleFilePath:Deleted "+ deleleFilePath );
			}

	    	zvl.put( "atchmnfl_id", atchmnflId.get(i).toString() );
	    	zvl.put( "file_id",    fileId.get(i).toString() );
	    	
	    	zvl.put("sqlid", "cjsBbs.bbsAttachFileDelete");
	    	cjsBbsDao.bbsCommonDelete(zvl);
		}
		
		int cnt = cjsBbsDao.selectCnt("cjsBbs.bbsAttachFileCnt", zvl);
		if(cnt == 0) {
			zvl.put("sqlid", "cjsBbs.bbsAttachFileDeleteId");
			cjsBbsDao.bbsCommonUpdate(zvl);
		}
	}
	
	@Override
	public void bbsDelete(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		ArrayList atchmnflId = zvl.getArrayList("atchmnfl_id[]");
		ArrayList fileId = zvl.getArrayList("file_id[]");
		ArrayList filePath = zvl.getArrayList("filePath[]");
		
    	String crossuploaderFilePath = Globals.CROSSUPLOADER_FILE_PATH;

    	String deleleFilePath = crossuploaderFilePath;

		for(int i=0; i < fileId.size(); i++) {
			deleleFilePath = crossuploaderFilePath + filePath.get(i).toString();
 
			File temp = new File(EgovWebUtil.filePathWhiteList(deleleFilePath));

			if (!temp.exists()) {
		    	logger.info( "bbsFileDelete:deleleFilePath:NotFound "+ deleleFilePath );
			} else {
				temp.delete();
		    	logger.info( "bbsFileDelete:deleleFilePath:Deleted "+ deleleFilePath );
			}

	    	zvl.put( "atchmnfl_id", atchmnflId.get(i).toString() );
	    	zvl.put( "file_id",    fileId.get(i).toString() );
	    	
	    	zvl.put("sqlid", "cjsBbs.bbsAttachFileDelete");
	    	cjsBbsDao.bbsCommonDelete(zvl);
		}
		zvl.put("sqlid", "cjsBbs.bbsDelete");
		cjsBbsDao.bbsCommonDelete(zvl);
	}
	
	@Override
	public void bbsCountUpdate(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cjsBbs.bbsCountUpdate");
		cjsBbsDao.bbsCommonUpdate(zvl);
	}
	
	@Override
	public List<ZValue> userList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cjsBbs.userList");
		return cjsBbsDao.bbsCommonList(zvl);
	}
}