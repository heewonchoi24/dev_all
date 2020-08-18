package org.ssis.pss.statusExaminReq.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

import egovframework.com.utl.fcc.service.EgovStringUtil;

@Repository
public class StatusExaminReqDao extends CmnSupportDAO {

	/**
	 * 현황조사 - 실적등록(기관분류 select box 변경 시 기관 목록 AJAX)ㄴ
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> StatusExaminInsttListAjax(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminReq.statusExaminInsttList", zvl);
	}

	/**
	 * 현황조사 - 실적등록 - 기관 목록(테이블용)
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> statusExaminInsttTableList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminReq.statusExaminInsttTableList", zvl);
	}

	/**
	 * 현황조사 - 실적등록 - 평가항목 년도
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> statusExaminInsttEvlOrderList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminReq.statusExaminInsttEvlOrderList", zvl);
	}

	/**
	 * 현황조사 - 실적등록 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> statusExaminInsttList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminReq.statusExaminInsttList", zvl);
	}

	/**
	 * 현황조사 - 실적등록 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> statusExaminInsttSelectList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminReq.statusExaminInsttSelectList", zvl);
	}

	/**
	 * 현황조사 - 실적등록 - 기관 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> statusExaminInsttClCdList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminReq.statusExaminInsttClCdList", zvl);
	}

	/**
	 * 현황조사 - 실적등록 - 평가 항목 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> statusExaminIdxList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminReq.statusExaminIdxList", zvl);
	}

	/**
	 * 현황조사 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> statusExaminSelectList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 현황조사 단일 항목
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	public ZValue statusExaminSelectOne(ZValue zvl) throws Exception {
		return (ZValue) selectOne(zvl.getString("sqlid"), zvl);
	}

	/**
	 * 현황조사 - 실적등록 - 평가 상태 목록
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> statusExaminInsttEvlList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminReq.statusExaminInsttEvlList", zvl);
	}

	/**
	 * 현황조사 등록 List 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminIndexList(ZValue zvl) throws Exception {
		
		return (List<ZValue>) selectList("statusExaminReq.selectStatusExaminMastrList", zvl);
		
	}	

	/**
	 * 현황조사 대분류 ORDER 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectLclasOrderCnt() throws Exception {
		return (Integer) selectCnt("statusExaminReq.selectLclasOrderCnt");
	}

	/**
	 *현황조사 결과 등록 여부 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectStatusExaminCnt(ZValue zvl) throws Exception {
		String gubun       = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) ); 
		if("1".equals(gubun)) {
			return (Integer) selectCnt("statusExaminReq.selectStatusExaminGnrlzEvlCnt", zvl);
		} else {
			return (Integer) selectCnt("statusExaminReq.selectStatusExaminEvlCnt", zvl);
		}
	}

	/**
	 * 현황 집계 결과 등록 여부 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public ZValue selectStatusExaminEvlSum(ZValue zvl) throws Exception {
		return (ZValue) selectOne("statusExaminReq.selectStatusExaminEvlSum", zvl);
	}

	/**
	 * 현황조사 결과 등록 여부 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectStatusExaminDetailCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("statusExaminReq.selectStatusExaminEvlDetailCnt", zvl);
	}

	@SuppressWarnings("unchecked")
	public List<ZValue> selectCntStatusExaminReqstStatus(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminReq.selectCntStatusExaminReqstStatus", zvl);
	}

	/**
	 * 현황조사 결과 삭제 여부 확인
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int seleteStatusExaminResFileCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("statusExaminReq.seleteStatusExaminResFileCnt", zvl);
	}

	/**
	 * 현황조사 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void insertStatusExaminRes(ZValue zvl) throws Exception {
		String gubun       = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) ); 
		if("1".equals(gubun)) {
			insert("statusExaminReq.insertSttusExaminGnrlzEvl", zvl);
		} else {
			insert("statusExaminReq.insertSttusExaminEvl", zvl);
		}
	}

	/**
	 * 현황조사 등록
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void insertStatusExaminDetailRes(ZValue zvl) throws Exception {
		insert("statusExaminReq.insertSttusExaminEvlDetail", zvl);
	}

	/**
	 * 현황조사 실적 등록 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteStatusExaminReqst(ZValue zvl) throws Exception {
		String gubun       = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) ); 
		if("1".equals(gubun)) {
			delete("statusExaminReq.deleteSttusExaminGnrlzEvl", zvl);
		} else {
			delete("statusExaminReq.deleteSttusExaminEvl", zvl);
		}
	}

	/**
	 * 현황조사 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateStatusExaminRes(ZValue zvl) throws Exception {
		String gubun       = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) ); 
		if("1".equals(gubun)) {
			update("statusExaminReq.updateSttusExaminGnrlzEvl", zvl);
		} else {
			update("statusExaminReq.updateSttusExaminEvl", zvl);			
		}
	}

	/**
	 * 현황조사 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateStatusExaminDetailRes(ZValue zvl) throws Exception {
		update("statusExaminReq.updateSttusExaminEvlDetail", zvl);			
	}

	/**
	 * 현황조사 실적 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteStatusExaminResFile(ZValue zvl) throws Exception {
		delete("statusExaminReq.deleteStatusExaminResFile", zvl);
	}
	/**
	 * 현황조사 실적 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteStatusExaminRes(ZValue zvl) throws Exception {
		delete("statusExaminReq.deleteStatusExaminRes", zvl);
	}

	/**
	 * 현황조사 결과 등록 상태 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateStatusExaminResStat(ZValue zvl) throws Exception {
		update("statusExaminReq.updateStatusExaminEvlStat", zvl);
	}

	/**
	 * 현황조사 등록 단건 조회 
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue selectStatusExaminEvl(ZValue zvl) throws Exception {
		
		return (ZValue) selectOne("statusExaminReq.selectStatusExaminEvl", zvl);
		
	}	

}
