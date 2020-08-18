package org.ssis.pss.user.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.util.SHAPasswordEncoder;
import org.ssis.pss.user.dao.UserDao;
import org.ssis.pss.user.service.UserService;
import org.ssis.pss.util.Globals;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.SessionVO;

@Service
public class UserServiceImpl implements UserService  {
	
	
	protected Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired 
	private UserDao UserDao;

	@Override
	public LoginVO userLogin(LoginVO loginVO) throws Exception {
		LoginVO result = (LoginVO) UserDao.userLogin(loginVO);
		
		return result;
	}
	
	@Override
	public LoginVO certLogin(ZValue zvl) throws Exception {
		zvl.put("sqlid", "cmn.certLoginUserSelect");
		return (LoginVO)UserDao.certLogin(zvl);
	}
	
	@Override
	public ZValue userInfo(ZValue zvl) throws Exception {
		return UserDao.userInfo(zvl);
	}
	
	@Override
	public void certRegist(ZValue zvl) throws Exception {
		UserDao.certRegist(zvl);
	}
	
	@Override
	public void userUpdate(ZValue zvl) throws Exception {
		UserDao.updateUser(zvl);
	}
	
	@Override
	public void connectHistoryInsert(ZValue zvl, HttpServletRequest request) throws Exception {

		String clientIp = request.getRemoteAddr();
		
		HttpSession session = request.getSession();
		
		if(null != session) {
			SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
			if(null != userInfo) {
				zvl.put("user_id", userInfo.getUserId());
			}
		}
		
		zvl.put("ip", clientIp);
		
		UserDao.insert("user.connectHistoryInsert", zvl);
	}
	
	@Override
	public void lastConnectDtUpdate(ZValue zvl, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		zvl.put("user_id", userInfo.getUserId());
		
		UserDao.update("user.lastConnectDtUpdate", zvl);
	}
	
	@Override
	public void passwordErrorCntUpdate(LoginVO loginVO) throws Exception {
		UserDao.insert("user.passwordErrorCntDtUpdate", loginVO);
	}
	
	@Override
	public void passwordErrorCntDtReset(LoginVO loginVO) throws Exception {
		UserDao.insert("user.passwordErrorCntDtReset", loginVO);
	}
	
	
	@Override
	public String passUpdate(ZValue zvl) throws Exception {
		LoginVO loginVO = new LoginVO();
		String user_pw = zvl.getValue("password");

		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);
	    user_pw = shaPasswordEncoder.encode(user_pw);
	    
	    loginVO.setUserId(zvl.getValue("userId"));
	    loginVO.setPassword(user_pw);
	    
		LoginVO result = (LoginVO) UserDao.userLogin(loginVO);

		if (result != null && result.getUserId() != null && !result.getUserId().equals("")) {
			String new_pw = zvl.getValue("password_new");
			new_pw = shaPasswordEncoder.encode(new_pw);
			zvl.put("password", new_pw);
			UserDao.updatePass(zvl);
			return "Y";
		}
		return "N";
	}
	
	@Override
	public List<ZValue> userList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.userList");
		return UserDao.userCommonList(zvl);
	}
	
	@Override
	public int userListCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.userListCnt");
		return UserDao.userCommonCnt(zvl);
	}
	
	@Override
	public List<ZValue> insctrInsttList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.insctrInsttList");
		return UserDao.userCommonList(zvl);
	}
	
	@Override
	public List<ZValue> insctrInsttExcelList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.selectUserInsctrExcelList");
		return UserDao.userCommonList(zvl);
	}
	
	@Override
	public void setInsctrInstt(ZValue zvl) throws Exception {
		String[] insttArray = zvl.getString("instt_cds").split(",");
		List<String> insttList = Arrays.asList(insttArray); 
		
		zvl.remove("instt_cds");
		zvl.put("instt_cds" ,insttList);
		zvl.put("sqlid", "user.setInsctrInstt");
		
		UserDao.userCommonInsert(zvl);
	}
	
	@Override
	public void createInsctr(ZValue zvl) throws Exception {
		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);

		String insctrId = "";
		String password = "";
		String[] insctrNmArray = zvl.getString("insctrNms").split(",");
		String[] ip1Array = zvl.getString("permIp1").split(",");
		String[] ip2Array = zvl.getString("permIp2").split(",");
		String[] ip3Array = zvl.getString("permIp3").split(",");
		String[] ip4Array = zvl.getString("permIp4").split(",");
		
		String mngLevelCd = zvl.getValue("mngLevelCd");
		if(Globals.MNG_LEVEL_CD.equals(mngLevelCd)) {
			zvl.put("mngLevelType", "ds");
		} else {
			zvl.put("mngLevelType", "se");
		}
		
		zvl.put("sqlid", "user.insertUserInsctr");
		for(int i=0; i < insctrNmArray.length; i++){
			insctrId = UserDao.selectString("user.selectNextInsctrNo", zvl);
			password = shaPasswordEncoder.encode(insctrId);
			
			String insctrNm = insctrNmArray[i];
			String permIp = ip1Array[i]+"."+ip2Array[i]+"."+ip3Array[i]+"."+ip4Array[i];
			zvl.put("user_nm", insctrNm);
			zvl.put("permIp", permIp);
			zvl.put("user_id", insctrId);
			zvl.put("password", password);
			
			logger.debug("################## INSTRD INFO ######################");
			logger.debug(zvl);
			logger.debug("################## INSTRD INFO ######################");
			
			UserDao.userCommonInsert(zvl);
		}
	}
	
	@Override
	public void updateInsctr(ZValue zvl) throws Exception {
		
		zvl.put("sqlid", "user.updateUserInsctr");
		String permIp = zvl.getValue("permIp1")+"."+zvl.getValue("permIp2")+"."+zvl.getValue("permIp3")+"."+zvl.getValue("permIp4");
		zvl.put("permIp", permIp);
		
		UserDao.userCommonUpdate(zvl);
	}
	
	@Override
	public void updateInsctrPasswd(ZValue zvl) throws Exception {
		
		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);
	    String password = shaPasswordEncoder.encode(zvl.getValue("userId"));
	    
	    zvl.put("password", password);
		zvl.put("sqlid", "user.updateInsctrPasswd");
		
		UserDao.userCommonUpdate(zvl);
	}
	
	@Override
	public void deleteInsctr(ZValue zvl) throws Exception {
		
		zvl.put("sqlid", "user.deleteUserInsctr");
		
		UserDao.userCommonUpdate(zvl);
	}
	
	@Override
	public String resetPassword(ZValue zvl) throws Exception{
		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);
	    
	    zvl.put("user_id", zvl.getString("userId"));
	    
	    ZValue userInfo = UserDao.userInfo(zvl);
	    
		String userEmail = userInfo.getString("EMAIL");
		String encUserEmail = null;
		
		encUserEmail = shaPasswordEncoder.encode(userEmail);
		zvl.put("password", encUserEmail);
		
		UserDao.update("user.resetPassword", zvl);
		
		return userEmail;
	}
	
	public void userInfoModify(ZValue zvl) throws Exception {
		String isModify = zvl.getString("isModify");
		
		//암호 암호화
		String user_pw = zvl.getString("password");
		
		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);
	    user_pw = shaPasswordEncoder.encode(user_pw);
	    
    	logger.debug("######################################################");
    	logger.debug("user_pw : \n" + user_pw);
    	logger.debug("######################################################");
	    
	    zvl.setValue("password", user_pw);
		
		if("Y".equals(isModify)){
			zvl.put("sqlid", "user.modifyUser");
			UserDao.userCommonUpdate(zvl);
		}else{
			zvl.put("sqlid", "user.createUser");
			UserDao.userCommonInsert(zvl);
		}
	}
	
	@Override
	public void userDelete(ZValue zvl) throws Exception {
		String[] userArray = zvl.getString("user_ids").split(",");
		List<String> userList = Arrays.asList(userArray); 
		zvl.remove("user_ids");
		zvl.put("user_ids" ,userList);
		zvl.put("sqlid", "user.userDelete");
		UserDao.userCommonUpdate(zvl);
	}

	@Override
	public ZValue findUserId(ZValue zvl) throws Exception {
		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);

		ZValue result = UserDao.findId(zvl);
		
		String user_id = zvl.getValue("user_id");
		String password = zvl.getValue("password");
		
		if(!"".equals(password)) {
			zvl.put("userId", user_id);
			String new_pw = zvl.getValue("password");
			new_pw = shaPasswordEncoder.encode(new_pw);
			zvl.put("password", new_pw);
			UserDao.updatePass(zvl);			
		}
		return result;
	}

	@Override
	public void firstLoginChangePassword(ZValue zvl) throws Exception {
		String user_pw = zvl.getValue("password_new");

		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);
	    user_pw = shaPasswordEncoder.encode(user_pw);
	    
		zvl.setValue("password", user_pw);
		
		UserDao.update("user.firstLoginChangePassword", zvl);
	}
	
	@Override
	public List<ZValue> selectUserCertificationList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.selectUserCertificationList");
		return UserDao.userCommonList(zvl);
	}
	
	@Override
	public int selectUserCertificationCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.selectUserCertificationCnt");
		return UserDao.userCommonCnt(zvl);
	}
	
	@Override
	public void insertUserCertification(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.insertUserCertification");
		UserDao.userCommonInsert(zvl);
	}
	
	@Override
	public void updateUserCertification(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.updateUserCertification");
		UserDao.userCommonUpdate(zvl);
	}
	
	@Override
	public void deleteUserCertification(ZValue zvl) throws Exception {

		ArrayList<?> seqList = zvl.getArrayList("seq[]");
		
		for(int i=0; i < seqList.size(); i++) {
			
			String seq = seqList.get(i).toString();
			
			ZValue iZvl = new ZValue();
			
			iZvl.put("seq", seq);
			iZvl.put("sqlid", "user.deleteUserCertification");
			
			UserDao.userCommonInsert(iZvl);
		}
	}
	
	@Override
	public int selectUserCertificationCheck(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.selectUserCertificationCheck");
		return UserDao.userCommonCnt(zvl);
	}

	@Override
	public List<ZValue> selectUserLogList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.selectUserLogList");
		return UserDao.userCommonList(zvl);
	}
	
	@Override
	public int selectUserLogCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.selectUserLogCnt");
		return UserDao.userCommonCnt(zvl);
	}
	
	@Override
	public List<ZValue> selectUserInsctrList(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.selectUserInsctrList");
		return UserDao.userCommonList(zvl);
	}
	
	@Override
	public int selectUserInsctrCnt(ZValue zvl) throws Exception {
		zvl.put("sqlid", "user.selectUserInsctrCnt");
		return UserDao.userCommonCnt(zvl);
	}

	@Override
	public String passwordChangeDtYN(LoginVO loginVO) throws Exception {
		return UserDao.passwordChangeDtYN(loginVO);
	}
	
	@Override
	public void updateLastLoginDt(LoginVO loginVO) throws Exception {
		UserDao.update("user.updateLastLoginDt", loginVO);
	}
	
}