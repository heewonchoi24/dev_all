package org.ssis.pss.msg.service.impl;

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
import org.ssis.pss.msg.dao.MsgDao;
import org.ssis.pss.msg.service.MsgService;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class MsgServiceImpl implements MsgService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private MsgDao msgDao;
	
	@Override
	public int trnsmitMsgCntThread(ZValue zvl) throws Exception {
		return msgDao.trnsmitMsgCnt(zvl);
	}
	
	@Override
	public List<ZValue> trnsmitMsgListThread(ZValue zvl) throws Exception {
		return msgDao.trnsmitMsgList(zvl);
	}

	@Override
	public ZValue trnsmitMsgThread(ZValue zvl) throws Exception {
		return msgDao.trnsmitMsgOne(zvl);
	}

	@Override
	public List<ZValue> trnsmitUserList(ZValue zvl) throws Exception {
		return msgDao.trnsmitUserList(zvl);
	}

	@Override
	public void deleteTrnsmitMsg(ZValue zvl) throws Exception {
		ArrayList seq = zvl.getArrayList("seq[]");

		for(int i=0; i < seq.size(); i++) {
	    	zvl.put( "threadSeq", seq.get(i).toString() );

	    	msgDao.deleteTrnsmitMsg(zvl);
		}		
	}

	@Override
	public int receiveMsgCntThread(ZValue zvl) throws Exception {
		return msgDao.receiveMsgCnt(zvl);
	}
	
	@Override
	public List<ZValue> receiveMsgListThread(ZValue zvl) throws Exception {
		return msgDao.receiveMsgList(zvl);
	}

	@Override
	public ZValue receiveMsgThread(ZValue zvl) throws Exception {
		return msgDao.receiveMsgOne(zvl);
	}

	@Override
	public void deleteReceiveMsg(ZValue zvl) throws Exception {
		ArrayList seq = zvl.getArrayList("seq[]");

		for(int i=0; i < seq.size(); i++) {
	    	zvl.put( "threadSeq", seq.get(i).toString() );

	    	msgDao.deleteReceiveMsg(zvl);
		}		
	}

	@Override
	public void updateReceiveMsg(ZValue zvl) throws Exception {
		msgDao.updateReceiveMsg(zvl);
		
		int chkCnt = msgDao.cntReceiveCheck(zvl);
		if(chkCnt == 0 )
		{
			msgDao.updateTrnsmitMsg(zvl);
		}
	}

	@Override
	public List<ZValue> msgInsttListAjax(ZValue zvl) throws Exception {
		return msgDao.msgInsttListAjax(zvl);
	}

	@Override
	public List<ZValue> msgUserListAjax(ZValue zvl) throws Exception {
		return msgDao.msgUserListAjax(zvl);
	}

	@Override
	public List<ZValue> msgInsttClCdList(ZValue zvl) throws Exception {
		return msgDao.msgInsttClCdList(zvl);
	}

	@Override
	public List<ZValue> msgInsttSelectList(ZValue zvl) throws Exception {
		return msgDao.msgInsttSelectList(zvl);
	}

	@Override
	public List<ZValue> msgInsttUserList(ZValue zvl) throws Exception {
		return msgDao.msgInsttUserList(zvl);
	}

	@Override
	public void insertTrnsmitMsg(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		ArrayList<String> fileIdList	= new ArrayList<String>();

		String uploadedFilesInfo = EgovStringUtil.nullConvert( zvl.getString( "uploadedFilesInfo" ) );
		
		if( "".equals( uploadedFilesInfo ) != true ) {
			JSONParser jsonParser = new JSONParser();
			Object obj = jsonParser.parse( uploadedFilesInfo ); 
	    	logger.debug( "insertTrnsmitMsg:: obj {{"+ obj +"}}" );
			JSONArray fileInfoArray = ( JSONArray )obj; 
			for( int inx = 0; inx < fileInfoArray.size(); inx++ ) {
				JSONObject jsonObject = (JSONObject)fileInfoArray.get( inx );
				String fileId = ( String )jsonObject.get( "fileId" ); 
				Boolean isSaved = Boolean.parseBoolean( ( String )jsonObject.get( "isSaved" ) ); 
				if( isSaved == false )
					continue;
				fileIdList.add( fileId );
			}
			
    		String atchmnflId = ( fileIdList.size() > 0 ) ? UUID.randomUUID().toString() : "";
    		zvl.put( "atchmnfl_id", atchmnflId );
		}
		zvl.put( "file_ids", fileIdList );

		try {
    		zvl.put( "regist_id", userInfo.getUserId() );			// 로그인 아이디로 변경 
    		ArrayList userList  = zvl.getArrayList("user_list[]");

	    	int seqkey = msgDao.insertTrnsmitMsg(zvl);
	    	
	    	for(int i=0; i < userList.size(); i++) {
	    		zvl.put("threadSeq", zvl.getValue("seq"));
	    		zvl.put("detail_id", userList.get(i).toString());

	    		msgDao.insertReceiveMsg(zvl);   			
	    	}
	    	
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void deleteMsgFile(ZValue zvl) throws Exception {
		ArrayList seq = zvl.getArrayList("seq[]");

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
	    	zvl.put( "fileId",    fileId.get(i).toString() );

	    	msgDao.deleteMsgFile(zvl);
		}
	}

	@Override
	public List<ZValue> msgFileList(ZValue zvl) throws Exception {
		return msgDao.msgFileList(zvl);
	}
	
	@Override
	public ZValue msgPrev(ZValue zvl) throws Exception {
		if("R".equals(zvl.get("typeTR"))){
			zvl.put("sqlid", "msg.msgRPrev");
		} else if("T".equals(zvl.get("typeTR"))){
			zvl.put("sqlid", "msg.msgTPrev");
		}
		return msgDao.msgPrevNext(zvl);
	}
	
	@Override
	public ZValue msgNext(ZValue zvl) throws Exception {
		if("R".equals(zvl.get("typeTR"))){
			zvl.put("sqlid", "msg.msgRNext");
		} else if("T".equals(zvl.get("typeTR"))){
			zvl.put("sqlid", "msg.msgTNext");
		}
		return msgDao.msgPrevNext(zvl);
	}

}