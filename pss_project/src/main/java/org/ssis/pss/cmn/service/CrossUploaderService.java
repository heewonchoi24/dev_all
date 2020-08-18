package org.ssis.pss.cmn.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ssis.pss.cmn.model.ZValue;

public interface CrossUploaderService {

	/**
	 *  
	 * @param zvl
	 * @throws Exception
	 */
	void fileUpload( HttpServletRequest request, HttpServletResponse response, ZValue zvl) throws Exception; 
	
	/**
	 *  
	 * @param zvl
	 * @throws Exception
	 */
	void fileDownload( HttpServletRequest request, HttpServletResponse response, ZValue zvl) throws Exception; 
 

	/**
	 *  
	 * @param zvl
	 * @throws Exception
	 */
	List<ZValue> fileList( ZValue zvl ) throws Exception; 
 
}
