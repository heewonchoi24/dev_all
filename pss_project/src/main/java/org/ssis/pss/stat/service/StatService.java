package org.ssis.pss.stat.service;

import java.util.List;

import org.ssis.pss.cmn.model.ZValue;


public interface StatService {
	
	/**
	 * 기초현황 통계 데이터
	 * @param zvl
	 * @returnList<ZValue>
	 * @throws Exception
	 */
	List<ZValue> bsisStatusDataList(ZValue zvl) throws Exception;
	
	/**
	 * 지표별 관리수준진단(기관) 통계 데이터
	 * @param zvl
	 * @returnList<ZValue>
	 * @throws Exception
	 */
	List<ZValue> indexInstitutionMngStatList(ZValue zvl) throws Exception;
	
	/**
	 * 지표별 관리수준진단(관리자) 통계 데이터
	 * @param zvl
	 * @returnList<ZValue>
	 * @throws Exception
	 */
	List<ZValue> indexMngStatList(ZValue zvl) throws Exception;
	
	/**
	 * 지표별 현황조사(기관) 통계 데이터
	 * @param zvl
	 * @returnList<ZValue>
	 * @throws Exception
	 */
	List<ZValue> indexInstitutionStatusStatList(ZValue zvl) throws Exception;
	
	/**
	 * 지표별 현황조사(관리자) 통계 데이터
	 * @param zvl
	 * @returnList<ZValue>
	 * @throws Exception
	 */
	List<ZValue> indexStatusStatList(ZValue zvl) throws Exception;
	
	/**
	 * 기관별 현황 - 관리수준진단 결과 통계 데이터
	 * @param zvl
	 * @returnList<ZValue>
	 * @throws Exception
	 */
	List<ZValue> insttStatManageLevelEvlList(ZValue zvl) throws Exception;
	
	/**
	 * 기관별 현황 - 관리수준현황 결과 통계 데이터
	 * @param zvl
	 * @returnList<ZValue>
	 * @throws Exception
	 */
	List<ZValue> insttStatStatusExaminList(ZValue zvl) throws Exception;
	
	/**
	 * 기관별 현황 - 개별기관 연도별 통계 데이터
	 * @param zvl
	 * @returnList<ZValue>
	 * @throws Exception
	 */
	List<ZValue> insttStatOrgEvlList(ZValue zvl) throws Exception;
	
	
	/**
	 * 접속 통계 데이터
	 * @param zvl
	 * @returnList<ZValue>
	 * @throws Exception
	 */
	List<ZValue> conectHistDataList(ZValue zvl) throws Exception;
}