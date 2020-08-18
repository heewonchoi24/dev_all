package org.ssis.pss.footer.service;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;

public interface FooterService {

	/**
	 * 푸터 텍스트 조회
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	ZValue selectFooterText(ZValue zvl) throws Exception;
	
	/**
	 * 푸터 텍스트 등록
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void insertFooterText(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 푸터 텍스트 수정
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void updateFooterText(ZValue zvl, HttpServletRequest request) throws Exception;

}
