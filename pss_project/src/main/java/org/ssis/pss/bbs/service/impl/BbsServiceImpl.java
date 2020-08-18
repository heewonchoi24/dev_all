package org.ssis.pss.bbs.service.impl;

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
import org.ssis.pss.bbs.dao.BbsDao;
import org.ssis.pss.bbs.service.BbsService;
import org.ssis.pss.cmn.model.ZValue;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class BbsServiceImpl implements BbsService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private BbsDao bbsDao;
	
	@Override
	public ZValue bbsNm(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsNm");
		return bbsDao.bbsCommonSelect(zvl);
	}
	
	@Override
	public List<ZValue> bbsList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsList");
		return bbsDao.bbsCommonList(zvl);
	}
	
	@Override
	public ZValue bbsView(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsView");
		return bbsDao.bbsCommonSelect(zvl);
	}
	
	@Override
	public ZValue bbsType(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsType");
		return bbsDao.bbsCommonSelect(zvl);
	}
	
	@Override
	public void deleteThread(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsDeleteThread");
		bbsDao.bbsCommonUpdate(zvl);
	}
	
	@Override
	public int bbsListCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsListCnt");
		return bbsDao.bbsCommonCnt(zvl);
	}
	
	@Override
	public void bbsViewCntIncrease(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsViewCntIncrease");
		bbsDao.bbsCommonUpdate(zvl);
	}
	
	@Override
	public List<ZValue> bbsAttachFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsAttachFileList");
		return bbsDao.bbsCommonList(zvl);
	}
	
	@Override
	public ZValue bbsThreadInsert(ZValue zvl,  HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		ArrayList<String> fileIdList	= new ArrayList<String>();
		String uploadedFilesInfo = EgovStringUtil.nullConvert(zvl.getString("uploadedFilesInfo"));
		String bbsSeq = zvl.getValue("bbsSeq");
		
		zvl.put("user_id", userInfo.getUserId()); 
		
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
		
		String atchmnflId = (fileIdList.size() > 0) ? UUID.randomUUID().toString() : "";
		zvl.put("atchmnfl_id", atchmnflId);
		zvl.put("file_ids", fileIdList);
		
		if("".equals(bbsSeq)) {
			zvl.put("sqlid", "bbs.bbsThreadFileInsert");
			bbsDao.bbsCommonInsert(zvl);
			logger.debug("############## bbsCommonInsertSelectKey ##############");
			logger.debug(zvl);
			logger.debug("############## bbsCommonInsertSelectKey ##############");
		} else {
			zvl.put("sqlid", "bbs.bbsThreadFileUpdate");
			bbsDao.bbsCommonUpdate(zvl);
		}
		
		return zvl;
	}
	
	@Override
	public void bbsThreadUpdate(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		zvl.put("user_id", userInfo.getUserId()); 
		
		ArrayList<String> ufileIdList	= new ArrayList<String>();
		ArrayList<String> fileIdList	= new ArrayList<String>();

		String atchmnfl_id = EgovStringUtil.nullConvert( zvl.getString( "atchmnfl_id" ) );  
		
		String modifiedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "modifiedFilesInfo" ) );
		String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );

		if( "".equals( uploadedFilesInfo ) != true ) {
			JSONParser jsonParser = new JSONParser();
			Object obj = jsonParser.parse( uploadedFilesInfo ); 
			JSONArray fileInfoArray = ( JSONArray )obj; 
			for( int inx = 0; inx < fileInfoArray.size(); inx++ ) {
				JSONObject jsonObject = (JSONObject)fileInfoArray.get( inx );
				String fileId = ( String )jsonObject.get( "fileId" ); 
				fileIdList.add( fileId );
			}
		}
    	logger.debug( "updateMngLevelRes:: fileIdList {{"+ ( ( fileIdList == null ) ? "Null" : fileIdList.toString() ) +"}}" );
    	if( "".equals( atchmnfl_id ) ) {
    		atchmnfl_id = ( ( ufileIdList.size() > 0 ) || ( fileIdList.size() > 0 ) ) ? UUID.randomUUID().toString() : atchmnfl_id;
    	}
    	zvl.put( "atchmnfl_id",	atchmnfl_id );
    	zvl.put( "ufile_ids",	ufileIdList );
		zvl.put( "file_ids",	fileIdList );
		zvl.put("sqlid", "bbs.bbsThreadFileUpdate");

		logger.debug("############## bbsFileUpdate zvl ##############");
		logger.debug(zvl);
		logger.debug("############## bbsFileUpdate zvl ##############");
		
   		bbsDao.bbsCommonUpdate(zvl);
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

	    	logger.info( "deleteMngLevelRes:deleleFilePath: "+ deleleFilePath );
	    	
			if (!temp.exists()) {
		    	logger.info( "deleteMngLevelRes:deleleFilePath:NotFound "+ deleleFilePath );
			} else {
				//temp.deleteOnExit();
				temp.delete();
		    	logger.info( "deleteMngLevelRes:deleleFilePath:Deleted "+ deleleFilePath );
			}

	    	zvl.put( "atchmnfl_id", atchmnflId.get(i).toString() );
	    	zvl.put( "file_id",    fileId.get(i).toString() );
	    	
	    	zvl.put("sqlid", "bbs.bbsAttachFileDelete");
	    	bbsDao.bbsCommonDelete(zvl);
		}
		
		int cnt = bbsDao.selectCnt("bbs.bbsAttachFileCnt", zvl);
		if(cnt == 0) {
			zvl.put("sqlid", "bbs.bbsAttachFileDeleteId");
			bbsDao.bbsCommonUpdate(zvl);
		}
	}
	
	@Override
	public void bbsRegistThread(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		zvl.put("user_id", userInfo.getUserId());
		
		int cnt = bbsDao.selectCnt("bbs.bbsThreadCnt", zvl);
		if(cnt > 0) {
			zvl.put("sqlid", "bbs.bbsThreadUpdate");
			logger.debug("############## zvl1 ##############");
			logger.debug(zvl);
			logger.debug("############## zvl1 ##############");
			bbsDao.bbsCommonUpdate(zvl);
		} else {
			zvl.put("sqlid", "bbs.bbsThreadInsert");
			logger.debug("############## zvl2 ##############");
			logger.debug(zvl);
			logger.debug("############## zvl2 ##############");
			bbsDao.bbsCommonInsert(zvl);
		}
	}
	
	@Override
	public ZValue bbsAnswerFileInsert(ZValue zvl,  HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		ArrayList<String> fileIdList	= new ArrayList<String>();
		String uploadedFilesInfo = EgovStringUtil.nullConvert(zvl.getString("uploadedFilesInfo"));
		ZValue userInstt = null;
		zvl.put("user_id", userInfo.getUserId()); 
		
		zvl.put("sqlid", "bbs.selectUserInstt");
		userInstt = bbsDao.bbsCommonSelect(zvl);
		
		zvl.put("insttCd", userInstt.get("INSTT_CD"));
		zvl.put("insttNm", userInstt.get("INSTT_NM"));
		
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
		
		String answerAtchmnflId = (fileIdList.size() > 0) ? UUID.randomUUID().toString() : "";
		zvl.put("answerAtchmnflId", answerAtchmnflId);
		zvl.put("file_ids", fileIdList);

		zvl.put("sqlid", "bbs.bbsAnswerFileInsert");
		bbsDao.bbsCommonInsert(zvl);
		
		logger.debug("############## bbsCommonInsertSelectKey ##############");
		logger.debug(zvl);
		logger.debug("############## bbsCommonInsertSelectKey ##############");
		
		return zvl;
	}
	
	@Override
	public List<ZValue> bbsAnswerFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsAnswerFileList");
		return bbsDao.bbsCommonList(zvl);
	}
	
	@Override
	public List<ZValue> bbsImgList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsImgList");
		return bbsDao.bbsCommonList(zvl);
	}
	
	@Override
	public ZValue bbsPrev(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsPrev");
		return bbsDao.bbsCommonSelect(zvl);
	}
	
	@Override
	public ZValue bbsNext(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bbs.bbsNext");
		return bbsDao.bbsCommonSelect(zvl);
	}
	
}