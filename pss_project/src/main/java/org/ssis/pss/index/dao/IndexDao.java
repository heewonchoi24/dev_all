package org.ssis.pss.index.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class IndexDao extends CmnSupportDAO {

	/**
	 * 점검항목구간별점수 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectCheckItemSctnScoreList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("index.selectCheckItemSctnScoreList", zvl);
	}
	
	/**
	 * 점검항목구간별점수 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void insertCheckItemSctnScore(ZValue zvl) throws Exception {
		insert("index.insertCheckItemSctnScore", zvl);
	}
	
	/**
	 * 점검항목구간별점수 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteCheckItemSctnScore(ZValue zvl) throws Exception {
		delete("index.deleteCheckItemSctnScore", zvl);
	}
	
	/**
	 * 점검항목점수구분 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectCheckItemScoreSeList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("index.selectCheckItemScoreSeList", zvl);
	}
	
	/**
	 * 점검항목점수구분 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void insertCheckItemScoreSe(ZValue zvl) throws Exception {
		insert("index.insertCheckItemScoreSe", zvl);
	}
	
	/**
	 * 점검항목점수구분 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteCheckItemScoreSe(ZValue zvl) throws Exception {
		delete("index.deleteCheckItemScoreSe", zvl);
	}
	
	/**
	 * 관리수준진단 지표 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectMngLevelIndexList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("index.selectMngLevelIndexMastrList", zvl);
	}
	
	/**
	 * 관리수준진단 대분류 ORDER 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectMngLclasOrderCnt() throws Exception {
		return (Integer) selectCnt("index.selectLclasOrderCnt");
	}
	
	
	/**
	 * 관리수준진단 지표 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void insertMngLevelIndex(ZValue zvl) throws Exception {
		insert("index.insertMngLevelIdxMastr", zvl);
	}
	
	/**
	 * 관리수준진단 지표 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteMngLevelIndex(ZValue zvl) throws Exception {
		delete("index.deleteMngLevelIndexMastr", zvl);
	}
	
	/**
	 * 관리수준 현황조사 지표 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminIndexList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("index.selectStatusExaminIndexList", zvl);
	}
	
	/**
	 * 관리수준 지표 번호 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectMngLevelIndexSeqList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("index.selectMngLevelIndexSeqList", zvl);
	}
	
	/**
	 * 관리수준 현황조사 대분류 ORDER 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectStatusLclasOrderCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("index.selectStatusLclasOrderCnt", zvl);
	}
	
	/**
	 * 관리수준 현황조사 지표 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public int insertStatusExaminIdx(ZValue zvl) throws Exception {
		return (Integer) insert("index.insertStatusExaminIdx", zvl);
	}
	
	/**
	 * 관리수준 현황조사 상세 지표 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void insertStatusExaminIdxDetail(ZValue zvl) throws Exception {
		insert("index.insertStatusExaminIdxDetail", zvl);
	}
	
	/**
	 * 관리수준 현황조사 지표 상세 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminIndexDtlList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("index.selectStatusExaminIndexDtlList", zvl);
	}
	
	/**
	 * 관리수준 현황조사 지표 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteStatusExaminIdx(ZValue zvl) throws Exception {
		delete("index.deleteStatusExaminIdx", zvl);
	}
	
	/**
	 * 관리수준 현황조사 상세 지표 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteStatusExaminIdxDetail(ZValue zvl) throws Exception {
		delete("index.deleteStatusExaminIdxDetail", zvl);
	}
	
	/**
	 * 관리수준진단 기관 등록 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectMngLevelReqstCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("index.selectMngLevelReqstCnt", zvl);
	}
	
	/**
	 * 관리수준 현황조사 기관 평가 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectStatusExaminEvalCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("index.selectStatusExaminEvalCnt", zvl);
	}
}
