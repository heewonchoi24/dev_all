package org.ssis.pss.mylibry.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

@Repository
public class MylibryDao extends CmnSupportDAO {

	@SuppressWarnings("unchecked")
	public List<ZValue> mylibryBbsList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mylibry.mylibryBbsList04", zvl);
	}
	
	@SuppressWarnings("unchecked")
	public List<ZValue> mylibryBbsFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mylibry.mylibryBbsFileList04", zvl);
	}
	
	@SuppressWarnings("unchecked")
	public List<ZValue> mylibryAttachFileList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mylibry.mylibryAttachFileList", zvl);
	}
	
	@SuppressWarnings("unchecked")
	public List<ZValue> mylibryBbsImg(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList("mylibry.mylibryBbsImg", zvl);
	}

	public ZValue mylibryFile(ZValue zvl) throws Exception {
		return (ZValue) selectOne("mylibry.mylibryAttachFile", zvl);
	}
	
	public void mylibryFileInsert(ZValue zvl) throws Exception {
		insert("mylibry.mylibryFileInsert", zvl);
	}
	
	public void mylibryFileDelete(ZValue zvl) throws Exception {
		delete("mylibry.mylibryFileDelete", zvl);
	}

	public ZValue mylibryBsisSttusCnt(ZValue zvl) throws Exception {
		return (ZValue) selectOne("mylibry.mylibryBsisSttusCnt", zvl);
	}

	public ZValue selectMngLevelResult(ZValue zvl) throws Exception {
		return (ZValue) selectOne("mylibry.selectMngLevelResult", zvl);
	}

}
