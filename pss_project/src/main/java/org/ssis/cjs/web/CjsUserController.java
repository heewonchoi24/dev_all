package org.ssis.cjs.web;

import java.io.IOException;
import java.net.InetAddress;
import java.security.cert.X509Certificate;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.mngLevelReq.service.MngLevelReqService;
import org.ssis.pss.user.service.UserService;

import com.initech.iniplugin.AbnormalPropertyFileException;
import com.initech.iniplugin.AbnormalVerifyDataException;
import com.initech.iniplugin.CACertFileIOException;
import com.initech.iniplugin.CACertFileNotFoundException;
import com.initech.iniplugin.CACertFileParseException;
import com.initech.iniplugin.CRLFileIOException;
import com.initech.iniplugin.CRLFileNotFoundException;
import com.initech.iniplugin.CRLFileParseException;
import com.initech.iniplugin.ClientCertParseException;
import com.initech.iniplugin.ClientCertRevokedException;
import com.initech.iniplugin.ClientCertValidityException;
import com.initech.iniplugin.DecryptDataException;
import com.initech.iniplugin.EncryptDataException;
import com.initech.iniplugin.ExpiredVerifyDataException;
import com.initech.iniplugin.INIpluginDataAbnormalFormatException;
import com.initech.iniplugin.IniPlugin;
import com.initech.iniplugin.LongParseException;
import com.initech.iniplugin.PrivateKeyDecryptException;
import com.initech.iniplugin.PrivateKeyFileIOException;
import com.initech.iniplugin.PrivateKeyFileNotFoundException;
import com.initech.iniplugin.PrivateKeyParseException;
import com.initech.iniplugin.PropertyFileIOException;
import com.initech.iniplugin.PropertyFileNotFoundException;
import com.initech.iniplugin.PropertyFileParseException;
import com.initech.iniplugin.PropertyNotFoundException;
import com.initech.iniplugin.SessionKeyException;
import com.initech.iniplugin.SignDataException;
import com.initech.iniplugin.SignatureVerifyException;
import com.initech.iniplugin.VerifyDataDecryptException;
import com.initech.iniplugin.VerifyFlagException;
import com.initech.iniplugin.oid.CertOIDUtil;
import com.initech.iniplugin.vid.IDVerifier;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.EgovProperties;

@Controller
public class CjsUserController {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	protected Logger logger = LogManager.getLogger(this.getClass()); 
	
	@Autowired
	private UserService UserService;

	@Autowired
	private EgovMessageSource egovMessageSource;

	@Autowired
	private CmnService PssCommonService;
	
	@Autowired
	private MngLevelReqService MngLevelReqService;
	
	private ZValue certPropZvl = new ZValue();
	
	public CjsUserController(){
		String hostIp = "";
		String installPath = "";
		List<String> localServerList = Arrays.asList(getProperty("local.server.list").split(","));
		List<String> devServerList = Arrays.asList(getProperty("dev.server.list").split(","));
		List<String> prodServerList = Arrays.asList(getProperty("prod.server.list").split(","));
		
		try {
			hostIp = InetAddress.getLocalHost().getHostAddress();
			certPropZvl.put("hostIp", hostIp);
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
		}
		
		if(localServerList.contains(hostIp)){
			certPropZvl.put("installPath", getProperty("cert.install.path.local"));
			installPath = certPropZvl.getValue("installPath");
			certPropZvl.put("IniPluginPath", installPath + "/" + getProperty("local.IniPlugin.prop"));
			certPropZvl.put("CRLPath", installPath + "/" + getProperty("local.CRL.prop"));
			certPropZvl.put("jCERTOIDPath", installPath + "/" + getProperty("local.jCERTOID.prop"));
			certPropZvl.put("jCertPathValidatorPath", installPath + "/" + getProperty("local.jCertPathValidator.prop"));
		}else if(devServerList.contains(hostIp)){
			certPropZvl.put("installPath", getProperty("cert.install.path.dev"));
			installPath = certPropZvl.getValue("installPath");
			certPropZvl.put("IniPluginPath", installPath + "/" + getProperty("dev.IniPlugin.prop"));
			certPropZvl.put("CRLPath", installPath + "/" + getProperty("dev.CRL.prop"));
			certPropZvl.put("jCERTOIDPath", installPath + "/" + getProperty("dev.jCERTOID.prop"));
			certPropZvl.put("jCertPathValidatorPath", installPath + "/" + getProperty("dev.jCertPathValidator.prop"));
		}else if(prodServerList.contains(hostIp)){
			certPropZvl.put("installPath", getProperty("cert.install.path.prod"));
			installPath = certPropZvl.getValue("installPath");
			certPropZvl.put("IniPluginPath", installPath + "/" + getProperty("prod.IniPlugin.prop"));
			certPropZvl.put("CRLPath", installPath + "/" + getProperty("prod.CRL.prop"));
			certPropZvl.put("jCERTOIDPath", installPath + "/" + getProperty("prod.jCERTOID.prop"));
			certPropZvl.put("jCertPathValidatorPath", installPath + "/" + getProperty("prod.jCertPathValidator.prop"));
		}else{
			certPropZvl.put("installPath", getProperty("cert.install.path.local"));
			installPath = certPropZvl.getValue("installPath");
			certPropZvl.put("IniPluginPath", installPath + "/" + getProperty("local.IniPlugin.prop"));
			certPropZvl.put("CRLPath", installPath + "/" + getProperty("local.CRL.prop"));
			certPropZvl.put("jCERTOIDPath", installPath + "/" + getProperty("local.jCERTOID.prop"));
			certPropZvl.put("jCertPathValidatorPath", installPath + "/" + getProperty("local.jCertPathValidator.prop"));
		}
		
		
		logger.debug("################################ certPropZvl ##############################");
		logger.debug("certPropZvl : " + certPropZvl);
		logger.debug("################################ certPropZvl ##############################");
	}
	
	private String getProperty(String propNm){
		return EgovProperties.getProperty(propNm);
	}
		
	/**
	 * 공인인증서 등록
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/certRegist.do")
	public ModelAndView certRegist(
						@ModelAttribute("loginVO") LoginVO loginVO,
						HttpServletRequest request,
						HttpServletResponse response
						) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();		
		HttpSession session = request.getSession();
		ZValue certZvl = new ZValue();
		LoginVO resultVO = new LoginVO();
		SessionVO sessionVO = new SessionVO();
		
		//#########################로컬, 서버, 운영 설정 변경#############################
		//공인인증서 처리
		//로컬, 서버, 운영 설정 변경
//		String installPath = EgovProperties.getProperty("cert.install.path.local");
//		//String installPath = EgovProperties.getProperty("cert.install.path.dev");
//		
//		String propertiesPath = installPath + "/properties/";
//		String [][] propertiesFullPath = {
//			{propertiesPath,"IniPlugin.properties"},
//			{propertiesPath,"CRL.properties"},
//			{propertiesPath,"jCERTOID.properties"},
//			{propertiesPath,"jCertPathValidator.properties"}
//		};
//		String [][] propertiesFullPath = {
//			{propertiesPath,"IniPlugin_DEV.properties"},
//			{propertiesPath,"CRL_DEV.properties"},
//			{propertiesPath,"jCERTOID_DEV.properties"},
//			{propertiesPath,"jCertPathValidator_DEV.properties"}
//		};
		//################################################################################
		
		// pcenter v6.0 property path
		//String webPath = propertiesPath + "IniPlugin.properties";
		String licensePath = certPropZvl.getValue("installPath") + "/license/iniline.lic";
		
		String m_IniErrCode = null;
		String m_IniErrMsg = null;
		
		IniPlugin m_IP = new IniPlugin(request,response, certPropZvl.getValue("IniPluginPath"));
		String INIdata = request.getParameter("INIpluginData");
		
		logger.debug("INIdata              " + INIdata);
		
		if (INIdata == null) 
		{
			m_IniErrCode = "PLUGIN_000";
			m_IniErrMsg = "Exception : INIpluginData is null";              
		}else{
			try {m_IP.init();} 
			catch(PrivateKeyDecryptException e) {m_IniErrCode = "PLUGIN_001"; m_IniErrMsg = "Exception : " + e.getMessage();} 
			catch(CRLFileNotFoundException e) {m_IniErrCode = "PLUGIN_002"; m_IniErrMsg = "Exception : " + e.getMessage();} 
			catch(PropertyFileNotFoundException e) {m_IniErrCode = "PLUGIN_003"; m_IniErrMsg = "Exception : " + e.getMessage();} 
			catch(PrivateKeyFileNotFoundException e) {m_IniErrCode = "PLUGIN_004"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(CACertFileNotFoundException e) {m_IniErrCode = "PLUGIN_005"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(INIpluginDataAbnormalFormatException e) {m_IniErrCode = "PLUGIN_006"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(LongParseException e) {m_IniErrCode = "PLUGIN_007"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(PrivateKeyParseException e) {m_IniErrCode = "PLUGIN_008"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(CRLFileParseException e) {m_IniErrCode = "PLUGIN_009"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(CACertFileParseException e) {m_IniErrCode = "PLUGIN_010"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(ClientCertParseException e) {m_IniErrCode = "PLUGIN_011"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(AbnormalPropertyFileException e) {m_IniErrCode = "PLUGIN_012"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(PropertyNotFoundException e) {m_IniErrCode = "PLUGIN_013"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(VerifyDataDecryptException e) {m_IniErrCode = "PLUGIN_014"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(AbnormalVerifyDataException e) {m_IniErrCode = "PLUGIN_015"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(ExpiredVerifyDataException e) {m_IniErrCode = "PLUGIN_016"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(ClientCertValidityException e) {m_IniErrCode = "PLUGIN_017"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(SignatureVerifyException e) {m_IniErrCode = "PLUGIN_018"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(ClientCertRevokedException e) {m_IniErrCode = "PLUGIN_019"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(SessionKeyException e) {m_IniErrCode = "PLUGIN_020"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(EncryptDataException e) {m_IniErrCode = "PLUGIN_021"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(DecryptDataException e) {m_IniErrCode = "PLUGIN_022"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(CRLFileIOException e) {m_IniErrCode = "PLUGIN_023"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(PropertyFileIOException e) {m_IniErrCode = "PLUGIN_024"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(PrivateKeyFileIOException e) {m_IniErrCode = "PLUGIN_025"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(CACertFileIOException e) {m_IniErrCode = "PLUGIN_026"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(PropertyFileParseException e) {m_IniErrCode = "PLUGIN_027"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(VerifyFlagException e) {m_IniErrCode = "PLUGIN_028"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(IOException e) {m_IniErrCode = "PLUGIN_029"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(SignDataException e) {m_IniErrCode = "PLUGIN_030"; m_IniErrMsg = "Exception : " + e.getMessage(); }
			catch(Exception e) {m_IniErrCode = "PLUGIN_099"; m_IniErrMsg = "Exception : " + e.getMessage(); }
		}
		
		if(m_IniErrCode != null)
		{
			logger.debug("<br><b>INISAFE Web 6.1 Server SDK - Init() ERROR</b>");
			logger.debug("<hr>");
			logger.debug("<br><b>Error Code</b> = <font color='red'>" + m_IniErrCode + "</font>");
			logger.debug("<br><b>Error Message</b> = " + m_IniErrMsg);
		}
		
		String certInfo = "";
		
		//각각의 모듈을 분리해서 처리
		X509Certificate userCert = null;
		String caFlag = "";	
		userCert = m_IP.getClientCertificate();

		String propOID = certZvl.getValue("jCERTOIDPath");

		String juminHash = m_IP.getVIDRandom();
		String juminParam = m_IP.getParameter("juminNO");
		IDVerifier idv = new IDVerifier();
		boolean vidRet = false; 
		
		boolean ocspFlag = false;   // true: OCSP, flase: CRL 
	    String status;
		String resCode;
		
		try
		{
		  //======================================================
		  // 2. 상호연동용 인증서
		  //======================================================
			CertOIDUtil cou = new CertOIDUtil(propOID);

			if (cou.checkOID(userCert) == true) {
				certInfo += "<br><b> OID 검증 : 상호연동용 인증서입니다.</b>";
				certInfo += "<br><b>OID=[" + cou.getCertOID() + "]";
			} else {
				certInfo += "<br><b> OID 검증 : 상호연동용 인증서가 아닙니다.</b>";
				certInfo += "<br><b>OID=[" + cou.getCertOID() + "]";
			}
		} catch (Exception e) {
			m_IniErrCode = "PPKI_999";
			m_IniErrMsg  = "Exception : " + e.getMessage();
			e.printStackTrace();
		}
		
		if(m_IniErrCode != null){
			logger.debug("<br><b>INISAFE Public PKI 검증 ERROR</b>");
			logger.debug("<hr>");
			logger.debug("<br><b>Error Code</b> = <font color='red'>" + m_IniErrCode + "</font>");
			logger.debug("<br><b>Error Message</b> = " + m_IniErrMsg);
		 }
		
		
		try{
			DateFormat myDate = new SimpleDateFormat("yyyy-MM-dd hh:mm ss");
			Date NotBefore = userCert.getNotBefore();	// 인증서 발급일
			Date NotAfter = userCert.getNotAfter();		// 인증서 만기일
			Date currentTime = new Date();				// 현재 시간
			int dateformat = (int) ((NotAfter.getTime() - currentTime.getTime()) / (24 * 60 * 60 * 1000));

			certInfo += "\n발급자 : " + userCert.getIssuerDN().toString();
			certInfo += "\n발급대상 : " + userCert.getSubjectDN().toString();
			certInfo += "\n발급일 : " + myDate.format(NotBefore);
			certInfo += "\n만료일 : " + myDate.format(NotAfter);
			certInfo += "\nSerial : " + userCert.getSerialNumber().toString(10);
			certInfo += "\n현재시간 : " + myDate.format(currentTime);
			certInfo += "\n고객님의 인증서는 ";
			certInfo += dateformat;
			certInfo += "일 후에 만료가 됩니다.";
			certInfo += "\ngetSubjectDN" + userCert.getSubjectDN().getName();
			
			logger.debug("################################ certInfo ##############################");
			logger.debug("certInfo : " + certInfo);
			logger.debug("################################ certInfo ##############################");
			
			SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
			
			certZvl.put("userId", userInfo.getUserId());
			certZvl.put("ogcr", userCert.getSerialNumber().toString(10));
			
			UserService.certRegist(certZvl);

			modelAndView.addObject("message", "cert.regist.complete");
			modelAndView.setViewName("redirect:/login/login.do");
		} catch (Exception e) {
			modelAndView.addObject("message", "cert.regist.failed");
			modelAndView.setViewName("redirect:/login/login.do");
			logger.error(e);
			e.printStackTrace();
		}
		
		return modelAndView;
	}
	
	/**
	 * 나의 정보관리
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/cjs/userInfo.do")
    public ModelAndView userInfo(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		ZValue result = null;
		List<ZValue> resultList = null;
		
		zvl.put("user_id", userInfo.getUserId());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			result = UserService.userInfo(zvl);
			model.addAttribute("result", result);

			resultList = PssCommonService.retrieveChrgDutyList(zvl);
			model.addAttribute("resultChrgDutyList", resultList);
			
			resultList = PssCommonService.retrieveInstCodeList();
			model.addAttribute("resultInstList", resultList);

			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "cjs/userInfo" );

		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		// 보건복지부 or 관제 시스템 담당자
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId()))
			modelAndView.addObject("adminMenu", "Y");
		
		modelAndView.addObject("menuDeths", "2");
		modelAndView.addObject("menuDethsValue", "CA");
		
		return modelAndView;	
    }
	
	/**
	 * 나의 정보관리 - 회원정보 수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/updateUser.do")
	public ModelAndView updateUserInfo(
			HttpServletRequest request, 
			HttpServletResponse response
			) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		zvl.put("userId", userInfo.getUserId());

		logger.debug(zvl);
		
		try{
			UserService.userUpdate(zvl);
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));

			modelAndView.setViewName( "jsonView" );

			//로그 이력 저장(HC05 개인정보)
/*			zvl.put("conect_cd", "HC05");
			zvl.put("crud",      "U");
			UserService.connectHistoryInsert(zvl, request);*/

		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
			e.printStackTrace();
		}
		
		return modelAndView;
	}

	/**
	 * 비밀번호 변경 화면
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/passwordInfo.do")
	public ModelAndView passwordInfo(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		try{
			modelAndView.setViewName( "cjs/passwordInfo" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		// 보건복지부 or 관제 시스템 담당자
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId()))
			modelAndView.addObject("adminMenu", "Y");
		
		modelAndView.addObject("menuDeths", "2");
		modelAndView.addObject("menuDethsValue", "CD");
		
		return modelAndView;	
	}

	/**
	 * 비밀번호 수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/updatePass.do")
	public ModelAndView updatePass(
			HttpServletRequest request, 
			HttpServletResponse response
			) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		zvl.put("userId", userInfo.getUserId());

		logger.debug(zvl);
		
		try{
			String updateStat = UserService.passUpdate(zvl);
			
			if("Y".equals(updateStat)) {
				modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
				
				//로그 이력 저장(HC04 비밀번호)
/*				zvl.put("conect_cd", "HC04");
				zvl.put("crud",      "U");
				UserService.connectHistoryInsert(zvl, request);*/
			} else {
				modelAndView.addObject("message", "현재 비밀번호가 일치하지 않습니다. 다시 입력 하세요!");
			}
			modelAndView.addObject("updateStat", updateStat);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error(e);
			e.printStackTrace();
		}
		
		return modelAndView;
	}
	
	
	/**
	 * 공인인증서 갱신
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/cjs/certUpdate.do")
	public ModelAndView certUpdate(
								HttpServletRequest request
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		try{
			modelAndView.setViewName( "cjs/certUpdate" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		
		// 보건복지부 or 관제 시스템 담당자
		if("1".equals(userInfo.getAuthorId()) || "3".equals(userInfo.getAuthorId()))
			modelAndView.addObject("adminMenu", "Y");
		
		modelAndView.addObject("menuDeths", "2");
		modelAndView.addObject("menuDethsValue", "CC");
		
		return modelAndView;	
	}
}