package org.ssis.pss.mngLevelRes.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class MngLevelResDao extends CmnSupportDAO {

	/**
	 * 관리수준 진단 - 실적등록(기관분류 select box 변경 시 기관 목록 AJAX)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> MngLevelInsttListAjax(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRes.mngLevelInsttList", zvl);
	}

	/**
	 * 관리수준 진단 - 실적등록 - 기관 목록(테이블용)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> mngLevelInsttTableList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRes.mngLevelInsttTableList", zvl);
	}

	/**
	 * 관리수준 진단 - 실적등록 - 평가항목 년도
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> mngLevelInsttEvlOrderList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRes.mngLevelInsttEvlOrderList", zvl);
	}

	/**
	 * 관리수준 진단 - 실적등록 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> mngLevelInsttList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRes.mngLevelInsttList", zvl);
	}

	/**
	 * 관리수준 진단 - 실적등록 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> mngLevelInsttSelectList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRes.mngLevelInsttSelectList", zvl);
	}

	/**
	 * 관리수준 진단 - 실적등록 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> mngLevelInsttClCdList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRes.mngLevelInsttClCdList", zvl);
	}

	/**
	 * 관리수준 진단 - 실적등록 - 평가 항목 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> mngLevelIdxList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRes.mngLevelIdxList", zvl);
	}

	/**
	 * 관리수준 진단 - 실적등록 - 평가 상태 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> mngLevelInsttEvlList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRes.mngLevelInsttEvlList", zvl);
	}

	/**
	 * 관리수준진단 등록 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectMngLevelIndexList(ZValue zvl) throws Exception {
		
		return (List<ZValue>) selectList("mngLevelRes.selectMngLevelMastrList", zvl);
		
	}	

	/**
	 * 관리수준진단 대분류 ORDER 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectLclasOrderCnt() throws Exception {
		return (Integer) selectCnt("mngLevelRes.selectLclasOrderCnt");
	}

	/**
	 * 관리수준진단 결과 등록완료 여부 확인용 지표건수 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectMngLevelIdxCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("mngLevelRes.selectMngLevelIdxCnt", zvl);
	}

	/**
	 * 관리수준진단 결과 등록완료 여부 확인용 등록건수 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectMngLevelReqstCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("mngLevelRes.selectMngLevelReqstCnt", zvl);
	}

	/**
	 * 관리수준진단 결과 등록완료 여부 확인용 상태코드별 등록건수 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectCntMngLevelReqstStatus(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRes.selectCntMngLevelReqstStatus", zvl);
	}

	/**
	 * 관리수준진단 결과 삭제 여부 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int seleteMngLevelResFileCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("mngLevelRes.seleteMngLevelResFileCnt", zvl);
	}

	/**
	 * 관리수준진단 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void insertMngLevelRes(ZValue zvl) throws Exception {
		insert("mngLevelRes.insertMngLevelReqst", zvl);
	}

	/**
	 * 관리수준진단 실적 등록 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteMngLevelReqst(ZValue zvl) throws Exception {
		delete("mngLevelRes.deleteMngLevelReqst", zvl);
	}

	/**
	 * 관리수준진단 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateMngLevelRes(ZValue zvl) throws Exception {
		update("mngLevelRes.updateMngLevelReqst", zvl);
	}

	/**
	 * 관리수준진단 실적 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteMngLevelResFile(ZValue zvl) throws Exception {
		delete("mngLevelRes.deleteMngLevelResFile", zvl);
	}
	/**
	 * 관리수준진단 실적 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteMngLevelRes(ZValue zvl) throws Exception {
		delete("mngLevelRes.deleteMngLevelRes", zvl);
	}

	/**
	 * 관리수준진단 결과 등록 상태 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateMngLevelResStat(ZValue zvl) throws Exception {
		update("mngLevelRes.updateMngLevelReqstStat", zvl);
	}

	/**
	 * 관리수준진단 등록 단건 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue selectMngLevelReqst(ZValue zvl) throws Exception {
		
		return (ZValue) selectOne("mngLevelRes.selectMngLevelReqst", zvl);
		
	}	

	/**
	 * 관리수준진단 등록 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> mngLevelInsttFileList(ZValue zvl) throws Exception {
		
		return (List<ZValue>) selectList("mngLevelRes.mngLevelInsttFileList", zvl);
		
	}	

	/**
	 * 관리수준진단 결과 등록완료 여부 확인용 기초현황 등록 건수 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectBsisSttusCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("mngLevelRes.selectBsisSttusCnt", zvl);
	}
	
	/**
	 * 관리수준 진단 - 실정등록 및 조회 - 최대 업로드 가능 파일 사이즈
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue getLimitFileSize(ZValue zvl) throws Exception {
		return (ZValue) selectOne("mngLevelRes.getLimitFileSize", zvl);
	}	
}
