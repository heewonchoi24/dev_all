package org.ssis.pss.statusExaminRst.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class StatusExaminRstDao extends CmnSupportDAO {
	
	/**
	 * 관리수준 현황조사 종합 결과 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminRstSummaryList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminRst.selectStatusExaminRstSummaryList", zvl);
	}
	
	/**
	 * 관리수준 현황조사 종합 결과
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue selectStatusExaminRstSummary(ZValue zvl) throws Exception {
		return (ZValue) selectOne("statusExaminRst.selectStatusExaminRstSummary", zvl);
	}
	
	/**
	 * 관리수준 현황조사 최종결과 파일 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminRstSummaryFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminRst.selectStatusExaminRstSummaryFileList", zvl);
	}
	
	/**
	 * 관리수준 현황조사 결과 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminRstList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminRst.selectStatusExaminRstList", zvl);
	}
	
	/**
	 * 관리수준 현황조사 상세 SUM 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminRstDtlSum(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminRst.selectStatusExaminRstDtlSum", zvl);
	}
	
	/**
	 * 관리수준 현황조사 결과 상세 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminRstDtlAllList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminRst.selectStatusExaminRstDtlAllList", zvl);
	}
	
	/**
	 * 관리수준 현황조사 결과 상세 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminRstDtlList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminRst.selectStatusExaminRstDtlList", zvl);
	}
	
	/**
	 * 관리수준 현황조사 결과
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue selectStatusExaminRst(ZValue zvl) throws Exception {
		return (ZValue) selectOne("statusExaminRst.selectStatusExaminRst", zvl);
	}
	
	/**
	 * 관리수준 현황조사 신청 파일 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminRstFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminRst.selectStatusExaminRstFileList", zvl);
	}
	
	/**
	 * 관리수준 현황조사 결과 메모 파일 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminEvlMemoFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminRst.selectStatusExaminEvlMemoFileList", zvl);
	}
	
	/**
	 * 관리수준 현황조사 결과 이의신청 파일list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminEvlFobjctFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminRst.selectStatusExaminEvlFobjctFileList", zvl);
	}
	
	/**
	 * 관리수준 현황조사 파일 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectAttachmentFileMapCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("statusExaminRst.selectAttachmentFileMapCnt", zvl);
	}
	
	/**
	 * 관리수준 현황조사 파일 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deletefile(ZValue zvl) throws Exception {
		delete("statusExaminRst.deletefile", zvl);
	}
	
	/**
	 * 관리수준 현황조사 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateStatusExaminRstFobjct(ZValue zvl) throws Exception {
		update("statusExaminRst.updateStatusExaminRstFobjct", zvl);
	}
	
	/**
	 * 관리수준 현황조사 파일 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateStatusExaminEvlFobjctFile(ZValue zvl) throws Exception {
		update("statusExaminRst.updateStatusExaminEvlFobjctFile", zvl);
	}
	
	/**
	 * 관리수준 현황조사 이의신청 파일 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteStatusExaminEvlFobjctFile(ZValue zvl) throws Exception {
		update("statusExaminRst.deleteStatusExaminEvlFobjctFile", zvl);
	}
	
	/**
	 * 관리수준 현황조사 결과 전체
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectStatusExaminExcelDtlList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("statusExaminRst.selectStatusExaminExcelDtlList", zvl);
	}
}
