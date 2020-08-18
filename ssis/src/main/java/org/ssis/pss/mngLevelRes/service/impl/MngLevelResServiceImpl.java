package org.ssis.pss.mngLevelRes.service.impl;

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
import org.ssis.pss.mngLevelRes.dao.MngLevelResDao;
import org.ssis.pss.mngLevelRes.service.MngLevelResService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class MngLevelResServiceImpl implements MngLevelResService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private MngLevelResDao mngLevelResDao;

	@Override
	public List<ZValue> mngLevelInsttEvlOrderList(ZValue zvl) throws Exception {
		return mngLevelResDao.mngLevelInsttEvlOrderList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttClCdList(ZValue zvl) throws Exception {
		return mngLevelResDao.mngLevelInsttClCdList(zvl);
	}

	@Override
	public List<ZValue> mngLevelInsttList(ZValue zvl) throws Exception {
		return mngLevelResDao.mngLevelInsttList(zvl);
	}

	@Override
	public List<ZValue> mngLevelInsttSelectList(ZValue zvl) throws Exception {
		return mngLevelResDao.mngLevelInsttSelectList(zvl);
	}

	@Override
	public List<ZValue> mngLevelInsttTableList(ZValue zvl) throws Exception {
		return mngLevelResDao.mngLevelInsttTableList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelIdxList(ZValue zvl) throws Exception {
		return mngLevelResDao.mngLevelIdxList(zvl);
	}
	
	@Override
	public List<ZValue> mngLevelInsttEvlList(ZValue zvl) throws Exception {
		return mngLevelResDao.mngLevelInsttEvlList(zvl);
	}
	
	@Override
	public List<ZValue> MngLevelInsttListAjax(ZValue zvl) throws Exception {
		return mngLevelResDao.MngLevelInsttListAjax(zvl);
	}

	@Override
	public List<ZValue> selectMngLevelIndexList(ZValue zvl) throws Exception {
		return mngLevelResDao.selectMngLevelIndexList(zvl);
	}

	@Override
	public void insertMngLevelExcpYn(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
			//
    		zvl.put( "regist_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
			//
			ArrayList<String> fileIdList	= new ArrayList<String>();
    		String insttCd     = EgovStringUtil.nullConvert( zvl.getValue( "insttCd" ) );  
    		zvl.put( "atchmnfl_id", "" );
    		zvl.put( "file_ids", fileIdList );
       		zvl.put( "insttCd",	    insttCd );
			//
    		int cnt = mngLevelResDao.selectMngLevelReqstCnt(zvl);
    		
    		if(cnt > 0) {
    			mngLevelResDao.updateMngLevelRes(zvl);
    		} else {
    			mngLevelResDao.insertMngLevelRes(zvl);   			
    		}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void createMngLevelRes(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
			
    		zvl.put( "registId", userInfo.getUserId() );			// 로그인 아이디로 변경 
    		zvl.put( "updtId"  , userInfo.getUserId() );			// 로그인 아이디로 변경 
			
			ArrayList<String> fileIdList	= new ArrayList<String>();
    		String insttCd     = EgovStringUtil.nullConvert( zvl.getValue( "insttCd" ) );  
			String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
    		String gubunCd     = EgovStringUtil.nullConvert( zvl.getValue( "gubunCd" ) ); 
    		String memo = EgovStringUtil.nullConvert( zvl.getString( "memo" ) );
			
	    	logger.debug( "createMngLevelRes:insttCd:" + insttCd);
	    	
			if( "".equals( zvl.getString( "uploadedFilesInfo" ) ) != true ) {
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
			
	    	logger.debug( "bbsRegistThread:: fileIdList {{"+ ( ( fileIdList == null ) ? "Null" : fileIdList.toString() ) +"}}" );
	    	
    		String atchmnflId = ( fileIdList.size() > 0 ) ? UUID.randomUUID().toString() : "";
    		zvl.put( "atchmnfl_id", atchmnflId );
    		zvl.put( "file_ids",    fileIdList );
       		zvl.put( "insttCd",	    insttCd );
       		zvl.put( "excpPermYn",  "N");
       		zvl.put( "memo",        memo);
			
       		if("2".equals(gubunCd)) {
           		zvl.put( "status",	 "RS05" );
       		}
    		int cnt = mngLevelResDao.selectMngLevelReqstCnt(zvl);
    		if(cnt > 0) {
    			mngLevelResDao.updateMngLevelRes(zvl);
    		} else {
    			mngLevelResDao.insertMngLevelRes(zvl);   			
    		}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Override
	public void updateMngLevelRes(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		try {
			//
    		zvl.put( "registId", userInfo.getUserId() );			// 로그인 아이디로 변경 
    		zvl.put( "updtId"  , userInfo.getUserId() );			// 로그인 아이디로 변경 
			//
			ArrayList<String> ufileIdList	= new ArrayList<String>();
			ArrayList<String> fileIdList	= new ArrayList<String>();
			//
    		String atchmnfl_id = EgovStringUtil.nullConvert( zvl.getString( "atchmnfl_id" ) );  
    		String insttCd     = EgovStringUtil.nullConvert( zvl.getValue( "insttCd" ) );  
    		String gubunCd     = EgovStringUtil.nullConvert( zvl.getValue( "gubunCd" ) );  
			String modifiedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "modifiedFilesInfo" ) );
			String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
			String memo = EgovStringUtil.nullConvert( zvl.getString( "memo" ) );
			//
	    	logger.debug( "MngLevelResServiceImpl:: updateMngLevelRes " );

	    	if( "".equals( uploadedFilesInfo ) != true ) {
				JSONParser jsonParser = new JSONParser();
				Object obj = jsonParser.parse( uploadedFilesInfo ); 
		    	logger.debug( "updateMngLevelRes:: obj {{"+ obj +"}}" );
				JSONArray fileInfoArray = ( JSONArray )obj; 
				for( int inx = 0; inx < fileInfoArray.size(); inx++ ) {
					JSONObject jsonObject = (JSONObject)fileInfoArray.get( inx );
					String fileId = ( String )jsonObject.get( "fileId" ); 
					fileIdList.add( fileId );
				}
			}
	    	logger.debug( "updateMngLevelRes:: fileIdList {{"+ ( ( fileIdList == null ) ? "Null" : fileIdList.toString() ) +"}}" );
	    	//
	    	if( "".equals( atchmnfl_id ) ) {
	    		atchmnfl_id = ( ( ufileIdList.size() > 0 ) || ( fileIdList.size() > 0 ) ) ? UUID.randomUUID().toString() : atchmnfl_id;
	    	}
	    	zvl.put( "atchmnfl_id",	atchmnfl_id );
	    	zvl.put( "ufile_ids",	ufileIdList );
    		zvl.put( "file_ids",	fileIdList );
    		zvl.put( "insttCd",	    insttCd );
       		zvl.put( "excpPermYn",  "N");
       		zvl.put( "memo",        memo );
       		
       		if("2".equals(gubunCd)) {
           		zvl.put( "status",	 "RS05" );
       		}
			//
    		mngLevelResDao.updateMngLevelRes(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Override
	public void deleteMngLevelRes(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		ArrayList atchmnflId = zvl.getArrayList("atchmnflId[]");
		ArrayList fileId = zvl.getArrayList("fileId[]");
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

//			if (!temp.isFile()) {
//				throw new FileNotFoundException(deleleFilePath);
//			}

	    	zvl.put( "atchmnflId", atchmnflId.get(i).toString() );
	    	zvl.put( "fileId",    fileId.get(i).toString() );

	    	mngLevelResDao.deleteMngLevelRes(zvl);
	    	mngLevelResDao.deleteMngLevelResFile(zvl);
		}
		
		int cnt = mngLevelResDao.seleteMngLevelResFileCnt(zvl);
		if(cnt == 0) {
			ZValue result  = mngLevelResDao.selectMngLevelReqst(zvl);
			if(result.getInt( "MNG_LEVEL_IDX_SEQ" ) == 0) {
				mngLevelResDao.deleteMngLevelReqst(zvl);
			} else {
				String statVal = EgovStringUtil.nullConvert( result.getValue( "STATUS" ) );
				if("".equals(statVal)) {
					mngLevelResDao.update("mngLevelRes.updateMngLevelReqstAttachId", zvl);
				}
			}
		}

	}
	
	@Override
	public int selectMngLevelReqstCnt(ZValue zvl) throws Exception {
		return mngLevelResDao.selectMngLevelReqstCnt(zvl);
	}

	@Override
	public int selectMngLevelIdxCnt(ZValue zvl) throws Exception {
		return mngLevelResDao.selectMngLevelIdxCnt(zvl);
	}

	@Override
	public List<ZValue> selectCntMngLevelReqstStatus(ZValue zvl) throws Exception {
		return mngLevelResDao.selectCntMngLevelReqstStatus(zvl);
	}

	@Override
	public void updateMngLevelResStat(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		try {
			//
    		zvl.put( "registId", userInfo.getUserId() );			// 로그인 아이디로 변경 
    		zvl.put( "updtId"  , userInfo.getUserId() );			// 로그인 아이디로 변경 
			//
			ArrayList<String> ufileIdList	= new ArrayList<String>();
			ArrayList<String> fileIdList	= new ArrayList<String>();
			//
    		String atchmnfl_id = EgovStringUtil.nullConvert( zvl.getString( "atchmnfl_id" ) );  
    		String insttCd     = EgovStringUtil.nullConvert( zvl.getValue( "insttCd" ) );  
			String modifiedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "modifiedFilesInfo" ) );
			String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
			//
	    	logger.debug( "MngLevelResServiceImpl:: updateMngLevelRes " );
			if( "".equals( uploadedFilesInfo ) != true ) {
				JSONParser jsonParser = new JSONParser();
				Object obj = jsonParser.parse( uploadedFilesInfo ); 
		    	logger.debug( "updateMngLevelRes:: obj {{"+ obj +"}}" );
				JSONArray fileInfoArray = ( JSONArray )obj; 
				for( int inx = 0; inx < fileInfoArray.size(); inx++ ) {
					JSONObject jsonObject = (JSONObject)fileInfoArray.get( inx );
					String fileId = ( String )jsonObject.get( "fileId" ); 
					//Boolean isSaved = Boolean.parseBoolean( ( String )jsonObject.get( "isSaved" ) ); 
					//if( isSaved == false )
					//	continue;
					fileIdList.add( fileId );
				}
			}
	    	logger.debug( "updateMngLevelRes:: fileIdList {{"+ ( ( fileIdList == null ) ? "Null" : fileIdList.toString() ) +"}}" );
	    	//
	    	if( "".equals( atchmnfl_id ) ) {
	    		atchmnfl_id = ( ( ufileIdList.size() > 0 ) || ( fileIdList.size() > 0 ) ) ? UUID.randomUUID().toString() : atchmnfl_id;
	    	}
	    	zvl.put( "atchmnfl_id",	atchmnfl_id );
	    	zvl.put( "ufile_ids",	ufileIdList );
    		zvl.put( "file_ids",	fileIdList );
    		zvl.put( "insttCd",	    insttCd );
       		zvl.put( "excpPermYn",  "N");
			//
    		mngLevelResDao.updateMngLevelResStat(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public ZValue selectMngLevelRergistResnAjax(ZValue zvl) throws Exception {
		return mngLevelResDao.selectMngLevelReqst(zvl);
	}

	@Override
	public ZValue selectMngLevelReqst(ZValue zvl) throws Exception {
		return mngLevelResDao.selectMngLevelReqst(zvl);
	}

	@Override
	public List<ZValue> mngLevelInsttFileList(ZValue zvl) throws Exception {
		return mngLevelResDao.mngLevelInsttFileList(zvl);
	}

	@Override
	public int selectBsisSttusCnt(ZValue zvl) throws Exception {
		return mngLevelResDao.selectBsisSttusCnt(zvl);
	}
	
	@Override
	public ZValue getLimitFileSize(ZValue zvl) throws Exception {
		return mngLevelResDao.getLimitFileSize(zvl);
	}
}