package org.ssis.pss.cmn.service.impl;

import java.util.List;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;

import org.ssis.pss.cmn.util.CrossUploader;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.dao.CmnDAO;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.service.CrossUploaderService;

import egovframework.com.utl.fcc.service.EgovStringUtil;

@Service
public class CrossUploaderServiceImpl implements CrossUploaderService  {
	//
	protected Logger logger = LogManager.getLogger(this.getClass()); 

	@Autowired 
	private CmnService PssCommonService;
 
 	@Override
	public void fileUpload( HttpServletRequest request, HttpServletResponse response, ZValue zvl) throws Exception {
    	logger.debug( "fileUpload:: Start" );
		try {
			ZValue zValue = CrossUploader.fileUpload( request, response, zvl );
	    	//logger.debug( "CrossUploaderServiceImpl:: zValue{{"+ zValue.toString() +"}}" );
			if( zValue != null && !zValue.isEmpty() ) {
				zValue.put( "sqlid",	"attachmentFile.insertAttachmentFile" );
				zValue.put( "registId", "System" );
		    	//logger.debug( "zValue{{"+ zValue.toString() +"}}" );
				PssCommonService.createCommonInfo( zValue );
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}		
    	logger.debug( "fileUpload:: End" );
	}
	
	@Override
	public void fileDownload( HttpServletRequest request, HttpServletResponse response, ZValue zvl) throws Exception {
    	logger.debug( "fileDownload:: Start" );
		try {
	    	logger.debug( "fileDownload :: zValue {{"+ zvl.toString() +"}}" );
	    	logger.debug( "fileDownload :: zValue.CD_DOWNLOAD_FILE_INFO {{"+ zvl.get( "CD_DOWNLOAD_FILE_INFO" ) +"}}" );
			//String downloadFormData = EgovStringUtil.getHtmlStrCnvr( ( String )request.getParameter( "CD_DOWNLOAD_FILE_INFO" ) );
			//zvl.put( "CD_DOWNLOAD_FILE_INFO", downloadFormData );
			List<ZValue> listZValue = fileList( zvl );
	    	logger.debug( "fileDownload:: listZValue {{"+ listZValue.size() +"}}" );
			if( listZValue.size() > 0 ) {
				CrossUploader.fileDownload( request, response, listZValue );
			}
		}
		catch(Exception e){
			e.printStackTrace();
			throw e;
		}
    	logger.debug( "fileDownload:: End" );
	}

	@Override
	public List<ZValue> fileList( ZValue zvl ) throws Exception {
    	logger.debug( "fileList:: Start" );
    	List<ZValue> listZValue = new ArrayList<ZValue>();
		try {
			if( zvl != null && !zvl.isEmpty() ) {
				//
				ArrayList<String> fileIdList	= new ArrayList<String>();
				//
				String downloadFormData = EgovStringUtil.nullConvert( zvl.getString( "CD_DOWNLOAD_FILE_INFO" ) );
		    	logger.debug( "fileList:: downloadFormData {{"+ downloadFormData +"}}" );
				if( "".equals( downloadFormData ) != true ) {
					JSONParser jsonParser = new JSONParser();
					Object obj = jsonParser.parse( downloadFormData ); 
			    	logger.debug( "fileList:: obj {{"+ obj +"}}" );
					JSONArray downloadFileInfoArray = ( JSONArray )obj; 
					for( int inx = 0; inx < downloadFileInfoArray.size(); inx++ ) {
						JSONObject jsonObject = (JSONObject)downloadFileInfoArray.get( inx );
						String fileId = ( String )jsonObject.get( "fileId" ); 
						fileIdList.add( fileId );
					}
				}
		    	logger.debug( "fileList:: fileIdList {{"+ ( ( fileIdList == null ) ? "Null" : fileIdList.toString() ) +"}}" );
				//
				zvl.put( "sqlid",		"attachmentFile.selectAttachmentFile" );
				zvl.put( "fileIds",		fileIdList );
				//zvl.put( "atchmnflId",	"" );
		    	logger.debug( "zValue{{"+ zvl.toString() +"}}" );
		    	listZValue = PssCommonService.retrieveCommonList( zvl );
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}		
    	logger.debug( "fileList:: End" );
    	return listZValue;
	}
}
