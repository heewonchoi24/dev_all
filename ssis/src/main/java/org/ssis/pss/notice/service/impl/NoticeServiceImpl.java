package org.ssis.pss.notice.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.ssis.pss.connect.web.servie.ConnectService;
import org.ssis.pss.notice.dao.NoticeDao;
import org.ssis.pss.notice.service.NoticeService;
import org.ssis.pss.user.service.UserService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class NoticeServiceImpl implements NoticeService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private NoticeDao noticeDao;
	
	@Autowired
	private UserService UserService;	
	
	@Autowired
	private ConnectService connectService;	
	
	@Override
	public List<ZValue> noticeBbsList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsManageList");
		return noticeDao.noticeCommonList(zvl);
	}
	
	@Override
	public void updateBbsStatus(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.updateBbsStatus");
		noticeDao.noticeCommonUpdate(zvl);
	}
	
	@Override
	public void deleteThread(ZValue zvl) throws Exception {
		String[] arr = zvl.getString("delSeqArr").split(",");
		List<String> list  = Arrays.asList(arr); 
		
		zvl.remove("delSeqArr");
		zvl.put("delSeqArr", list);
		zvl.put("sqlid", "notice.deleteThread");
		noticeDao.noticeCommonUpdate(zvl);
	}
	
	@Override
	public void rollbackThread(ZValue zvl) throws Exception {
		String[] arr = zvl.getString("delSeqArr").split(",");
		List<String> list  = Arrays.asList(arr); 
		
		zvl.remove("delSeqArr");
		zvl.put("delSeqArr", list);
		zvl.put("sqlid", "notice.rollbackThread");
		noticeDao.noticeCommonUpdate(zvl);
	}
	
	@Override
	public ZValue bbsNm(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsNm");
		return noticeDao.noticeCommonSelect(zvl);
	}
	
	@Override
	public List<ZValue> bbsList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsList");
		return noticeDao.noticeCommonList(zvl);
	}
	
	@Override
	public ZValue bbsView(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsView");
		return noticeDao.noticeCommonSelect(zvl);
	}
	
	@Override
	public int bbsListCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsListCnt");
		return noticeDao.noticeCommonCnt(zvl);
	}
	
	@Override
	public List<ZValue> bbsAttachFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsAttachFileList");
		return noticeDao.noticeCommonList(zvl);
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
			zvl.put("sqlid", "notice.bbsThreadFileInsert");
			noticeDao.noticeCommonInsert(zvl);
			logger.debug("############## noticeCommonInsertSelectKey ##############");
			logger.debug(zvl);
			logger.debug("############## noticeCommonInsertSelectKey ##############");
		} else {
			zvl.put("sqlid", "notice.bbsThreadFileUpdate");
			noticeDao.noticeCommonUpdate(zvl);
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
		zvl.put("sqlid", "notice.bbsThreadFileUpdate");

		logger.debug("############## bbsFileUpdate zvl ##############");
		logger.debug(zvl);
		logger.debug("############## bbsFileUpdate zvl ##############");
		
   		noticeDao.noticeCommonUpdate(zvl);
	}
	
	
	@Override
	public void bbsFileDelete(ZValue zvl, HttpServletRequest request) throws Exception {
		ArrayList<?> fileId = zvl.getArrayList("file_id[]");
		ArrayList<?> filePath = zvl.getArrayList("filePath[]");
		
    	String crossuploaderFilePath = Globals.CROSSUPLOADER_FILE_PATH;

    	String deleleFilePath = crossuploaderFilePath;

    	String atchmnfl_id = null;
    	
		for(int i=0; i < fileId.size(); i++) {
			deleleFilePath = crossuploaderFilePath + filePath.get(i).toString();
 
			File temp = new File(EgovWebUtil.filePathWhiteList(deleleFilePath));

	    	logger.info( "deleteMngLevelRes:deleleFilePath: "+ deleleFilePath );
	    	
			if (!temp.exists()) {
		    	logger.info( "deleteMngLevelRes:deleleFilePath:NotFound "+ deleleFilePath );
			} else {
				temp.delete();
		    	logger.info( "deleteMngLevelRes:deleleFilePath:Deleted "+ deleleFilePath );
			}
			
	    	zvl.put( "file_id",    fileId.get(i).toString() );
	    	atchmnfl_id = (String) noticeDao.selectOne("notice.bbsGetAttachId", zvl.getString("file_id"));
	    	zvl.put( "atchmnfl_id", atchmnfl_id );
	    	
	    	zvl.put("sqlid", "notice.bbsAttachFileDelete");
	    	noticeDao.noticeCommonDelete(zvl);
		}
		
		int cnt = noticeDao.selectCnt("notice.bbsAttachFileCnt", zvl);
		
		logger.debug("############  bbsAttachFileDeleteId  ############");
		logger.debug("cnt : " + cnt);
		logger.debug("zvl : " + zvl);
		logger.debug("############  bbsAttachFileDeleteId  ############");
		
		if(cnt == 0) {
			zvl.put("sqlid", "notice.bbsAttachFileDeleteId");
			noticeDao.noticeCommonUpdate(zvl);
		}
	}
	
	@Override
	public void bbsRegistThread(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		zvl.put("user_id", userInfo.getUserId());
		
		int cnt = noticeDao.selectCnt("notice.bbsThreadCnt", zvl);
		if(cnt > 0) {
			zvl.put("sqlid", "notice.bbsThreadUpdate");
			logger.debug("############## zvl1 ##############");
			logger.debug(zvl);
			logger.debug("############## zvl1 ##############");
			noticeDao.noticeCommonUpdate(zvl);
			bbsImgUseYNUpdate(zvl);
			
			// 로그 이력 저장
			String menu_id = null;
			String url = "/admin/notice/mngNoticeDtlList.do?bbsCd=" + zvl.get("bbsCd");
			zvl.put("url", url);
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);			
			zvl.put("parameter",  zvl.toString());
			zvl.put("bbs_cd",     zvl.get("bbsCd"));
			zvl.put("crud",       LogCrud.UPDATE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			zvl.put("view_seq",   zvl.getString("bbsSeq"));
			UserService.connectHistoryInsert(zvl, request);	
	
		} else {
			zvl.put("sqlid", "notice.bbsThreadInsert");
			logger.debug("############## zvl2 ##############");
			logger.debug(zvl);
			logger.debug("############## zvl2 ##############");
			noticeDao.noticeCommonInsert(zvl);
			
			// 로그 이력 저장
			String menu_id = null;
			String url = "/admin/notice/mngNoticeDtlList.do?bbsCd=" + zvl.get("bbsCd");
			zvl.put("url", url);
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);			
			zvl.put("parameter",  zvl.toString());
			zvl.put("bbs_cd",     zvl.get("bbsCd"));
			zvl.put("crud",       LogCrud.INSERT);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			zvl.put("view_seq",   zvl.getString("bbsSeq"));
			UserService.connectHistoryInsert(zvl, request);	
		}
	}
	
	@Override
	public void bbsRegistThreadAnswer(ZValue zvl, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		zvl.put("user_id", userInfo.getUserId());
		zvl.put("sqlid", "notice.bbsThreadAnswerUpdate");

		noticeDao.noticeCommonUpdate(zvl);		
	}
	
	@Override
	public void bbsTypeUpdateThread(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsTypeUpdate");
		noticeDao.noticeCommonUpdate(zvl);
	}

	@Override
	public void bbsListImgInsertThread(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		zvl.put("user_id", userInfo.getUserId());
		
		try {
			String log = EgovStringUtil.nullConvert(zvl.getString("log"));
		
			zvl.put("sqlid", "notice.bbsImgListInsert");
			noticeDao.noticeCommonInsert(zvl);
			
			if(log.equals("true")){
				// 로그 이력 저장
				String menu_id = "";
				String url = "/admin/notice/listImgInsert.do";
				zvl.put("url", url);
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);		
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	@Override
	public ZValue bbsImgList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsImgList");
		return noticeDao.noticeCommonSelect(zvl);
	}
	
	@Override
	public void bbsImgUseYNUpdate(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsImgUseYNUpdate");
		noticeDao.noticeCommonUpdate(zvl);
	}
	
	@Override
	public void bbsImgdelete(ZValue zvl) throws Exception {
	
		String uploadPath = Globals.CROSSUPLOADER_FILE_PATH;
		String saveDirPath = uploadPath + "bbsImg/";
		logger.debug("############## file delete start  ##############");
		File file = new File(saveDirPath + zvl.get("img_nm"));
		
		logger.debug("@@@@@@@ " + saveDirPath + zvl.get("img_nm"));
		if( file.exists() ){
			try { file.delete(); } 
			catch(Exception e) {
				logger.error( e );
				e.printStackTrace();
			}
		}
		logger.debug("############## file delete end  ##############");
		
		zvl.put("sqlid", "notice.bbsImgDelete");
		noticeDao.noticeCommonDelete(zvl);
	}
	
	@Override
	public void bbsImgUpdate(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsImgUpdate");
		noticeDao.noticeCommonUpdate(zvl);
	}
	
	@Override
	public int bbsImgCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "notice.bbsImgListFileCnt");
		return noticeDao.noticeCommonCnt(zvl);
	}
	
}