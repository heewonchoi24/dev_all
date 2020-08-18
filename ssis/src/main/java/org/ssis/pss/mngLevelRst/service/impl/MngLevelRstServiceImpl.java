package org.ssis.pss.mngLevelRst.service.impl;

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
import org.ssis.pss.mngLevelRst.dao.MngLevelRstDao;
import org.ssis.pss.mngLevelRst.service.MngLevelRstService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class MngLevelRstServiceImpl implements MngLevelRstService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private MngLevelRstDao mngLevelRstDao;
	
	@Override
	public List<ZValue> selectMngLevelResultSummaryList(ZValue zvl) throws Exception {
		return mngLevelRstDao.selectMngLevelResultSummaryList(zvl);
	}
	
	@Override
	public ZValue selectMngLevelResultSummary(ZValue zvl) throws Exception {
		return mngLevelRstDao.selectMngLevelResultSummary(zvl);
	}
	
	@Override
	public List<ZValue> selectMngLevelResultList(ZValue zvl) throws Exception {
		return mngLevelRstDao.selectMngLevelResultList(zvl);
	}
	
	@Override
	public ZValue selectMngLevelResult(ZValue zvl) throws Exception {
		return mngLevelRstDao.selectMngLevelResult(zvl);
	}
	
	@Override
	public List<ZValue> selectMngLevelRequestFileList(ZValue zvl) throws Exception {
		return mngLevelRstDao.selectMngLevelRequestFileList(zvl);
	}
	
	@Override
	public List<ZValue> selectMngLevelEvlMemoFileList(ZValue zvl) throws Exception {
		return mngLevelRstDao.selectMngLevelEvlMemoFileList(zvl);
	}
	
	@Override
	public List<ZValue> selectMngLevelEvlFobjctFileList(ZValue zvl) throws Exception {
		return mngLevelRstDao.selectMngLevelEvlFobjctFileList(zvl);
	}
	
	@Override
	public void updateMngLevelRstFobjct(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put( "updateId"  , userInfo.getUserId() );			// 로그인 아이디로 변경
		
		mngLevelRstDao.updateMngLevelRstFobjct(zvl);
	}
	
	@Override
	public void updateMngLevelRstFobjctFile(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		zvl.put( "updateId"  , userInfo.getUserId() );			// 로그인 아이디로 변경
		zvl.put( "registId"  , userInfo.getUserId() );			// 로그인 아이디로 변경
		
		ArrayList<String> ufileIdList	= new ArrayList<String>();
		ArrayList<String> fileIdList	= new ArrayList<String>();

		String atchmnflId = EgovStringUtil.nullConvert( zvl.getString( "atchmnfl_id" ) );  
		
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
    	if( "".equals( atchmnflId ) ) {
    		atchmnflId = ( ( ufileIdList.size() > 0 ) || ( fileIdList.size() > 0 ) ) ? UUID.randomUUID().toString() : atchmnflId;
    	}
    	zvl.put( "atchmnflId",	atchmnflId );
    	zvl.put( "ufile_ids",	ufileIdList );
		zvl.put( "file_ids",	fileIdList );

		mngLevelRstDao.updateMngLevelEvlFobjctFile(zvl);
	}
	
	@Override
	public void deleteMngLevelRstFobjct(ZValue zvl, HttpServletRequest request) throws Exception {
		
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

			if (temp.exists()) {
				temp.delete();
			}
	    	zvl.put( "atchmnflId", atchmnflId.get(i).toString() );
	    	zvl.put( "fileId",    fileId.get(i).toString() );
	    	mngLevelRstDao.deletefile(zvl);
		}
		
		int cnt = mngLevelRstDao.selectAttachmentFileMapCnt(zvl);
		if(cnt == 0) {
			mngLevelRstDao.deleteMngLevelEvlFobjctFile(zvl);
		}
	}
}