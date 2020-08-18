package org.ssis.pss.user.web;

import java.io.IOException;
import java.net.InetAddress;
import java.security.cert.X509Certificate;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.ssis.pss.cmn.model.ZValue;
import org.ssis.pss.cmn.service.CmnService;
import org.ssis.pss.cmn.util.SHAPasswordEncoder;
import org.ssis.pss.cmn.util.WebFactoryUtil;
import org.ssis.pss.connect.web.servie.ConnectService;
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
import com.initech.iniplugin.crl.CheckCRL;
import com.initech.iniplugin.oid.CertOIDUtil;
import com.initech.iniplugin.vid.IDVerifier;

import egovframework.com.cmm.CustomUserDetails;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.LogCrud;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class UserController {
	
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
	
	@Autowired
	private ConnectService connectService;		
	
	private ZValue certPropZvl = new ZValue();
	
	public UserController(){
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
		}else if(prodServerList.contains(hostIp)){
			certPropZvl.put("installPath", getProperty("cert.install.path.prod"));
			installPath = certPropZvl.getValue("installPath");
			certPropZvl.put("IniPluginPath", installPath + "/" + getProperty("prod.IniPlugin.prop"));
			certPropZvl.put("CRLPath", installPath + "/" + getProperty("prod.CRL.prop"));
			certPropZvl.put("jCERTOIDPath", installPath + "/" + getProperty("prod.jCERTOID.prop"));
			certPropZvl.put("jCertPathValidatorPath", installPath + "/" + getProperty("prod.jCertPathValidator.prop"));
		}else {
			certPropZvl.put("installPath", getProperty("cert.install.path.dev"));
			installPath = certPropZvl.getValue("installPath");
			certPropZvl.put("IniPluginPath", installPath + "/" + getProperty("dev.IniPlugin.prop"));
			certPropZvl.put("CRLPath", installPath + "/" + getProperty("dev.CRL.prop"));
			certPropZvl.put("jCERTOIDPath", installPath + "/" + getProperty("dev.jCERTOID.prop"));
			certPropZvl.put("jCertPathValidatorPath", installPath + "/" + getProperty("dev.jCertPathValidator.prop"));
		}
		
		logger.debug("################################ certPropZvl ##############################");
		logger.debug("certPropZvl : " + certPropZvl);
		logger.debug("################################ certPropZvl ##############################");
	}
	
	private String getProperty(String propNm){
		return EgovProperties.getProperty(propNm);
	}
	
	/**
	 * 공인인증서 로그인
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/user/certLogin.do")
	public ModelAndView certLogin(
						@ModelAttribute("loginVO") LoginVO loginVO,
						HttpServletRequest request,
						HttpServletResponse response
						) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();		
		HttpSession session = request.getSession();
		
		ZValue certZvl = new ZValue();
		ZValue zvl = new ZValue();
		certZvl.put("userId", request.getParameter("certUserId"));
		LoginVO resultVO = new LoginVO();

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
			
			modelAndView.addObject("message", m_IniErrMsg);
			modelAndView.addObject("messageCd", "B");
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
		}
		
		String certInfo = "";
		
		//각각의 모듈을 분리해서 처리
		X509Certificate userCert = null;
		String caFlag = "";	
		userCert = m_IP.getClientCertificate();

		String propOID = certPropZvl.getValue("jCERTOIDPath");

		String juminHash = m_IP.getVIDRandom();
		String juminParam = m_IP.getParameter("juminNO");
		IDVerifier idv = new IDVerifier();
		boolean vidRet = false; 
		
		boolean ocspFlag = false;   // true: OCSP, flase: CRL 
	    String status;
		String resCode;
		
		try{
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
				
				modelAndView.addObject("message", egovMessageSource.getMessage("cert.sangho.failed"));
				modelAndView.addObject("messageCd", "B");
				modelAndView.setViewName("jsonView");
				
				return modelAndView;
			}
	
			//======================================================
			//3. 인증서 유효성 확인
			//======================================================
			CheckCRL ccrl = null;
	    	//String crlConfig = getPropertiesFullPath(propertiesFullPath,"CRL");
			String crlConfig = certPropZvl.getValue("CRLPath");
	    	boolean returnFlag = false;	 
	    	ccrl = new CheckCRL();
	    	ccrl.init(crlConfig);
	    	returnFlag = ccrl.isValid(userCert);
	    	if(returnFlag){
	    		certInfo += "<br><b>CRL 체크 : 유효한 인증서가 맞습니다.</b>";
	    	}else{
	    		certInfo += "<br><b>CRL 체크 : 유효한 인증서가 아닙니다.</b>";
	    		
	    		modelAndView.addObject("message", egovMessageSource.getMessage("cert.valid.failed"));
				modelAndView.addObject("messageCd", "B");
				modelAndView.setViewName("jsonView");
				
				return modelAndView;
	    	} 
		} catch (Exception e) {
			m_IniErrCode = "PPKI_999";
			m_IniErrMsg  = "Exception : " + e.getMessage();
			e.printStackTrace();
			
			modelAndView.addObject("message", egovMessageSource.getMessage("cert.connect.failed"));
			modelAndView.addObject("messageCd", "B");
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
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
			logger.debug("certPropZvl : " + certPropZvl);
			logger.debug("################################ certInfo ##############################");
			
			certZvl.put("ogcr", userCert.getSerialNumber().toString(10));
			
			resultVO = UserService.certLogin(certZvl);
			
			if (resultVO != null && resultVO.getUserId() != null && !resultVO.getUserId().equals("")) {
				SessionVO sessionVO = new SessionVO();
				BeanUtils.copyProperties(resultVO, sessionVO);
			    //session에 유저정보 저장 임시
				request.getSession().setAttribute("userInfo", sessionVO);
				
				//최종 로그인 일시 인서트
				UserService.lastConnectDtUpdate(zvl, request);
				
/*				zvl.put("conect_cd", "HC02");
				UserService.connectHistoryInsert(zvl, request);*/
				
				modelAndView.addObject("messageCd", "D");
				modelAndView.setViewName("jsonView");
			}else{
				modelAndView.addObject("message", egovMessageSource.getMessage("cert.unregisted"));
				modelAndView.addObject("messageCd", "A");
				modelAndView.setViewName("jsonView");
			}
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
		}
		
		return modelAndView;
	}
	
	/**
	 * 로그아웃
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/login/logout.do")
	public ModelAndView logout(
				HttpServletRequest request, 
				HttpServletResponse response
								) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession();

		if(request.isRequestedSessionIdValid()){
			logger.debug("############## 로그아웃 : 유효하지 않은 세션 ##############");
/*			zvl.put("conect_cd", "HC03");
			UserService.connectHistoryInsert(zvl, request);*/
			
			session.invalidate();
		}
		
		modelAndView.setViewName("login/login");
		return modelAndView;
	}
	
	public String getPropertiesFullPath(String[][] path, String value)
	{
		String	retunPath = "";
		//#########################로컬, 서버, 운영 설정 변경#############################
		String	sValue = value + ".properties";
		//String	sValue = value + "_DEV.properties";
		//################################################################################
		for(int i=0; i < path.length; i++)
		{
			if(path[i][1].equals(sValue))
			{
				retunPath = path[i][0] + path[i][1];
			}
		}
		return retunPath;
	}
	
	/**
	 * 공인인증서 등록
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/user/certRegist.do")
	public ModelAndView certRegist(
						@ModelAttribute("loginVO") LoginVO loginVO,
						HttpServletRequest request,
						HttpServletResponse response
						) throws Exception { 
		
		loginVO.setUserId(request.getSession().getAttribute("tempUserId").toString());
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue certZvl = new ZValue();
		LoginVO resultVO = new LoginVO();

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
			
			modelAndView.addObject("message", "인증서 등록 오류 : " + m_IniErrMsg);
			modelAndView.addObject("messageCd", "A");
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
		}
		
		String certInfo = "";
		
		//각각의 모듈을 분리해서 처리
		X509Certificate userCert = null;
		String caFlag = "";	
		userCert = m_IP.getClientCertificate();

		String propOID = certPropZvl.getValue("jCERTOIDPath");

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
				
				modelAndView.addObject("message", egovMessageSource.getMessage("cert.sangho.failed"));
				modelAndView.addObject("messageCd", "A");
				modelAndView.setViewName("jsonView");
				
				return modelAndView;
			}
		
			
			//======================================================
			// 3. 인증서 유효성 확인
			//======================================================
			CheckCRL ccrl = null;
	    	//String crlConfig = getPropertiesFullPath(propertiesFullPath,"CRL");
			String crlConfig = certPropZvl.getValue("CRLPath");
	    	boolean returnFlag = false;	 
	    	ccrl = new CheckCRL();
	    	ccrl.init(crlConfig);
	    	returnFlag = ccrl.isValid(userCert);
	    	if(returnFlag){
	    		certInfo += "<br><b>CRL 체크 : 유효한 인증서가 맞습니다.</b>";
	    	}else{
	    		certInfo += "<br><b>CRL 체크 : 유효한 인증서가 아닙니다.</b>";
	    		
	    		modelAndView.addObject("message", "유효한 인증서가 아닙니다.");
				modelAndView.addObject("messageCd", "A");
				modelAndView.setViewName("jsonView");
				
				return modelAndView;
	    	} 
		} catch (Exception e) {
			m_IniErrCode = "PPKI_999";
			m_IniErrMsg  = "Exception : " + e.getMessage();
			e.printStackTrace();
			
			modelAndView.addObject("message", egovMessageSource.getMessage("cert.connect.failed"));
			modelAndView.addObject("messageCd", "A");
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
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
			
			resultVO = UserService.userLogin(loginVO);
			String subjectDNStr = userCert.getSubjectDN().toString();
			String userNm = resultVO.getUserNm();
			
			if(!subjectDNStr.contains(userNm)){
				modelAndView.addObject("message", "가입한 사용자의 이름과 다른 공인인증서는 사용하실 수 없습니다.");
				modelAndView.addObject("messageCd", "A");
				modelAndView.setViewName("jsonView");
				return modelAndView;
			}
			
			logger.debug("################################ certInfo ##############################");
			logger.debug("certInfo : " + certInfo);
			logger.debug("################################ certInfo ##############################");
			
			certZvl.put("userId", loginVO.getUserId());
			certZvl.put("ogcr", userCert.getSerialNumber().toString(10));
			
			UserService.certRegist(certZvl);

			modelAndView.addObject("message", egovMessageSource.getMessage("cert.regist.complete"));
			modelAndView.addObject("messageCd", "B");
			modelAndView.setViewName("jsonView");
		} catch (Exception e) {
			modelAndView.addObject("message", egovMessageSource.getMessage("cert.regist.failed"));
			modelAndView.addObject("messageCd", "A");
			modelAndView.setViewName("jsonView");
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
	@RequestMapping(value="/user/certRefresh.do")
	public ModelAndView certRefresh(
						@ModelAttribute("loginVO") LoginVO loginVO,
						HttpServletRequest request,
						HttpServletResponse response
						) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();		
		HttpSession session = request.getSession();
		ZValue certZvl = new ZValue();
		LoginVO resultVO = new LoginVO();
		
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
			
			modelAndView.addObject("message", "인증서 갱신 오류 : " + m_IniErrMsg);
			modelAndView.addObject("messageCd", "A");
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
		}
		
		String certInfo = "";
		
		//각각의 모듈을 분리해서 처리
		X509Certificate userCert = null;
		String caFlag = "";	
		userCert = m_IP.getClientCertificate();

		String propOID = certPropZvl.getValue("jCERTOIDPath");

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
				
				modelAndView.addObject("message", egovMessageSource.getMessage("cert.sangho.failed"));
				modelAndView.addObject("messageCd", "A");
				modelAndView.setViewName("jsonView");
				
				return modelAndView;
			}
		
			
			//======================================================
			// 3. 인증서 유효성 확인
			//======================================================
			CheckCRL ccrl = null;
	    	//String crlConfig = getPropertiesFullPath(propertiesFullPath,"CRL");
			String crlConfig = certPropZvl.getValue("CRLPath");
	    	boolean returnFlag = false;	 
	    	ccrl = new CheckCRL();
	    	ccrl.init(crlConfig);
	    	returnFlag = ccrl.isValid(userCert);
	    	if(returnFlag){
	    		certInfo += "<br><b>CRL 체크 : 유효한 인증서가 맞습니다.</b>";
	    	}else{
	    		certInfo += "<br><b>CRL 체크 : 유효한 인증서가 아닙니다.</b>";
	    		
	    		//modelAndView.addObject("message", "cert.sangho.failed");
	    		modelAndView.addObject("message", "유효한 인증서가 아닙니다.");
	    		modelAndView.addObject("messageCd", "A");
				modelAndView.setViewName("jsonView");
				
				return modelAndView;
	    	} 
		} catch (Exception e) {
			m_IniErrCode = "PPKI_999";
			m_IniErrMsg  = "Exception : " + e.getMessage();
			e.printStackTrace();
			
			modelAndView.addObject("message", egovMessageSource.getMessage("cert.connect.failed"));
			modelAndView.addObject("messageCd", "A");
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
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
			
			String subjectDNStr = userCert.getSubjectDN().toString();
			String userNm = userInfo.getUserNm();
			
			if(!subjectDNStr.contains(userNm)){
				modelAndView.addObject("message", egovMessageSource.getMessage("cert.name.failed"));
				modelAndView.addObject("messageCd", "A");
				modelAndView.setViewName("jsonView");
				return modelAndView;
			}
			
			certZvl.put("userId", userInfo.getUserId());
			certZvl.put("ogcr", userCert.getSerialNumber().toString(10));
			
			UserService.certRegist(certZvl);

			modelAndView.addObject("message", egovMessageSource.getMessage("cert.regist.complete"));
			modelAndView.addObject("messageCd", "B");
			modelAndView.setViewName("jsonView");
		} catch (Exception e) {
			modelAndView.addObject("message", egovMessageSource.getMessage("cert.regist.failed"));
			modelAndView.addObject("messageCd", "A");
			modelAndView.setViewName("jsonView");
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
	@SuppressWarnings("unchecked")
	@RequestMapping("/user/userInfo.do")
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
			modelAndView.addObject("pageName", "나의정보"); // 페이지 정보
			modelAndView.setViewName( "user/userInfo" );

		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
    }
	
	/**
	 * 나의 정보관리 - 회원정보 수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/user/updateUser.do")
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
	@RequestMapping(value="/user/passwordInfo.do")
	public ModelAndView passwordInfo(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		try{
			modelAndView.addObject("pageName", "비밀번호변경");
			modelAndView.setViewName( "user/passwordInfo" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}

	/**
	 * 비밀번호 수정
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/user/updatePass.do")
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
	 * 시스템 관리 - 사용자 관리
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/admin/user/userList.do")
	public ModelAndView userList(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		int totalCnt = 0; 
		int totalPageCnt = 0;
		
		//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) 
    		zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	zvl.put("pageSize", 10);
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));
		
		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = UserService.userList(zvl);
			modelAndView.addObject("userList", resultList);
			
			resultList = PssCommonService.retrieveInstCodeList();
			modelAndView.addObject("insttList", resultList);
			
			resultList = MngLevelReqService.mngLevelInsttClCdList(zvl);
			modelAndView.addObject("insttClCdList", resultList);
			
			resultList = MngLevelReqService.mngLevelInsttSelectList(zvl);
			modelAndView.addObject("insttSelectList", resultList);

			resultList = PssCommonService.retrieveAuthorList();
			modelAndView.addObject("authorList", resultList);
			
			totalCnt = UserService.userListCnt(zvl);
			totalPageCnt = (int) Math.ceil((double)totalCnt/(double)10);
			
			logger.debug("############## zvl ##############");
			logger.debug(totalPageCnt);
			logger.debug("############## zvl ##############");
			
			modelAndView.addObject("totalCnt", totalCnt);
			modelAndView.addObject("totalPageCnt", totalPageCnt);
			
			paginationInfo.setTotalRecordCount(totalCnt);
			
			modelAndView.addAllObjects(zvl);
			modelAndView.addObject("paginationInfo", paginationInfo);
			modelAndView.setViewName( "user/userList" );

			modelAndView.addObject("requestZvl", zvl);
			
			//화면Sidebar정보
			modelAndView.addObject("pageLevel1", "account");
			modelAndView.addObject("pageLevel2", "2");
			modelAndView.addObject("pageName", "사용자 관리");
			
			//로그 이력 저장(HC05 개인정보)
/*			zvl.put("parameter",  zvl.toString());
			zvl.put("conect_cd", "HC05");
			zvl.put("crud"    ,  "R");			
			UserService.connectHistoryInsert(zvl, request);*/
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/user/userList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.READ);
			zvl.put("menu_id",    menu_id);
			zvl.put("conect_cd",  "HC05");
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);					

		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		return modelAndView;
	}
	
	/**
	 * 시스템 관리 - 사용자 관리 - 사용자 수정
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/admin/user/userModify.do")
	public ModelAndView userModify(HttpServletRequest request
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		List<ZValue> resultList = null;
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = PssCommonService.retrieveChrgDutyList(zvl);
			modelAndView.addObject("chrgDutyList", resultList);
			
			resultList = PssCommonService.retrieveInstCodeList();
			modelAndView.addObject("instList", resultList);
			
			resultList = PssCommonService.retrieveAuthorList();
			modelAndView.addObject("authorList", resultList);
			
			result = UserService.userInfo(zvl);
			modelAndView.addObject("user", result);
			
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "user/userModify" );

			//화면Sidebar정보
			modelAndView.addObject("pageLevel1", "account");
			modelAndView.addObject("pageLevel2", "2");
			modelAndView.addObject("pageName", "사용자 관리");
			
			//로그 이력 저장(HC05 개인정보)
/*			zvl.put("parameter",  zvl.toString());
			zvl.put("conect_cd", "HC05");
			zvl.put("crud"    ,  "R");			
			UserService.connectHistoryInsert(zvl, request);*/
			
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		return modelAndView;
	}
	
	/**
	 * 시스템 관리 - 사용자 관리 - 사용자 수정 - 정보수정
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/admin/user/userInfoModify.do")
	public ModelAndView userInfoModify(HttpServletRequest request
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		zvl.put("adminId", userInfo.getUserId());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			UserService.userInfoModify(zvl);
			
			String isModify = zvl.getString("isModify");
			
			// 로그 이력 저장
			if("Y".equals(isModify)){
				String menu_id = "";
				zvl.put("url", 		  "/admin/user/userList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       "U");
				zvl.put("menu_id",    menu_id);
				zvl.put("conect_cd",  "HC05");
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);
			}else{
				String menu_id = "";
				zvl.put("url", 		  "/admin/user/userList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);
				zvl.put("conect_cd",  "HC05");
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);
			}
			
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
			
			//로그 이력 저장(HC05 개인정보)
/*			zvl.put("conect_cd", "HC05");
			zvl.put("crud",      "U");
			UserService.connectHistoryInsert(zvl, request);*/

		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		return modelAndView;
	}

	/**
	 * 시스템 관리 - 사용자 수정(비밀번호 초기화)
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/user/resetPassword.do")
	public ModelAndView resetPassword(
			HttpServletRequest request 
			) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		zvl.put("adminId", userInfo.getUserId());
		
		String result = null;
		logger.debug("############## resetPassword zvl ##############");
		logger.debug(zvl);
		logger.debug("############## resetPassword zvl ##############");
		
		try{
			result = UserService.resetPassword(zvl);
			modelAndView.addObject("newPassword", result);
			
			modelAndView.addObject("message", egovMessageSource.getMessage("password.reset.success"));
			modelAndView.setViewName( "jsonView" );
			
			//로그 이력 저장(HC04 비밀번호)
/*			zvl.put("conect_cd", "HC04");
			zvl.put("crud",      "U");
			UserService.connectHistoryInsert(zvl, request);*/
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/user/userList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.UPDATE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);	
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("password.reset.failed"));
			logger.error(e);
			e.printStackTrace();
		}
		
		return modelAndView;
	}
	
	/** 시스템 관리 - 사용자 관리 - 사용자 삭제
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/admin/user/userDelete.do")
	public ModelAndView userDelete(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");

		zvl.put("user_id", userInfo.getUserId()); 
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			UserService.userDelete(zvl);
			
			modelAndView.addObject("message", "정상적으로 삭제되었습니다.");
			modelAndView.addAllObjects(zvl);
			modelAndView.setViewName( "jsonView" );
			
			//로그 이력 저장(HC05 개인정보)
/*			zvl.put("conect_cd", "HC09");
			UserService.connectHistoryInsert(zvl, request);*/
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/user/userList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.DELETE);
			zvl.put("menu_id",    menu_id);
			zvl.put("conect_cd", "HC09");
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);		

		}catch(Exception e){
			modelAndView.addObject("message", "정상적으로 삭제되지 않았습니다.");
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	/**
	 * 시스템 관리 - 사용자 관리 - 점검원 배정 기관 목록 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/user/insctrInsttList.do")
	public ModelAndView insctrInsttList(HttpServletRequest request
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		List<ZValue> resultList = null;
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			resultList = UserService.insctrInsttList(zvl);
			
			modelAndView.addObject("insctrInsttList", resultList);
			modelAndView.setViewName( "jsonView" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		return modelAndView;
	}
	
	/**
	 * 시스템 관리 - 사용자 관리 - 점검원 기관 배정 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/user/setInsctrInstt.do")
	public ModelAndView setInsctrInstt(HttpServletRequest request
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("adminId", userInfo.getUserId());
		
		try {
			UserService.setInsctrInstt(zvl);
			
/*			zvl.put("parameter",  zvl.toString());
			zvl.put("conect_cd", "HC12");
			zvl.put("crud", "C");
			UserService.connectHistoryInsert(zvl, request);*/
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/user/userInsctrList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.INSERT);
			zvl.put("menu_id",    menu_id);
			zvl.put("conect_cd",  "HC12");
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);		
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
		}
		
		modelAndView.setViewName( "jsonView" );
		return modelAndView;
	}
	
	/**
	 * 시스템 관리 - 사용자 관리 - 점검원 일괄 등록 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/user/createInsctr.do")
	public ModelAndView createInsctr(HttpServletRequest request
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("adminId", userInfo.getUserId());
		
		try {
			
			UserService.createInsctr(zvl);
			
/*			zvl.put("parameter",  zvl.toString());
			zvl.put("conect_cd", "HC12");
			zvl.put("crud", "C");
			UserService.connectHistoryInsert(zvl, request);*/
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.insert"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/user/userInsctrList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.INSERT);
			zvl.put("menu_id",    menu_id);
			zvl.put("conect_cd",  "HC12");
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);			
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			logger.error( e );
			e.printStackTrace();
			
		}
		modelAndView.setViewName( "jsonView" );
		return modelAndView;
	}
	
	/**
	 * 시스템 관리 - 사용자 관리 - 점검원 수정 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/user/updateInsctr.do")
	public ModelAndView updateInsctr(HttpServletRequest request
					      ) throws Exception { 
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("adminId", userInfo.getUserId());

		try {
			UserService.updateInsctr(zvl);
			
/*			zvl.put("parameter",  zvl.toString());
			zvl.put("conect_cd", "HC12");
			zvl.put("crud", "U");
			UserService.connectHistoryInsert(zvl, request);*/
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/user/userInsctrList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.UPDATE);
			zvl.put("menu_id",    menu_id);
			zvl.put("conect_cd",  "HC12");
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);	
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error( e );
			e.printStackTrace();
			
		}
		
		modelAndView.setViewName( "jsonView" );
		return modelAndView;
	}
	
	/**
	 * 시스템 관리 - 사용자 관리 - 점검원 삭제 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/user/deleteInsctr.do")
	public ModelAndView deleteInsctr(HttpServletRequest request
					      ) throws Exception { 
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("adminId", userInfo.getUserId());

		try {
			zvl.put("del_user_tbl", "USER_CERTIFICATION");
			UserService.deleteInsctr(zvl);
			
			zvl.setValue("del_user_tbl", "USER_MASTR");
			UserService.deleteInsctr(zvl);
			
/*			zvl.put("parameter",  zvl.toString());
			zvl.put("conect_cd", "HC12");
			zvl.put("crud", "D");
			UserService.connectHistoryInsert(zvl, request);*/
			
			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/user/userInsctrList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.DELETE);
			zvl.put("menu_id",    menu_id);
			zvl.put("conect_cd",  "HC12");
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);				
			
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.delete"));
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error( e );
			e.printStackTrace();
			
		}
		
		modelAndView.setViewName( "jsonView" );
		return modelAndView;
	}
	
	/**
	 * 공인인증서 갱신
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/user/certUpdate.do")
	public ModelAndView certUpdate(
								HttpServletRequest request
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		try{
			modelAndView.setViewName( "user/certUpdate" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
	}

	/**
	 * 아이디/비밀번호 찾기
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */

	@RequestMapping(value="/user/idPwdFind.do")
	public ModelAndView idPwdFind(
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
	
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		ZValue result = null;
		
		String name    = zvl.getValue("userNm");
		String email   = zvl.getValue("email");
	
		String password     = zvl.getValue("password");
	
		try{
			
			if(!"".equals(name) && !"".equals(email)) {
				result = UserService.findUserId(zvl);
				
				modelAndView.addObject("result", result);
				
				if(!"".equals(password)) {
					modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));
				}
				modelAndView.setViewName( "jsonView" );
			} else {
				modelAndView.setViewName( "user/idPwdFind" ); 
			}	
		}catch(Exception e){
			logger.error( e );
			if(!"".equals(password)) {
				modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			}
			e.printStackTrace();
		}
		
		return modelAndView;	
	}
	
	
	/**
	 * 아이디/로그인 체크 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/user/checkLogin.do")
	public ModelAndView checkLogin(@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "jsonView" );
		LoginVO resultVO = new LoginVO();
		
		String user_pw = loginVO.getPassword();
		
		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);
	    user_pw = shaPasswordEncoder.encode(user_pw);
	    loginVO.setPassword("");
		
		String clientIp = request.getRemoteAddr();
		
		logger.debug("############## clientIp ##############");
		logger.debug(clientIp);
		logger.debug("############## clientIp ##############");
		
		resultVO  = UserService.userLogin(loginVO);
		int pwdErrCnt;
		int pwdErrTerm;
		
		if(resultVO != null){
			pwdErrCnt = resultVO.getPasswordErrCnt();
			pwdErrTerm = resultVO.getPasswordErrTerm();

			if(pwdErrCnt > 4){
				if(pwdErrTerm >= 0 && pwdErrTerm < 1800){
					modelAndView.addObject("message", egovMessageSource.getMessage("login.password.failed.over5times"));
					//modelAndView.addObject("messageCd", "N");
					modelAndView.addObject("messageUrl", "/login/login.do");
					return modelAndView;
				} else {
					UserService.passwordErrorCntDtReset(loginVO);
				}
			}
		}

		HttpSession session = request.getSession();
		String[] clientIpArr = clientIp.split("\\.");
		
		//로그인 성공 체크
		if (resultVO != null && resultVO.getPassword().equals(user_pw)) {
			
			UserService.passwordErrorCntDtReset(loginVO);
			//관리자 승인 여부 체크
			if(resultVO.getConfmYn().equals("Y")){
				if("5".equals(resultVO.getAuthorId())){
					if("Y".equals(resultVO.getInsctrPdYn())){
						if("".equals(resultVO.getPasswordChangeDt()) || null == resultVO.getPasswordChangeDt()){
							modelAndView.addObject("message", egovMessageSource.getMessage("password.change.required"));
							modelAndView.addObject("messageCd", "R");
							modelAndView.addObject("messageUrl", "");
							return modelAndView;
						} else {
							String[] permIpArr = resultVO.getPermIp().split("\\.");
							for(int i=0; i<clientIpArr.length; i++){
								if(!Pattern.matches(wildcardToRegex(permIpArr[i]), clientIpArr[i])){
									modelAndView.addObject("message", egovMessageSource.getMessage("errors.ip"));
									//modelAndView.addObject("messageCd", "N");
									modelAndView.addObject("messageUrl", "/login/login.do");
									session.invalidate();
									return modelAndView;
								}
							}
						}
					}else{
						modelAndView.addObject("message", egovMessageSource.getMessage("insctr.period.check.failed"));
						//modelAndView.addObject("messageCd", "N");
						modelAndView.addObject("messageUrl", "/login/login.do");
						session.invalidate();
						return modelAndView;
					}
				}
				
				if(!"5".equals(resultVO.getAuthorId())){
					String[] insttPermIpArr = resultVO.getInsttPermIp().split("\\.");
					for(int i=0; i<clientIpArr.length; i++){
						if(!Pattern.matches(wildcardToRegex(insttPermIpArr[i]), clientIpArr[i])){
							modelAndView.addObject("message", egovMessageSource.getMessage("errors.ip"));
							//modelAndView.addObject("messageCd", "N");
							modelAndView.addObject("messageUrl", "/login/login.do");
							session.invalidate();
							return modelAndView;
						}
					}
				}
				
				if(!StringUtils.isEmpty(resultVO.getOgcr())) {
					UserService.passwordErrorCntDtReset(loginVO);
					modelAndView.addObject("messageUrl", "");
					//modelAndView.addObject("messageCd", "Y");
					//modelAndView.addObject("messageUrl", "/login/login.do");
					session.invalidate();
				} else {
					modelAndView.addObject("messageUrl", "/join/join04.do");
					UserService.updateLastLoginDt(loginVO);
					
					//modelAndView.addObject("messageCd", "Y");
				}
				modelAndView.addObject("message", "");
			}else{
				modelAndView.addObject("messageUrl", "/join/join03.do");
				//modelAndView.addObject("messageCd", "Y");
				modelAndView.addObject("message", "");
			}			
		}else{
			if(resultVO != null) {
				UserService.passwordErrorCntUpdate(loginVO);
				pwdErrCnt = loginVO.getPasswordErrCnt();
				
				modelAndView.addObject("message", "로그인 정보가 올바르지 않습니다. 비밀번호 " + pwdErrCnt + "회 오류.");
				//modelAndView.addObject("messageCd", "N");
				modelAndView.addObject("messageUrl", "/login/login.do");
				
				session.invalidate();
				return modelAndView;
			}
			session.invalidate();
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.login"));
			//modelAndView.addObject("messageCd", "N");
			modelAndView.addObject("messageUrl", "/login/login.do");
		}
		
		return modelAndView;
	}
	
	public static String wildcardToRegex(String wildcard){
		StringBuffer s = new StringBuffer(wildcard.length());
		s.append('^');
		for(int i=0;i<wildcard.length();i++){
			char c = wildcard.charAt(i);
			switch(c){
				case '*':
					s.append(".*");
					break;
			default:
				s.append(c);
				break;
			}
		}
		s.append('$');
		return(s.toString());
	}
	
	/**
	 * 점검원 최초 로그인 시 비밀번호 변경
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */

	@RequestMapping(value="/user/changePwd.do")
	public ModelAndView firstLoginChangePassword(
								@ModelAttribute("loginVO") LoginVO loginVO,
								HttpServletRequest request, 
								HttpServletResponse response
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		LoginVO resultVO = new LoginVO();
		modelAndView.setViewName( "jsonView" );
		
		String userId = request.getParameter("userId");
		String loginVOId = loginVO.getUserId();
		
		String user_pw = zvl.getValue("password");
		String new_user_pw = zvl.getValue("password_new");
		
		if(!userId.equals(loginVOId)){
			modelAndView.addObject("message", "잘못된 접근 입니다.");
			return modelAndView;
		}
		
		if(new_user_pw.equals(user_pw)){
			modelAndView.addObject("message", egovMessageSource.getMessage("password.same.failed"));
			modelAndView.addObject("messageCd", "D");
			return modelAndView;
		}
				
		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);
	    user_pw = shaPasswordEncoder.encode(user_pw);
		
	    loginVO.setPassword(user_pw);
	    
		resultVO = UserService.userLogin(loginVO);

		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		if(resultVO != null){
			UserService.firstLoginChangePassword(zvl);
			modelAndView.addObject("message", egovMessageSource.getMessage("password.change.success"));
		}else{
			modelAndView.addObject("message", egovMessageSource.getMessage("password.change.failed"));
		}
		
		return modelAndView;
	}
	
	/**
	 * 사용자 등록 관리 목록
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/user/userCertificationList.do")
    public ModelAndView userCertificationList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView model = new ModelAndView();
		model.setViewName( "/user/userCertificationList" );
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		int totalCnt = 0; 
		int totalPageCnt = 0;
		
		//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	zvl.put("pageSize", 10);
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));
		
		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		logger.debug("##############  zvl ##############");
		logger.debug(zvl);
		logger.debug("##############  zvl ##############");
		
		List<ZValue> resultList = UserService.selectUserCertificationList(zvl);
		
		totalCnt = UserService.selectUserCertificationCnt(zvl);
		totalPageCnt = (int) Math.ceil((double)totalCnt/(double)10);
		
		model.addObject("totalCnt", totalCnt);
		model.addObject("totalPageCnt", totalPageCnt);
		
		paginationInfo.setTotalRecordCount(totalCnt);
		
		model.addAllObjects(zvl);
		model.addObject("paginationInfo", paginationInfo);
		model.addObject("resultList", resultList);
		
		// 화면Sidebar정보
		model.addObject("pageLevel1", "account");
		model.addObject("pageLevel2", "3");
		model.addObject("pageName", "사용자 사전등록");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/user/userCertificationList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);			
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);			
		
		return model;
    }
	
	/**
	 * 사용자 등록 관리 등록/수정
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/user/modifyUserCertification.do")
	public ModelAndView modifyUserCertification(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		ModelAndView model = new ModelAndView();
		HttpSession session = request.getSession();
		SessionVO userInfo = (SessionVO) session.getAttribute("userInfo");
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		String gubun     = EgovStringUtil.nullConvert( zvl.getValue( "gubun" ) );  
		
		zvl.put( "userId", userInfo.getUserId() );			// 로그인 아이디로 변경 
		
		try{
			if("I".equals(gubun)) {
				UserService.insertUserCertification(zvl);
				model.addObject("message", egovMessageSource.getMessage("success.common.insert"));
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/user/userCertificationList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.INSERT);
				zvl.put("menu_id",    menu_id);			
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);		
				
			} else {
				UserService.updateUserCertification(zvl);
				model.addObject("message", egovMessageSource.getMessage("success.common.update"));
				
				// 로그 이력 저장
				String menu_id = "";
				zvl.put("url", 		  "/admin/user/userCertificationList.do");
				menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
				zvl.put("parameter",  zvl.toString());
				zvl.put("crud",       LogCrud.UPDATE);
				zvl.put("menu_id",    menu_id);			
				zvl.put("session_id", request.getRequestedSessionId());
				UserService.connectHistoryInsert(zvl, request);				
			}
			
		}catch(Exception e){
			if("I".equals(gubun)) {
				model.addObject("message", egovMessageSource.getMessage("fail.common.insert"));
			} else {
				model.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			}
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}

	/**
	 * 사용자 등록 관리 삭제
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/user/deleteUserCertification.do")
	public ModelAndView deleteUserCertification(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		ModelAndView model = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		try{
			UserService.deleteUserCertification(zvl);
			
			model.addObject("message", egovMessageSource.getMessage("success.common.delete"));
		}catch(Exception e){
			
			model.addObject("message", egovMessageSource.getMessage("fail.common.delete"));
			logger.error(e);
		}
		
		model.setViewName( "jsonView" );
		
		return model;
	}
	
	/**
	 * 사용자 인증 체크 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/user/checkUserCertification.do")
	public ModelAndView checkUserCertification(HttpServletRequest request) throws Exception { 
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		int checkCnt =  UserService.selectUserCertificationCheck(zvl);
		
		if(checkCnt == 0) {
			modelAndView.addObject("message", "P");
		} else {
			modelAndView.addObject("message", "E");
		}
		
		modelAndView.setViewName( "jsonView" );
		
		return modelAndView;
	}
	
	/**
	 * 사용자 등록 관리 목록
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/user/userLogList.do")
    public ModelAndView userLogList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView model = new ModelAndView();
		model.setViewName( "/user/userLogList" );
    	ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		int totalCnt = 0; 
		int totalPageCnt = 0;
		
		//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	zvl.put("pageSize", 10);
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));
		
		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		List<ZValue> resultList = UserService.selectUserLogList(zvl);
		
		totalCnt = UserService.selectUserLogCnt(zvl);
		totalPageCnt = (int) Math.ceil((double)totalCnt/(double)10);
		
		model.addObject("totalCnt", totalCnt);
		model.addObject("totalPageCnt", totalPageCnt);
		
		paginationInfo.setTotalRecordCount(totalCnt);
		
		zvl.put("uppercode", "HC00");
		List<ZValue> codeList = PssCommonService.retrieveCommCdList(zvl);
		
		model.addAllObjects(zvl);
		model.addObject("paginationInfo", paginationInfo);
		model.addObject("resultList", resultList);
		model.addObject("codeList", codeList);
		
		return model;
    }
	
	/**
	 * 수준진단 결과 다운로드
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/user/userExcelDown.do")
	public String mIndexExcelDownload(
			Map<String, Object> ModelMap,
			HttpServletRequest request,
			HttpServletResponse response
			) throws Exception {
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		zvl.put("excelFlag", "E");
		
		List<ZValue> resultList = UserService.userList(zvl);
		
		List<ZValue> chrgDutyList = PssCommonService.retrieveChrgDutyList(zvl);
    	
		ModelMap.put("chrgDutyList", chrgDutyList);
		ModelMap.put("resultList", resultList);
		ModelMap.put("downName", "userExcelDown");
		
		return "excelDownload";
	}
	
	/**
	 * 시스템 관리 - 사용자 관리
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/admin/user/userInsctrList.do")
	public ModelAndView userInsctrList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
		int totalCnt = 0; 
		int totalPageCnt = 0;
		
		//페이징 처리 변수 추후 property 방식으로 변경가능
    	if(!zvl.containsKey("pageIndex")) 
    		zvl.put("pageIndex", 1);
    	zvl.put("pageUnit", 10);
    	zvl.put("pageSize", 10);
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(zvl.getInt("pageUnit"));
		paginationInfo.setPageSize(zvl.getInt("pageSize"));
		
		
		zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
		zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
		zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		List<ZValue> resultList = UserService.selectUserInsctrList(zvl);
		modelAndView.addObject("userList", resultList);
		
		totalCnt = UserService.selectUserInsctrCnt(zvl);
		totalPageCnt = (int) Math.ceil((double)totalCnt/(double)10);
		
		modelAndView.addObject("totalCnt", totalCnt);
		modelAndView.addObject("totalPageCnt", totalPageCnt);
		
		paginationInfo.setTotalRecordCount(totalCnt);
		
		modelAndView.addAllObjects(zvl);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName( "user/userInsctrList" );
		
		// 화면 Sidebar 정보
		modelAndView.addObject("pageLevel1", "account");
		modelAndView.addObject("pageLevel2", "7");
		modelAndView.addObject("pageName", "점검원 관리");
		
		// 로그 이력 저장
		String menu_id = "";
		zvl.put("url", 		  "/admin/user/userInsctrList.do");
		menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
		zvl.put("parameter",  zvl.toString());
		zvl.put("crud",       LogCrud.READ);
		zvl.put("menu_id",    menu_id);
		zvl.put("session_id", request.getRequestedSessionId());
		UserService.connectHistoryInsert(zvl, request);			

		return modelAndView;
	}

	/**
	 * 시스템 관리 - 사용자 관리 - 점검원 비밀번호 초기화 AJAX
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/user/insctrRePasswd.do")
	public ModelAndView insctrRePasswd(HttpServletRequest request) throws Exception { 
		
		ModelAndView modelAndView = new ModelAndView();
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");

		zvl.put("adminId", userInfo.getUserId());

		try {
			UserService.updateInsctrPasswd(zvl);
			modelAndView.addObject("message", egovMessageSource.getMessage("success.common.update"));

			// 로그 이력 저장
			String menu_id = "";
			zvl.put("url", 		  "/admin/user/userInsctrList.do");
			menu_id = connectService.getConnectHistDataAdminMenuId(zvl);
			zvl.put("parameter",  zvl.toString());
			zvl.put("crud",       LogCrud.UPDATE);
			zvl.put("menu_id",    menu_id);
			zvl.put("session_id", request.getRequestedSessionId());
			UserService.connectHistoryInsert(zvl, request);	
			
		}catch(Exception e){
			modelAndView.addObject("message", egovMessageSource.getMessage("fail.common.update"));
			logger.error( e );
			e.printStackTrace();
		}
		
		modelAndView.setViewName( "jsonView" );
		return modelAndView;
	}
	
	/**
	 * 시스템 관리 - 사용자 관리 - 점검원 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("/admin/user/insctrExcelDownload.do")
	public String sIndexExcelDownload(Map<String, Object> ModelMap,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		List<ZValue> resultList = UserService.insctrInsttExcelList(zvl);

		ModelMap.put("resultList", resultList);
		ModelMap.put("downName", "insctrUser");

		return "excelDownload";
	}
	
	/**
	 * 중복 로그인
	 * @param request
	 * @param response
	 * @return modelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/login/loginDuplicate.do")
	public ModelAndView loginDuplicate(
				HttpServletRequest request, 
				HttpServletResponse response
								) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);
		
/*		zvl.put("conect_cd", "HC11");
		UserService.connectHistoryInsert(zvl, request);*/
		
		modelAndView.setViewName("redirect:/login/login.do");
		modelAndView.addObject("messageCd", "dup");
		//modelAndView.addObject("message", "동일 계정으로 로그인 되어 있습니다.");
		
		return modelAndView;
	}
	

	
	/**
	 * 세션 생성
	 * @param request
	 * @param response
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/login/sessionCreate.do")
	public ModelAndView sessionCreate(HttpServletRequest request,
					      HttpServletResponse response
					      ) throws Exception { 
		ModelAndView modelAndView = new ModelAndView();
		
		CustomUserDetails userDetails = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getDetails();

		String userId = userDetails.getUsername();
		
		LoginVO resultVO = new LoginVO();
		resultVO.setUserId(userId);
		resultVO  = UserService.userLogin(resultVO);
		
		SessionVO sessionVO = new SessionVO();

		sessionVO.setMyLibryYN("N");
		BeanUtils.copyProperties(resultVO, sessionVO);
	    //session에 유저정보 저장 임시
		request.getSession().setAttribute("userInfo", sessionVO);
		
		// 본부로 로그인 시 보건복지부로 셋팅
		String insttCd = sessionVO.getInsttCd();
		if ("1001000".equals(insttCd)){ sessionVO.setInsttCd("1000000"); sessionVO.setInsttNm("보건복지부"); }
		
		String authorId = sessionVO.getAuthorId();
		
		if("3".equals(authorId) || "6".equals(authorId)){
			modelAndView.setViewName("redirect:/cjs/intrcnRegist.do");
		}else if("4".equals(authorId)){
			modelAndView.setViewName("redirect:/admin/user/userList.do");
		}else{
			modelAndView.setViewName("redirect:/main.do");
		}
		
		return modelAndView;
	}
	
	/**
	 * 나의 정보관리 패스워드 확인
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/user/userInfoChk.do")
    public ModelAndView userInfoChk(
    						HttpServletRequest request,
							HttpServletResponse response,
							ModelMap model
							) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		HttpSession session = request.getSession(false);
		SessionVO userInfo = (SessionVO)session.getAttribute("userInfo");
		ZValue zvl = WebFactoryUtil.getAttributesInit(request);

		ZValue result = null;
		
		zvl.put("user_id", userInfo.getUserId());
		
		logger.debug("############## zvl ##############");
		logger.debug(zvl);
		logger.debug("############## zvl ##############");
		
		try{
			result = UserService.userInfo(zvl);
			model.addAttribute("result", result);
			modelAndView.addObject("pageName", "나의정보"); // 페이지 정보
			modelAndView.setViewName( "user/userInfoChk" );
		}catch(Exception e){
			logger.error( e );
			e.printStackTrace();
		}
		
		return modelAndView;	
    }
	
	
	/**
	 * 나의정보 접속시 패스워드 체크 AJAX 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/user/checkPw.do")
	public ModelAndView checkPw(@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName( "jsonView" );
		LoginVO resultVO = new LoginVO();
		
		String user_pw = loginVO.getPassword();
		
		SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
	    shaPasswordEncoder.setEncodeHashAsBase64(true);
	    user_pw = shaPasswordEncoder.encode(user_pw);
	    loginVO.setPassword("");
		resultVO  = UserService.userLogin(loginVO);
		
		//로그인 성공 체크
		if (resultVO != null && resultVO.getPassword().equals(user_pw)) {
			modelAndView.addObject("messageUrl", "/user/userInfo.do");
			modelAndView.addObject("messageCd", "Y");
		}else{
			modelAndView.addObject("message", "패스워드가 올바르지 않습니다.");
			modelAndView.addObject("messageCd", "N");
		}
		
		return modelAndView;
	}
	
}