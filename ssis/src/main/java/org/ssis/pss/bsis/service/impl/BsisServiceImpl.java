package org.ssis.pss.bsis.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.bsis.dao.BsisDao;
import org.ssis.pss.bsis.service.BsisService;
import org.ssis.pss.cmn.model.ZValue;

import egovframework.com.cmm.SessionVO;

@Service
public class BsisServiceImpl implements BsisService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private BsisDao bsisDao;

	
	@Override
	public ZValue selectInstitution(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bsis.selectInstitution");
		return bsisDao.commonOne(zvl);
	}
	
	@Override
	public List<ZValue> selectInstitutionUserList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bsis.selectInstitutionUserList");
		return bsisDao.commonList(zvl);
	}
	
	@Override
	public List<ZValue> selectInstitutionExcel(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bsis.selectInstitutionExcel");
		return bsisDao.commonList(zvl);
	}
	
	@Override
	public void modifyInstitution(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		zvl.put("insttCd", userInfo.getInsttCd());
		zvl.put("userId", userInfo.getUserId());
		zvl.put("sqlid", "bsis.insertInstitution");
		
		bsisDao.commonInsert(zvl);
		
		zvl.put("sqlid", "bsis.deleteInstitutionUser");
		bsisDao.commonDelete(zvl);
		
		zvl.put("sqlid", "bsis.insertInstitutionUser");
		
		ArrayList dept = zvl.getArrayList("dept[]");
		ArrayList rspofc = zvl.getArrayList("rspofc[]");
		ArrayList userNm = zvl.getArrayList("userNm[]");
		ArrayList telNo = zvl.getArrayList("telNo[]");
		ArrayList email = zvl.getArrayList("email[]");
		
		for(int i=0; i < dept.size(); i++) {
			zvl.put("dept", dept.get(i).toString());
			zvl.put("rspofc", rspofc.get(i).toString());
			zvl.put("userNm", userNm.get(i).toString());
			zvl.put("telNo", telNo.get(i).toString());
			zvl.put("email", email.get(i).toString());
			bsisDao.commonInsert(zvl);
		}
	}
	
	@Override
	public List<ZValue> selectSttusEdcList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bsis.selectSttusEdcList");
		return bsisDao.commonList(zvl);
	}
	
	@Override
	public void modifySttusEdc(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		zvl.put("insttCd", userInfo.getInsttCd());
		zvl.put("userId", userInfo.getUserId());
		zvl.put("sqlid", "bsis.deleteSttusEdc");
		bsisDao.commonDelete(zvl);
		
		zvl.put("sqlid", "bsis.insertSttusEdc");
		
		ArrayList edcDe = zvl.getArrayList("edcDe[]");
		ArrayList edcTarget = zvl.getArrayList("edcTarget[]");
		ArrayList edcContents = zvl.getArrayList("edcContents[]");
		ArrayList edcMethod = zvl.getArrayList("edcMethod[]");
		ArrayList edcUserCo = zvl.getArrayList("edcUserCo[]");
		
		for(int i=0; i < edcDe.size(); i++) {
			zvl.put("edcDe", edcDe.get(i).toString());
			zvl.put("edcTarget", edcTarget.get(i).toString());
			zvl.put("edcContents", edcContents.get(i).toString());
			zvl.put("edcMethod", edcMethod.get(i).toString());
			zvl.put("edcUserCo", edcUserCo.get(i).toString());
			bsisDao.commonInsert(zvl);
		}
	}
	
	@Override
	public List<ZValue> selectSttusFileList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bsis.selectSttusFileList");
		return bsisDao.commonList(zvl);
	}
	
	@Override
	public void modifySttusFile(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		zvl.put("insttCd", userInfo.getInsttCd());
		zvl.put("userId", userInfo.getUserId());
		zvl.put("sqlid", "bsis.deleteSttusFile");
		bsisDao.commonDelete(zvl);
		
		zvl.put("sqlid", "bsis.insertSttusFile");
		
		ArrayList indvdlinfoFileNm = zvl.getArrayList("indvdlinfoFileNm[]");
		ArrayList indvdlinfoItem = zvl.getArrayList("indvdlinfoItem[]");
		ArrayList indvdlinfoColctMethod = zvl.getArrayList("indvdlinfoColctMethod[]");
		ArrayList indvdlinfoColctBasis = zvl.getArrayList("indvdlinfoColctBasis[]");
		ArrayList indvdlinfoCo = zvl.getArrayList("indvdlinfoCo[]");
		
		for(int i=0; i < indvdlinfoFileNm.size(); i++) {
			zvl.put("indvdlinfoFileNm", indvdlinfoFileNm.get(i).toString());
			zvl.put("indvdlinfoItem", indvdlinfoItem.get(i).toString());
			zvl.put("indvdlinfoColctMethod", indvdlinfoColctMethod.get(i).toString());
			zvl.put("indvdlinfoColctBasis", indvdlinfoColctBasis.get(i).toString());
			zvl.put("indvdlinfoCo", indvdlinfoCo.get(i).toString());
			bsisDao.commonInsert(zvl);
		}
	}
	
	@Override
	public List<ZValue> selectSttusCnsgnList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bsis.selectSttusCnsgnList");
		return bsisDao.commonList(zvl);
	}
	
	@Override
	public void modifySttusCnsgn(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		zvl.put("insttCd", userInfo.getInsttCd());
		zvl.put("userId", userInfo.getUserId());
		zvl.put("sqlid", "bsis.deleteSttusCnsgn");
		bsisDao.commonDelete(zvl);
		
		zvl.put("sqlid", "bsis.insertSttusCnsgn");
		
		String excpPermYn = zvl.getString("excpPermYn");
		ArrayList entrpsNm = zvl.getArrayList("entrpsNm[]");
		ArrayList jobContents = zvl.getArrayList("jobContents[]");
		ArrayList cnsgnBgnde = zvl.getArrayList("cnsgnBgnde[]");
		ArrayList cnsgnEndde = zvl.getArrayList("cnsgnEndde[]");
		ArrayList cnsgnDocYn = zvl.getArrayList("cnsgnDocYn[]");
		ArrayList cnsgnMngYn = zvl.getArrayList("cnsgnMngYn[]");
		ArrayList cnsgnDdcYn = zvl.getArrayList("cnsgnDdcYn[]");
		
		if("Y".equals(excpPermYn)) {
			zvl.put("excpPermYn", excpPermYn);
			bsisDao.commonInsert(zvl);
		} else {
			for(int i=0; i < entrpsNm.size(); i++) {
				zvl.put("excpPermYn", excpPermYn);
				zvl.put("entrpsNm", entrpsNm.get(i).toString());
				zvl.put("jobContents", jobContents.get(i).toString());
				zvl.put("cnsgnBgnde", cnsgnBgnde.get(i).toString());
				zvl.put("cnsgnEndde", cnsgnEndde.get(i).toString());
				zvl.put("cnsgnDocYn", cnsgnDocYn.get(i).toString());
				zvl.put("cnsgnMngYn", cnsgnMngYn.get(i).toString());
				zvl.put("cnsgnDdcYn", cnsgnDdcYn.get(i).toString());
				bsisDao.commonInsert(zvl);
			}
		}
	}
	
	@Override
	public List<ZValue> selectSttusSysList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bsis.selectSttusSysList");
		return bsisDao.commonList(zvl);
	}
	
	@Override
	public void modifySttusSys(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		zvl.put("insttCd", userInfo.getInsttCd());
		zvl.put("userId", userInfo.getUserId());
		zvl.put("sqlid", "bsis.deleteSttusSys");
		bsisDao.commonDelete(zvl);
		
		zvl.put("sqlid", "bsis.insertSttusSys");
		
		ArrayList sysNm = zvl.getArrayList("sysNm[]");
		ArrayList operPurps = zvl.getArrayList("operPurps[]");
		ArrayList dbEncptYn = zvl.getArrayList("dbEncptYn[]");
		ArrayList trsmrcvEncptYn = zvl.getArrayList("trsmrcvEncptYn[]");
		ArrayList ipcssYn = zvl.getArrayList("ipcssYn[]");
		
		for(int i=0; i < sysNm.size(); i++) {
			zvl.put("sysNm", sysNm.get(i).toString());
			zvl.put("operPurps", operPurps.get(i).toString());
			zvl.put("dbEncptYn", dbEncptYn.get(i).toString());
			zvl.put("trsmrcvEncptYn", trsmrcvEncptYn.get(i).toString());
			zvl.put("ipcssYn", ipcssYn.get(i).toString());
			bsisDao.commonInsert(zvl);
		}
	}
	
	@Override
	public List<ZValue> selectSttusVideoList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "bsis.selectSttusVideoList");
		return bsisDao.commonList(zvl);
	}
	
	@Override
	public void modifySttusVideo(ZValue zvl, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		zvl.put("insttCd", userInfo.getInsttCd());
		zvl.put("userId", userInfo.getUserId());
		zvl.put("sqlid", "bsis.deleteSttusVideo");
		bsisDao.commonDelete(zvl);
		
		zvl.put("sqlid", "bsis.insertSttusVideo");
		
		String excpPermYn = zvl.getString("excpPermYn");
		
		ArrayList instlLc = zvl.getArrayList("instlLc[]");
		ArrayList videoCo = zvl.getArrayList("videoCo[]");
		ArrayList purps = zvl.getArrayList("purps[]");
		ArrayList othbcYn = zvl.getArrayList("othbcYn[]");
		ArrayList drcbrdYn = zvl.getArrayList("drcbrdYn[]");
		ArrayList fdrmChckYn = zvl.getArrayList("fdrmChckYn[]");
		
		if("Y".equals(excpPermYn)) {
			zvl.put("excpPermYn", excpPermYn);
			bsisDao.commonInsert(zvl);
		} else {
			for(int i=0; i < instlLc.size(); i++) {
				zvl.put("excpPermYn", excpPermYn);
				zvl.put("instlLc", instlLc.get(i).toString());
				zvl.put("purps", purps.get(i).toString());
				zvl.put("videoCo", videoCo.get(i).toString());
				zvl.put("othbcYn", othbcYn.get(i).toString());
				zvl.put("drcbrdYn", drcbrdYn.get(i).toString());
				zvl.put("fdrmChckYn", fdrmChckYn.get(i).toString());
				bsisDao.commonInsert(zvl);
			}
		}
	}

}