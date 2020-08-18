package org.ssis.pss.statusExaminRst.service.impl;

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
import org.ssis.pss.statusExaminRst.dao.StatusExaminRstDao;
import org.ssis.pss.statusExaminRst.service.StatusExaminRstService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class StatusExaminRstServiceImpl implements StatusExaminRstService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private StatusExaminRstDao statusExaminRstDao;
	
	@Override
	public List<ZValue> selectStatusExaminRstSummaryList(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminRstSummaryList(zvl);
	}
	
	@Override
	public ZValue selectStatusExaminRstSummary(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminRstSummary(zvl);
	}
	
	@Override
	public List<ZValue> selectStatusExaminRstSummaryFileList(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminRstSummaryFileList(zvl);
	}
	
	@Override
	public List<ZValue> selectStatusExaminRstList(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminRstList(zvl);
	}
	
	@Override
	public List<ZValue> selectStatusExaminRstDtlSum(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminRstDtlSum(zvl);
	}
	
	@Override
	public List<ZValue> selectStatusExaminRstDtlAllList(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminRstDtlAllList(zvl);
	}
	
	@Override
	public List<ZValue> selectStatusExaminRstDtlList(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminRstDtlList(zvl);
	}
	
	@Override
	public ZValue selectStatusExaminRst(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminRst(zvl);
	}
	
	@Override
	public List<ZValue> selectStatusExaminRstFileList(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminRstFileList(zvl);
	}
	
	@Override
	public List<ZValue> selectStatusExaminEvlMemoFileList(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminEvlMemoFileList(zvl);
	}
	
	@Override
	public List<ZValue> selectStatusExaminEvlFobjctFileList(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminEvlFobjctFileList(zvl);
	}
	
	@Override
	public void updateStatusExaminRstFobjct(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		zvl.put( "updateId"  , userInfo.getUserId() );			// 로그인 아이디로 변경
		
		statusExaminRstDao.updateStatusExaminRstFobjct(zvl);
	}
	
	@Override
	public void updateStatusExaminEvlFobjctFile(ZValue zvl, HttpServletRequest request) throws Exception {
		
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

		statusExaminRstDao.updateStatusExaminEvlFobjctFile(zvl);
	}
	
	@Override
	public void deleteStatusExaminEvlFobjctFile(ZValue zvl, HttpServletRequest request) throws Exception {
		
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
	    	statusExaminRstDao.deletefile(zvl);
		}
		
		int cnt = statusExaminRstDao.selectAttachmentFileMapCnt(zvl);
		if(cnt == 0) {
			statusExaminRstDao.deleteStatusExaminEvlFobjctFile(zvl);
		}
	}
	
	@Override
	public List<ZValue> selectStatusExaminExcelDtlList(ZValue zvl) throws Exception {
		return statusExaminRstDao.selectStatusExaminExcelDtlList(zvl);
	}
}