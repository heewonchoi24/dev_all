package org.ssis.pss.sort.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;

public interface SortService {

	/**
	 * 컨텐츠 관리 - 메인 컨텐츠 순서 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	List<ZValue> sortList(ZValue zvl) throws Exception;
	
	/**
	 * 컨텐츠 관리 - 메인 컨텐츠 순서 전체 삭제 후 등록
	 * @param zvl
	 * @param request
	 * @throws Exception
	 */
	void sortRegistThread(ZValue zvl, HttpServletRequest request) throws Exception;
}
