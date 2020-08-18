package org.ssis.pss.mngLevelRst.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class MngLevelRstDao extends CmnSupportDAO {
	
	/**
	 * 관리수준 종합 결과 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectMngLevelResultSummaryList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRst.selectMngLevelResultSummaryList", zvl);
	}
	
	/**
	 * 관리수준 종합 결과
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue selectMngLevelResultSummary(ZValue zvl) throws Exception {
		return (ZValue) selectOne("mngLevelRst.selectMngLevelResultSummary", zvl);
	}
	
	/**
	 * 관리수준 결과 리스트
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectMngLevelResultList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRst.selectMngLevelResultList", zvl);
	}
	
	/**
	 * 관리수준 결과
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue selectMngLevelResult(ZValue zvl) throws Exception {
		return (ZValue) selectOne("mngLevelRst.selectMngLevelResult", zvl);
	}
	
	/**
	 * 관리수준 신청 파일 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectMngLevelRequestFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRst.selectMngLevelRequestFileList", zvl);
	}
	
	/**
	 * 관리수준 결과 메모 파일 list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectMngLevelEvlMemoFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRst.selectMngLevelEvlMemoFileList", zvl);
	}
	
	/**
	 * 관리수준 결과 이의신청 파일list
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectMngLevelEvlFobjctFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mngLevelRst.selectMngLevelEvlFobjctFileList", zvl);
	}
	
	/**
	 * 관리수준진단 파일 카운트
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int selectAttachmentFileMapCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("mngLevelRst.selectAttachmentFileMapCnt", zvl);
	}
	
	/**
	 * 관리수준진단 파일 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deletefile(ZValue zvl) throws Exception {
		delete("mngLevelRst.deletefile", zvl);
	}
	
	/**
	 * 관리수준진단 파일 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateMngLevelRstFobjct(ZValue zvl) throws Exception {
		update("mngLevelRst.updateMngLevelRstFobjct", zvl);
	}
	
	/**
	 * 관리수준진단 파일 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateMngLevelEvlFobjctFile(ZValue zvl) throws Exception {
		update("mngLevelRst.updateMngLevelEvlFobjctFile", zvl);
	}
	
	/**
	 * 관리수준진단 이의신청 파일 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteMngLevelEvlFobjctFile(ZValue zvl) throws Exception {
		update("mngLevelRst.deleteMngLevelEvlFobjctFile", zvl);
	}
}
