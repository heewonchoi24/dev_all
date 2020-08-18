package org.ssis.pss.statusExaminReq.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.io.File;
import java.io.FileNotFoundException;

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
import org.ssis.pss.statusExaminReq.service.StatusExaminReqService;
import org.ssis.pss.statusExaminReq.dao.StatusExaminReqDao;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class StatusExaminReqServiceImpl implements StatusExaminReqService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private StatusExaminReqDao statusExaminReqDao;

	@Override
	public List<ZValue> statusExaminInsttEvlOrderList(ZValue zvl) throws Exception {
		return statusExaminReqDao.statusExaminInsttEvlOrderList(zvl);
	}
	
	@Override
	public List<ZValue> statusExaminInsttClCdList(ZValue zvl) throws Exception {
		return statusExaminReqDao.statusExaminInsttClCdList(zvl);
	}

	@Override
	public List<ZValue> statusExaminInsttList(ZValue zvl) throws Exception {
		return statusExaminReqDao.statusExaminInsttList(zvl);
	}

	@Override
	public List<ZValue> statusExaminInsttSelectList(ZValue zvl) throws Exception {
		return statusExaminReqDao.statusExaminInsttSelectList(zvl);
	}

	@Override
	public List<ZValue> statusExaminInsttTableList(ZValue zvl) throws Exception {
		return statusExaminReqDao.statusExaminInsttTableList(zvl);
	}
	
	@Override
	public List<ZValue> statusExaminIdxList(ZValue zvl) throws Exception {
		return statusExaminReqDao.statusExaminIdxList(zvl);
	}
	
	@Override
	public List<ZValue> statusExaminInsttEvlList(ZValue zvl) throws Exception {
		return statusExaminReqDao.statusExaminInsttEvlList(zvl);
	}

	@Override
	public List<ZValue> statusExaminInsttDetailList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminInsttDetailList");
		return statusExaminReqDao.statusExaminSelectList(zvl);
	}
	
	@Override
	public ZValue statusExaminInsttTotalEvl(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminGnrlzEvl");
		return statusExaminReqDao.statusExaminSelectOne(zvl);
	}

	@Override
	public ZValue statusExaminInsttDetail(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminInsttDetailList");
		return statusExaminReqDao.statusExaminSelectOne(zvl);
	}

	@Override
	public List<ZValue> statusExaminPreFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminPreFileList");
		return statusExaminReqDao.statusExaminSelectList(zvl);
	}

	@Override
	public List<ZValue> statusExaminInsttFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminInsttFileList");
		return statusExaminReqDao.statusExaminSelectList(zvl);
	}

	@Override
	public List<ZValue> statusExaminInsttDetailFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminInsttDetailFileList");
		return statusExaminReqDao.statusExaminSelectList(zvl);
	}

	@Override
	public List<ZValue> statusExaminInsttIdxFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminInsttIdxFileList");
		return statusExaminReqDao.statusExaminSelectList(zvl);
	}

	@Override
	public List<ZValue> statusExaminInsttFobjctFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminInsttFobjctFileList");
		return statusExaminReqDao.statusExaminSelectList(zvl);
	}

	@Override
	public List<ZValue> statusExaminInsttIdxDetailList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminInsttIdxDetailList");
		return statusExaminReqDao.statusExaminSelectList(zvl);
	}

	@Override
	public List<ZValue> StatusExaminInsttListAjax(ZValue zvl) throws Exception {
		return statusExaminReqDao.StatusExaminInsttListAjax(zvl);
	}

	@Override
	public List<ZValue> selectStatusExaminIndexList(ZValue zvl) throws Exception {
		return statusExaminReqDao.selectStatusExaminIndexList(zvl);
	}

	@Override
	public void insertStatusExaminExcpYn(ZValue zvl, HttpServletRequest request) throws Exception {
		
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
    		int cnt = statusExaminReqDao.selectStatusExaminCnt(zvl);
    		
    		if(cnt > 0) {
    			statusExaminReqDao.updateStatusExaminRes(zvl);
    		} else {
    			statusExaminReqDao.insertStatusExaminRes(zvl);   			
    		}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void createStatusExaminRes(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		try {
			//
    		zvl.put( "registId", userInfo.getUserId() );			// 로그인 아이디로 변경 
    		zvl.put( "updtId"  , userInfo.getUserId() );			// 로그인 아이디로 변경 
			//
			ArrayList<String> fileIdList	= new ArrayList<String>();

    		String insttCd     = EgovStringUtil.nullConvert( zvl.getValue( "instt_cd" ) );   
			String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
    		String indexSeq     = EgovStringUtil.nullConvert( zvl.getValue( "index_seq" ) );  
    		String atchmnfl_id = EgovStringUtil.nullConvert( zvl.getString( "atchmnfl_id" ) );
    		String gubun     = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) );   
    		String periodCd    = EgovStringUtil.nullConvert( zvl.getValue( "periodCd" ) );   
			//
	    	logger.debug( "createStatusExaminRes:insttCd:" + insttCd);
			if( "".equals( uploadedFilesInfo ) != true ) {
				JSONParser jsonParser = new JSONParser();
				Object obj = jsonParser.parse( uploadedFilesInfo ); 
		    	logger.debug( "createStatusExaminRes:: obj {{"+ obj +"}}" );
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
	    	logger.debug( "createStatusExaminRes:: fileIdList {{"+ ( ( fileIdList == null ) ? "Null" : fileIdList.toString() ) +"}}" );
	    	if("".equals(atchmnfl_id)){
	    		String atchmnflId = ( fileIdList.size() > 0 ) ? UUID.randomUUID().toString() : "";
	    		zvl.put( "atchmnfl_id", atchmnflId );
    		} else {
    			zvl.put( "atchmnfl_id", atchmnfl_id );
    		}
    		zvl.put( "file_ids"   , fileIdList );
       		zvl.put( "insttCd"    ,	insttCd    );
       		zvl.put( "indexSeq"   ,	indexSeq   );
			//
    		if("1".equals(gubun)) {
    			ZValue totScore = statusExaminReqDao.selectStatusExaminEvlSum(zvl);
    			zvl.put( "totResultScore1"   ,	totScore.getValue("RESULT_SCORE1")  );
    			zvl.put( "totResultScore2"   ,	totScore.getValue("RESULT_SCORE2")   );
    		}

	    	int cnt = statusExaminReqDao.selectStatusExaminCnt(zvl);
	    	if(cnt > 0) {
	    		statusExaminReqDao.updateStatusExaminRes(zvl);
	    	} else {
	    		statusExaminReqDao.insertStatusExaminRes(zvl);   			
	    	}
	    	if("1".equals(gubun) && "E".equals(periodCd)) {
	    		statusExaminReqDao.updateStatusExaminResStat(zvl);
	    	}
    		if("2".equals(gubun)) {
    			ArrayList detailSeqList = zvl.getArrayList("detail_seq[]");
    			ArrayList detailValList = zvl.getArrayList("detail_val[]");
    			if( detailSeqList.size() > 0 ) {
    				for( int i = 0; i < detailSeqList.size(); i++ ) {
    			    	logger.debug( "detailSeqList:: {{"+  i + ":" + detailSeqList.get(i).toString() +"}}" );
    			    	if(!"".equals(detailSeqList.get(i).toString())) {
	    					int detail_seq =  Integer.parseInt(detailSeqList.get(i).toString());
		    				String detail_val = detailValList.get(i).toString();
		    				zvl.put( "indexDetailSeq" , detail_seq );
	    					zvl.put( "resultScore1"   , detail_val );
		    				zvl.put( "resultScore2"   , detail_val );
		    				int cnt2 = statusExaminReqDao.selectStatusExaminDetailCnt(zvl);
		    		    	if(cnt2 > 0) {
		    		    		statusExaminReqDao.updateStatusExaminDetailRes(zvl);
		    		    	} else {
		    		    		statusExaminReqDao.insertStatusExaminDetailRes(zvl);   			
		    		    	}
    			    	}
    				}
    			}
    		}

		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Override
	public void updateStatusExaminRes(ZValue zvl, HttpServletRequest request) throws Exception {
		
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
    		String insttCd     = EgovStringUtil.nullConvert( zvl.getValue( "instt_cd" ) );  
    		String indexSeq    = EgovStringUtil.nullConvert( zvl.getValue( "index_seq" ) );  
    		String gubun       = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) );   
    		String periodCd    = EgovStringUtil.nullConvert( zvl.getValue( "periodCd" ) );   
			String modifiedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "modifiedFilesInfo" ) );
			String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
			//
	    	logger.debug( "StatusExaminReqServiceImpl:: updateStatusExaminRes " );
			if( "".equals( uploadedFilesInfo ) != true ) {
				JSONParser jsonParser = new JSONParser();
				Object obj = jsonParser.parse( uploadedFilesInfo ); 
		    	logger.debug( "updateStatusExaminRes:: obj {{"+ obj +"}}" );
				JSONArray fileInfoArray = ( JSONArray )obj; 
				for( int inx = 0; inx < fileInfoArray.size(); inx++ ) {
					JSONObject jsonObject = (JSONObject)fileInfoArray.get( inx );
					String fileId = ( String )jsonObject.get( "fileId" ); 
					fileIdList.add( fileId );
				}
			}
	    	logger.debug( "updateStatusExaminRes:: fileIdList {{"+ ( ( fileIdList == null ) ? "Null" : fileIdList.toString() ) +"}}" );
	    	//
	    	if( "".equals( atchmnfl_id ) ) {
	    		atchmnfl_id = ( ( ufileIdList.size() > 0 ) || ( fileIdList.size() > 0 ) ) ? UUID.randomUUID().toString() : atchmnfl_id;
	    	}
	    	zvl.put( "atchmnfl_id",	atchmnfl_id );
	    	zvl.put( "ufile_ids",	ufileIdList );
    		zvl.put( "file_ids",	fileIdList );
    		zvl.put( "insttCd",	    insttCd );
       		zvl.put( "indexSeq"   ,	indexSeq   );
			//
    		if("1".equals(gubun)) {
    			ZValue totScore = statusExaminReqDao.selectStatusExaminEvlSum(zvl);
         		zvl.put( "totResultScore1"   ,	totScore.getInt("RESULT_SCORE1")  );
        		zvl.put( "totResultScore2"   ,	totScore.getInt("RESULT_SCORE2")   );
    		}

       		statusExaminReqDao.updateStatusExaminRes(zvl);

	    	if("1".equals(gubun) && "G".equals(periodCd)) {
	    		statusExaminReqDao.updateStatusExaminResStat(zvl);
	    	}

    		if("2".equals(gubun)) {
    			ArrayList detailSeqList = zvl.getArrayList("detail_seq[]");
    			ArrayList detailValList = zvl.getArrayList("detail_val[]");
    			if( detailSeqList.size() > 0 ) {
    				for( int i = 0; i < detailSeqList.size(); i++ ) {
    			    	if(!"".equals(detailSeqList.get(i).toString())) {
		    				int detail_seq = Integer.parseInt(detailSeqList.get(i).toString());
		    				String detail_val = detailValList.get(i).toString();
		    				zvl.put( "indexDetailSeq" , detail_seq );
		    				if(!"G".equals(periodCd)) {
		    					zvl.put( "resultScore1"   , detail_val );
			    				zvl.put( "resultScore2"   , detail_val );
		    				} else {		    					
			    				zvl.put( "resultScore2"   , detail_val );
		    				}
		    				int cnt2 = statusExaminReqDao.selectStatusExaminDetailCnt(zvl);
		    		    	if(cnt2 > 0) {
		    		    		statusExaminReqDao.updateStatusExaminDetailRes(zvl);
		    		    	} else {
		    		    		statusExaminReqDao.insertStatusExaminDetailRes(zvl);   			
		    		    	}
    			    	}
    				}
    			}
    		}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@Override
	public void deleteStatusExaminRes(ZValue zvl, HttpServletRequest request) throws Exception {
		
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

	    	statusExaminReqDao.deleteStatusExaminRes(zvl);
	    	statusExaminReqDao.deleteStatusExaminResFile(zvl);
		}
		
	}
	
	@Override
	public int selectStatusExaminCnt(ZValue zvl) throws Exception {
		return statusExaminReqDao.selectStatusExaminCnt(zvl);
	}
	
	@Override
	public List<ZValue> selectCntStatusExaminReqstStatus(ZValue zvl) throws Exception {
		return statusExaminReqDao.selectCntStatusExaminReqstStatus(zvl);
	}

	@Override
	public void updateStatusExaminResStat(ZValue zvl, HttpServletRequest request) throws Exception {
		
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
	    	logger.debug( "StatusExaminReqServiceImpl:: updateStatusExaminResStat " );
			if( "".equals( uploadedFilesInfo ) != true ) {
				JSONParser jsonParser = new JSONParser();
				Object obj = jsonParser.parse( uploadedFilesInfo ); 
		    	logger.debug( "updateStatusExaminResStat:: obj {{"+ obj +"}}" );
				JSONArray fileInfoArray = ( JSONArray )obj; 
				for( int inx = 0; inx < fileInfoArray.size(); inx++ ) {
					JSONObject jsonObject = (JSONObject)fileInfoArray.get( inx );
					String fileId = ( String )jsonObject.get( "fileId" ); 
					fileIdList.add( fileId );
				}
			}
	    	logger.debug( "updateStatusExaminResStat:: fileIdList {{"+ ( ( fileIdList == null ) ? "Null" : fileIdList.toString() ) +"}}" );
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
       		statusExaminReqDao.updateStatusExaminResStat(zvl);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public ZValue statusExaminFobjctResnAjax(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminInsttDetailList");
		return statusExaminReqDao.statusExaminSelectOne(zvl);
	}

	@Override
	public List<ZValue> statusExaminFobjctResnFile(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.statusExaminInsttFobjctFileList");
		return statusExaminReqDao.statusExaminSelectList(zvl);
	}

	@Override
	public ZValue beforeOrderNo(ZValue zvl) throws Exception {
		zvl.put("sqlid", "statusExaminReq.beforeOrderNo");
		return statusExaminReqDao.statusExaminSelectOne(zvl);
	}

}