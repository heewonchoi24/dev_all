package org.ssis.pss.qestnar.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class QestnarDao extends CmnSupportDAO {

	/**
	 * 설문리스트 갯수 조회 
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int qestnarCnt(ZValue zvl) throws Exception {
		return (Integer) selectCnt("qestnar.cntThread", zvl);
	}
	
	/**
	 * 설문리스트 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> qestnarList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("qestnar.listThread", zvl);
	}

	/**
	 * 설문리스트 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertQestnarList(ZValue zvl) throws Exception {
		return (Integer) insert("qestnar.insertQestnar", zvl);
	}

	/**
	 * 설문리스트 수정
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void updateQestnarList(ZValue zvl) throws Exception {
		update("qestnar.updateQestnar", zvl);
	}

	/**
	 * 설문리스트 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteQestnarList(ZValue zvl) throws Exception {
		delete("qestnar.deleteQestnar", zvl);
	}
	
	/**
	 * 설문리스트 항목 삭제
	 * @param zvl
	 * @return void
	 * @throws Exception
	 */
	public void deleteQestnarItem(ZValue zvl) throws Exception {
		delete("qestnar.deleteQestnarItem", zvl);
	}

	/**
	 * 설문마스터 단건 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public ZValue selectQestnar(ZValue zvl) throws Exception {
		return (ZValue) selectOne("qestnar.selectQestnar", zvl);
	}

	/**
	 * 설문항목 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertQestnarItem(ZValue zvl) throws Exception {
		return (Integer) insert("qestnar.insertQestnarItem", zvl);
	}
	/**
	 * 설문항목 보기 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertQestnarItemDetail(ZValue zvl) throws Exception {
		return (Integer) insert("qestnar.insertQestnarItemDetail", zvl);
	}

	/**
	 * 설문항목 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectItemList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("qestnar.selectItemList", zvl);
	}

	/**
	 * 설문보기 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> selectDetailList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("qestnar.selectDetailList", zvl);
	}

	/**
	 * 설문 주관식 항목 응답 목록 조회
	 * @param zvl
	 * @return List<ZValue>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> qestnarResultList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("qestnar.qestnarResultList", zvl);
	}

	/**
	 * 설문응답 결과 등록
	 * @param zvl
	 * @return int
	 * @throws Exception
	 */
	public int insertQestnarResult(ZValue zvl) throws Exception {
		return (Integer) insert("qestnar.insertQestnarResult", zvl);
	}

}

