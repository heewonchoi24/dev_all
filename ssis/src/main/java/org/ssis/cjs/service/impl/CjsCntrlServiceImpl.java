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
import org.ssis.cjs.dao.CjsCntrlDao;
import org.ssis.cjs.service.CjsCntrlService;
import org.ssis.pss.cmn.model.ZValue;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class CjsCntrlServiceImpl implements CjsCntrlService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private CjsCntrlDao cjsCntrlDao;
	
	@Override
	public List<ZValue> selectCntrlList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cjsCntrl.selectCntrlList");
		return cjsCntrlDao.cntrlCommonList(zvl);
	}
	
	@Override
	public int selectCntrlCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cjsCntrl.selectCntrlCnt");
		return cjsCntrlDao.cntrlCommonCnt(zvl);
	}
	
	@Override
	public List<ZValue> selectCntrlFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cjsCntrl.selectCntrlFileList");
		return cjsCntrlDao.cntrlCommonList(zvl);
	}
	
	@Override
	public void updateCntrlStatus(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put("sqlid", "cjsCntrl.updateCntrlStatus");
		zvl.put("updtId", userInfo.getUserId());
		
		cjsCntrlDao.cntrlCommonUpdate(zvl);
	}
	
	@Override
	public ZValue selectCntrl(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cjsCntrl.selectCntrl");
		return cjsCntrlDao.cntrlCommonSelect(zvl);
	}
	
	@Override
	public void createCntrlStatus(ZValue zvl,  HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		ArrayList<String> fileIdList	= new ArrayList<String>();
		String uploadedFilesInfo = EgovStringUtil.nullConvert(zvl.getString("uploadedFilesInfo"));
		String insttCd = userInfo.getInsttCd();
		
		zvl.put("registId", userInfo.getUserId());
		
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
		String atchmnflId = EgovStringUtil.nullConvert(zvl.getString("atchmnfl_id"));
		if("".equals(atchmnflId)) {
			atchmnflId = (fileIdList.size() > 0) ? UUID.randomUUID().toString() : "";
		}
		zvl.put("insttCd", insttCd);
		zvl.put("atchmnfl_id", atchmnflId);
		zvl.put("file_ids", (fileIdList.size() > 0) ? fileIdList : "");
		
		zvl.put("sqlid", "cjsCntrl.selectCntrlCnt");
		int cnt = cjsCntrlDao.cntrlCommonCnt(zvl);
		
		if(0 == cnt) {
			zvl.put("sqlid", "cjsCntrl.insertCntrl");
			cjsCntrlDao.cntrlCommonInsert(zvl);
		} else {
			zvl.put("sqlid", "cjsCntrl.updateCntrlFile");
			zvl.put("updtId", userInfo.getUserId());
			cjsCntrlDao.cntrlCommonUpdate(zvl);
		}
	}
	
	@Override
	public void deleteCntrlFile(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put("insttCd", userInfo.getInsttCd());

		ArrayList atchmnflId = zvl.getArrayList("atchmnfl_id[]");
		ArrayList fileId = zvl.getArrayList("file_id[]");
		ArrayList filePath = zvl.getArrayList("filePath[]");
		
    	String crossuploaderFilePath = Globals.CROSSUPLOADER_FILE_PATH;

    	String deleleFilePath = crossuploaderFilePath;

		for(int i=0; i < fileId.size(); i++) {
			deleleFilePath = crossuploaderFilePath + filePath.get(i).toString();
 
			File temp = new File(EgovWebUtil.filePathWhiteList(deleleFilePath));

			if (!temp.exists()) {
		    	logger.info( "deleteCntrlFile:deleleFilePath:NotFound "+ deleleFilePath );
			} else {
				temp.delete();
		    	logger.info( "deleteCntrlFile:deleleFilePath:Deleted "+ deleleFilePath );
			}

	    	zvl.put( "atchmnfl_id", atchmnflId.get(i).toString() );
	    	zvl.put( "file_id",    fileId.get(i).toString() );
	    	
	    	zvl.put("sqlid", "cjsCntrl.deleteCntrlAttachFile");
	    	cjsCntrlDao.cntrlCommonDelete(zvl);
		}
		
		int cnt = cjsCntrlDao.selectCnt("cjsCntrl.selectCntrlAttachFileCnt", zvl);
		if(cnt == 0) {
			zvl.put("sqlid", "cjsCntrl.deleteCntrl");
			cjsCntrlDao.cntrlCommonDelete(zvl);
		}
	}
}