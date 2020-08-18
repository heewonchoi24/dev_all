package org.ssis.pss.mngLevelReq.service.impl;

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
import org.ssis.pss.mngLevelReq.dao.MngLevelReqDao;
import org.ssis.pss.mngLevelReq.service.MngLevelReqService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class MngLevelReqServiceImpl implements MngLevelReqService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private MngLevelReqDao MngLevelReqDao;
	
	@Override
	public List<ZValue> mngLevelInsttEvlOrderList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttEvlOrderList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttClCdList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttClCdList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttSelectList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttSelectList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttTableList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttTableList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelIdxList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelIdxList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttEvlList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttEvlList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttListAjax(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttDetailList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttDetailList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public ZValue selectMngLevelResultSummary(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.selectMngLevelResultSummary");
		return MngLevelReqDao.MngLevelSelectOne(zvl);
	}
	
	@Override
	public List<ZValue> selectMngLevelResultList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.selectMngLevelResultList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public ZValue mngLevelInsttTotalEvl(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttTotalEvl");
		return MngLevelReqDao.MngLevelSelectOne(zvl);
	}
	
	@Override
	public ZValue mngLevelFobjctResnAjax(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttDetailList");
		return MngLevelReqDao.MngLevelSelectOne(zvl);
	}
	
	@Override
	public ZValue mngLevelDocumentEvaluationRegist(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttDetailList");
		return MngLevelReqDao.MngLevelSelectOne(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttDetailEvlFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttDetailEvlFileList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttDetailMemoFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelInsttDetailMemoFileList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public void mngLevelDocumentEvaluationInsertAjax(ZValue zvl) throws Exception {
		
		int cnt = MngLevelReqDao.selectCnt("mngLevelReq.mngLevelEvlCnt", zvl);
		if(cnt > 0) {
			zvl.put("sqlid", "mngLevelReq.mngLevelDocumentEvaluationUpdate");
			logger.debug("############## zvl1 ##############");
			logger.debug(zvl);
			logger.debug("############## zvl1 ##############");
			MngLevelReqDao.MngLevelUpdate(zvl);
		} else {
			zvl.put("sqlid", "mngLevelReq.mngLevelDocumentEvaluationInsert");
			logger.debug("############## zvl2 ##############");
			logger.debug(zvl);
			logger.debug("############## zvl2 ##############");
			MngLevelReqDao.MngLevelInsert(zvl);   			
		}
	}
	
	
	@Override
	public void mngLevelDocumentEvaluationFileInsertAjax(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put( "user_id", userInfo.getUserId() ); 
		zvl.put( "regist_id", userInfo.getUserId() ); 
		zvl.put( "update_id"  , userInfo.getUserId() ); 
		
		ArrayList<String> fileIdList	= new ArrayList<String>();
		String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
		
		if( "".equals( uploadedFilesInfo ) != true ) {
			JSONParser jsonParser = new JSONParser();
			Object obj = jsonParser.parse( uploadedFilesInfo ); 
	    	logger.debug( "createMngLevelRes:: obj {{"+ obj +"}}" );
			JSONArray fileInfoArray = ( JSONArray )obj; 
			for( int inx = 0; inx < fileInfoArray.size(); inx++ ) {
				JSONObject jsonObject = (JSONObject)fileInfoArray.get( inx );
				String fileId = ( String )jsonObject.get( "fileId" ); 
				Boolean isSaved = Boolean.parseBoolean( ( String )jsonObject.get( "isSaved" ) ); 
				if( isSaved == false )
					continue;
				fileIdList.add( fileId );
			}
		}
		
		String atchmnflId = ( fileIdList.size() > 0 ) ? UUID.randomUUID().toString() : "";
		zvl.put( "atchmnfl_id", atchmnflId );
		zvl.put( "file_ids", fileIdList );

		int cnt = MngLevelReqDao.selectCnt("mngLevelReq.mngLevelEvlCnt", zvl);
		if(cnt > 0) {
			zvl.put("sqlid", "mngLevelReq.mngLevelDocumentEvaluationUpdate");
			logger.debug("############## zvl1 ##############");
			logger.debug(zvl);
			logger.debug("############## zvl1 ##############");
			MngLevelReqDao.MngLevelUpdate(zvl);
		} else {
			zvl.put("sqlid", "mngLevelReq.mngLevelDocumentEvaluationInsert");
			logger.debug("############## zvl2 ##############");
			logger.debug(zvl);
			logger.debug("############## zvl2 ##############");
			MngLevelReqDao.MngLevelInsert(zvl);   			
		}
	}
	
	
	@Override
	public void mngLevelDocumentEvaluationFileUpdateAjax(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put( "user_id", userInfo.getUserId() );
		zvl.put( "regist_id", userInfo.getUserId() ); 
		zvl.put( "update_id"  , userInfo.getUserId() ); 
		
		ArrayList<String> ufileIdList	= new ArrayList<String>();
		ArrayList<String> fileIdList	= new ArrayList<String>();

		String atchmnfl_id = EgovStringUtil.nullConvert( zvl.getString( "atchmnfl_id" ) );  
		
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
		zvl.put("sqlid", "mngLevelReq.mngLevelDocumentEvaluationUpdate");

		logger.debug("############## zvl3 ##############");
		logger.debug(zvl);
		
		logger.debug("############## zvl3 ##############");
   		MngLevelReqDao.MngLevelUpdate(zvl);
	}
	
	
	@Override
	public void mngLevelDocumentEvaluationFileDeleteAjax(ZValue zvl, HttpServletRequest request) throws Exception {		

		ArrayList<?> atchmnflId = zvl.getArrayList("atchmnfl_id[]");
		ArrayList<?> fileId = zvl.getArrayList("file_id[]");
		ArrayList<?> filePath = zvl.getArrayList("filePath[]");
		
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
	    	
	    	zvl.put("sqlid", "mngLevelReq.mngLevelDocumentEvaluationDeleteMemoFile");
	    	MngLevelReqDao.MngLevelDelete(zvl);
		}
		
		int cnt = MngLevelReqDao.selectCnt("mngLevelReq.mngLevelDocumentEvaluationCntMemoFile", zvl);
		if(cnt == 0) {
			zvl.put("sqlid", "mngLevelReq.mngLevelDocumentEvaluationDeleteMemoFileId");
			MngLevelReqDao.MngLevelUpdate(zvl);
		}
	}
	
	
	public void mngLevelDocumentEvaluationTotalRegist(ZValue zvl, HttpServletRequest request) throws Exception {
		String periodCode = "";
		ZValue avg = null;
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		zvl.put( "regist_id", userInfo.getUserId() ); 
		zvl.put( "update_id"  , userInfo.getUserId() ); 
		
		avg = (ZValue)MngLevelReqDao.selectOne("mngLevelReq.mngLevelDocumentEvaluationAvgPoint", zvl);
		
		zvl.put("totResultScore1",avg.getValue("AVG_SCORE1"));
		zvl.put("totResultScore2",avg.getValue("AVG_SCORE2"));
		
		periodCode = zvl.getValue("periodCode");
		
		if(periodCode.contains("B")){
			zvl.put("sqlid", "mngLevelReq.mngLevelDocumentEvaluationAvgPointInsert");
			MngLevelReqDao.MngLevelInsert(zvl);
		}else if(periodCode.contains("D")){
			zvl.put("sqlid", "mngLevelReq.mngLevelDocumentEvaluationAvgPointUpdate");
			MngLevelReqDao.MngLevelUpdate(zvl);
		}
		
		zvl.put("sqlid", "mngLevelReq.mngLevelDocumentEvaluationStatusUpdate");
		MngLevelReqDao.MngLevelUpdate(zvl);
	}
	
	@Override
	public List<ZValue> selectMngLevelReqstAllFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.selectMngLevelReqstAllFileList");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelResultReportFile(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelResultReportFile");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelFobjctResnFileAjax(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelFobjctResnFileAjax");
		return MngLevelReqDao.MngLevelSelectList(zvl);
	}
	
	@Override
	public ZValue mngLevelResultBeforeYear(ZValue zvl) throws Exception {
		zvl.put("sqlid", "mngLevelReq.mngLevelResultBeforeYear");
		return MngLevelReqDao.MngLevelSelectOne(zvl);
	}
	
	@Override
	public void updateResultTotPerScoreAjax(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		zvl.put("userId", userInfo.getUserId());
		zvl.put("sqlid", "mngLevelReq.updateResultTotPerScoreAjax");
		
		ArrayList resultTotPer = zvl.getArrayList("resultTotPer[]");
		ArrayList resultTotScore = zvl.getArrayList("resultTotScore[]");
		ArrayList lclasOrder = zvl.getArrayList("lclasOrder[]");
		ArrayList mlsfcOrder = zvl.getArrayList("mlsfcOrder[]");
		
		for(int i=0; i < resultTotPer.size(); i++) {
			zvl.put("resultTotPer", resultTotPer.get(i).toString());
			zvl.put("resultTotScore", resultTotScore.get(i).toString());
			zvl.put("lclasOrder", lclasOrder.get(i).toString());
			zvl.put("mlsfcOrder", mlsfcOrder.get(i).toString());
			MngLevelReqDao.MngLevelUpdate(zvl);
		}
	}
}