package org.ssis.pss.popup.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.ssis.pss.cmn.model.ZValue;

public interface PopupService {

	/**
	 * 컨텐츠 관리 - 팝업 관리 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> popupList(ZValue zvl) throws Exception;

	/**
	 *  컨텐츠 관리 - 팝업 관리 등록/수정
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void popupRegistThread(ZValue zvl, MultipartHttpServletRequest request) throws Exception;

}
