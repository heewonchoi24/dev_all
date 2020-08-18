package org.ssis.pss.bsis.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.ssis.pss.cmn.model.ZValue;


public interface BsisService {
	
	/**
	 * 기관 정보
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	ZValue selectInstitution(ZValue zvl) throws Exception;
	
	/**
	 * 기관 담당자
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectInstitutionUserList(ZValue zvl) throws Exception;
	
	/**
	 * 기관 / 담당자 EXCEL
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectInstitutionExcel(ZValue zvl) throws Exception;
	
	/**
	 * 기관 정보 등록/수정
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	void modifyInstitution(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 개인정보보호 교육
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectSttusEdcList(ZValue zvl) throws Exception;
	
	/**
	 * 개인정보보호 교육 등록/수정
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	void modifySttusEdc(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 개인정보 파일
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectSttusFileList(ZValue zvl) throws Exception;
	
	/**
	 * 개인정보 파일 등록/수정
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	void modifySttusFile(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 개인정보 위탁관리
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectSttusCnsgnList(ZValue zvl) throws Exception;
	
	/**
	 * 개인정보 위탁관리 등록/수정
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	void modifySttusCnsgn(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 개인정보처리시스템 현황
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectSttusSysList(ZValue zvl) throws Exception;
	
	/**
	 * 개인정보처리시스템 현황 등록/수정
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	void modifySttusSys(ZValue zvl, HttpServletRequest request) throws Exception;
	
	/**
	 * 영상정보처리기기 운영현황
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	List<ZValue> selectSttusVideoList(ZValue zvl) throws Exception;
	
	/**
	 * 영상정보처리기기 운영현황 등록/수정
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	void modifySttusVideo(ZValue zvl, HttpServletRequest request) throws Exception;
}