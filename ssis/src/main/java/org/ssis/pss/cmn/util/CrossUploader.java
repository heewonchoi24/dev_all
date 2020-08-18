
package org.ssis.pss.cmn.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.channels.Channels;
import java.nio.channels.FileChannel;
import java.nio.channels.WritableByteChannel;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.time.StopWatch;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.FileCopyUtils;
import org.ssis.pss.cmn.model.ZValue;

import com.drew.lang.StringUtil;
import com.initech.safedb.SimpleSafeDB;
import com.initech.safedb.sdk.exception.SafeDBSDKException;
import com.namo.crossuploader.CrossUploaderException;
import com.namo.crossuploader.FileDownload;
import com.namo.crossuploader.FileItem;
import com.namo.crossuploader.FileUpload;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovDateUtil;

/**
 * crossUploader.java Class title
 * 
 * <p><ul><li>The crossUploader.java description.</li></ul>
 *
 * @version 1.0.0
 * @since 2017. 08. 18.
 */

public class CrossUploader {
	
	protected static Log log = LogFactory.getLog( CrossUploader.class );
	
	/**
	 *  
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
    public static ZValue fileUpload( HttpServletRequest request, HttpServletResponse response, ZValue zvl ) throws Exception {

		log.debug( "CrossUploader:: fileUpload :: Start..." );
		ZValue zValue = new ZValue(); 
		PrintWriter writer = response.getWriter();
		FileUpload fileUpload = new FileUpload( request, response, "UTF-8" ); 
		log.debug( "fileUpload :: fileUpload {{"+ fileUpload +"}}" );		
		
		try { 
			// autoMakeDirs를 true로 설정하면 파일 저장 및 이동시 파일생성에 필요한 상위 디렉토리를 모두 생성합니다.
			fileUpload.setAutoMakeDirs( true );

			// 파일을 저장할 경로를 설정합니다.
			//String saveDirPath = request.getRealPath("/");
			//saveDirPath += ("UploadDir" + File.separator);
			String filePath = File.separator;
			String crossuploaderFilePath = Globals.CROSSUPLOADER_FILE_PATH;
			// 경로에 년/월/일을 추가한다.
			String saveDirPath = filePath + EgovDateUtil.getCurrentDate( "yyyy/MM/dd" );
			String fullFilePath = "";

			// saveDirPath에 지정한 경로로 파일 업로드를 시작합니다. 
			fileUpload.startUpload( crossuploaderFilePath + saveDirPath );
			
			// 업로드 경로를 지정하지 않을 경우, 시스템의 임시 디렉토리로 파일 업로드를 시작합니다.		
			// fileUpload.startUpload(); 

			/**
			 * 입력한 file 태그의 name을 키로 갖는 FileItem[] 객체를 리턴합니다.  
			 * NamoCrossUploader Client Flex Edition의 name은 "CU_FILE" 입니다.
			 */
			FileItem fileItem = fileUpload.getFileItem( "CU_FILE" ); 
			log.debug( "fileUpload :: fileItem {{"+ fileItem +"}}" );

			if(fileItem != null) { 
				String fileId = UUID.randomUUID().toString();
				fullFilePath = crossuploaderFilePath + saveDirPath + File.separator  + fileId;
				
				// saveDirPath 경로에 원본 파일명으로 저장(이동)합니다. 동일한 파일명이 존재할 경우 다른 이름으로 저장됩니다.
				fileItem.save( crossuploaderFilePath + saveDirPath );
 
				// 2019-05-08 CrossUploader copyFile 을 FileUtils.copyFile 로 대체
				// fileItem.copyFile( crossuploaderFilePath + saveDirPath,  fileId ); 
				
				File originalFile = new File(fileItem.getFile().getAbsolutePath());
				File copiedFile = new File(fullFilePath);
				FileUtils.copyFile(originalFile, copiedFile);
				
				fileItem.deleteFile();
				
				//파일 암호화 로컬 개발 환경에서는 이 부분을 주석처리 하고 테스
				file_encrypts(fullFilePath);

				zValue.put( "fileId",					fileId ); 
				zValue.put( "name",						fileItem.getName() ); 
				zValue.put( "fileName",					fileItem.getFileName() ); 
				zValue.put( "lastSavedDirectoryPath",	saveDirPath.replaceAll("\\\\", "/" ) );	// ffileItem.getLastSavedDirPath().replaceAll("\\\\", "/") ); 
				zValue.put( "lastSavedFilePath",		fileItem.getLastSavedFilePath().replaceAll("\\\\", "/" )); 
				zValue.put( "lastSavedFileName",		fileId );								// fileItem.getLastSavedFileName() ); 
				zValue.put( "fileSize",					Long.toString(fileItem.getFileSize()) ); 
				zValue.put( "fileNameWithoutFileExt",	fileItem.getFileNameWithoutFileExt() ); 
				zValue.put( "fileExtension",			fileItem.getFileExtension() ); 
				zValue.put( "contentType",				fileItem.getContentType() ); 
				zValue.put( "isSaved",					Boolean.toString(fileItem.isSaved()) ); 
				zValue.put( "isEmptyFile",				Boolean.toString(fileItem.isEmptyFile()) );
				zValue.put( "isDeleted",				Boolean.FALSE );
				zValue.put( "modifiedFileId",			"" );

				log.debug( "CrossUploader:: fileUpload :: jsonObject {{"+ zValue.getJSONValue().toString() +"}}" );
				response.setCharacterEncoding( "UTF-8" );
				response.getWriter().println( zValue.getJSONValue().toString() );
			}
		}
		catch(CrossUploaderException ex) {
			zValue = null; 
			response.setStatus( response.SC_INTERNAL_SERVER_ERROR );
		}
		catch(Exception ex) { 
			zValue = null; 
			// 업로드 외 로직에서 예외 발생시 업로드 중인 모든 파일을 삭제합니다. 
			fileUpload.deleteUploadedFiles(); 
			response.setStatus( response.SC_INTERNAL_SERVER_ERROR );
			ex.printStackTrace();
		}
		finally { 
			// 파일 업로드 객체에서 사용한 자원을 해제합니다. 
			if( fileUpload != null ) {  
				fileUpload.clear(); 
			}
		}
		log.debug( "CrossUploader:: fileUpload :: zValue {{"+ ( ( zValue != null ) ? zValue.toString() : "Null" ) +"}}" );
		log.debug( "CrossUploader:: fileUpload :: Done..." );
		return zValue; 
	}
	
	/**
	 *  
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
    public static void fileDownload( HttpServletRequest request, HttpServletResponse response, ZValue zvl  ) throws Exception {
		
	}
	@SuppressWarnings("rawtypes")
    public static void fileDownload( HttpServletRequest request, HttpServletResponse response, List<ZValue> zList ) throws Exception {
		log.debug( "fileDownload :: Start..." );
		ZValue zValue = new ZValue(); 
		
		String tempZipFilePath = "";
		File decPath = null;
		String decPathStr ="";
		String decFilePathStr ="";
		boolean isSingleFile = false;
		FileDownload fileDownload = new FileDownload( request, response, "UTF-8" );
		
		String fileNameAlias	= "";
		String file_name		= "";
		String save_file_name	= "";
		String file_path		= "";
		String crossuploaderFilePath = Globals.CROSSUPLOADER_FILE_PATH;
		String filePath = crossuploaderFilePath;
		
		try {
			if ( ( zList == null ) || ( zList.size() < 1 ) ) 
				throw new Exception( "다운로드 중 예외가 발생했습니다." );
			
			log.debug( "fileDownload :: filePath {{"+ filePath +"}}" );
			log.debug( "fileDownload :: zList {{"+ zList.size() +"}}" );
			
			if( zList.size() == 1 ) {
				
				zValue 			= zList.get( 0 );
				file_name 		= zValue.getString( "FILE_NAME" ); 
				save_file_name 	= zValue.getString( "SAVE_FILE_NAME" ); 
				file_path 		= zValue.getString( "FILE_PATH" ); 
	            filePath		= filePath + file_path + File.separator + save_file_name;
	            decPathStr 		= Globals.CROSSUPLOADER_TEMP_PATH + File.separator  + UUID.randomUUID().toString();
	            decPath 	    = new File(decPathStr);
				decFilePathStr  = decPathStr + File.separator +  save_file_name;
				fileNameAlias	= file_name;
				isSingleFile    = true;
				
				if( !decPath.exists() ) {
					try {
						decPath.mkdirs();
					}
					catch(Exception ex) {
						log.error( ex );
						ex.printStackTrace();
					}
				}
				
				//파일복호화
				file_decrypts(filePath, decFilePathStr);
				filePath = decFilePathStr;
			}
			else if( zList.size() > 1) {

				tempZipFilePath = compressFiles( zList );
		        Date dt = new Date();
		        SimpleDateFormat sdf = new SimpleDateFormat( "yyyyMMddHHmmss" );
	            filePath = tempZipFilePath;
	            fileNameAlias = "pss_"+ sdf.format( dt ) .toString() +".zip";
			}
			// fileNameAlias는 웹서버 환경에 따라 적절히 인코딩 되어야 합니다.
			fileNameAlias = URLEncoder.encode( fileNameAlias, "UTF-8" ); 
            log.debug( "fileDownload :: fileNameAlias {{"+ fileNameAlias +"}}" ); 
			boolean attachment = true;  
			// resumable 옵션에 따라 파일 이어받기가 가능합니다.
			// 클라이언트에서 이어받기 요청이 있어야 하며, 이어받기 요청이 없을 경우 일반 다운로드와 동일하게 동작합니다.
			boolean resumable = true;  
			// filePath에 지정된 파일을 fileNameAlias 이름으로 다운로드 합니다. 
			fileDownload.startDownload( filePath, fileNameAlias, attachment, resumable ); 
			
		}
		catch(CrossUploaderException ex) { 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
            log.error( "다운로드 중 예외 발생 : " + ex.getMessage() );
            throw ex;
		}
		catch(FileNotFoundException ex) { 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
			log.error(  "다운로드 중 예외 발생 : " + ex.getMessage() );
			throw ex;
		}
		catch(IOException ex) { 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
			log.error(  "다운로드 중 예외 발생 : " + ex.getMessage() );
			throw ex;
		}
		catch(Exception ex) { 
			response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
			log.error(  "다운로드 중 예외 발생 : " + ex.getMessage() );
			throw ex;
		}
		finally {
			File downloadCompleteFile = new File(filePath);
			if(isSingleFile){
				String downloadCompleteFilePath = downloadCompleteFile.getParent(); 
				
				FileUtils.deleteDirectory(new File(downloadCompleteFilePath));
			}else{
				downloadCompleteFile.delete();
			}
			
			//try {	FileSystemUtils.deleteRecursively( new File( tempZipFilePath ) );	}	catch(Exception ex) {}	finally {}
		}
		log.debug( "fileDownload :: Done..." );
		return;
	}
	
	private static void startDownload( HttpServletRequest request, HttpServletResponse response, String filePath, String fileNameAlias, boolean attachment, boolean resumable )  throws Exception
	{
        log.debug( "startDownload :: Start" );
        
		File file			= null;
		OutputStream out	= null;
		FileInputStream fis	= null;
		String browser		= "";
		String disposition	= "";

		FileChannel inputChannel			= null; 
		WritableByteChannel outputChannel	= null; 

        log.debug( "startDownload :: filePath {{"+ filePath +"}}" );
        log.debug( "startDownload :: fileNameAlias {{"+ fileNameAlias +"}}" );

		try {
			file = new File( filePath );
			if( file.isFile() && file.exists() ) {
				browser = getBrowser( request );
				disposition = getDisposition( fileNameAlias, browser );

				response.setContentType( "application/octet-stream: charset=utf-8" );
				response.setContentLength( ( int )file.length() );
				response.setHeader( "Content-Disposition", disposition );
				response.setHeader( "Content-Transfer-Encoding", "binary" );

				out = response.getOutputStream();
				fis = new FileInputStream( file );
				inputChannel	= fis.getChannel();
				outputChannel	= Channels.newChannel( response.getOutputStream() );
				inputChannel.transferTo( 0, fis.available(), outputChannel );
			}
		}
		catch(Exception ex) { 
			ex.printStackTrace();
		}
		finally {
			//
			try {	if( inputChannel.isOpen() )		inputChannel.close();	} catch(Exception ex) {} finally {}
			try {	if( outputChannel.isOpen() )	outputChannel.close();	} catch(Exception ex) {} finally {}
			//
			try {	if( fis != null )	fis.close();						} catch(Exception ex) {} finally {}
			try {	if( out != null )	out.flush();	out.close();		} catch(Exception ex) {} finally {}
		}
        log.debug( "startDownload :: End" );
	}

	
	private static String getBrowser( HttpServletRequest request ) throws Exception {
		//
		String header	=  request.getHeader( "User-Agent" );
		//
		if( ( header.indexOf( "MSIE" ) > -1 ) || ( header.indexOf( "Trident" ) > -1 ) )
			return "MSIE";
		if( header.indexOf( "Chrome" ) > -1 )
			return "Chrome";
		if( header.indexOf( "Opera" ) > -1 )
			return "Opera";
		return "FireFox";
	}
	private static String getDisposition( String filename, String browser ) throws UnsupportedEncodingException  {
		//
		String dispositionPerfix	= "attachment;filename=";
		String encodedFilename 	= "";
		//
		if( browser.equals( "MSIE" ) ) {
			encodedFilename = URLEncoder.encode( filename, "UTF-8").replaceAll( "\\+", "%20" );
		}
		else if( browser.equals( "Firefox" ) ) {
			encodedFilename = "\"" + new String( filename.getBytes("UTF-8"), "8895_1" ) + "\"";
		}
		else if( browser.equals( "Opera" ) ) {
			encodedFilename = "\"" + new String( filename.getBytes("UTF-8"), "8895_1" ) + "\"";
		}
		else if( browser.equals( "Chrome" ) ) {
			StringBuffer sb = new StringBuffer();
			for( int i = 0; i < filename.length(); i++ ) {
				char c = filename.charAt( i );
				if( c > '~' )
					sb.append( URLEncoder.encode( "" + c , "UTF-8" ) );
				else 
					sb.append( c );
			}
			encodedFilename = sb.toString();
		}
		return( dispositionPerfix + encodedFilename );
	}
	
	
	public static String compressFiles( List<ZValue> filePathList) throws IOException
	{
		final int BUFFER_SIZE		= 1024 * 2;
		final int COMPRESSION_LEVEL	= 8;			// Default 
		String tempZipFilePath		= "";
		File tempZipFile			= null;
		String tempZipDirectory		= ""; 
		File tempZipDir				= null; 

		try  {
			// 파일을 임시 디렉토리에 복사한다.
			// 임시디렉토리를 만든다.
			tempZipDirectory	= Globals.CROSSUPLOADER_TEMP_PATH + File.separator  + UUID.randomUUID().toString() ;
			tempZipDir			= new File( tempZipDirectory ); 
			//log.debug( "compressFiles :: tempZipDirectory {{"+ tempZipDirectory +"}}" );
			if( !tempZipDir.exists() ) {
				try {
					tempZipDir.mkdirs();
				}
				catch(Exception ex) {
					log.error( ex );
					ex.printStackTrace();
				}
			}
			// 파일을 임시 디렉토리에 복사한다.
			for( int i = 0; i < filePathList.size(); i++ ) {
				try { 
					String filePath	= filePathList.get( i ).getString( "FILE_PATH" );
					String srcFile	= filePathList.get( i ).getString( "SAVE_FILE_NAME" );
					String desFile	= filePathList.get( i ).getString( "FILE_NAME" );
					
					srcFile	= Globals.CROSSUPLOADER_FILE_PATH + File.separator + filePath + File.separator + srcFile;
					desFile	= tempZipDirectory + File.separator + desFile;
					
					file_decrypts(srcFile, desFile);
//					fileCopy( srcFile, desFile );
				}
				catch(Exception ex) {
					log.error( ex );
					ex.printStackTrace();
				}
			}
			//
			// 파일을 임시 디렉토리에 있는 파일들을 압축한다.
			tempZipFile					= File.createTempFile( "pss_download_", ".tmp", new File( Globals.CROSSUPLOADER_TEMP_PATH ) );
			FileOutputStream fos		= new FileOutputStream( tempZipFile );		// FileOutputStream;
			BufferedOutputStream bos 	= new BufferedOutputStream( fos );			// BufferedStream
			ZipArchiveOutputStream zos	= new ZipArchiveOutputStream( bos );		// ZipOutputStream
			//ZipOutputStream zos			= new ZipOutputStream( bos );		// ZipOutputStream
			zos.setLevel( COMPRESSION_LEVEL );										// 압축 레벨 - 최대 압축률은 9, 디폴트 8
			
			try {
		        File[] zipFiles		= new File( tempZipDirectory ).listFiles();
		        log.debug( "compressFiles :: zipFiles {{"+ zipFiles.length +"}}" );
				for( File sFile : zipFiles ) {
					
			        log.debug( "compressFiles :: sFile {{"+ sFile.getPath() +"}}" );
					File sourceFile = new File( sFile.getPath() );
					
					BufferedInputStream bis = new BufferedInputStream( new FileInputStream( sourceFile ) );
					ZipArchiveEntry zentry = new ZipArchiveEntry( sourceFile.getName() );

					zentry.setTime( sourceFile.lastModified() );
					zos.setUseLanguageEncodingFlag( true );
					zos.setEncoding( "UTF-8" );
					zos.putArchiveEntry( zentry );

					byte[] buffer = new byte[ BUFFER_SIZE ];
					int cnt = 0;
					while ( ( cnt = bis.read( buffer, 0, BUFFER_SIZE ) ) != -1  ) {
						zos.write( buffer, 0, cnt  );
					}
					if ( bis != null )
						bis.close();
					//
					//zos.finish();
					zos.closeArchiveEntry();
					//zos.closeEntry();
				}
			}
			catch(Exception ex) {
				log.error( ex );
				ex.printStackTrace();
			}
			finally {
					if( zos != null )	zos.finish();	zos.close();
					if( bos != null )	bos.close();
					if( fos != null )	fos.close();
					FileUtils.deleteDirectory(new File(tempZipDirectory));
			}
		}
		catch(Exception ex) {
			log.error( ex );
			ex.printStackTrace();
		}
		finally {
			
			//try {	FileSystemUtils.deleteRecursively( new File( tempZipDirectory ) );	}	catch(Exception ex) {}	finally {}
		}

		tempZipFilePath = tempZipFile.getPath(); 
		return tempZipFilePath; 
	}

	
	public static int fileCopy( String srcFile, String desFile ) throws IOException {
		try { 
			File iFile	= new File( srcFile );
			File oFile	= new File( desFile );
			
			while( oFile.exists() ) {
				oFile.getName();
				String fileNameArr[] =  desFile.split( "\\." );
				fileNameArr[ fileNameArr.length - 2 ] = fileNameArr[ fileNameArr.length - 2 ] + "_copy";
				desFile = StringUtil.join( fileNameArr, "." );
				oFile	= new File( desFile );
			}

			FileCopyUtils.copy( iFile, oFile );
		}
		catch(Exception ex) {
			log.error( ex );
			ex.printStackTrace();
		}

		return 0;
	}
	
	public static void file_encrypts(String enc_path) throws Exception
	{
		String user_name = "SAFEDB";
		String table = "SAFEDB.Agent-API";
		String column = "PSS_SAFEDB";	
		SimpleSafeDB safedb = null;
		
		safedb = SimpleSafeDB.getInstance();
		if (safedb.login())
		{
			StopWatch sw = new StopWatch();
			sw.start();
			try {
				String result = safedb.file_unit_encrypt(user_name, table, column, enc_path);				
			} catch(SafeDBSDKException e) {
				e.printStackTrace();
			}
			sw.stop();
		}
	}
	
	public static void file_decrypts(String enc_path, String dec_path)
	{
		String user_name = "SAFEDB";
        String table = "SAFEDB.Agent-API";
        String column = "PSS_SAFEDB";
        SimpleSafeDB safedb = null;
		
		safedb = SimpleSafeDB.getInstance();
		if (safedb.login())
		{
			StopWatch sw = new StopWatch();
			sw.start();

			try {
				String result = safedb.file_unit_decrypt(user_name, table, column, enc_path, dec_path);
			} catch(SafeDBSDKException e) {
				e.printStackTrace();
			}
			sw.stop();
		}
	}
}
