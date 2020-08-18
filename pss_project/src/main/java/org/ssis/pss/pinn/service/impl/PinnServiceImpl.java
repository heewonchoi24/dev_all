package org.ssis.pss.pinn.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.pinn.dao.PinnDao;
import org.ssis.pss.pinn.service.PinnService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class PinnServiceImpl implements PinnService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private PinnDao pinnDao;
	
	@Override
	public List<ZValue> selectPinnSummaryList(ZValue zvl) throws Exception {
		return pinnDao.selectPinnSummaryList(zvl);
	}
	
	@Override
	public List<ZValue> selectInsttGroupList(ZValue zvl) throws Exception {
		return pinnDao.selectInsttGroupList(zvl);
	}
	
	@Override
	public List<ZValue> selectInsttClSelectBoxList(ZValue zvl) throws Exception {
		return pinnDao.selectInsttClSelectBoxList(zvl);
	}
	
	@Override
	public List<ZValue> selectInsttSelectBoxList(ZValue zvl) throws Exception {
		return pinnDao.selectInsttSelectBoxList(zvl);
	}
	
	@Override
	public List<ZValue> selectFyerSchdulSelectBoxList() throws Exception {
		return pinnDao.selectFyerSchdulSelectBoxList();
	}
	
	@Override
	public List<ZValue> selectPinnReqEvalDtlList(ZValue zvl) throws Exception {
		return pinnDao.selectPinnReqEvalDtlList(zvl);
	}
	
	@Override
	public List<ZValue> selectPinnReqFileList(ZValue zvl) throws Exception {
		return pinnDao.selectPinnReqFileList(zvl);
	}
	
	@Override
	public List<ZValue> selectPinnEvalFileList(ZValue zvl) throws Exception {
		return pinnDao.selectPinnEvalFileList(zvl);
	}
	
	@Override
	public void modifyPinnReqst(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put( "registId", userInfo.getUserId() );			// 로그인 아이디로 변경 
		zvl.put( "updtId"  , userInfo.getUserId() );			// 로그인 아이디로 변경
		
		ArrayList<String> fileIdList	= new ArrayList<String>();
		String insttCd     = userInfo.getInsttCd();
		String atchmnflId = EgovStringUtil.nullConvert( zvl.getString("atchmnfl_id"));
		String schdulSeq     = EgovStringUtil.nullConvert( zvl.getValue("schdulSeq"));
		
		String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
		
		if( "".equals( uploadedFilesInfo ) != true ) {
			JSONParser jsonParser = new JSONParser();
			Object obj = jsonParser.parse( uploadedFilesInfo ); 
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
		
		if(StringUtils.isEmpty(atchmnflId)) {
			atchmnflId = ( fileIdList.size() > 0 ) ? UUID.randomUUID().toString() : "";
		}
		
		zvl.put( "atchmnfl_id", atchmnflId );
		zvl.put( "schdulSeq", schdulSeq );
		zvl.put( "file_ids", fileIdList );
   		zvl.put( "insttCd", insttCd );
   		
		int cnt = pinnDao.selectPinnReqstEvalCnt(zvl);
		if(cnt > 0) {
			pinnDao.updatePinnReqst(zvl);
		} else {
			pinnDao.insertPinnReqstEval(zvl);   			
		}
	}
	
	@Override
	public void deletePinnReqst(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		ArrayList atchmnflId = zvl.getArrayList("atchmnflId[]");
		ArrayList fileId = zvl.getArrayList("fileId[]");
		ArrayList filePath = zvl.getArrayList("filePath[]");
		String insttCd     = userInfo.getInsttCd();
		String schdulSeq = EgovStringUtil.nullConvert( zvl.getValue("schdulSeq"));
		
    	String crossuploaderFilePath = Globals.CROSSUPLOADER_FILE_PATH;

    	String deleleFilePath = crossuploaderFilePath;

		for(int i=0; i < fileId.size(); i++) {
			deleleFilePath = crossuploaderFilePath + filePath.get(i).toString();
 
			File temp = new File(EgovWebUtil.filePathWhiteList(deleleFilePath));

			if (!temp.exists()) {
		    	logger.info( "deletePinnReqst:deleleFilePath:NotFound "+ deleleFilePath );
			} else {
				temp.delete();
		    	logger.info( "deletePinnReqst:deleleFilePath:Deleted "+ deleleFilePath );
			}

	    	zvl.put( "atchmnflId", atchmnflId.get(i).toString() );
	    	zvl.put( "atchmnfl_id", atchmnflId.get(i).toString() );
	    	zvl.put( "fileId",    fileId.get(i).toString() );

	    	pinnDao.deletePinnReqstEvalFileMap(zvl);
	    	pinnDao.deletePinnReqstEvalFileMstr(zvl);
		}
		
		int cnt = pinnDao.selectPinnReqstEvalFileCnt(zvl);
		if(cnt == 0) {
			zvl.put( "schdulSeq", schdulSeq );
	   		zvl.put( "insttCd", insttCd );
			pinnDao.deletePinnReqst(zvl);
		}
	}
	
	@Override
	public void modifyPinnEval(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		ArrayList<String> fileIdList	= new ArrayList<String>();
		String insttCd     = EgovStringUtil.nullConvert(zvl.getValue("insttCd"));
		String atchmnflId = EgovStringUtil.nullConvert( zvl.getString("atchmnfl_id"));
		String schdulSeq     = EgovStringUtil.nullConvert( zvl.getValue("schdulSeq"));
		
		String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
		
		if( "".equals( uploadedFilesInfo ) != true ) {
			JSONParser jsonParser = new JSONParser();
			Object obj = jsonParser.parse( uploadedFilesInfo ); 
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
		
		if(StringUtils.isEmpty(atchmnflId)) {
			atchmnflId = ( fileIdList.size() > 0 ) ? UUID.randomUUID().toString() : "";
			zvl.put( "registId", userInfo.getUserId() );			// 로그인 아이디로 변경
		} else {
			zvl.put( "updtId"  , userInfo.getUserId() );			// 로그인 아이디로 변경
		}
		
		zvl.put( "atchmnfl_id", atchmnflId );
		zvl.put( "schdulSeq", schdulSeq );
		zvl.put( "file_ids", fileIdList );
   		zvl.put( "insttCd", insttCd );
   		
		pinnDao.updatePinnEval(zvl);
	}
	
	@Override
	public void deletePinnEval(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		ArrayList atchmnflId = zvl.getArrayList("atchmnflId[]");
		ArrayList fileId = zvl.getArrayList("fileId[]");
		ArrayList filePath = zvl.getArrayList("filePath[]");
		String insttCd     = EgovStringUtil.nullConvert(zvl.getValue("insttCd"));
		String schdulSeq = EgovStringUtil.nullConvert(zvl.getValue("schdulSeq"));
		
    	String crossuploaderFilePath = Globals.CROSSUPLOADER_FILE_PATH;

    	String deleleFilePath = crossuploaderFilePath;

		for(int i=0; i < fileId.size(); i++) {
			deleleFilePath = crossuploaderFilePath + filePath.get(i).toString();
 
			File temp = new File(EgovWebUtil.filePathWhiteList(deleleFilePath));

			if (!temp.exists()) {
		    	logger.info( "deletePinnReqst:deleleFilePath:NotFound "+ deleleFilePath );
			} else {
				temp.delete();
		    	logger.info( "deletePinnReqst:deleleFilePath:Deleted "+ deleleFilePath );
			}

	    	zvl.put( "atchmnflId", atchmnflId.get(i).toString() );
	    	zvl.put( "atchmnfl_id", atchmnflId.get(i).toString() );
	    	zvl.put( "fileId",    fileId.get(i).toString() );

	    	pinnDao.deletePinnReqstEvalFileMap(zvl);
	    	pinnDao.deletePinnReqstEvalFileMstr(zvl);
		}
		
		int cnt = pinnDao.selectPinnReqstEvalFileCnt(zvl);
		if(cnt == 0) {
			zvl.put( "schdulSeq", schdulSeq );
	   		zvl.put( "insttCd", insttCd );
			pinnDao.deletePinnEval(zvl);
		}
	}
	
	@Override
	public void updatePinnEvalStatus(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		String insttCd     = EgovStringUtil.nullConvert(zvl.getValue("insttCd"));
		String status = EgovStringUtil.nullConvert( zvl.getString("status"));
		String schdulSeq     = EgovStringUtil.nullConvert( zvl.getValue("schdulSeq"));
		String crud     = EgovStringUtil.nullConvert( zvl.getValue("crud"));
		
		zvl.put( "updtId"  , userInfo.getUserId() );			// 로그인 아이디로 변경
		
		zvl.put( "schdulSeq", schdulSeq );
		zvl.put( "status", status );
   		zvl.put( "insttCd", insttCd );
   		
   		if("I".equals(crud)) {
   			pinnDao.insertPinnEvalStatus(zvl);
   		} else if("U".equals(crud)) {
   			pinnDao.updatePinnEvalStatus(zvl);	
   		} else if("D".equals(crud)) {
   			pinnDao.deletePinnEvalStatus(zvl);
   		}
	}
}