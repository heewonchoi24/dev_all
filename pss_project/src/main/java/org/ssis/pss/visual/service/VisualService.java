package org.ssis.pss.visual.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;

public interface VisualService {

	/**
	 * 컨텐츠 관리 > 메인 비주얼 관리 - 메인 비주얼 리스트 조회
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> visualList(ZValue zvl) throws Exception;
	
	/**
	 * 컨텐츠 관리 > 메인 비주얼 관리 - 메인 비주얼 등록
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void visualRegistThread(ZValue zvl, HttpServletRequest request) throws Exception;
	
}
