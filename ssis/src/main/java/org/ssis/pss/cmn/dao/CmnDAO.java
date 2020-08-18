package org.ssis.pss.cmn.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class CmnDAO extends CmnSupportDAO {
	
	/**
	 * 공통 List count 조회 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int retrieveCommonListCnt(ZValue zvl) throws Exception {
		
		return (Integer) selectCnt(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> retrieveCommonList(ZValue zvl) throws Exception {
		
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
		
	}
	
	/**
	 * 공통 상세 조회 
	 * @param zvl
	 * @return ZValue
	 * @throws Exception
	 */
	public ZValue retrieveCommonDetail(ZValue zvl) throws Exception {
		
		return (ZValue) selectOne(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 등록 처리 
	 * @param zvl
	 * @throws Exception
	 */
	public void createCommonInfo(ZValue zvl) throws Exception {
		
		insert(zvl.getString("sqlid"), zvl);
		
	}
	
	/**
	 * 공통 수정 처리 
	 * @param zvl
	 * @throws Exception
	 */
	public void modifyCommonInfo(ZValue zvl) throws Exception {
		
		update(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 공통 삭제 처리 
	 * @param zvl
	 * @throws Exception
	 */
	public void removeCommonInfo(ZValue zvl) throws Exception {
		
		delete(zvl.getString("sqlid"), zvl);
		
	}
	
	/**
	 * 공통 코드 테이블 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> retrieveChrgDutyList(ZValue zvl) throws Exception {
		
		return (List<ZValue>) selectList("cmn.commonCode", zvl);
		
	}
	 
	/**
	 * 공통 기관 코드 테이블 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> retrieveInstCodeList() throws Exception {
		
		return (List<ZValue>) selectList("cmn.instCode");
		
	}
	
	/**
	 * 권한별 메뉴 리스트 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> retrieveMenuList(String author_id) throws Exception {
		return (List<ZValue>) selectList("cmn.menuList", author_id);
	}
	
	/**
	 * 현재 차수 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public ZValue retrieveCurrentOrderNo() throws Exception {
		return  (ZValue)selectOne("cmn.currentOrderNo");
	}
	
	/**
	 * 현재 등록되어있는 차수 마지막 년도 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public ZValue retrieveMaxOrderNo() throws Exception {
		return  (ZValue)selectOne("cmn.maxOrderNo");
	}	
	
	/**
	 * 차수 리스트 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> retrieveOrderNoList() throws Exception {
		return (List<ZValue>) selectList("cmn.orderNoList");
	}
	
	/**
	 * 평가기간 코드 조회
	 * @param 
	 * @return	char
	 * @throws Exception
	 */
	public String retrieveEvlPeriodCode() throws Exception {
		return (String) selectOne("cmn.retrieveEvlPeriodCode");
	}
	
	/**
	 * 점검항목 점수 구분조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> retrieveCheckItemScoreSeList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("cmn.checkItemScoreSeList", zvl);
	}
	
	/**
	 * 점검항목 구간별 점수 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> retrieveCheckItemSctnScoreList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("cmn.checkItemSctnScoreList", zvl);
	}
	
	/**
	 * 권한 List 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> retrieveAuthorList() throws Exception {
		return (List<ZValue>) selectList("cmn.selectAuthorList");
	}

	/**
	 * READ/WRITE/DOWNLOAD 권한
	 * @param zvl
	 * @return List<ZValue>
	 */
	public List<ZValue> retrieveAuthority(ZValue zvl) {
		return (List<ZValue>) selectList("cmn.selectAuthority", zvl);
	}
}
