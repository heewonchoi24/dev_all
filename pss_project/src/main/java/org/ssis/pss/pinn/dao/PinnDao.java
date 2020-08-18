package org.ssis.pss.pinn.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class PinnDao extends CmnSupportDAO {
	
	/**
	 * 서면점검 종합 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectPinnSummaryList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("pinn.selectPinnSummaryList", zvl);
	}
	
	/**
	 * 기관 그룹 종합 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectInsttGroupList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("pinn.selectInsttGroupList", zvl);
	}
	
	/**
	 * 기관 그룹 selectbox list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectInsttClSelectBoxList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("pinn.selectInsttClSelectBoxList", zvl);
	}
	
	/**
	 * 기관 selectbox list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectInsttSelectBoxList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("pinn.selectInsttSelectBoxList", zvl);
	}
	
	/**
	 * 서면점검 스케즐 연도 selectbox list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectFyerSchdulSelectBoxList() throws Exception {
		return (List<ZValue>) selectList("pinn.selectFyerSchdulSelectBoxList");
	}
	
	/**
	 * 서면점검 상세 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectPinnReqEvalDtlList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("pinn.selectPinnReqEvalDtlList", zvl);
	}
	
	/**
	 * 서면점검 등록 파일 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectPinnReqFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("pinn.selectPinnReqFileList", zvl);
	}
	
	/**
	 * 서면점검 결과 파일 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectPinnEvalFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("pinn.selectPinnEvalFileList", zvl);
	}
	
	/**
	 * 서면점검 등록(기관)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void insertPinnReqstEval(ZValue zvl) throws Exception {
		insert("pinn.insertPinnReqstEval", zvl);
	}
	
	/**
	 * 서면점검 수정(기관)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void updatePinnReqst(ZValue zvl) throws Exception {
		update("pinn.updatePinnReqst", zvl);
	}
	
	/**
	 * 서면점검 삭제(기관)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void deletePinnReqst(ZValue zvl) throws Exception {
		delete("pinn.deletePinnReqst", zvl);
	}
	
	/**
	 * 서면점검 파일 마스터 삭제
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void deletePinnReqstEvalFileMstr(ZValue zvl) throws Exception {
		delete("pinn.deletePinnReqstEvalFileMstr", zvl);
	}
	
	/**
	 * 서면점검 파일 맵 삭제
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void deletePinnReqstEvalFileMap(ZValue zvl) throws Exception {
		delete("pinn.deletePinnReqstEvalFileMap", zvl);
	}
	
	/**
	 * 서면점검 카운트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public int selectPinnReqstEvalCnt(ZValue zvl) throws Exception {
		return selectCnt("pinn.selectPinnReqstEvalCnt", zvl);
	}
	
	/**
	 * 서면점검 파일 맵 카운트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public int selectPinnReqstEvalFileCnt(ZValue zvl) throws Exception {
		return selectCnt("pinn.selectPinnReqstEvalFileCnt", zvl);
	}
	
	/**
	 * 서면점검 평가
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void updatePinnEval(ZValue zvl) throws Exception {
		update("pinn.updatePinnEval", zvl);
	}
	
	/**
	 * 서면점검 평가 삭제
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void deletePinnEval(ZValue zvl) throws Exception {
		update("pinn.deletePinnEval", zvl);
	}
	
	/**
	 * 서면점검 평가 상태 수정
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void updatePinnEvalStatus(ZValue zvl) throws Exception {
		update("pinn.updatePinnEvalStatus", zvl);
	}
	
	/**
	 * 서면점검 평가 상태 수정
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void insertPinnEvalStatus(ZValue zvl) throws Exception {
		update("pinn.insertPinnEvalStatus", zvl);
	}
	
	/**
	 * 서면점검 평가 상태 수정
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public void deletePinnEvalStatus(ZValue zvl) throws Exception {
		update("pinn.deletePinnEvalStatus", zvl);
	}
}
