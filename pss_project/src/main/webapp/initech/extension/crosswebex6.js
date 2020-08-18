/************************************************************
 * @brief		JS 로더
 * @retval		url				URL
 * @retval		callback		콜백 함수
 * @retval		charset			문자열 형식
 * @retval		attribute		속성
 ************************************************************/
function jsloader(url, callback, charset, attribute) {
	var head = document.getElementsByTagName('head')[0];
	var script = document.createElement('script');
	script.type = "text/javascript";

	if (!charset) {
		script.charset = "utf-8";
	};

	var loaded = false;
	script.onreadystatechange = function () {
		if (this.readyState == 'complete' || this.readyState == 'loaded') {
			if (loaded) {
				return;
			};
			loaded = true;
			if (callback) {
				callback();
			};
		};
	};
	script.onload = function () {
		if (loaded) {
			return;
		};
		loaded = true;
		if (callback) {
			callback();
		};
	};
	script.src = url;

	if (attribute && (attribute.length > 0)) {
		for (var aint = 0; aint < attribute.length; aint++) {
			script.setAttribute(attribute[aint].key, attribute[aint].value);
		}
	}
	head.appendChild(script);
};

/************************************************************
 * @brief		CSS 로더
 * @retval		url				URL
 * @retval		callback		콜백 함수
 * @retval		charset			문자열 형식
 ************************************************************/
function cssloader(url, callback, charset) {
	var head = document.getElementsByTagName('head')[0];
	var css = document.createElement('link');
	css.rel = "stylesheet";
	css.type = "text/css";
	if (!charset) {
		css.charset = "utf-8";
	};
	css.href = url;
	head.appendChild(css);
	if (callback) {
		callback();
	}
};

/************************************************************
 * @brief		플랫폼 정보 취득
 * @retval		platformInfo	플랫폼 정보
 ************************************************************/
function INI_getPlatformInfo() {
	var platformInfo = {
		Windows: false, Linux: false, Ubuntu: false, Fedora: false, Mac: false, iOS: false, Android: false,
		Mobile: false, x64: false,
		type: "unknown", name: "unknown"
	};
	platformInfo.name = navigator.platform;
	if (navigator.appVersion.match("WOW64")) platformInfo.name = "WOW64";

	if (platformInfo.name.match(/Win32/i) || platformInfo.name.match(/WOW64/i)) {
		platformInfo.Windows = true;
		platformInfo.type = "Windows";
		if (navigator.appVersion.match(/Win64/i)) {
			platformInfo.name = "Win64";
			platformInfo.x64 = true;
			platformInfo.type = "Windows64";
		}
	} else if (platformInfo.name.match("Win64")) {
		platformInfo.Windows = true;
		platformInfo.x64 = true;
		platformInfo.type = "Windows64";
	} else if (platformInfo.name.match("Linux armv")) {
		platformInfo.Mobile = true;
		platformInfo.Android = true;
		platformInfo.type = "Android";
	} else if (platformInfo.name.match(/Linux/i)) {
		platformInfo.Linux = true;
		platformInfo.type = "Linux";
		if (platformInfo.name.match(/x86_64/i)) {
			platformInfo.x64 = true;
			platformInfo.type = "Linux64";
		} else if (navigator.userAgent.match(/x86_64/i)) { //Opera
			platformInfo.x64 = true;
			platformInfo.type = "Linux64";
		}
		if (navigator.userAgent.match(/Fedora/i)) {
			platformInfo.Fedora = true;
			platformInfo.type = "Fedora";
			if (platformInfo.x64) platformInfo.type = "Fedora64";
		} else if (navigator.userAgent.match(/Ubuntu/i)) {
			platformInfo.Ubuntu = true;
			platformInfo.type = "Ubuntu";
			if (platformInfo.x64) platformInfo.type = "Ubuntu64";
		} else if (navigator.userAgent.match(/Android/i)) { //modify 20150903: Samsung Galaxy Edge
			platformInfo.Linux = false;
			platformInfo.Mobile = true;
			platformInfo.Android = true;
			platformInfo.type = "Android";
		}
	} else if (platformInfo.name.match(/MacIntel/i)) {
		platformInfo.Mac = true;
		platformInfo.type = "Mac";
	} else if (platformInfo.name == "iPad"
		|| platformInfo.name == "iPhone"
		|| platformInfo.name == "iPod"
		|| platformInfo.name == "iOS") {
		platformInfo.Mobile = true;
		platformInfo.iOS = true;
		platformInfo.type = "iOS";
	}

	if ((navigator.userAgent.match(/iPhone/i)) ||
		(navigator.userAgent.match(/iPod/i)) ||
		(navigator.userAgent.match(/iPad/i)) ||
		(navigator.userAgent.match(/Android/i))) {
		platformInfo.Mobile = true;
	}
	if ((navigator.userAgent.match(/Windows Phone/i)) ||
		(navigator.userAgent.match(/Windows CE/i)) ||
		(navigator.userAgent.match(/Symbian/i)) ||
		(navigator.userAgent.match(/BlackBerry/i))) {
		platformInfo.Mobile = true;
	}

	//modify/remove system type
	if (navigator.userAgent.match("Android") && navigator.userAgent.match("Opera Mini")) {
		platformInfo.Mobile = true;
		platformInfo.Android = true;
		platformInfo.type = "Android";
	}
	return platformInfo;
}

/************************************************************
 * @brief		HTML5 지원 여부
 * @retval		true			HTML5 지원
 * @retval		false			HTML5 지원 안함
 ************************************************************/
var GINI_supportHtml5 = function () {

	var agentInfo = navigator.userAgent.toLowerCase();
	if ((navigator.appName == 'Microsoft Internet Explorer') || (agentInfo.indexOf("msie") != -1)) {

		// IE 6		
		if (agentInfo.indexOf("msie 6") != -1) {
			// HTML5 지원 안함
			return false;
		// IE 7
		} else if (agentInfo.indexOf("msie 7") != -1) {
			// HTML5 지원 안함
			return false;
		// IE 8
		} else if (agentInfo.indexOf("msie 8") != -1) {
			// HTML5 지원 안함
			return false;
		// IE 9
		} else if (agentInfo.indexOf("msie 9") != -1) {
			// HTML5 지원 안함
			return false;
		}
	}

	return true;
}

/************************************************************
 * @brief		구간 암호화 지원 여부
 * @retval		true			구간 암호화 지원
 * @retval		false			구간 암호화 안함
 ************************************************************/
var GINI_supportEncryptHtml5 = function () {
	return true;
}

var INI_html5BasePath = '';
var crosswebexBaseDir = INI_html5BasePath + "/initech/extension";
var TNK_SR = '';

var GINI_DYNAMIC_LOAD = (function () {

	var loadCSSAndScript = function () {
		// Mobile 로드
		if (INI_getPlatformInfo().Mobile) {
			var loadCSS = function () { cssloader(INI_html5BasePath + "/initech/unikey/keypad/uniwebkey/css/uniwebkey_w2ui.css", loadCSSJqueryui, "utf-8"); };
			var loadCSSJqueryui = function () { cssloader(INI_html5BasePath + "/initech/html5/style/jqueryui/jquery-ui.css", loadCSS0, "utf-8"); };
			var loadCSS0 = function () { cssloader(INI_html5BasePath + "/initech/html5/style/jqueryui/jquery-ui.theme.css", loadCSS1, "utf-8"); };
			var loadCSS1 = function () { cssloader(INI_html5BasePath + "/initech/html5/style/initechBlueCommon.css", mCertificate, "utf-8"); };

			var mCertificate = function () {
				if (INI_getPlatformInfo().iOS) {
					cssloader(INI_html5BasePath + "/initech/html5/style/mobile/m_certificate_ios.css", mColorBlue, "utf-8");
				} else {
					cssloader(INI_html5BasePath + "/initech/html5/style/mobile/m_certificate.css", mColorBlue, "utf-8");
				}
			};
			var mColorBlue = function () { cssloader(INI_html5BasePath + "/initech/html5/style/mobile/m_color_blue.css", callback1, "utf-8"); };

			var callback1 = function () { jsloader(INI_html5BasePath + "/initech/html5/script/adaptor/cw_web6_neo_adt.js", uniwebkeySpLoad, "utf-8") };
			var uniwebkeySpLoad = function () { jsloader(INI_html5BasePath + "/initech/unikey/keypad/uniwebkey/js/uniwebkey_sp_20161214.min.js", uniwebkeyDebugLoad, "utf-8") };
			var uniwebkeyDebugLoad = function () { jsloader(INI_html5BasePath + "/initech/unikey/keypad/uniwebkey/js/uniwebkey_can_debug_20160812.min.js", iniGlobal, "utf-8") };
			var iniGlobal = function () { jsloader(INI_html5BasePath + "/initech/html5/script/main/initechGlobal.js", thirdPartyProductInit, "utf-8") };
			var thirdPartyProductInit = function () { jsloader(INI_html5BasePath + "/initech/html5/script/thirdParty/3rd_interface.js", html5MainJS, "utf-8") };
			var html5MainJS = function () {
				jsloader(INI_html5BasePath + "/initech/html5/script/common/requirejs/require.js",
					undefined,
					"utf-8",
					[{ "key": "data-main", "value": INI_html5BasePath + "/initech/html5/script/main/initechMain" }]
				);
			}
			loadCSS();
		// PC 로드
		} else {
			//document.write("<script type='text/javascript' src='" + INI_html5BasePath + "/TouchEn/nxKey/js/TouchEnNx.js'></script>");
			/************************************************************
			 * CrossWeb EX JavaScript 로딩
			 ************************************************************/
			document.write("<script type='text/javascript' src='" + crosswebexBaseDir + "/common/js/exproto.js'></script>");
			document.write("<script type='text/javascript' src='" + crosswebexBaseDir + "/common/exinstall.js'></script>");
			document.write("<script type='text/javascript' src='" + crosswebexBaseDir + "/common/exinterface.js'></script>");
			document.write("<script type='text/javascript' src='" + crosswebexBaseDir + "/cw_web6_adt.js'></script>");
			document.write("<script type='text/javascript' src='" + crosswebexBaseDir + "/crosswebexInit.js'></script>");

			/************************************************************
			 *  JavaScript 로딩
			 ************************************************************/
			var loadCSS = function () { cssloader(INI_html5BasePath + "/initech/unikey/keypad/uniwebkey/css/uniwebkey_w2ui.css", loadCSSJqueryui, "utf-8"); };
			var loadCSSJqueryui = function () { cssloader(INI_html5BasePath + "/initech/html5/style/jqueryui/jquery-ui.css", loadCSS0, "utf-8"); };
			var loadCSS0 = function () { cssloader(INI_html5BasePath + "/initech/html5/style/jqueryui/jquery-ui.theme.css", loadCSS1, "utf-8"); };
			var loadCSS1 = function () { cssloader(INI_html5BasePath + "/initech/html5/style/initechBlueCommon.css", undefined, "utf-8"); };

			/************************************************************
			 * 가상키패드(유니키패드) JavaScript 로딩
			 ************************************************************/
			//var callback1 = function () { jsloader(INI_html5BasePath + "/initech/html5/script/adaptor/cw_web6_neo_adt.js", uniwebkeySpLoad, "utf-8") };
			var uniwebkeySpLoad = function () { jsloader(INI_html5BasePath + "/initech/unikey/keypad/uniwebkey/js/uniwebkey_sp_20161214.min.js", uniwebkeyDebugLoad, "utf-8") };
			var uniwebkeyDebugLoad = function () { jsloader(INI_html5BasePath + "/initech/unikey/keypad/uniwebkey/js/uniwebkey_can_debug_20160812.min.js", iniGlobal, "utf-8") };

			/************************************************************
			 * 가상키패드(라온키패드) JavaScript 로딩
			 ************************************************************/
			var callback1 = function () { jsloader(INI_html5BasePath + "/initech/html5/script/adaptor/cw_web6_neo_adt.js", transkeyLoad1, "utf-8") };
			var transkeyLoad1 = function () { jsloader("/Transkey/rsa_oaep_files/rsa_oaep-min.js", transkeyLoad2, "utf-8") };
			var transkeyLoad2 = function () { jsloader("/Transkey/jsbn/jsbn-min.js", transkeyLoad3, "utf-8") };
			var transkeyLoad3 = function () { jsloader("/Transkey/TranskeyLibPack_op.js", transkeyLoad4, "utf-8") };
			var transkeyLoad4 = function () { jsloader("/transkeyServlet?op=getToken&'"+new Date().getTime(), transkeyLoad5, "utf-8") };
			var transkeyLoad5 = function () { jsloader("/Transkey/transkey.js",  transkeyCss, "utf-8") };
			var transkeyCss  = function () { cssloader("/Transkey/transkey.css", iniGlobal, "utf-8") };

			/************************************************************
			 * HTML5 JavaScript 로딩
			 ************************************************************/
			var iniGlobal = function () { jsloader(INI_html5BasePath + "/initech/html5/script/main/initechGlobal.js", html5MainJS, "utf-8") };
			var html5MainJS = function () {
				jsloader(INI_html5BasePath + "/initech/html5/script/common/requirejs/require.js",
					thirdPartyProductInit,
					"utf-8",
					[{ "key": "data-main", "value": INI_html5BasePath + "/initech/html5/script/main/initechMain" }]
				);
			}
			var thirdPartyProductInit = function () { jsloader(INI_html5BasePath + "/initech/html5/script/thirdParty/3rd_interface.js", undefined, "utf-8") };

			//loadCSS();
			//callback1();
		}
	}
	var completed = false;

	var moduleLoad = function () {
		loadCSSAndScript();
	};

	var changeCompleted = function () {
		completed = true;
	};

	var isCompleted = function () {
		return completed;
	}

	return {
		moduleLoad: moduleLoad,
		changeCompleted: changeCompleted,
		isCompleted: isCompleted
	}
})();

GINI_DYNAMIC_LOAD.moduleLoad();

//////////////////////////////
// common vaiable
//////////////////////////////
var importURL = window.location.protocol + "//" + window.location.host + INI_html5BasePath + "/CertRelay/servlet/GetCertificateV12";
var exportURL = window.location.protocol + "//" + window.location.host + INI_html5BasePath + "/CertRelay/servlet/GetCertificateV12";

var TimeURL = window.location.protocol + "//" + window.location.host + crosswebexBaseDir + "/common/tools/Time.jsp";
var RandomURL = window.location.protocol + "//" + window.location.host + crosswebexBaseDir + "/common/tools/Random.jsp";
var E2ERandomURL = window.location.protocol + "//" + window.location.host + crosswebexBaseDir + "/common/tools/E2E_Random.jsp";
var LogoURL = window.location.protocol + "//" + window.location.host + crosswebexBaseDir + '/img/certificate_top_TRUSTWEX.gif';
var TrustBannerURL = window.location.protocol + "//" + window.location.host + crosswebexBaseDir + '/img/banner.demo.initech.com.gif';

var EncFlag = 10;
var VerifyFlag = 11;
var CrossWebSpanTag = "CrossWeb_Extension";

var cipher = "SEED-CBC";
var hashalg = "sha2";

var turl = TimeURL;
var rurl = TimeURL;

//-------------------------------------------
//인증서 발급/갱신/폐기 관련 CA 정보(2048용 테스트)
//-------------------------------------------
var YessignCAIP = "203.233.91.231";		//금결원 테스트 CA 서버
var CrossCertCAIP = "211.180.234.201";	//전자인증 테스트 CA 서버 ( 201 서버가 안될 경우, 205 서버로 접속 211.180.234.205 )
var SignKoreaCAIP = "211.175.81.101";	//코스콤 테스트 CA 서버
var SignGateCAIP = "114.108.187.156";	//정보인증 테스트 CA 서버 ( 156 서버가 안될 경우, 61.72.247.156로 변경 )
//-------------------------------------------

//-------------------------------------------
//인증서 발급/갱신/폐기 관련 CA 정보(리얼)
//-------------------------------------------
//var YessignCAIP = "203.233.91.71";		//금결원 리얼 CA 서버
//var CrossCertCAIP = "211.192.169.90";		//전자인증 리얼 CA 서버
//var SignKoreaCAIP = "210.207.195.100";	//코스콤 리얼 CA 서버
//var SignGateCAIP = "211.35.96.43";		//정보인증 리얼 CA 서버
//-------------------------------------------

var YessignCMPPort = "4512";
var CrossCertCMPPort = "4512";
var SignKoreaCMPPort = "4099";
var SignGateCMPPort = "4502";

var InitechPackage = "INITECH";
var YessignPackage = "YESSIGN";
var CrossCertPackage = "CROSSCERT";
var SignKoreaPackage = "SIGNKOREA";
var SignGatePackage = "SIGNGATE";

// INITECH CA
var Initech_CAPackage = "INITECH_CA";
var Initech_CAIP = "dev.initech.com";
var Initech_CMPPort = "28088";	// HTTP
//var Initech_CMPPort = "28089";	// TCP
//var Initech_CMPPort = "8200";
var CANAME = "INITECHCA";

var CW_DEV_HOST = location.hostname;
var CW_TEST_HOST = location.hostname;
var CW_REAL_HOST = location.hostname;

// 서버 인증서
//var SCert = "-----BEGIN CERTIFICATE-----\nMIIDrDCCApSgAwIBAgIDAg6AMA0GCSqGSIb3DQEBCwUAMFMxCzAJBgNVBAYTAktSMRAwDgYDVQQKEwdJTklURUNIMREwDwYDVQQLEwhQbHVnaW5DQTEfMB0GA1UEAxMWSU5JVEVDSCBQbHVnaW4gUm9vdCBDQTAeFw0xMzA4MjAwMTA4NTZaFw0yMzA4MjAwMTA4NTVaMDgxCzAJBgNVBAYTAktSMRIwEAYDVQQKEwlJTklURUNIQ0ExFTATBgNVBAMTDDE3Mi4yMC4yNS43NjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALsJGJptNZVR18P6kdaBeb+DYTFpr8spXfFk5D8X1X1LEsfJzjSJmz7ApGqyxmY9ikFFqKtGaROoivHCR7v7AHRS7XXiu9kYe953HqXErs9bIVn9vvOn79hnahl4hlQpTrmAZNPBrTUpFHjMdegS4bC2gc4cRXbcvj3jn/gzvy3yqikKoXFQsYZLhkIdpEoQh+SW9ez2U6nYGursGWcHcPgAJKatLz6rjVjezKAhRxHbxn9A7LKRBLKw9BGStBwQNYxuPB7CE4R1odmb7emYasIzI0HS9kqEXFr98fHhoOFr6E2qypd4neiHOSwNxslZuCF/MCsSNhfG9Nelnw6ZQAcCAwEAAaOBozCBoDAfBgNVHSMEGDAWgBR1kfKc6tS556OlX3eE26EaDRiLpTAdBgNVHQ4EFgQUN/+hlTy59dnhJTPv6XxpjiNkH88wDgYDVR0PAQH/BAQDAgH+MAwGA1UdEwEB/wQCMAAwQAYDVR0fBDkwNzA1oDOgMYYvaHR0cDovLzExOC4yMTkuNTUuMTM5OjQ4MjAwL0NSTC9JTklURUNIQ0ExMy5jcmwwDQYJKoZIhvcNAQELBQADggEBADv7KiJjCOIilb1pl2VJrPflM/zopTMo0u+wJltwixE93FULMPk70/dOVXDP1Esf5itzZ55BKUqo/sq1JRLsBba6RUKeOiJ8bmJejl4RnHrQwraicVVF/aNKGTPws4iYOAFR9u9Y49kzQem/PL64vUQh4QVVoNN3254AZh2vBJ3swK/P+8lhx63V2Qet0hy6EZRZEjZUa8Do8eSVacfaDCM6kKHjP2a0bmvCFmEmrc1RWpiqZK7B6BNWhgg4br2oub6pGa6ntDxbSaXlDUW/jujPhtRKXa5tNbDtHqceTzTMLDKP4k2CbSk44fv1ryygv6Q3HOs3k9sPAIN8qtnMJTE=\n-----END CERTIFICATE-----";

/* 개발 서버인증서
var SCert = "-----BEGIN CERTIFICATE-----\n";
SCert += "MIIDzDCCArSgAwIBAgIDAgxLMA0GCSqGSIb3DQEBCwUAMFMxCzAJBgNVBAYTAktS\n";
SCert += "MRAwDgYDVQQKEwdJTklURUNIMREwDwYDVQQLEwhQbHVnaW5DQTEfMB0GA1UEAxMW\n";
SCert += "SU5JVEVDSCBQbHVnaW4gUm9vdCBDQTAeFw0xMjA1MDIwMjQwNDdaFw0yMjA1MDIw\n";
SCert += "MjQwNDZaMD4xCzAJBgNVBAYTAktSMRIwEAYDVQQKEwlJTklURUNIQ0ExGzAZBgNV\n";
SCert += "BAMTEmRlbW8uaW5pbGluZS5jby5rcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC\n";
SCert += "AQoCggEBAKmD5N+VmmzZpJ/2DgU+DZ91d5xv+ooZi5Fua9GLubJEL0Ybn9yVf6l3\n";
SCert += "EppHeJ+urBTzNXiifR4V56anaRrd/PeGvFar+NZL1TEpsQl4BOAgDLeXAVZiDBo/\n";
SCert += "h83dJDwq7pfPxlCU9w6jIFzoWiiB51KNqCsVDX6CRWfRVazG+LIcFgiN8pyUnxDa\n";
SCert += "XjTxygy9e3AVO7sH3vx0k8A1tK+mRPHfjiz4bNTlLKJD606WXSSy5ztnhM3P6wFM\n";
SCert += "S7A7kW0NCVrSueCUdggTI5w5HM0DVgXnC8zUd3XB/0dK0S9J7JJ4cawE5PsmElNR\n";
SCert += "hRJ5IYpVpsc+YBsbL+Qlv/NRRKtFrvECAwEAAaOBvTCBujAfBgNVHSMEGDAWgBR1\n";
SCert += "kfKc6tS556OlX3eE26EaDRiLpTAdBgNVHQ4EFgQUSLn2Fx+UtOeXPPUIHs/tbCcc\n";
SCert += "Qf8wDgYDVR0PAQH/BAQDAgH+MAwGA1UdEwEB/wQCMAAwGAYDVR0RBBEwD4YNMTEy\n";
SCert += "LjIxNi45OC42ODBABgNVHR8EOTA3MDWgM6Axhi9odHRwOi8vMTE4LjIxOS41NS4x\n";
SCert += "Mzk6NDgyMDAvQ1JML0lOSVRFQ0hDQTEzLmNybDANBgkqhkiG9w0BAQsFAAOCAQEA\n";
SCert += "MPKrYOGm8t9McVRGWdiNRUNIEErMqYAVPMpgox+Ic+ownnhdaHWlFkyQlyRbPBV/\n";
SCert += "tv8Edvakmf71nszEgD2jGYprnwCo6ZPvGS+ozNkokon9JDDw9WBfJqMUpqqh8HC/\n";
SCert += "U0wdpMq3Fd5LQnwDWGXlD/sV5ri4ZAvZQEFlD/rEqYBBiFK5iuoP1Om7AASPlwaN\n";
SCert += "xazr0B7iznJ6llkTmMzTzh/XQ6CERvHoEeY1wi2eeY9I8LMZhYcywopYrrZL21io\n";
SCert += "noZ0jvkbu5uEeCYhJ30nlolrK2gpo/vrWpaFua7rgpNKEu+hFwSNeqfGLylj4bg5\n";
SCert += "tEzdI16l93WiaUDFjSvttg==\n";
SCert += "-----END CERTIFICATE-----\n";
*/

//운영서버 인증서
var SCert = "-----BEGIN CERTIFICATE-----MIIDrjCCApagAwIBAgIDAhKYMA0GCSqGSIb3DQEBCwUAMFMxCzAJBgNVBAYTAktSMRAwDgYDVQQKEwdJTklURUNIMREwDwYDVQQLEwhQbHVnaW5DQTEfMB0GA1UEAxMWSU5JVEVDSCBQbHVnaW4gUm9vdCBDQTAeFw0xNzEwMjcwNTU5NDdaFw0yNzEwMjcwNTU5NDZaMDkxCzAJBgNVBAYTAktSMRIwEAYDVQQKEwlJTklURUNIQ0ExFjAUBgNVBAMTDTE5Mi4xNjguMC4xMzAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCuQhNWUzwlXAgo+PdN0CQEVWU2CFxPK75UZgpN3ORDckQt7mwYwH6ofxBtJueIrdHVqEoDh66HYRNic29kjPFN2ZdUADD4LHR1KQ5s8ybqprw4fs/ZP2dIGBAWM+30FerPfHuN26e3pOTmUj3LIUf+hR6SoyDgkjJuVAaB55A943/Zj8lFwiRQmNEmy3f45inKSLzcR72izsm4qyg2ScLI8k0BfoD8hrV4/+F4X/ZrPjWONhG2PZeuTPK5xT7rYF4T9lVThW/9doD/PisGVXmwNBwqXB7MdTb1D18xvDFyYdWbUQxS0Ht0iRizD994taWz852dPRT+omqr3+vRB1kLAgMBAAGjgaQwgaEwHwYDVR0jBBgwFoAUdZHynOrUueejpV93hNuhGg0Yi6UwHQYDVR0OBBYEFFC1vvyjdlCqEj2SFaAEKCuMCgy9MA4GA1UdDwEB/wQEAwIB/jAMBgNVHRMBAf8EAjAAMEEGA1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9kZXYuaW5pdGVjaC5jb206NDgyMDAvQ1JML0lOSVRFQ0hDQTEzLmNybDANBgkqhkiG9w0BAQsFAAOCAQEAXCffHsHL0RNirKGvWbAKoFFS6eMLlB/GEMC17RYMJglyyXxlW85JLIHutBPF52EXYUyIXJWLr0Pzi4s4S6Rrx+hUSHl6anwYNygKugSqL4JK0S6+sjAeliahQChHsHIl+74gaLDw3AW/i88bDwFgF6QXrd91ptiPa1FsNsnnwzhhU88GQMKcPWysiM9wOeETaXG2LcXvwyL/p8Bj8xZInw/HyyKgxo182l9BcnM1KzSy0K67R5V1mt6oU9AE0XWDc5z5ImLQody/0Rq2xTUBtpjWv4Mc5IknjOSkQk6k4bQxnMPRRt7fTk4MCbpvjigGSDdxTdZbYO9lRYwxg2CLqg==-----END CERTIFICATE-----";

// Real-CA 인증서 (2048)
var realSignKorea_2048 = "-----BEGIN CERTIFICATE-----\nMIIGDTCCBPWgAwIBAgICEAIwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTAwOTA2\nMDgzNTUxWhcNMjAwOTA2MDgzNTUxWjBQMQswCQYDVQQGEwJLUjESMBAGA1UECgwJ\nU2lnbktvcmVhMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExFjAUBgNVBAMMDVNpZ25L\nb3JlYSBDQTIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCPxvWUWarJ\nIEsIcRYOQqfso/15wBqOLQjfBjodSZjERjPYHlGdPP+ThzCvrJx3D9M7ECWMMEJX\nvG/5NpH/2JRbRyUH3uNeocrIT5wgcEbDfpeg0DsHWy1Ln92ZwVjstHetu/9DrIu5\nM3b7fuHYaRhZ1EXMbicxsSCEVILP07rKHlxjZJrxqtBa5sjYJdU5TT3PS+3QdD1e\nK3X1nmwMexm0fb3CpW07bNXkPVSucuoZL+vZSPFszZpDtGnbYMt4HtaOQVQ+99vq\n7M0ZfZ9YoYt4e0AVQI0QaWg5lb+bB0ROh6qRpFAh711q5K0vVlqvq0ikj6eZTBbS\nVGTF9C4PkoTHAgMBAAGjggLbMIIC1zCBjgYDVR0jBIGGMIGDgBTI0I7HSa4fIEKy\nS38TyXdYDKHNwaFopGYwZDELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAs\nBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxFjAU\nBgNVBAMMDUtJU0EgUm9vdENBIDSCAQEwHQYDVR0OBBYEFCeWlr7zhNxZAWIkI+IY\ne9NBjS1CMA4GA1UdDwEB/wQEAwIBBjCCATEGA1UdIAEB/wSCASUwggEhMIIBHQYE\nVR0gADCCARMwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9yLmtyL3Jj\nYS9jcHMuaHRtbDCB3gYIKwYBBQUHAgIwgdEegc7HdAAgx3jJncEcspQAIKz1x3jH\neMmdwRzHhbLIsuQAKABUAGgAaQBzACAAYwBlAHIAdABpAGYAaQBjAGEAdABlACAA\naQBzACAAYQBjAGMAcgBlAGQAaQB0AGUAZAAgAHUAbgBkAGUAcgAgAEUAbABlAGMA\ndAByAG8AbgBpAGMAIABTAGkAZwBuAGEAdAB1AHIAZQAgAEEAYwB0ACAAbwBmACAA\ndABoAGUAIABSAGUAcAB1AGIAbABpAGMAIABvAGYAIABLAG8AcgBlAGEAKTAqBgNV\nHREEIzAhoB8GCSqDGoyaRAoBAaASMBAMDijso7wp7L2U7Iqk7L2kMBIGA1UdEwEB\n/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjgYDVR0fBIGGMIGDMIGAoH6g\nfIZ6bGRhcDovL2Rpci5zaWdua29yZWEuY29tOjM4OS9DTj1LSVNBLVJvb3RDQS00\nLE9VPUtvcmVhLUNlcnRpZmljYXRpb24tQXV0aG9yaXR5LUNlbnRyYWwsTz1LSVNB\nLEM9S1I/YXV0aG9yaXR5UmV2b2NhdGlvbkxpc3QwDQYJKoZIhvcNAQELBQADggEB\nAMM91U4LDzBWvL3NzmMalbWhndl3jFR+pUJv28tIdUCLBXgkf6NYkw22IStw2xgp\ndtjz6y23c1iLGUfiEamR88tWKTF9lut32d45HdP83Uhhlvi8UM0HKfHUlerKjWRG\nI6KwL+9n+7MwXXLmqFSa5zuhsgAWnI9Crydo+las3MlS+HrFVQBHhDAyYZHdQ206\nkLw2rQmLZVsqBgvMPquPEiE7uymNrnGeBWO52RUuhjkiGtMmJ0FrJcIew3lhgQES\n7RYhwcpHD7hbzAeD/H48QfCCY+XmwBswI7R9wZJtev54505WlG8cME7agFgDJNjQ\nGG/5s824NwQrnD8P/KqPqn8=\n-----END CERTIFICATE-----\n";
var realSignKorea_2048_1020 = "-----BEGIN CERTIFICATE-----\nMIIGDTCCBPWgAwIBAgICECAwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTYwNTEz\nMDIzMzM1WhcNMjYwNTEzMDIzMzM1WjBQMQswCQYDVQQGEwJLUjESMBAGA1UECgwJ\nU2lnbktvcmVhMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExFjAUBgNVBAMMDVNpZ25L\nb3JlYSBDQTMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC8NWUKGJNd\nVCNqvd/QcILyO4isIUPttcnuEGBTgNYb1q66ChssV2rMZrazyT96PZwmMwusp7Np\n+TsmmifDJtRrzS3K2MiPEK7xubND8nlQqL3OC61QglqdPO5JYe75e7aHJGe/ijGz\nlnrTxEx2OpC27gZCHuheei8Hn2eN6HPA7YmmazSe5VEOS8f1jSFQFGKQFaO+28OO\ng4gzuSwE8uZ3UbeV1iWhvPybs52x3PV8/vqHGUKLBAIz8xKvEFsWHhxeh1VcbvDZ\nHVDVi1A0fNry2OMgW7QiCIhfo3i/EHKtUp4SL8NDJ8dfjseqSwNMCKxHXK9Edoq2\npo5v/d0VNDz1AgMBAAGjggLbMIIC1zCBjgYDVR0jBIGGMIGDgBTI0I7HSa4fIEKy\nS38TyXdYDKHNwaFopGYwZDELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAs\nBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxFjAU\nBgNVBAMMDUtJU0EgUm9vdENBIDSCAQEwHQYDVR0OBBYEFARURbDeEsQnnKBPAmmL\n1VsUFGMHMA4GA1UdDwEB/wQEAwIBBjCCATEGA1UdIAEB/wSCASUwggEhMIIBHQYE\nVR0gADCCARMwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9yLmtyL3Jj\nYS9jcHMuaHRtbDCB3gYIKwYBBQUHAgIwgdEegc7HdAAgx3jJncEcspQAIKz1x3jH\neMmdwRzHhbLIsuQAKABUAGgAaQBzACAAYwBlAHIAdABpAGYAaQBjAGEAdABlACAA\naQBzACAAYQBjAGMAcgBlAGQAaQB0AGUAZAAgAHUAbgBkAGUAcgAgAEUAbABlAGMA\ndAByAG8AbgBpAGMAIABTAGkAZwBuAGEAdAB1AHIAZQAgAEEAYwB0ACAAbwBmACAA\ndABoAGUAIABSAGUAcAB1AGIAbABpAGMAIABvAGYAIABLAG8AcgBlAGEAKTAqBgNV\nHREEIzAhoB8GCSqDGoyaRAoBAaASMBAMDijso7wp7L2U7Iqk7L2kMBIGA1UdEwEB\n/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjgYDVR0fBIGGMIGDMIGAoH6g\nfIZ6bGRhcDovL2Rpci5zaWdua29yZWEuY29tOjM4OS9DTj1LSVNBLVJvb3RDQS00\nLE9VPUtvcmVhLUNlcnRpZmljYXRpb24tQXV0aG9yaXR5LUNlbnRyYWwsTz1LSVNB\nLEM9S1I/YXV0aG9yaXR5UmV2b2NhdGlvbkxpc3QwDQYJKoZIhvcNAQELBQADggEB\nAEi2H54k3tOF/fXAI0W20SiSOfizAX+t5qvJrV9ob1xDWeaTnLjSpu/IGNwcjWS7\nwseFyo2T95cEGMcmzMlIp/t0HopziXv4WC0mulAdk0yvynBQY9HcO5DzXWp83lYe\nU+CMB3UkBBaOAWU/aXQNxZUwnsn2wYoWq3OE4I6hHB33jSJZTYXTcHt4wkTa+BGO\nCu4cQOa6mtMiG12Zo+J3+360z4laRSmM/nQdVMYFLvdEJ8/3ki1MhEr3efhNE/8X\nwhtboEi7qXUH8MrViR6uUnKcMMySI+26N+Aim/itOqYCvhFmDY7619ttPk6ktefB\niIHMsKEv168n68Bm7l/GGRE=\n-----END CERTIFICATE-----\n"
var realYessign_2048 = "-----BEGIN CERTIFICATE-----\nMIIGDjCCBPagAwIBAgICEAMwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTAwOTA2\nMDgzNjI3WhcNMjAwOTA2MDgzNjI3WjBSMQswCQYDVQQGEwJrcjEQMA4GA1UECgwH\neWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRowGAYDVQQDDBF5ZXNzaWdu\nQ0EgQ2xhc3MgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMIRylMU\nnaWOTdB3uVrlR5++4zJX+6XUqesC4G0ijU9Ux38T3UvexzlHjXevFrdTacujjFP+\nTPtGr2V/UehKlJfb1ozrUZ5oUqsxf0C0+iA0ZnVBT2JG1YvhuAV20p+rcWxMjyvP\nR5VoV7kg6QT3DiW/Ok6V2SpMu63DZ3Dl1h5ONECHtOmMade7T8PH4y2wS+Gu5cVK\nVyRYrPzgU8xmbpfhoV52MR+hCIwuSgj/v0DNF6wSJB8WXQiSX/Sa9YT5fHht8zgq\na4uLqJUxy9Azid4OFKxFWiLKLP1k5GAGjODIWifhNmBfCdRs+6ohcF0D/I5tsC+v\nD9JGGM5c//73gdkCAwEAAaOCAtowggLWMIGOBgNVHSMEgYYwgYOAFMjQjsdJrh8g\nQrJLfxPJd1gMoc3BoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEu\nMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEW\nMBQGA1UEAwwNS0lTQSBSb290Q0EgNIIBATAdBgNVHQ4EFgQUUgQyn4+dIXK6+jOY\nqGF+JzMkjV8wDgYDVR0PAQH/BAQDAgEGMIIBMQYDVR0gAQH/BIIBJTCCASEwggEd\nBgRVHSAAMIIBEzAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3Iv\ncmNhL2Nwcy5odG1sMIHeBggrBgEFBQcCAjCB0R6Bzsd0ACDHeMmdwRyylAAgrPXH\neMd4yZ3BHMeFssiy5AAoAFQAaABpAHMAIABjAGUAcgB0AGkAZgBpAGMAYQB0AGUA\nIABpAHMAIABhAGMAYwByAGUAZABpAHQAZQBkACAAdQBuAGQAZQByACAARQBsAGUA\nYwB0AHIAbwBuAGkAYwAgAFMAaQBnAG4AYQB0AHUAcgBlACAAQQBjAHQAIABvAGYA\nIAB0AGgAZQAgAFIAZQBwAHUAYgBsAGkAYwAgAG8AZgAgAEsAbwByAGUAYQApMCsG\nA1UdEQQkMCKgIAYJKoMajJpECgEBoBMwEQwP6riI7Jy16rKw7KCc7JuQMBIGA1Ud\nEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjAYDVR0fBIGEMIGBMH+g\nfaB7hnlsZGFwOi8vZHMueWVzc2lnbi5vci5rcjozODkvQ049S0lTQS1Sb290Q0Et\nNCxPVT1Lb3JlYS1DZXJ0aWZpY2F0aW9uLUF1dGhvcml0eS1DZW50cmFsLE89S0lT\nQSxDPUtSP2F1dGhvcml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3DQEBCwUAA4IB\nAQBdGlZZIV/ciFPet6HLmBfgI3WdHP9gXfplTsV9HqAIPSGNOSjJrfSIWFP+mjk0\nhVlt1fMF3D+5loekqsskp7U6bmbPt5QCpXdX6TdhyP7hcUGClXS0jcQR1Nli1Bgx\ntKNL3nv3PwW005dAyQVVx3qmtPXR8a9/FzOPoY4Gf6PyWi9yQugfBQkvkTMNa+r3\nbULTj3jk1IaK5rp23EKbhCrLUTJ6BIdjOaS/NY1DDCtU3SVAUlZhi9X0lh3cGchl\nJT5G57OiC1/rjNZcwoQBPLflsqJ8ZtWBmN9VDXNwAHtLl7znKJ286OjT+5AHuifm\nIYtAnDJPs4Oy3F4dQ/4pjgm6\n-----END CERTIFICATE-----\n";
var realYessign_2048_101C = "-----BEGIN CERTIFICATE-----\nMIIGDjCCBPagAwIBAgICEBwwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTUxMDAy\nMDEzNDA1WhcNMjUxMDAyMDEzNDA1WjBSMQswCQYDVQQGEwJrcjEQMA4GA1UECgwH\neWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRowGAYDVQQDDBF5ZXNzaWdu\nQ0EgQ2xhc3MgMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKXC/hP9\nvF6PPP10R6jNcjptiIUxBg8uiqIKhLKKrBT4iBIBJA9/emG1hZpvi/CAGyGI18Ri\nZctzU8LFdsEbP+HSuuSXpbIHpUZ4xbm3zipeJx/hzu94KxwePcuQM+/p4UIZY0dK\n4ItV3s2oSsprENVAe6WCRcaeD5+5AvTlRDa6mvZyghJsoj5kPgpigixW9Ci3O4l5\nNyi2BtvlN0alPMeEvv6j32ACSPtXyBGI7PlM3zUoy5jj9HyDW7x2ZEO7b7yB1UZC\nI4UWMtKINm6eu73Imy4eL4fVJqUIkkER2OKPvSjLxeD8y6iFOT6UJsIg4r2By35I\nZmuMIAPG3s03G4ECAwEAAaOCAtowggLWMIGOBgNVHSMEgYYwgYOAFMjQjsdJrh8g\nQrJLfxPJd1gMoc3BoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEu\nMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEW\nMBQGA1UEAwwNS0lTQSBSb290Q0EgNIIBATAdBgNVHQ4EFgQU79xE0saNwA6jOMB8\nk8bDQb9Kj/AwDgYDVR0PAQH/BAQDAgEGMIIBMQYDVR0gAQH/BIIBJTCCASEwggEd\nBgRVHSAAMIIBEzAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3Iv\ncmNhL2Nwcy5odG1sMIHeBggrBgEFBQcCAjCB0R6Bzsd0ACDHeMmdwRyylAAgrPXH\neMd4yZ3BHMeFssiy5AAoAFQAaABpAHMAIABjAGUAcgB0AGkAZgBpAGMAYQB0AGUA\nIABpAHMAIABhAGMAYwByAGUAZABpAHQAZQBkACAAdQBuAGQAZQByACAARQBsAGUA\nYwB0AHIAbwBuAGkAYwAgAFMAaQBnAG4AYQB0AHUAcgBlACAAQQBjAHQAIABvAGYA\nIAB0AGgAZQAgAFIAZQBwAHUAYgBsAGkAYwAgAG8AZgAgAEsAbwByAGUAYQApMCsG\nA1UdEQQkMCKgIAYJKoMajJpECgEBoBMwEQwP6riI7Jy16rKw7KCc7JuQMBIGA1Ud\nEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjAYDVR0fBIGEMIGBMH+g\nfaB7hnlsZGFwOi8vZHMueWVzc2lnbi5vci5rcjozODkvQ049S0lTQS1Sb290Q0Et\nNCxPVT1Lb3JlYS1DZXJ0aWZpY2F0aW9uLUF1dGhvcml0eS1DZW50cmFsLE89S0lT\nQSxDPUtSP2F1dGhvcml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3DQEBCwUAA4IB\nAQAhOe2oq/Uazi/nKMhM3W+H1y3GnVc9n+lfmmTA4PjM6U07h/hvCbFJQiDe6zoM\ne4lVu+YxGWDAEol5ZiSBAaGAjdJFy+uoYHqJP+33+jruj4j4c7/wK7wyAzSfjNwu\nNXThM8Aygkohv784o/2Vq7cxD4ZpVYOznb/0/MmLzl2mDYRsCtHrkADHloD7JGB6\n8/ESX6Y4sfNwsOFZ9saLDclQuEeZJ0pJMzkkGo3r8bGkxHo2VgJsVqBmiLk5RWP6\nsxAY2OVmaSObBYv1IhiovW+A3FSnY5LAvaSKWqKe+pq/3EwqBKvmMIF4/j7P0sA+\nIneqPXtp+T1FxODf4yT5reEu\n-----END CERTIFICATE-----\n";
var realCrossCert_2048 = "-----BEGIN CERTIFICATE-----\nMIIGEDCCBPigAwIBAgICEAQwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTAwOTA2\nMDgzNzAwWhcNMjAwOTA2MDgzNzAwWjBPMQswCQYDVQQGEwJLUjESMBAGA1UECgwJ\nQ3Jvc3NDZXJ0MRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExFTATBgNVBAMMDENyb3Nz\nQ2VydENBMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALDruBWuOVv1\nLj3D1TuGXBFLUpdNi/o4jasLVM8/V4ZDP0lbR6SOJoGOp7muS7XHyiCZSLlNVFZp\nxvXfD83doYhqjB7axwwVShLTp5+RbXjTYxgNqjHOCDh6HF9NvEocYL3YEndO1Mfq\nhhcare4yYZE3CrrCHtlorJRqtvfDiD92jeIPG8SB91fPqOtYljDrqeBT1lD8njcj\naw8u9+l4UXOUmRX+Qfkk6OOzAx6rl956/qCQfia+2O6d8tIRpk0ICz6kuY/XtL09\n9bVFAetReyEPDErs0kcvEbif/yd8MW6k/2ZHWuqhP8a//DZ7w9GD0bGkmlfA5d+r\nTc9VAKM+cnUCAwEAAaOCAt8wggLbMIGOBgNVHSMEgYYwgYOAFMjQjsdJrh8gQrJL\nfxPJd1gMoc3BoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwG\nA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQG\nA1UEAwwNS0lTQSBSb290Q0EgNIIBATAdBgNVHQ4EFgQUtnSpm5I8x1GxIqRPvLc8\n/iIz13YwDgYDVR0PAQH/BAQDAgEGMIIBMQYDVR0gAQH/BIIBJTCCASEwggEdBgRV\nHSAAMIIBEzAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3IvcmNh\nL2Nwcy5odG1sMIHeBggrBgEFBQcCAjCB0R6Bzsd0ACDHeMmdwRyylAAgrPXHeMd4\nyZ3BHMeFssiy5AAoAFQAaABpAHMAIABjAGUAcgB0AGkAZgBpAGMAYQB0AGUAIABp\nAHMAIABhAGMAYwByAGUAZABpAHQAZQBkACAAdQBuAGQAZQByACAARQBsAGUAYwB0\nAHIAbwBuAGkAYwAgAFMAaQBnAG4AYQB0AHUAcgBlACAAQQBjAHQAIABvAGYAIAB0\nAGgAZQAgAFIAZQBwAHUAYgBsAGkAYwAgAG8AZgAgAEsAbwByAGUAYQApMC4GA1Ud\nEQQnMCWgIwYJKoMajJpECgEBoBYwFAwS7ZWc6rWt7KCE7J6Q7J247KadMBIGA1Ud\nEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjgYDVR0fBIGGMIGDMIGA\noH6gfIZ6bGRhcDovL2Rpci5jcm9zc2NlcnQuY29tOjM4OS9DTj1LSVNBLVJvb3RD\nQS00LE9VPUtvcmVhLUNlcnRpZmljYXRpb24tQXV0aG9yaXR5LUNlbnRyYWwsTz1L\nSVNBLEM9S1I/YXV0aG9yaXR5UmV2b2NhdGlvbkxpc3QwDQYJKoZIhvcNAQELBQAD\nggEBAJdrnJLYDElPoEvWNXZX8OYs5b2qA17Nz2RyGfuxz7NZHaQKNcdBGIMWmHvm\nMclpYrCkXjJfqhDKkgdOhyE4CjfYJqjTQxbrbMnTwYcjTRZ+VwwW9auPDImrEOsk\n4wl3hiSfLtHZXEi8YnnoB6TvYI9ZnALJs/SjNFSoQEpvxRA/3Tmx1KeyYcaFcC/W\n+qjmDN+b10SfFEcUeCqcO9dRHjuBpFeTGxtU8qIiWItWFvHVx6un6oTvoqRjJXS7\nY5Hn29F1rnr9HOZO+jho2L9Yf0lnlZIB7OnAgS/hcARSHcCFQWoZI4OTV7fkUFht\nGn0jUlDJ6Kd8Xp5xD08myIgfimY=\n-----END CERTIFICATE-----\n";
var realCrossCert_2048_101E = "-----BEGIN CERTIFICATE-----\nMIIGEDCCBPigAwIBAgICEB4wDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTYwMTA1\nMDgyMTA1WhcNMjYwMTA1MDgyMTA1WjBPMQswCQYDVQQGEwJLUjESMBAGA1UECgwJ\nQ3Jvc3NDZXJ0MRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExFTATBgNVBAMMDENyb3Nz\nQ2VydENBMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMQh+483jjVm\nmqoGaWKLZyz81MObZq94RIPwq1kEQUu46umnobZaOamnVxB9ggJfJV34ugY95zEI\nqNOcMRGYXSfySd5uDvPVstwOb4vuMQDdrsHtcbRMIESsq6By8jKAvVbYV9T+RFyy\n4TOCiRfzyAIZeZ9kyHLze2Q3bAjeHgPWA/M+F7MAMtKhx8IB4NUa83rJ1mY6t35E\n8L7i7QoCX8/w7hu+W6DU+DbZBUk10kDUZqMP28h9k0brRnmCr8pcleuuOjymwaWu\nBWDhSavWpXwY4vGNHg4HZvdDsEPEXTwveQY3SoceENdJDiSOMzXvebwJlJVWDvFD\nTueYrSkmS9cCAwEAAaOCAt8wggLbMIGOBgNVHSMEgYYwgYOAFMjQjsdJrh8gQrJL\nfxPJd1gMoc3BoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwG\nA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQG\nA1UEAwwNS0lTQSBSb290Q0EgNIIBATAdBgNVHQ4EFgQUQ9bzZX9lnc1rwc5zCr8y\nEKBR5xEwDgYDVR0PAQH/BAQDAgEGMIIBMQYDVR0gAQH/BIIBJTCCASEwggEdBgRV\nHSAAMIIBEzAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3IvcmNh\nL2Nwcy5odG1sMIHeBggrBgEFBQcCAjCB0R6Bzsd0ACDHeMmdwRyylAAgrPXHeMd4\nyZ3BHMeFssiy5AAoAFQAaABpAHMAIABjAGUAcgB0AGkAZgBpAGMAYQB0AGUAIABp\nAHMAIABhAGMAYwByAGUAZABpAHQAZQBkACAAdQBuAGQAZQByACAARQBsAGUAYwB0\nAHIAbwBuAGkAYwAgAFMAaQBnAG4AYQB0AHUAcgBlACAAQQBjAHQAIABvAGYAIAB0\nAGgAZQAgAFIAZQBwAHUAYgBsAGkAYwAgAG8AZgAgAEsAbwByAGUAYQApMC4GA1Ud\nEQQnMCWgIwYJKoMajJpECgEBoBYwFAwS7ZWc6rWt7KCE7J6Q7J247KadMBIGA1Ud\nEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjgYDVR0fBIGGMIGDMIGA\noH6gfIZ6bGRhcDovL2Rpci5jcm9zc2NlcnQuY29tOjM4OS9DTj1LSVNBLVJvb3RD\nQS00LE9VPUtvcmVhLUNlcnRpZmljYXRpb24tQXV0aG9yaXR5LUNlbnRyYWwsTz1L\nSVNBLEM9S1I/YXV0aG9yaXR5UmV2b2NhdGlvbkxpc3QwDQYJKoZIhvcNAQELBQAD\nggEBAFmykQiYoAVr8mceqWYw3sI4wQWCASRqLHnB7QnhhehzzLIK+E3q/7vct6T/\niToq8I5s6R2DqUZB6LuTQY0IJnM/EUBVANuGT044IuhiIs5er14f4YaX58Q96l7j\nbTWyed8OtR1dvS84kPTdSDpDKgrk+IEvS7M2rNXj/Kkb1rSXRgpvxpyEECCevcZO\ngrdNnP96Il/7O/XaBVYQJIRi7k4aY4PoLP+k58xAVu+9zlMwRFRMJ3+w+l1fECzD\nHzIkQGGh4LRdrjrUoYbxMr2USHpaWq/mfzrWymuJrhi/xTxSoWw1cWEcz7i+JnLS\nJaXjggr4rRrzo0ilz2mEDUj6MUc=\n-----END CERTIFICATE-----\n";
var realTradeSign_2048 = "-----BEGIN CERTIFICATE-----\nMIIGFzCCBP+gAwIBAgICEAkwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTAxMDAx\nMDgzODAzWhcNMjAxMDAxMDgzODAzWjBPMQswCQYDVQQGEwJLUjESMBAGA1UECgwJ\nVHJhZGVTaWduMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExFTATBgNVBAMMDFRyYWRl\nU2lnbkNBMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKHCC18Bv3d+\n+/iVp24Sj3CADxtA0pXPXdvvJAuB8IWlbNMj04qOhu8dw2PF7xEThRkpP37FKIlL\nmpuUSSAxPIHsex44ybOXEM69xy1noykUaGQWlC1Ax1T0at+mB9RjyHaWyPppWmQ7\nVC4r8G5mImjltDHAds+IPZU/DKLXkEBDZctjh0Gja0HaNYUu1P+9Pl3ZdEo8Wb0D\n6I5yLbTBwPOGdiY7yGBRb5Ez6XFbZnDtHPMqAcDmk10kabR4gkZQypTlpURnyAag\n303vwuKUKeKb0wvmtEs3Yyb27bd+R7uVD0gOwTIqahapG92YtyzwLEzgaVkOtQpr\nAfPaJ8rqwQcCAwEAAaOCAuYwggLiMIGOBgNVHSMEgYYwgYOAFMjQjsdJrh8gQrJL\nfxPJd1gMoc3BoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwG\nA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQG\nA1UEAwwNS0lTQSBSb290Q0EgNIIBATAdBgNVHQ4EFgQUTV1WCgcD34PK89Vtjxn8\nEqyQooowDgYDVR0PAQH/BAQDAgEGMIIBMQYDVR0gAQH/BIIBJTCCASEwggEdBgRV\nHSAAMIIBEzAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3IvcmNh\nL2Nwcy5odG1sMIHeBggrBgEFBQcCAjCB0R6Bzsd0ACDHeMmdwRyylAAgrPXHeMd4\nyZ3BHMeFssiy5AAoAFQAaABpAHMAIABjAGUAcgB0AGkAZgBpAGMAYQB0AGUAIABp\nAHMAIABhAGMAYwByAGUAZABpAHQAZQBkACAAdQBuAGQAZQByACAARQBsAGUAYwB0\nAHIAbwBuAGkAYwAgAFMAaQBnAG4AYQB0AHUAcgBlACAAQQBjAHQAIABvAGYAIAB0\nAGgAZQAgAFIAZQBwAHUAYgBsAGkAYwAgAG8AZgAgAEsAbwByAGUAYQApMDQGA1Ud\nEQQtMCugKQYJKoMajJpECgEBoBwwGgwY7ZWc6rWt66y07Jet7KCV67O07Ya17Iug\nMBIGA1UdEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjwYDVR0fBIGH\nMIGEMIGBoH+gfYZ7bGRhcDovL2xkYXAudHJhZGVzaWduLm5ldDozODkvQ049S0lT\nQS1Sb290Q0EtNCxPVT1Lb3JlYS1DZXJ0aWZpY2F0aW9uLUF1dGhvcml0eS1DZW50\ncmFsLE89S0lTQSxDPUtSP2F1dGhvcml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3\nDQEBCwUAA4IBAQBUWGneikhd1rVgunY7pknvhBiK1wAvZODQRSJBxjY7M+xkmmZT\nKm0n0oDJ1K7PbTcwrmaMzKVcHnOantcBKhyNLfJivQ3+0NTi88OFIjPnFa/otfCE\nKxdNpet5+6huJjDD5FouxsIbeZU6v11vAfzefcHRwcpFhbwJ4PPE4uPcPOlkBvTf\nKzwMXjOca4i3+vvQ6OgcRg8ff27msKDmZNuTqba6sjzWPV6XFT7tVXJHWfQBcMkH\nksEnW/CXppqOsJM/+eMQzVp6xZ5ONtfpo6Godk/Vcr5P10kJyEmrWlh+0XcaVux5\n52PlLvF2Mdo9WydtCzc5GY3npzO9DrAUKMhu\n-----END CERTIFICATE-----\n";
var realTradeSign_2048_101F = "-----BEGIN CERTIFICATE-----\nMIIGFzCCBP+gAwIBAgICEB8wDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTYwMjI2\nMDIzNTA5WhcNMjYwMjI2MDIzNTA5WjBPMQswCQYDVQQGEwJLUjESMBAGA1UECgwJ\nVHJhZGVTaWduMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExFTATBgNVBAMMDFRyYWRl\nU2lnbkNBMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANYyWa44JAH1\njOqVF3u4O4khr1K9hfZ7rkqLF6/Efbbhdvbcg3Mr29mz7rWemMhOvdwm3Dh2qVYM\nqD1K3tVaVALA93KbWzi54cDRg5jbbcgQqsg96B2ZqdbxgTdGXhPpPd+A8jJfdBr4\n95UUNUdEoM9lNi2hkFeVWCzC5z36IwOH9/vZOSz/hUkeHjtOeo4V17Iy64zQDy4q\n07kAM2rFzdApX8CnjhJHyK3JF/gQfi+9JYGVqgwVt8Crubeb3DKw3avDnVf3JPKe\nivaRxwftJm3Yr3Skzx8gJmkPdxTjIVbJrVFh1anm8OCJYD6ZPv18HPoxZPvmkfhh\nRh1pumT08LECAwEAAaOCAuYwggLiMIGOBgNVHSMEgYYwgYOAFMjQjsdJrh8gQrJL\nfxPJd1gMoc3BoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwG\nA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQG\nA1UEAwwNS0lTQSBSb290Q0EgNIIBATAdBgNVHQ4EFgQUtQcjbFfPPq6OtTKBn5Gn\nINvo6+MwDgYDVR0PAQH/BAQDAgEGMIIBMQYDVR0gAQH/BIIBJTCCASEwggEdBgRV\nHSAAMIIBEzAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3IvcmNh\nL2Nwcy5odG1sMIHeBggrBgEFBQcCAjCB0R6Bzsd0ACDHeMmdwRyylAAgrPXHeMd4\nyZ3BHMeFssiy5AAoAFQAaABpAHMAIABjAGUAcgB0AGkAZgBpAGMAYQB0AGUAIABp\nAHMAIABhAGMAYwByAGUAZABpAHQAZQBkACAAdQBuAGQAZQByACAARQBsAGUAYwB0\nAHIAbwBuAGkAYwAgAFMAaQBnAG4AYQB0AHUAcgBlACAAQQBjAHQAIABvAGYAIAB0\nAGgAZQAgAFIAZQBwAHUAYgBsAGkAYwAgAG8AZgAgAEsAbwByAGUAYQApMDQGA1Ud\nEQQtMCugKQYJKoMajJpECgEBoBwwGgwY7ZWc6rWt66y07Jet7KCV67O07Ya17Iug\nMBIGA1UdEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjwYDVR0fBIGH\nMIGEMIGBoH+gfYZ7bGRhcDovL2xkYXAudHJhZGVzaWduLm5ldDozODkvQ049S0lT\nQS1Sb290Q0EtNCxPVT1Lb3JlYS1DZXJ0aWZpY2F0aW9uLUF1dGhvcml0eS1DZW50\ncmFsLE89S0lTQSxDPUtSP2F1dGhvcml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3\nDQEBCwUAA4IBAQCfvk0cqm1tyDuCC6Uqc5cFJ14aujinjeButBCiM1oa8A2GwCuK\nk6Mjr1m8V6mcx35ZTKUxpzJSQ+Dx2VzqLCskM5PShJuR1IG5lSobYXKsdjL4a+wy\n2fzQIafkEYg++y1Yte/g5VgXoSZPWL88EVt38NcRgGgRXf/cE/FBmwBpFcwkMe3o\n5AScjS5Lw8Af8ZH/YhOz6oIJzK1B7ph0b7PnNgYVKKdbID+MXMcXSOYg3R4uhrbk\nj1RUY4XxCE6phZN8llIoB//CwbDlZQZlf9K6gvTE+a/w4LofHpz/GbXWSBfiJB3o\ne9/Bx1Y4MA+6uR+KZiWUnDf2yW3W+V2bTEvn\n-----END CERTIFICATE-----\n"
var realSignGate_2048 = "-----BEGIN CERTIFICATE-----\nMIIGCzCCBPOgAwIBAgICEAowDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTAxMDAx\nMDgzODM1WhcNMjAxMDAxMDgzODM1WjBKMQswCQYDVQQGEwJLUjENMAsGA1UECgwE\nS0lDQTEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxzaWduR0FURSBD\nQTQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBxoTcxnyAwA63sK0F\ncEv9MhgDOVDvZjSdqJSE/Dc9azjjj/0l1FxXtAlgbr9BWgfATm3Avzqy6XQAKnbB\npa3arD8FcyJt9dfxMnJ109OXrqjATD9mDMsZZMPngR0YN+lvVmUd6zANX6a2oms9\njiUmHkkkuj41xXK0KNCr81tjwiFJK50Z2cr8MQIN44u/0S3Tn1QeecnWaRYBu0ve\nUU1t3mDziR3VU/oq8RJqIu7v2eyGwwIRYujpMYaRlF4ED8DfcPmrtcjJeLs+V7Ni\nh2tp+b3yuSkLz3sSHomK32qFAq/FPG40qY0NjjMb8h6KaopTU2sw54Of/imS4iJX\nebjvAgMBAAGjggLfMIIC2zCBjgYDVR0jBIGGMIGDgBTI0I7HSa4fIEKyS38TyXdY\nDKHNwaFopGYwZDELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsM\nJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxFjAUBgNVBAMM\nDUtJU0EgUm9vdENBIDSCAQEwHQYDVR0OBBYEFK5S/Q4OAfgwhjd+9hjGSSVKYAlw\nMA4GA1UdDwEB/wQEAwIBBjCCATEGA1UdIAEB/wSCASUwggEhMIIBHQYEVR0gADCC\nARMwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9yLmtyL3JjYS9jcHMu\naHRtbDCB3gYIKwYBBQUHAgIwgdEegc7HdAAgx3jJncEcspQAIKz1x3jHeMmdwRzH\nhbLIsuQAKABUAGgAaQBzACAAYwBlAHIAdABpAGYAaQBjAGEAdABlACAAaQBzACAA\nYQBjAGMAcgBlAGQAaQB0AGUAZAAgAHUAbgBkAGUAcgAgAEUAbABlAGMAdAByAG8A\nbgBpAGMAIABTAGkAZwBuAGEAdAB1AHIAZQAgAEEAYwB0ACAAbwBmACAAdABoAGUA\nIABSAGUAcAB1AGIAbABpAGMAIABvAGYAIABLAG8AcgBlAGEAKTAuBgNVHREEJzAl\noCMGCSqDGoyaRAoBAaAWMBQMEu2VnOq1reygleuztOyduOymnTASBgNVHRMBAf8E\nCDAGAQH/AgEAMA8GA1UdJAEB/wQFMAOAAQAwgY4GA1UdHwSBhjCBgzCBgKB+oHyG\nemxkYXA6Ly9sZGFwLnNpZ25nYXRlLmNvbTozODkvQ049S0lTQS1Sb290Q0EtNCxP\nVT1Lb3JlYS1DZXJ0aWZpY2F0aW9uLUF1dGhvcml0eS1DZW50cmFsLE89S0lTQSxD\nPUtSP2F1dGhvcml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3DQEBCwUAA4IBAQB4\n/X/Uo0juPbru2nideeodSHGaZMbsVwE95hoUurA3EXhiF2G/sI3avU965bks5OiG\nXQraUq9+eE87gLxDKTen63Rtg9gvJbP5mHXFxcR9BlII+cgr30wA6H4l85flZFzc\nz+OahncFFrPFo9Rf3RfBGDHGqaa25z0oJWrTCQpjtLHS6QHxXgwTBrxVtq3W34JC\nbXtTRj7mZ/t31cBc4eVL2ft7u7p4lZp6XMfkHHUgLe8ZdSgQVfTVdiYbhfabiYAQ\n828W2jdpQ7iOumcvho/F5RcgVhsSlZKpwSEnP9I4kKIc4rictwRRl7QAMWIgL0Ls\nPebzsP4PpTl+94wuhJ/L\n-----END CERTIFICATE-----\n";
var realSignGate_2048_101D = "-----BEGIN CERTIFICATE-----\nMIIGCzCCBPOgAwIBAgICEB0wDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTUxMjI5\nMDc0NjI1WhcNMjUxMjI5MDc0NjI1WjBKMQswCQYDVQQGEwJLUjENMAsGA1UECgwE\nS0lDQTEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxzaWduR0FURSBD\nQTUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCpiTEmAeOssny+ettR\nSdHJWXBkRgE+nUOe19z0HUuy1L6G7iUVyMhc7GSqJFkZtcDWqLx3cKkBe5Vd7Xxb\n8fr52tXI+sQBnOQkb+tpfj6RNisbJAkTAGukOTkaiTuhL0s+AhdCNdkknF4i7aa5\n3/NFD1XeOYVjnNwx2yz0gCY7jBb79UE6wB5h9qFyuHleiJCdlkNAeJIhe0cPWuak\ngj5kB1hpb7nW3lpiiSSDA99cG5x2oSlNzMfxX382CjsgvQclUp/Wz7kNl46fgrER\nTOsHN2N5A7nqxx8ipAfYyyy+lCnv9YE7xg13+5uzN0oRJCU1A7obMGRx5WwYeKMx\nXfTbAgMBAAGjggLfMIIC2zCBjgYDVR0jBIGGMIGDgBTI0I7HSa4fIEKyS38TyXdY\nDKHNwaFopGYwZDELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsM\nJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxFjAUBgNVBAMM\nDUtJU0EgUm9vdENBIDSCAQEwHQYDVR0OBBYEFNi+OuxFmcWe45zqgR/SHRKwNj6I\nMA4GA1UdDwEB/wQEAwIBBjCCATEGA1UdIAEB/wSCASUwggEhMIIBHQYEVR0gADCC\nARMwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9yLmtyL3JjYS9jcHMu\naHRtbDCB3gYIKwYBBQUHAgIwgdEegc7HdAAgx3jJncEcspQAIKz1x3jHeMmdwRzH\nhbLIsuQAKABUAGgAaQBzACAAYwBlAHIAdABpAGYAaQBjAGEAdABlACAAaQBzACAA\nYQBjAGMAcgBlAGQAaQB0AGUAZAAgAHUAbgBkAGUAcgAgAEUAbABlAGMAdAByAG8A\nbgBpAGMAIABTAGkAZwBuAGEAdAB1AHIAZQAgAEEAYwB0ACAAbwBmACAAdABoAGUA\nIABSAGUAcAB1AGIAbABpAGMAIABvAGYAIABLAG8AcgBlAGEAKTAuBgNVHREEJzAl\noCMGCSqDGoyaRAoBAaAWMBQMEu2VnOq1reygleuztOyduOymnTASBgNVHRMBAf8E\nCDAGAQH/AgEAMA8GA1UdJAEB/wQFMAOAAQAwgY4GA1UdHwSBhjCBgzCBgKB+oHyG\nemxkYXA6Ly9sZGFwLnNpZ25nYXRlLmNvbTozODkvQ049S0lTQS1Sb290Q0EtNCxP\nVT1Lb3JlYS1DZXJ0aWZpY2F0aW9uLUF1dGhvcml0eS1DZW50cmFsLE89S0lTQSxD\nPUtSP2F1dGhvcml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3DQEBCwUAA4IBAQAj\nR/p1dqrwXm2xAwNUHukCvVKRrkIo0ReXWUXBawmFM7JDVYdiOWho87z427OCToFJ\njDxqw/iLQHMtIjfqpET2hRNIIFRsFKAnJEAhdboEf/zQ/++sAQBv/YRQLL0rxBVn\nq6ZGzCRsgAzLqc8d4wIC9bEQkPMNG5rFE3T36If82BZ7fDYVenvihwoEi/3khfT1\nnX46YnmHMybEx+5bnFsxnQdNiDV3DHuVKLR8DqsXJwMVLWOJcD+7UqRaTYx/dJsT\ng/RUKiIjlSlA6lnsfp+mGhQ5iW+jA96I8dGjlXLhtbFpQyyQ0VxoXRm7eb+MibHY\n761l+/Sg/GsciJBATsBK\n-----END CERTIFICATE-----\n"
var realGpki_01 = "-----BEGIN CERTIFICATE-----MIIDXTCCAkWgAwIBAgIBATANBgkqhkiG9w0BAQsFADBQMQswCQYDVQQGEwJLUjEcMBoGA1UECgwTR292ZXJubWVudCBvZiBLb3JlYTENMAsGA1UECwwER1BLSTEUMBIGA1UEAwwLR1BLSVJvb3RDQTEwHhcNMTEwODAzMDY1MjMwWhcNMzEwODAzMDY1MjMwWjBQMQswCQYDVQQGEwJLUjEcMBoGA1UECgwTR292ZXJubWVudCBvZiBLb3JlYTENMAsGA1UECwwER1BLSTEUMBIGA1UEAwwLR1BLSVJvb3RDQTEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCh/m8EBbDJhGQyN2+g5dTlsgjtaRKqhgj3gkYKBgtuXsXkaTVxbf99AvbN3QE8+WCIaPJUd0091UGmLzaBVyW4ct+iUNrX/FXyzjafbNbbl1nfHhaZhkiOTVQhmY5zuj96evEtJMevnxe6iRADOPWnqp+CxT2IzcSFkQCq7L2qn8hU2/LpXUvnAYglJZi8t6Ef+r03P1r8dA5OzZ8yV3qhD1R1wsNQtCzMgwcErFRZhFZYuxpfmS5y0fZW0seeTjcdxHiR3whYI5U6AI7DjdWIrT9Cd9ByV4aevkBhqkePPIYGmUPXnnqCkdHdnzkMH0WP9TBhD2jTXZKdcFtTyEJrAgMBAAGjQjBAMB0GA1UdDgQWBBR4A+sMjKbTVXWkh7Tr0ZpmD0xzizAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEARGJWATwo81x7UEQugNbicL8IWXoV51SZVH3kz49fNUjVoq1n2yzfaMddlblbflDNObp/68DxTlSXCeqFHkgi/WvyVHERRECXnF0WeeelI+Q8XdF3IJZLT3u5Ss0VAB2loCuC+4hBWSRQu2WZu2Yks9eBN0x6NmtopRmnf2d6VrcFA+WOgUeTjXiDkG52IaPw0w1uTfmRw5epky5idyY2bfJ1JeVUINMJnOWpgLkOH3xxakoD8F1Fbi6C3t7MmKupojUq/toUDms6zTk3DIkcwd7PALNWL5U8TxNLoroTHSf/lzaOv3o9KDRa0FQo58bPI7MdbRWE4F3mS/ZIrnv7jQ==-----END CERTIFICATE-----";
var realGpki_2712 = "-----BEGIN CERTIFICATE-----MIIEqzCCA5OgAwIBAgICJxIwDQYJKoZIhvcNAQELBQAwUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0dQS0lSb290Q0ExMB4XDTExMDkyMjA2MTIyM1oXDTIxMDkyMjA2MTIyM1owUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0NBMTMxMTAwMDAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApy8GHE24r1yEjXhwfmgihCFTLHK41iubcbmZnYUfmWZTud2jR6DKCcKWACYuam0PF4eB5GZmbTVMJgwPva8tII8/31tufGj6YV9yrTVmBt++ZRDE8LjHXW1fMPULIH4HMt2/W9C7da9gOtZwnOvh2xEY3Ewnru4AOMGOX1am3BZR7Xs4LYL/zG6Zk0MEJJDX718eFx7tOtm4Iyu4iMIMhmg9MybPnZi1hVCK/akuWgDFsyn/QKg0X1vP8mShqYE3EnJRahfo3EQHPmokpKvL2UQu+OvuoLTopC3RAxVf3wQ37WALz8ssXFlM6lNxJc4F8rKBM0Eh6J4pQ1H6MJFUYQIDAQABo4IBjTCCAYkweAYDVR0jBHEwb4AUeAPrDIym01V1pIe069GaZg9Mc4uhVKRSMFAxCzAJBgNVBAYTAktSMRwwGgYDVQQKDBNHb3Zlcm5tZW50IG9mIEtvcmVhMQ0wCwYDVQQLDARHUEtJMRQwEgYDVQQDDAtHUEtJUm9vdENBMYIBATAdBgNVHQ4EFgQUkqR4F7GqLxnYKz+5sysjFYPVlzUwDgYDVR0PAQH/BAQDAgEGMD0GA1UdIAQ2MDQwCwYJKoMaho0hAgEBMAsGCSqDGoaNIQIBAjALBgkqgxqGjSECAQMwCwYJKoMaho0hAgIBMBIGA1UdEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADB6BgNVHR8EczBxMG+gbaBrhmlsZGFwOi8vY2VuLmRpci5nby5rcjozODkvY249R1BLSVJvb3RDQTEsb3U9R1BLSSxvPUdvdmVybm1lbnQgb2YgS29yZWEsYz1LUj9hdXRob3JpdHlSZXZvY2F0aW9ubGlzdDtiaW5hcnkwDQYJKoZIhvcNAQELBQADggEBADEKRRmEVnZUKILMN1IOEbfWzTGIjqAVA2ssg4bceC7kr5EWE9G9wWu/jj2NqrvOmBag4BTr9MJASueciSwv4anifnZEYAWAP6b3Zk2a+zKlJ7IUFbi9dqImnhleRlWDBulC7dPkX1C+yETHC8kSvl60a41F46RH6cMICYiaKaAM4KzikexGGONc7Y68h5sb91v8aD/xUiSz71+Rjzp/Ni5hHuBnCIEjhqpWX/KD0bT590yj86CdKjEXdQFDcv5/2+gLuYDK0hbpvCuYh7wvosYBZgd89KnQjAOjDG3mMRNg+cWQV7Akbdz3xZ4ds3kCziMlcKSNVE258yihskUB2YA=-----END CERTIFICATE-----";
var realGpki_2713 = "-----BEGIN CERTIFICATE-----MIIEqzCCA5OgAwIBAgICJxMwDQYJKoZIhvcNAQELBQAwUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0dQS0lSb290Q0ExMB4XDTExMDkyMjA2MTMwMVoXDTIxMDkyMjA2MTMwMVowUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0NBMTMxMTAwMDAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvdwwMCeSeVK054GsNdSbc8M/QI818dlpgt05CL6GYjXLoHmXwbcs2utcEhxS3wBcxZjb5LrBnaYa3yjxh7m7bSE5d/xpKXzeitncOQ8WyOrRL+vb6Ux+UswsRIYSjlzZYQ8fkN99cLAwvXtjUjUbq5MkYrA/l6YXPl5e1d4PusCh9mk63sutRElmmW9FS/aIIhMeCjakclTWx8JTyqMBXq7l3mgNS9xBBAbS6tYb9z9OSuR6EQ6ksezA1V2AN8FlJsOUlQpn0J11ySQNp25vPxUDVH1FDjFprDVVpktsXf4Y/EwiBYBXBmQyIoNNfzwULtArflc0aoDwGsT3K249jwIDAQABo4IBjTCCAYkweAYDVR0jBHEwb4AUeAPrDIym01V1pIe069GaZg9Mc4uhVKRSMFAxCzAJBgNVBAYTAktSMRwwGgYDVQQKDBNHb3Zlcm5tZW50IG9mIEtvcmVhMQ0wCwYDVQQLDARHUEtJMRQwEgYDVQQDDAtHUEtJUm9vdENBMYIBATAdBgNVHQ4EFgQUomhh79OwGVyhIPU6NEqTWHl2UNEwDgYDVR0PAQH/BAQDAgEGMD0GA1UdIAQ2MDQwCwYJKoMaho0hAgEEMAsGCSqDGoaNIQIBBTALBgkqgxqGjSECAQYwCwYJKoMaho0hAgICMBIGA1UdEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADB6BgNVHR8EczBxMG+gbaBrhmlsZGFwOi8vY2VuLmRpci5nby5rcjozODkvY249R1BLSVJvb3RDQTEsb3U9R1BLSSxvPUdvdmVybm1lbnQgb2YgS29yZWEsYz1LUj9hdXRob3JpdHlSZXZvY2F0aW9ubGlzdDtiaW5hcnkwDQYJKoZIhvcNAQELBQADggEBAAQEyZgHqqOqOnz70yUoe0ip3Cd1vWIJeee8eV/yF7jcfP+nbVKoTAa8LXRBxojSLeUJcQe9qlNAN0dg/7w/QJ3sJGvD2RKrlLjPZbOE/7zjw7OyF6wO+b6a2b2h5/X7Y76xl6F6ZTqJ2tZTfdPIEwiiLe0JXvF+mMgkzYBwHQmf7zfXGg17L2/Kf1sJlWtiXA2uL0mmZlX9mF2TVxExeT0/dNxIaTR3JIAo51m9bVr2pyQqx6C7ue797UBMtiClQJf28lqQQLigZCHlNNtw/QxieKdUjs7ESyN012VzXauWp5h08go6DDdOdOTotuAqFO70D0W3jp0GLLF2wjebhIQ=-----END CERTIFICATE-----";
var realGpki_2714 = "-----BEGIN CERTIFICATE-----MIIEnjCCA4agAwIBAgICJxQwDQYJKoZIhvcNAQELBQAwUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0dQS0lSb290Q0ExMB4XDTExMTExMDAyMjAxNloXDTIxMDkyMjA2MTE1MlowUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0NBMTMwMDAwMDMxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDhNkjMoJxTniAhU7AxU+sr7cQyTnfr1GlCLaQbxKJ5R5xUf2wvZhPB/nzLZj/Os3y6M4cShPs4RFxWnUr7o3KPfWQm7iT5VjvzVlg7hcIH4RD0mRFjOWTnZAoAIl5Hfwq4rFPSltMJVaWdylGCC+Oe4tpa/nbCSblCQACbwmEBJuea6T16/XxTe9SBtgTy5ER/W0AVuJOBkMI2MBPRxVpdHc+PRPYbUYZs8sPEjP/Adc4nh4D6UnNFqZmCVzYRow9DPks9YfgWX/c6Ukb4mVadRke5j2gF5yUAtSlh8OMLM9/Xl2FFEArV/Z6f5TrhAowN0km2yexTpqugfLWBdswIDAQABo4IBgDCCAXwweAYDVR0jBHEwb4AUeAPrDIym01V1pIe069GaZg9Mc4uhVKRSMFAxCzAJBgNVBAYTAktSMRwwGgYDVQQKDBNHb3Zlcm5tZW50IG9mIEtvcmVhMQ0wCwYDVQQLDARHUEtJMRQwEgYDVQQDDAtHUEtJUm9vdENBMYIBATAdBgNVHQ4EFgQUnP+dEz1QSVfZJ1ogxUna8I9IPDowDgYDVR0PAQH/BAQDAgEGMDAGA1UdIAQpMCcwCwYJKoMaho0hAgEBMAsGCSqDGoaNIQIBAjALBgkqgxqGjSECAgEwEgYDVR0TAQH/BAgwBgEB/wIBADAPBgNVHSQBAf8EBTADgAEAMHoGA1UdHwRzMHEwb6BtoGuGaWxkYXA6Ly9jZW4uZGlyLmdvLmtyOjM4OS9jbj1HUEtJUm9vdENBMSxvdT1HUEtJLG89R292ZXJubWVudCBvZiBLb3JlYSxjPUtSP2F1dGhvcml0eVJldm9jYXRpb25saXN0O2JpbmFyeTANBgkqhkiG9w0BAQsFAAOCAQEAXxCjSKs14Bwwh+px2am23rMcEhgIORfZ9gTbuZkwkMtUg2V7isAUfMy4zAOzFVcCLbjY9hW/jCtm7deK4ge5o+t16TXec+Io8QSVBT1zJYTpxwoo4BI9msuO4PY1LlAGtngaOmUVVnLRxI5ZpNZ9T+KEnYm7kPmsT80PRzkebNB2qffPrw4FpJDFh+5sYP0y5irtkiaki+UP54RLZ5/qLbCFLiEkP2THl6dNGMt3P6ySJgfOR0+2Oy8UpubHtIWB+mcxsTaaLNKu8bg5Jc+d9FetxOAmeG/dwPk/YeD9r7SiEgQxjm8mSho1BLL0IS5YlPHdpDc/OeFeV54NWmm4Dg==-----END CERTIFICATE-----";
var realGpki_2715 = "-----BEGIN CERTIFICATE-----MIIEkTCCA3mgAwIBAgICJxUwDQYJKoZIhvcNAQELBQAwUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0dQS0lSb290Q0ExMB4XDTExMTEyNTEwNTI0M1oXDTIxMTEyNTEwNTI0M1owUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0NBMTI4MDAwMDMxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0InW9w+mz/C36DCEGi3ST19VWzfudz5b3KPYKSeSs+LnQqghfn7ytbCW/kBs5LYPM0ZHjj5nPXbWosypr48jv5hkufD1Eskihp9+8DT1qWWi+WMXUMCgJgDkWSNWFfzHos8jefCIGw7IxvdjEAM2XHofzHT1M34iGGG/VHyBW6NPYZjlh3X9IY2UjlOuDgUOBIDhwDQM+9JF8KcBHBW3Dx8/vjVZkimVNUN479RCoLwoTZctqPuYRQ7RkG3VqkWeZ6f2H1gXH2jrIEhzghoG9SPsq2Y09FsEbgWNy4SZra+V488kF1lYMZvg2x6NYz+ybXIL/kuxTj8mkXb9oRhSTwIDAQABo4IBczCCAW8weAYDVR0jBHEwb4AUeAPrDIym01V1pIe069GaZg9Mc4uhVKRSMFAxCzAJBgNVBAYTAktSMRwwGgYDVQQKDBNHb3Zlcm5tZW50IG9mIEtvcmVhMQ0wCwYDVQQLDARHUEtJMRQwEgYDVQQDDAtHUEtJUm9vdENBMYIBATAdBgNVHQ4EFgQUbq+9tajlyPjBwBCldEW/zQdewH0wDgYDVR0PAQH/BAQDAgEGMCMGA1UdIAQcMBowCwYJKoMaho0hAgEBMAsGCSqDGoaNIQIBAjASBgNVHRMBAf8ECDAGAQH/AgEAMA8GA1UdJAEB/wQFMAOAAQAwegYDVR0fBHMwcTBvoG2ga4ZpbGRhcDovL2Nlbi5kaXIuZ28ua3I6Mzg5L2NuPUdQS0lSb290Q0ExLG91PUdQS0ksbz1Hb3Zlcm5tZW50IG9mIEtvcmVhLGM9S1I/YXV0aG9yaXR5UmV2b2NhdGlvbmxpc3Q7YmluYXJ5MA0GCSqGSIb3DQEBCwUAA4IBAQBLUp5t/j8Mje/MeK4NoaPFdiSj+ThcXFD11ibireLENUj1TClQelJk0K+JOoizSt/JZkuhqzMDL7rF/YDl3ucimkukCLAY+jelKYEFpB3COLvqqTUqU1Jl+1Pp6QamfGAymCyQ4GJWhjiVcdjm5wXOgzvuYc7o1ki+bJ/BXOalhutFtQOww2BFRHRaBer7vng6URrJOHc2JWhq890nqSey+18dv1G+YgRen8H3inNS889r5yjECxdh/GmWg/DEs0j4AIaGzxun81Yi3jr13g32Iue4foA4ogwRm3aYVyUT5C1RFa/YVsxQJWoaRv9UXf1pUR1YxW5SJzi64Bwfg8PJ-----END CERTIFICATE-----";
var realGpki_2716 = "-----BEGIN CERTIFICATE-----MIIEhDCCA2ygAwIBAgICJxYwDQYJKoZIhvcNAQELBQAwUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0dQS0lSb290Q0ExMB4XDTExMTEyNTEwNTM0MFoXDTIxMTEyNTEwNTM0MFowUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0NBMTI4MDAwMDMyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0QKDmp1OUEfoiIgEsieM4VpToBrYmxCUjUmVfHG0UhQutAl4RfC/FJ3abTmfPxqhRbtAR1t3o4iuD/XDMtBQhcNAH3O7o85tyBFEtF4r0krYbDrDuv0reWNGSPd+jTupIay9q4rZrq4n7RnnONKpTwdGYjJYtut1S2zZxrZW59x+4Ax9wzvHqFtjbEwpvjKZxPza642m27XxOoeMqt/1deBZAWlA5KiaMogQLsPOq2SykKF48Zp9dWOw50dhwTJJHfDJpCLUa2+ZQWyv+nbrOfkEu7Yda9qF9WbBnganHVr0n+/X3pkMvuN/mms5+s2/SpLgODqMjm5Fu4s3SW4QnQIDAQABo4IBZjCCAWIweAYDVR0jBHEwb4AUeAPrDIym01V1pIe069GaZg9Mc4uhVKRSMFAxCzAJBgNVBAYTAktSMRwwGgYDVQQKDBNHb3Zlcm5tZW50IG9mIEtvcmVhMQ0wCwYDVQQLDARHUEtJMRQwEgYDVQQDDAtHUEtJUm9vdENBMYIBATAdBgNVHQ4EFgQUQdrI2MgbUIjaYldgZsLkKLL4p+QwDgYDVR0PAQH/BAQDAgEGMBYGA1UdIAQPMA0wCwYJKoMaho0hAgIBMBIGA1UdEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADB6BgNVHR8EczBxMG+gbaBrhmlsZGFwOi8vY2VuLmRpci5nby5rcjozODkvY249R1BLSVJvb3RDQTEsb3U9R1BLSSxvPUdvdmVybm1lbnQgb2YgS29yZWEsYz1LUj9hdXRob3JpdHlSZXZvY2F0aW9ubGlzdDtiaW5hcnkwDQYJKoZIhvcNAQELBQADggEBAF8A8TSpYGP1l0fJtVNf6DL0IiXRJvyl94R36KvBdxHcl5pCQ5o3FSbiBajASx7M8XquNC4yE73lnCpxaRFgzCDsAocvxrusgnICxSjKSx8uJylzckz7B+aCeqqzKiU3E1rJheCNtbWOER4mz2zBOvL9CbKKcPHOXkzm51G2Bcrb3XLv6FFU3OqWsQFZLAdZ7FnnfZFaH+pabbvT/cK22LsTn8/geFUAN01FAPM0E2n1YyMLqpsRI9mtWK9zQVYTV4W5PVHVeEReYQeLjQgWLXxdHLipCumVFvQUva5iGF/9zABgTReGqskOOloA/7pshpRVBzEcn2Xi8ptQnHXpcsU=-----END CERTIFICATE-----";
var realGpki_2717 = "-----BEGIN CERTIFICATE-----MIIEojCCA4qgAwIBAgICJxcwDQYJKoZIhvcNAQELBQAwUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0dQS0lSb290Q0ExMB4XDTExMTIxMjAxNDQyMFoXDTIxMTIxMjAxNDQyMFowUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0NBOTc0MDAwMDMxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhqe/Jr8tJqVr0U3nukn0RwOVg0b+3pMW1Wo18eybhxx0I56tZCaAejvm1YwLUTv9z4dBZBBhyPLxQv1n491EpB+fKiCpQBTNAcCRjOB385K41+FxRSY6hbTyygQM1wOrNXp426E0x91IzAafJ0Hig/dwiHVwKE5249g739MLpOh8mMvWkThKrJXlYD6TuYmhWOpTbzEN/C7qmuXqPUE25nD3QzVvXn3RoZr3tnl/UMYQSK6R9eOtCFaJ9OFUuRT4+vyu6vrGE0GPzZHCwlNZfINv4Z2IdE02saqNoUqF3JiEY+Xjk151W0yYN6mDL8i+j/ugWSnGBLzNP2QeQIArqwIDAQABo4IBhDCCAYAweAYDVR0jBHEwb4AUeAPrDIym01V1pIe069GaZg9Mc4uhVKRSMFAxCzAJBgNVBAYTAktSMRwwGgYDVQQKDBNHb3Zlcm5tZW50IG9mIEtvcmVhMQ0wCwYDVQQLDARHUEtJMRQwEgYDVQQDDAtHUEtJUm9vdENBMYIBATAdBgNVHQ4EFgQU+84yZI6rxMJKx+z6KJjMW6rMpsEwDgYDVR0PAQH/BAQDAgEGMDAGA1UdIAQpMCcwCwYJKoMaho0hAgEBMAsGCSqDGoaNIQIBAjALBgkqgxqGjSECAgEwEgYDVR0TAQH/BAgwBgEB/wIBADAPBgNVHSQBAf8EBTADgAEAMH4GA1UdHwR3MHUwc6BxoG+GbWxkYXA6Ly9sZGFwLnNjb3VydC5nby5rcjozODkvY249R1BLSVJvb3RDQTEsb3U9R1BLSSxvPUdvdmVybm1lbnQgb2YgS29yZWEsYz1LUj9hdXRob3JpdHlSZXZvY2F0aW9ubGlzdDtiaW5hcnkwDQYJKoZIhvcNAQELBQADggEBAARyV/Mh4OZLvfFFPd5fHBRx78A9vawTDmwv5T0vgTO7oDqdvfiVTQCyDvIUdxvg8HxC3lCS8UNgo2IMvm8d6aj1a8eh0bLGqqW2v0eAmq8IS+Q3VQ1Jc02KckIaITQWfD+XSAydkZsPQBbOKcixs0st2Z4stS421yYE/TrlVddHbRRUxZYqF/fZZGjs3nvPAikL/gGZJq5/WafoXOpp6fghnUs2eYFXTl8bf8aiKtPOD8UrklGest5KOT9Y5Ca7C1TxgZfSw4axhikkRad0Fi2I3iVSjRALNbb9m1/Xb6PuzXODxH/ckZvRskLbIC+WhgFZw03qVmQCw6hslvLGKkA=-----END CERTIFICATE-----";
var realGpki_2719 = "-----BEGIN CERTIFICATE-----MIIEvTCCA6WgAwIBAgICJxkwDQYJKoZIhvcNAQELBQAwUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0dQS0lSb290Q0ExMB4XDTExMTIxNTA2MDAxM1oXDTIxMTIxNTA2MDAxM1owUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0NBMTM0MTAwMDMxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwxGkCUA8iQHQdsTjMpV7zYjb3sBAvF/QK7OhhCfMGcUZVfh4z1A7X94Lxfu6CeyFn2KF2wy+AsCUs1xG+AqXB/y/zB9QPp1lZAEJotSyKbhQcJUNG+YwsdeEV8PIy2TvKmGjT6J+8G/RtRVA2I/lpOYcuFxS7ipu8kx78FHS9NyXiYGWPKxjemWsVgYrfwjkcIt1mAt30nZEvcO9LuFSlldtGSEir6lZjLv9Igb/K2ayHmmnSB5i7y2DOzYKF6o1GnNFc0fdK5VCuoyX4puQeDcSv3rVR6kwIL9c5HuC1czrD86cVY9kqe5qQUPeuvNd0gfG75mDv26yAMbmSx+LeQIDAQABo4IBnzCCAZsweAYDVR0jBHEwb4AUeAPrDIym01V1pIe069GaZg9Mc4uhVKRSMFAxCzAJBgNVBAYTAktSMRwwGgYDVQQKDBNHb3Zlcm5tZW50IG9mIEtvcmVhMQ0wCwYDVQQLDARHUEtJMRQwEgYDVQQDDAtHUEtJUm9vdENBMYIBATAdBgNVHQ4EFgQUjkb4DZ54dqLMGuQPUX9S102cWxswDgYDVR0PAQH/BAQDAgEGME8GA1UdIARIMEYwDAYKKoMaho0hBQMBAzAMBgoqgxqGjSEFAwEBMAwGCiqDGoaNIQUDAQcwDAYKKoMaho0hBQMBCTAMBgoqgxqGjSEFAwEFMBIGA1UdEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADB6BgNVHR8EczBxMG+gbaBrhmlsZGFwOi8vY2VuLmRpci5nby5rcjozODkvY249R1BLSVJvb3RDQTEsb3U9R1BLSSxvPUdvdmVybm1lbnQgb2YgS29yZWEsYz1LUj9hdXRob3JpdHlSZXZvY2F0aW9ubGlzdDtiaW5hcnkwDQYJKoZIhvcNAQELBQADggEBAH22zMoINn+lmZeGtxjvbSIzT8xvKH8VNw0KifIjqBbRS48duCctrCS5YGXkksNcDyAofKc1I0YyteeFJQtVGYXB05NN10i/IwklDdOSCfsWGBprYoFG/dBaEt4cSh/cgTQYxQWYmPhxYPUDF24yIVJSUvt1heZnSBP8vHayUa5Cvyyh8NibORHyGRZ0183cJrpqjDgw80Y/YgD7CMxw6P/rRw9vx1c0pbhhp68uc1jrYvKNxlfJrt/aGCm/sSxAPnbTUOtgBG22ghWnzamTtQingsgJiKF7GCDXeTRkt2GQgkHarm7vbZykMHmq8w1dYdrwkPFb8E5ejajxn30Uyyo=-----END CERTIFICATE-----";

var realSignKorea_CA3 = "-----BEGIN CERTIFICATE-----\nMIIGDTCCBPWgAwIBAgICECAwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTYwNTEz\nMDIzMzM1WhcNMjYwNTEzMDIzMzM1WjBQMQswCQYDVQQGEwJLUjESMBAGA1UECgwJ\nU2lnbktvcmVhMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExFjAUBgNVBAMMDVNpZ25L\nb3JlYSBDQTMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC8NWUKGJNd\nVCNqvd/QcILyO4isIUPttcnuEGBTgNYb1q66ChssV2rMZrazyT96PZwmMwusp7Np\n+TsmmifDJtRrzS3K2MiPEK7xubND8nlQqL3OC61QglqdPO5JYe75e7aHJGe/ijGz\nlnrTxEx2OpC27gZCHuheei8Hn2eN6HPA7YmmazSe5VEOS8f1jSFQFGKQFaO+28OO\ng4gzuSwE8uZ3UbeV1iWhvPybs52x3PV8/vqHGUKLBAIz8xKvEFsWHhxeh1VcbvDZ\nHVDVi1A0fNry2OMgW7QiCIhfo3i/EHKtUp4SL8NDJ8dfjseqSwNMCKxHXK9Edoq2\npo5v/d0VNDz1AgMBAAGjggLbMIIC1zCBjgYDVR0jBIGGMIGDgBTI0I7HSa4fIEKy\nS38TyXdYDKHNwaFopGYwZDELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAs\nBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxFjAU\nBgNVBAMMDUtJU0EgUm9vdENBIDSCAQEwHQYDVR0OBBYEFARURbDeEsQnnKBPAmmL\n1VsUFGMHMA4GA1UdDwEB/wQEAwIBBjCCATEGA1UdIAEB/wSCASUwggEhMIIBHQYE\nVR0gADCCARMwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9yLmtyL3Jj\nYS9jcHMuaHRtbDCB3gYIKwYBBQUHAgIwgdEegc7HdAAgx3jJncEcspQAIKz1x3jH\neMmdwRzHhbLIsuQAKABUAGgAaQBzACAAYwBlAHIAdABpAGYAaQBjAGEAdABlACAA\naQBzACAAYQBjAGMAcgBlAGQAaQB0AGUAZAAgAHUAbgBkAGUAcgAgAEUAbABlAGMA\ndAByAG8AbgBpAGMAIABTAGkAZwBuAGEAdAB1AHIAZQAgAEEAYwB0ACAAbwBmACAA\ndABoAGUAIABSAGUAcAB1AGIAbABpAGMAIABvAGYAIABLAG8AcgBlAGEAKTAqBgNV\nHREEIzAhoB8GCSqDGoyaRAoBAaASMBAMDijso7wp7L2U7Iqk7L2kMBIGA1UdEwEB\n/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjgYDVR0fBIGGMIGDMIGAoH6g\nfIZ6bGRhcDovL2Rpci5zaWdua29yZWEuY29tOjM4OS9DTj1LSVNBLVJvb3RDQS00\nLE9VPUtvcmVhLUNlcnRpZmljYXRpb24tQXV0aG9yaXR5LUNlbnRyYWwsTz1LSVNB\nLEM9S1I/YXV0aG9yaXR5UmV2b2NhdGlvbkxpc3QwDQYJKoZIhvcNAQELBQADggEB\nAEi2H54k3tOF/fXAI0W20SiSOfizAX+t5qvJrV9ob1xDWeaTnLjSpu/IGNwcjWS7\nwseFyo2T95cEGMcmzMlIp/t0HopziXv4WC0mulAdk0yvynBQY9HcO5DzXWp83lYe\nU+CMB3UkBBaOAWU/aXQNxZUwnsn2wYoWq3OE4I6hHB33jSJZTYXTcHt4wkTa+BGO\nCu4cQOa6mtMiG12Zo+J3+360z4laRSmM/nQdVMYFLvdEJ8/3ki1MhEr3efhNE/8X\nwhtboEi7qXUH8MrViR6uUnKcMMySI+26N+Aim/itOqYCvhFmDY7619ttPk6ktefB\niIHMsKEv168n68Bm7l/GGRE=\n-----END CERTIFICATE-----\n";
var realSignGate_CA5 = "-----BEGIN CERTIFICATE-----\nMIIGCzCCBPOgAwIBAgICEB0wDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTUxMjI5\nMDc0NjI1WhcNMjUxMjI5MDc0NjI1WjBKMQswCQYDVQQGEwJLUjENMAsGA1UECgwE\nS0lDQTEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQDDAxzaWduR0FURSBD\nQTUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCpiTEmAeOssny+ettR\nSdHJWXBkRgE+nUOe19z0HUuy1L6G7iUVyMhc7GSqJFkZtcDWqLx3cKkBe5Vd7Xxb\n8fr52tXI+sQBnOQkb+tpfj6RNisbJAkTAGukOTkaiTuhL0s+AhdCNdkknF4i7aa5\n3/NFD1XeOYVjnNwx2yz0gCY7jBb79UE6wB5h9qFyuHleiJCdlkNAeJIhe0cPWuak\ngj5kB1hpb7nW3lpiiSSDA99cG5x2oSlNzMfxX382CjsgvQclUp/Wz7kNl46fgrER\nTOsHN2N5A7nqxx8ipAfYyyy+lCnv9YE7xg13+5uzN0oRJCU1A7obMGRx5WwYeKMx\nXfTbAgMBAAGjggLfMIIC2zCBjgYDVR0jBIGGMIGDgBTI0I7HSa4fIEKyS38TyXdY\nDKHNwaFopGYwZDELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsM\nJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxFjAUBgNVBAMM\nDUtJU0EgUm9vdENBIDSCAQEwHQYDVR0OBBYEFNi+OuxFmcWe45zqgR/SHRKwNj6I\nMA4GA1UdDwEB/wQEAwIBBjCCATEGA1UdIAEB/wSCASUwggEhMIIBHQYEVR0gADCC\nARMwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9yLmtyL3JjYS9jcHMu\naHRtbDCB3gYIKwYBBQUHAgIwgdEegc7HdAAgx3jJncEcspQAIKz1x3jHeMmdwRzH\nhbLIsuQAKABUAGgAaQBzACAAYwBlAHIAdABpAGYAaQBjAGEAdABlACAAaQBzACAA\nYQBjAGMAcgBlAGQAaQB0AGUAZAAgAHUAbgBkAGUAcgAgAEUAbABlAGMAdAByAG8A\nbgBpAGMAIABTAGkAZwBuAGEAdAB1AHIAZQAgAEEAYwB0ACAAbwBmACAAdABoAGUA\nIABSAGUAcAB1AGIAbABpAGMAIABvAGYAIABLAG8AcgBlAGEAKTAuBgNVHREEJzAl\noCMGCSqDGoyaRAoBAaAWMBQMEu2VnOq1reygleuztOyduOymnTASBgNVHRMBAf8E\nCDAGAQH/AgEAMA8GA1UdJAEB/wQFMAOAAQAwgY4GA1UdHwSBhjCBgzCBgKB+oHyG\nemxkYXA6Ly9sZGFwLnNpZ25nYXRlLmNvbTozODkvQ049S0lTQS1Sb290Q0EtNCxP\nVT1Lb3JlYS1DZXJ0aWZpY2F0aW9uLUF1dGhvcml0eS1DZW50cmFsLE89S0lTQSxD\nPUtSP2F1dGhvcml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3DQEBCwUAA4IBAQAj\nR/p1dqrwXm2xAwNUHukCvVKRrkIo0ReXWUXBawmFM7JDVYdiOWho87z427OCToFJ\njDxqw/iLQHMtIjfqpET2hRNIIFRsFKAnJEAhdboEf/zQ/++sAQBv/YRQLL0rxBVn\nq6ZGzCRsgAzLqc8d4wIC9bEQkPMNG5rFE3T36If82BZ7fDYVenvihwoEi/3khfT1\nnX46YnmHMybEx+5bnFsxnQdNiDV3DHuVKLR8DqsXJwMVLWOJcD+7UqRaTYx/dJsT\ng/RUKiIjlSlA6lnsfp+mGhQ5iW+jA96I8dGjlXLhtbFpQyyQ0VxoXRm7eb+MibHY\n761l+/Sg/GsciJBATsBK\n-----END CERTIFICATE-----\n";
var realCrossCertCA3 = "-----BEGIN CERTIFICATE-----\nMIIGEDCCBPigAwIBAgICEB4wDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTYwMTA1\nMDgyMTA1WhcNMjYwMTA1MDgyMTA1WjBPMQswCQYDVQQGEwJLUjESMBAGA1UECgwJ\nQ3Jvc3NDZXJ0MRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExFTATBgNVBAMMDENyb3Nz\nQ2VydENBMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMQh+483jjVm\nmqoGaWKLZyz81MObZq94RIPwq1kEQUu46umnobZaOamnVxB9ggJfJV34ugY95zEI\nqNOcMRGYXSfySd5uDvPVstwOb4vuMQDdrsHtcbRMIESsq6By8jKAvVbYV9T+RFyy\n4TOCiRfzyAIZeZ9kyHLze2Q3bAjeHgPWA/M+F7MAMtKhx8IB4NUa83rJ1mY6t35E\n8L7i7QoCX8/w7hu+W6DU+DbZBUk10kDUZqMP28h9k0brRnmCr8pcleuuOjymwaWu\nBWDhSavWpXwY4vGNHg4HZvdDsEPEXTwveQY3SoceENdJDiSOMzXvebwJlJVWDvFD\nTueYrSkmS9cCAwEAAaOCAt8wggLbMIGOBgNVHSMEgYYwgYOAFMjQjsdJrh8gQrJL\nfxPJd1gMoc3BoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwG\nA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQG\nA1UEAwwNS0lTQSBSb290Q0EgNIIBATAdBgNVHQ4EFgQUQ9bzZX9lnc1rwc5zCr8y\nEKBR5xEwDgYDVR0PAQH/BAQDAgEGMIIBMQYDVR0gAQH/BIIBJTCCASEwggEdBgRV\nHSAAMIIBEzAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3IvcmNh\nL2Nwcy5odG1sMIHeBggrBgEFBQcCAjCB0R6Bzsd0ACDHeMmdwRyylAAgrPXHeMd4\nyZ3BHMeFssiy5AAoAFQAaABpAHMAIABjAGUAcgB0AGkAZgBpAGMAYQB0AGUAIABp\nAHMAIABhAGMAYwByAGUAZABpAHQAZQBkACAAdQBuAGQAZQByACAARQBsAGUAYwB0\nAHIAbwBuAGkAYwAgAFMAaQBnAG4AYQB0AHUAcgBlACAAQQBjAHQAIABvAGYAIAB0\nAGgAZQAgAFIAZQBwAHUAYgBsAGkAYwAgAG8AZgAgAEsAbwByAGUAYQApMC4GA1Ud\nEQQnMCWgIwYJKoMajJpECgEBoBYwFAwS7ZWc6rWt7KCE7J6Q7J247KadMBIGA1Ud\nEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjgYDVR0fBIGGMIGDMIGA\noH6gfIZ6bGRhcDovL2Rpci5jcm9zc2NlcnQuY29tOjM4OS9DTj1LSVNBLVJvb3RD\nQS00LE9VPUtvcmVhLUNlcnRpZmljYXRpb24tQXV0aG9yaXR5LUNlbnRyYWwsTz1L\nSVNBLEM9S1I/YXV0aG9yaXR5UmV2b2NhdGlvbkxpc3QwDQYJKoZIhvcNAQELBQAD\nggEBAFmykQiYoAVr8mceqWYw3sI4wQWCASRqLHnB7QnhhehzzLIK+E3q/7vct6T/\niToq8I5s6R2DqUZB6LuTQY0IJnM/EUBVANuGT044IuhiIs5er14f4YaX58Q96l7j\nbTWyed8OtR1dvS84kPTdSDpDKgrk+IEvS7M2rNXj/Kkb1rSXRgpvxpyEECCevcZO\ngrdNnP96Il/7O/XaBVYQJIRi7k4aY4PoLP+k58xAVu+9zlMwRFRMJ3+w+l1fECzD\nHzIkQGGh4LRdrjrUoYbxMr2USHpaWq/mfzrWymuJrhi/xTxSoWw1cWEcz7i+JnLS\nJaXjggr4rRrzo0ilz2mEDUj6MUc=\n-----END CERTIFICATE-----\n";
var realTradeSignCA3 = "-----BEGIN CERTIFICATE-----\nMIIGFzCCBP+gAwIBAgICEB8wDQYJKoZIhvcNAQELBQAwZDELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxFjAUBgNVBAMMDUtJU0EgUm9vdENBIDQwHhcNMTYwMjI2\nMDIzNTA5WhcNMjYwMjI2MDIzNTA5WjBPMQswCQYDVQQGEwJLUjESMBAGA1UECgwJ\nVHJhZGVTaWduMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExFTATBgNVBAMMDFRyYWRl\nU2lnbkNBMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANYyWa44JAH1\njOqVF3u4O4khr1K9hfZ7rkqLF6/Efbbhdvbcg3Mr29mz7rWemMhOvdwm3Dh2qVYM\nqD1K3tVaVALA93KbWzi54cDRg5jbbcgQqsg96B2ZqdbxgTdGXhPpPd+A8jJfdBr4\n95UUNUdEoM9lNi2hkFeVWCzC5z36IwOH9/vZOSz/hUkeHjtOeo4V17Iy64zQDy4q\n07kAM2rFzdApX8CnjhJHyK3JF/gQfi+9JYGVqgwVt8Crubeb3DKw3avDnVf3JPKe\nivaRxwftJm3Yr3Skzx8gJmkPdxTjIVbJrVFh1anm8OCJYD6ZPv18HPoxZPvmkfhh\nRh1pumT08LECAwEAAaOCAuYwggLiMIGOBgNVHSMEgYYwgYOAFMjQjsdJrh8gQrJL\nfxPJd1gMoc3BoWikZjBkMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwG\nA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEWMBQG\nA1UEAwwNS0lTQSBSb290Q0EgNIIBATAdBgNVHQ4EFgQUtQcjbFfPPq6OtTKBn5Gn\nINvo6+MwDgYDVR0PAQH/BAQDAgEGMIIBMQYDVR0gAQH/BIIBJTCCASEwggEdBgRV\nHSAAMIIBEzAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3IvcmNh\nL2Nwcy5odG1sMIHeBggrBgEFBQcCAjCB0R6Bzsd0ACDHeMmdwRyylAAgrPXHeMd4\nyZ3BHMeFssiy5AAoAFQAaABpAHMAIABjAGUAcgB0AGkAZgBpAGMAYQB0AGUAIABp\nAHMAIABhAGMAYwByAGUAZABpAHQAZQBkACAAdQBuAGQAZQByACAARQBsAGUAYwB0\nAHIAbwBuAGkAYwAgAFMAaQBnAG4AYQB0AHUAcgBlACAAQQBjAHQAIABvAGYAIAB0\nAGgAZQAgAFIAZQBwAHUAYgBsAGkAYwAgAG8AZgAgAEsAbwByAGUAYQApMDQGA1Ud\nEQQtMCugKQYJKoMajJpECgEBoBwwGgwY7ZWc6rWt66y07Jet7KCV67O07Ya17Iug\nMBIGA1UdEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBjwYDVR0fBIGH\nMIGEMIGBoH+gfYZ7bGRhcDovL2xkYXAudHJhZGVzaWduLm5ldDozODkvQ049S0lT\nQS1Sb290Q0EtNCxPVT1Lb3JlYS1DZXJ0aWZpY2F0aW9uLUF1dGhvcml0eS1DZW50\ncmFsLE89S0lTQSxDPUtSP2F1dGhvcml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3\nDQEBCwUAA4IBAQCfvk0cqm1tyDuCC6Uqc5cFJ14aujinjeButBCiM1oa8A2GwCuK\nk6Mjr1m8V6mcx35ZTKUxpzJSQ+Dx2VzqLCskM5PShJuR1IG5lSobYXKsdjL4a+wy\n2fzQIafkEYg++y1Yte/g5VgXoSZPWL88EVt38NcRgGgRXf/cE/FBmwBpFcwkMe3o\n5AScjS5Lw8Af8ZH/YhOz6oIJzK1B7ph0b7PnNgYVKKdbID+MXMcXSOYg3R4uhrbk\nj1RUY4XxCE6phZN8llIoB//CwbDlZQZlf9K6gvTE+a/w4LofHpz/GbXWSBfiJB3o\ne9/Bx1Y4MA+6uR+KZiWUnDf2yW3W+V2bTEvn\n-----END CERTIFICATE-----\n";

// Test-CA 인증서 (2048)
var testCrossCert_2048 = "-----BEGIN CERTIFICATE-----MIIFdzCCBF+gAwIBAgIBNDANBgkqhkiG9w0BAQsFADBpMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA1MB4XDTE0MTEyMTAxMzExN1oXDTE5MTEyMTAxMzExN1owUzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRkwFwYDVQQDDBBDcm9zc0NlcnRUZXN0Q0EzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzo9X0yeuI2bwmVVmy7NrLyIHVjVRE84yBRcJtDKkfyUh4z/ZcnGj1QJ8U/EnycVWnMgl+6ue2me61DGhw8nwmz108SKzv53u6HohMFEf25uO7Zj/yRzt9zIXapWYIL0pU7drYXD5Xe5KeBZ1i7D0lleQteXGH+F/k5fhIO9uFN/de+aGMHCK4cyUOTlDpUALA8UJx6GCYNuJ5NnPHuUaah/ANkgkuZPZbsFbimZ7eRv5BH6tKt58iGlLeNAmq4fYT8ng7HzoJqsH3bncnMCcTNZs6Hvaqv5+UfQcgHQ/5tadgynwwcL+DM7tbp+5S8bG6c+n9fjghwBFcDbK79YL8wIDAQABo4ICPjCCAjowgZMGA1UdIwSBizCBiIAUNHiHacP1mzONaqqqLo4PlL5XkQ6hbaRrMGkxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRswGQYDVQQDDBJLaXNhIFRlc3QgUm9vdENBIDWCAQEwHQYDVR0OBBYEFAI9JTNN5N5Zo9+Zk9rHoF4U974DMA4GA1UdDwEB/wQEAwIBBjB8BgNVHSABAf8EcjBwMG4GBFUdIAAwZjAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3IvcmNhL2Nwcy5odG1sMDIGCCsGAQUFBwICMCYeJMd0ACDHeMmdwRyylAAgwtzV2MapACDHeMmdwRzHhbLIsuQALjAzBgNVHREELDAqoCgGCSqDGoyaRAoBAaAbMBkMF+2VnOq1reyghOyekOyduOymnSjso7wpMBIGA1UdEwEB/wQIMAYBAf8CAQAwDwYDVR0kAQH/BAUwA4ABADCBmgYDVR0fBIGSMIGPMIGMoIGJoIGGhoGDbGRhcDovL3Rlc3RkaXIuY3Jvc3NjZXJ0LmNvbTozODkvQ049S2lzYS1UZXN0LVJvb3RDQS01LE9VPUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwsTz1LSVNBLEM9S1I/YXV0aG9yaXR5UmV2b2NhdGlvbkxpc3QwDQYJKoZIhvcNAQELBQADggEBACOeKGLWTAIl/UmbocoWAZn3cfHWIQwn1T5Rcdgkqd86Gg5XHgAZ8xbfWTzcN0p023iA7y8cVkPmpWNPiWBfBijmvYDGwoqe1e8QuO+LvVZBATJGibXCzwHMfmoORZMHF8BWTBZmORhrnhv0gWQzL2tUf1Jnm5iQJ1SAKt/WTVKARkydTc2JZfge9Xs82DUWJAJ7YnfySox3uukWAJQSxtlT+yN5yz6nTZa3QTaVORS6SOmnGqDz5lFCOpL8QJYKgC9Q1mPY7xBqPY5Q5Eb+BXMIIfWWHQtTtI2jDyvjIcsJdV39TCJHyu8b0lIt5GI63pdB21Xx5ksAS7kQLttTUWs=-----END CERTIFICATE-----\n";
var testSignGate_2048 = "-----BEGIN CERTIFICATE-----\nMIIFaTCCBFGgAwIBAgIBMDANBgkqhkiG9w0BAQsFADBpMQswCQYDVQQGEwJLUjEN\nMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRo\nb3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA1MB4XDTEz\nMTIwNjA3MTYxOVoXDTE4MTIwNjA3MTYxOVowTTELMAkGA1UEBhMCS1IxDTALBgNV\nBAoMBEtJQ0ExFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEYMBYGA1UEAwwPc2lnbkdB\nVEUgRlRDQTA0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmPETn5J8\nNql8/LtsvbEfF0VZyRSrhFLxXMzqvkU/nkitekOu9GHsGJ6NQqywoct6dXIztUjX\nw56sZs2jtKgfohI5Z67NK+i4/ZdZnlDTzmwI2HZnc8rP6KT6qSlvk9QwT5PyhW63\nmYGGczc5q7SL91EdAIwwvyFpvyoGga455VFBLWp/5JFA6MwhbhxK5xqKBLQYyMFz\n1dJ+tfmkRMgCE4ferdkZ9yLnRFccCnRvNQ8GRspeHRqIRH+x00daW/2nWezNtMKW\nIKQKoNS6JS9NRHdP5HwxQ/duHPMMYn4gZ26axxN4fLN0qfjN1/HRGe2rnt4P6KFs\nN/7k3rt1KNkZrwIDAQABo4ICNjCCAjIwgZMGA1UdIwSBizCBiIAUNHiHacP1mzON\naqqqLo4PlL5XkQ6hbaRrMGkxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4w\nLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRsw\nGQYDVQQDDBJLaXNhIFRlc3QgUm9vdENBIDWCAQEwHQYDVR0OBBYEFFhGOKvE6iVQ\n0hj6LtrcnPb1ouvVMA4GA1UdDwEB/wQEAwIBBjB8BgNVHSABAf8EcjBwMG4GBFUd\nIAAwZjAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3IvcmNhL2Nw\ncy5odG1sMDIGCCsGAQUFBwICMCYeJMd0ACDHeMmdwRyylAAgwtzV2MapACDHeMmd\nwRzHhbLIsuQALjAuBgNVHREEJzAloCMGCSqDGoyaRAoBAaAWMBQMEu2VnOq1reyg\nleuztOyduOymnTASBgNVHRMBAf8ECDAGAQH/AgEAMA8GA1UdJAEB/wQFMAOAAQAw\ngZcGA1UdHwSBjzCBjDCBiaCBhqCBg4aBgGxkYXA6Ly9jYXRlc3Quc2lnbmdhdGUu\nY29tOjM4OS9jbj1LSVNBIFRlc3RSb290Q0EgNSxvdT1Lb3JlYSBDZXJ0aWZpY2F0\naW9uIEF1dGhvcml0eSBDZW50cmFsLG89S0lTQSxjPUtSP2F1dGhvcml0eVJldm9j\nYXRpb25MaXN0MA0GCSqGSIb3DQEBCwUAA4IBAQCTPuO2qn6XC7buFSvpsUHFPpEV\npUHO7ywXDduqEN1QjUOtUoCwHJwdS96PIVSnhxww9R+jYzgabh3xtFESPD4WTcPx\nFVia+9FU6EPOIGMfKR1OGhkWsho25OTTPfuAwQvFP+7RhL/hNUQMhvZqDOA7V0SA\nd665sA/aQpAl9aOr9xgmHk80O8ea8KVyyZn0vaW27Y+mETouqryjy5+OBakfvxYF\nNQebsh/yDlm96hKokbJFeNrAzPcEZuqbC3TKtnFzQ9Uw/mEJLHgUISil+m+EuW4G\nHgyPhRhPOseJ30EZ48LMo2EhanZubQ0doD1TJi2OxO3QDAn3/lFaPnGJkM9r\n-----END CERTIFICATE-----\n";
var testSignKorea_2048 = "-----BEGIN CERTIFICATE-----MIIFQzCCBCugAwIBAgIBNTANBgkqhkiG9w0BAQsFADBpMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA1MB4XDTE0MTIxOTA2MzczM1oXDTE5MTIxOTA2MzczM1owVTELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCVNpZ25Lb3JlYTEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRswGQYDVQQDDBJTaWduS29yZWEgVGVzdCBDQTMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUq8MzX2vI86FOek0tfM+SnAMIOgluDRliPWtY2AkLy7gUDyIDq2slIEgByhkHzTyzKGyhRw6iXSYuw/TaAiWT1WKs69a8QL+UYXPF0ZoEc5mKhIC5/Cq/LjalCJ34GZ2cQRJVsNvhZyirJdwV2FBn/EvaLs9L/6gQdEmj87ynTVPuG4FR3ffWqPQ8OBk8JLsYaiWYwLpIz9xewDkssQToNmk47exQD/Uv3/9ceJc0ZE9Jp3ruQREM3bz/RQR8Bmqd6jZ/7vEiZ255KtGbuRFPI0NvkqABBxYBck3zxuw5HBVJmgUo0Vae9DiWC0L5mNxBe2PrKPfxRkrEKWydSG2xAgMBAAGjggIIMIICBDCBkwYDVR0jBIGLMIGIgBQ0eIdpw/WbM41qqqoujg+UvleRDqFtpGswaTELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktpc2EgVGVzdCBSb290Q0EgNYIBATAdBgNVHQ4EFgQUDwQzIZ4ZO9CskEcekRndC+UMZ+UwDgYDVR0PAQH/BAQDAgEGMHwGA1UdIAEB/wRyMHAwbgYEVR0gADBmMDAGCCsGAQUFBwIBFiRodHRwOi8vd3d3LnJvb3RjYS5vci5rci9yY2EvY3BzLmh0bWwwMgYIKwYBBQUHAgIwJh4kx3QAIMd4yZ3BHLKUACDC3NXYxqkAIMd4yZ3BHMeFssiy5AAuMCoGA1UdEQQjMCGgHwYJKoMajJpECgEBoBIwEAwOKOyjvCnsvZTsiqTsvaQwEgYDVR0TAQH/BAgwBgEB/wIBADAPBgNVHSQBAf8EBTADgAEAMG4GA1UdHwRnMGUwY6BhoF+GXWxkYXA6Ly8yMTEuMTc1LjgxLjEwMjo2ODkvQ049VEVTVC1ST09ULVJTQS1DUkwyLE9VPVJPT1RDQSxPPUtJU0EsQz1LUj9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdDANBgkqhkiG9w0BAQsFAAOCAQEAD65s+J6F/eSESCeBip7Mh9bwnOHNX1c8dIghyc9ncWWOEo4B8TEVUA9fuCZGUiezLNLU55QpaRp06aTMsHMdCkz++8av/SjNDJ6FcbIb3yJLH/bOs5XFrlxZsfkD5q/ugr4Wz13vhyfcsLjz5vhdRqGigMrpBRRDHGmBEjXmfHCEvAmuwMQes3CZhHBj2P1VpeJ7J6Ccucs7aZGMSvRNkWES7TDe/c0hgrRFoU1r1qEpnAz9PgyXR9RNsHn/2xO6XlX1RdmgImlqDxpR0utuAaHt77s98tE6i5DwYCqp35aHtKgehPdIi5V7fj2IKdErhvxf7Paok0AzA/MC3bCdcQ==-----END CERTIFICATE-----\n";
var testTradeSign_2048 = "-----BEGIN CERTIFICATE-----\nMIIFeDCCBGCgAwIBAgIBGTANBgkqhkiG9w0BAQsFADBpMQswCQYDVQQGEwJLUjEN\nMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRo\nb3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA1MB4XDTEx\nMDQwODAxMjMwN1oXDTE2MDQwODAxMjMwN1owVzELMAkGA1UEBhMCS1IxEjAQBgNV\nBAoMCVRyYWRlU2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMR0wGwYDVQQDDBRU\ncmFkZVNpZ25DQTIwMTFUZXN0MjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC\nggEBAOiizuoxk8dTTGbDd0CYf2Aq1YJmbB5Wg/LEhSBVHHOcB9IMuqCoIKzg+4BP\nQj0W9zEBud4cdvXPdoof3BSqzdSKHkj49H7cWT4SlHM36LdggB9xlwVodDmHrgiL\n9PPGioUjCSSz/Wa7gumYW9NR2CYlnaTjF+d30jESWWII5SB2TIu+rqHy577j9kcv\nFSZ7cNkRSXnotGfuvmKRyZUG7syK1I8zXumgmTHq2wrTKDuxpzTdMpWJdj/g/Wg4\ncqQeGx9rRkOJmEknQl7JTuOgvc3nrErWZEmp122Qrz+HWJq9qO0k3mJ1NpCc/Cxw\noL6Pm2EZKaASgbP2xTfjq//LbdkCAwEAAaOCAjswggI3MIGTBgNVHSMEgYswgYiA\nFDR4h2nD9ZszjWqqqi6OD5S+V5EOoW2kazBpMQswCQYDVQQGEwJLUjENMAsGA1UE\nCgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkg\nQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA1ggEBMB0GA1UdDgQW\nBBQHhJ7STY17e1qOdogFQUMa1wgnTjAOBgNVHQ8BAf8EBAMCAQYwfAYDVR0gAQH/\nBHIwcDBuBgRVHSAAMGYwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9y\nLmtyL3JjYS9jcHMuaHRtbDAyBggrBgEFBQcCAjAmHiTHdAAgx3jJncEcspQAIMLc\n1djGqQAgx3jJncEcx4WyyLLkAC4wOQYDVR0RBDIwMKAuBgkqgxqMmkQKAQGgITAf\nDB0o7KO8Ke2VnOq1reustOyXreygleuztO2GteyLoDASBgNVHRMBAf8ECDAGAQH/\nAgEAMA8GA1UdJAEB/wQFMAOAAQAwgZEGA1UdHwSBiTCBhjCBg6CBgKB+hnxsZGFw\nOi8vZGV2Y2EudHJhZGVzaWduLm5ldDozODkvQ049S0lTQS1Sb290Q0EtNSxPVT1L\nb3JlYS1DZXJ0aWZpY2F0aW9uLUF1dGhvcml0eS1DZW50cmFsLE89S0lTQSxDPUtS\nP2F1dGhvcml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3DQEBCwUAA4IBAQAOx4Ct\nUiwFmZGKpnBrWGIHoDz+TrtiVZ5JZ/5MKh8ElEiQT8huKbyFmztuo4YlBg5QP4j8\nOQkicL0nNVGj7iI88UZR/ek3d9xph+2uyklnemJMxEyPTfvIPnjvrD/ij337f7xc\npAsGEHncdmVW1TkiU0zw9npA090y4JzAixI1U4Mmy8kt/pEercwzYOFYjExXZe4V\nTZfrvBOU5qyEsQcCP4xgyI6YSG5bzflGeUmEza84FcMJCSE4eQqON/bBv9JHFZSP\nhiM5CF6KusrrpEQ6hfrIH7U0EEoL74DyJqveJz3Q+T94nnJm3Z3lrkBaUoa01wXF\nhQ+Az+3nFahWtwFc\n-----END CERTIFICATE-----\n";
var testYessign_2048 = "-----BEGIN CERTIFICATE-----\nMIIFRzCCBC+gAwIBAgIBJTANBgkqhkiG9w0BAQsFADBpMQswCQYDVQQGEwJLUjEN\nMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRo\nb3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA1MB4XDTEy\nMTIyMTEzMDIyOVoXDTE3MTIyMTEzMDIyOVowVzELMAkGA1UEBhMCa3IxEDAOBgNV\nBAoMB3llc3NpZ24xFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEfMB0GA1UEAwwWeWVz\nc2lnbkNBLVRlc3QgQ2xhc3MgMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC\nggEBALTZAbOQ4so/HD5BON/Ffxjqcvpjl4PE+1sjc3/dgaMCjqKMKCHXjeJJRmfi\nDDdJ7nDtcMwxWgXH3BxQ/SPTglfysvI1NhdxM58KYpOi2zVy5c9g9tG+ie9EnWdL\netky0Zc//f7nMLJi9DKgG42Ahxau4wC2W2GGUUmne9Ar+egz/Bgx1QwjhhefSKRO\nk/NJ12R7xFmm03GtZRav1AK0nx8mnYIwLw6C2TzPVsfRwR9zJjbbQ/84wkcYJ5Yl\nduLyKZP/+DWCiOd8yL4x1vTYvgESmlY7Wh41rpuDeeehkxom2TpUjzIwTiq+Rujd\nau4efmR9KVzu820jtLD9lfnvvVsCAwEAAaOCAgowggIGMIGTBgNVHSMEgYswgYiA\nFDR4h2nD9ZszjWqqqi6OD5S+V5EOoW2kazBpMQswCQYDVQQGEwJLUjENMAsGA1UE\nCgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkg\nQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA1ggEBMB0GA1UdDgQW\nBBQUj6BKC6Xz5vfMJkaxkNJdgJzS9DAOBgNVHQ8BAf8EBAMCAQYwfAYDVR0gAQH/\nBHIwcDBuBgRVHSAAMGYwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9y\nLmtyL3JjYS9jcHMuaHRtbDAyBggrBgEFBQcCAjAmHiTHdAAgx3jJncEcspQAIMLc\n1djGqQAgx3jJncEcx4WyyLLkAC4wKwYDVR0RBCQwIqAgBgkqgxqMmkQKAQGgEzAR\nDA/quIjsnLXqsrDsoJzsm5AwEgYDVR0TAQH/BAgwBgEB/wIBADAPBgNVHSQBAf8E\nBTADgAEAMG8GA1UdHwRoMGYwZKBioGCGXmxkYXA6Ly9kc3QxLnllc3NpZ24ub3Iu\na3I6NjAyMC9jbj1LSVNBLVRFU1QtQVJMNSxvdT1ST09UQ0Esbz1LSVNBLGM9S1I/\nYXV0aG9yaXR5UmV2b2NhdGlvbkxpc3QwDQYJKoZIhvcNAQELBQADggEBACR1A6qs\n2El9Yy2zfP9X/RM07208sWU6IPZU6uQKCaXKbK4azHPoL2mLUaLrTR+/0tKOde0A\nfz6n6DPU9T4DRlfn/8zspCXjf2eTHwtk92rC92NJoE9vf321SYzgZ9xzA+m9vFzV\nLGex+VARfolAq/Q6VKdw6VP0qu0gSQDgfnNYdLu+YE2UvFfspSBdKVvujnapTpau\nZ/Qcrpstgokb6S/iLkb5UfKEa45I5B4fmDCxlK6iahWCclwvJCHKKGqRUn5kjUhz\nY8xtTjjR7CdtLgyDQqh34V7ZhjUtHsSdftEH+KSootgdbGmUbxwNlHS+uPJwLYIo\nEurkh8g5ROeh7vM=\n-----END CERTIFICATE-----\n";
var testYessign_3280 = "-----BEGIN CERTIFICATE-----\nMIIFQDCCBCigAwIBAgICJ7UwDQYJKoZIhvcNAQEFBQAwaTELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktJU0EgVGVzdCBSb290Q0EgNDAeFw0w\nNTA5MzAwNjM5NDdaFw0xMDA5MzAwNjM5NDdaME8xCzAJBgNVBAYTAmtyMRAwDgYD\nVQQKDAd5ZXNzaWduMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExFzAVBgNVBAMMDnll\nc3NpZ25DQS1URVNUMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4PUD\n8UEIN9831Vo7t5jq5LaZ8NDxk+ulNhspTBAYMBPbqQ/hIJkc7I9iimk/tmS062fZ\n0clbj6aOpb/9QQfZ/4NlIcMYKk9aZPupv5I5rDxogs7bcpwhQ1/DSexYDO7X3V/T\nS1PwmN2E+tqELCdFHx+NPxCY/NZle2FtxWkad9bMXxuqESe8YDDQDCX6Kx2ZF59/\nuDnsvzXwWZWg+/6bMWx6utikRT0UiU5IXlagrQ7KiMRISrQ6jTPHbOT4zGNHbc3i\n97koMxJkEURoIY9fYV1jZZ9nSJjW/qrsiU2Hh5jZsjsO7U/zwgvNrx2p+EpGMweO\nyIooPhMritlve4he8QIDAQABo4ICCjCCAgYwgZMGA1UdIwSBizCBiIAUJYffPhgc\nksBsLpZ31EoAlVkHdkmhbaRrMGkxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNB\nMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFs\nMRswGQYDVQQDDBJLSVNBIFRlc3QgUm9vdENBIDSCARAwHQYDVR0OBBYEFEYp/i+1\n0zxTKTH5UgkcpME5Q+FmMA4GA1UdDwEB/wQEAwIBBjB8BgNVHSABAf8EcjBwMG4G\nBFUdIAAwZjAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3IvcmNh\nL2Nwcy5odG1sMDIGCCsGAQUFBwICMCYeJMd0ACDHeMmdwRyylAAgwtzV2MapACDH\neMmdwRzHhbLIsuQALjArBgNVHREEJDAioCAGCSqDGoyaRAoBAaATMBEMD+q4iOyc\nteqysOygnOybkDASBgNVHRMBAf8ECDAGAQH/AgEAMA8GA1UdJAEB/wQFMAOAAQAw\nbwYDVR0fBGgwZjBkoGKgYIZebGRhcDovL2RzdDEueWVzc2lnbi5vci5rcjo2MDIw\nL2NuPUtJU0EtVEVTVC1BUkw0LG91PVJPT1RDQSxvPUtJU0EsYz1LUj9hdXRob3Jp\ndHlSZXZvY2F0aW9uTGlzdDANBgkqhkiG9w0BAQUFAAOCAQEARfwkJnxFHQ0q6XFk\n7doXb+MVN5aVCvGOmxoUaXkbAcK9PNHEdQEDreZScFnQJnHPRNNqVyZ+jS3FF44y\naAiJNZqiSvEy8EaS289nQUOo5by5C3Bh/CguJJlJkvqrtOvmnr8hFDrDqEhslAGG\nn785IhIJxeVdNvlq2NB5VEzdigRpwq3BD94Bti5w4GglM4Pv3vubUHhC1zldi0Sr\nfyl8GqXV6CUsQRfzm+QHthS7EA+7ECKUmrummC25j1Amb6/psYPOuTrNnonA3/uV\nY3m6kPxpydQHda2ETPAtFIOMxQC6bKhGAoDLVV5GjXXRXwyl5PdZt14p4t6N4cBO\nBqrf8w==\n-----END CERTIFICATE-----\n";
var testNCACert_3280 = "-----BEGIN CERTIFICATE-----\nMIIFSTCCBDGgAwIBAgICJ6wwDQYJKoZIhvcNAQEFBQAwaTELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktJU0EgVGVzdCBSb290Q0EgNDAeFw0w\nNTA5MTUwOTEyMDVaFw0xMDA5MTUwOTEyMDVaMFIxCzAJBgNVBAYTAktSMRAwDgYD\nVQQKDAdOQ0FTaWduMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExGjAYBgNVBAMMEU5D\nQVRFU1RTaWduMzI4MENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA\n0HdhAtYCh/IKUxZzBTEQZVyB3/zC7Lw9glXjPnAZGTg5Ky9NVgOMbOZw4D/ploip\nUWKMnUmDRIMdyCkf1vJgDU9ZureqlbxDsO9LynoGts2nBhYF/fd5cDLjOo99PAHT\np66+Z/KlM2zsCVzARMtqpABL7fGSQhhAU1eGGvBHbJVkQ2kMVWZ14W79ryPa+U0b\nbsWhDH0KzOx4pQDTyGK8agdBMadJT85GWA1Ew2PwDA2sc29zsn1yvKE81ayfoAOz\n1d6HwQACy6KtUcdQDnrMnvv2e3Fgv0bYJUk+nkFUqEWsJpDDLasyKN/9q8JMV6Mi\nTjb96R2DxoPkelPgtL0f4QIDAQABo4ICEDCCAgwwgZMGA1UdIwSBizCBiIAUJYff\nPhgcksBsLpZ31EoAlVkHdkmhbaRrMGkxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARL\nSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50\ncmFsMRswGQYDVQQDDBJLSVNBIFRlc3QgUm9vdENBIDSCARAwHQYDVR0OBBYEFFU+\ntz0LMq7klWHmQxWh9hWjF+U0MA4GA1UdDwEB/wQEAwIBBjB8BgNVHSABAf8EcjBw\nMG4GBFUdIAAwZjAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3Iv\ncmNhL2Nwcy5odG1sMDIGCCsGAQUFBwICMCYeJMd0ACDHeMmdwRyylAAgwtzV2Map\nACDHeMmdwRzHhbLIsuQALjArBgNVHREEJDAioCAGCSqDGoyaRAoBAaATMBEMD+2V\nnOq1reyghOyCsOybkDASBgNVHRMBAf8ECDAGAQH/AgEAMA8GA1UdJAEB/wQFMAOA\nAQAwdQYDVR0fBG4wbDBqoGigZoZkbGRhcDovLzIxMC4xMTQuOTQuMTk6NDg5L0NO\nPVRFU1QtUk9PVC1SU0EtQ1JMLE9VPUFjY3JlZGl0ZWRDQSxPPU5DQVNpZ24sQz1L\nUj9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdDANBgkqhkiG9w0BAQUFAAOCAQEAO7Xb\nCbpLtKtbRVNJod9ypGd8vaiNYIW0yujZy/B/UwYgdQu97GE9+UvmV1Zakn6zTskW\njI4zxIH1nWPLO/Wk1YTrgg2yXITYGNZv98wWSnmiJNd8DoSVHt7Wy9lEBT6tQMv5\nK6JNidJpzWbjmtqAbapRAhfHVqOrkAb6HQwGs7ZN9KFzrIobRzj3c3qSEu60xFc/\nIEsZVmSo/8r+wXGLWfadVUaI26sleFOgBDmEOC8sajwc80yT4goH0E1vXCqBJNvG\n567q+EmzYIFPBDOJH7hh171jthkxXM6BoaQdt61vTeDRUvC9WU1o1kBcm5ND4Dok\nZNGwLsLDC3rqkbxo+Q==\n-----END CERTIFICATE-----\n";
var testCrossCert_3280 = "-----BEGIN CERTIFICATE-----\nMIIFUTCCBDmgAwIBAgICJ7YwDQYJKoZIhvcNAQEFBQAwaTELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktJU0EgVGVzdCBSb290Q0EgNDAeFw0w\nNTA5MzAwNjQxMjJaFw0xMDA5MzAwNjQxMjJaMFMxCzAJBgNVBAYTAktSMRIwEAYD\nVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEZMBcGA1UEAwwQ\nMzI4MFRlc3RDQVNlcnZlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB\nANwjj0HD1Yq5aLDsEO+jDk3HjlXkIpQ3wmgBlEwAsZzZZc/B2ZjMBh04jDwSqxCd\nLJOKHDG0DRBe/bbwZIrtSYBzejNAC0M3lJ0Cs/2SOwz7jbtH+ds5dCjV4DcR/ySO\nnbVU51l/BiGvSAGtNry2kita9cBHE/+Ef9uDXcOAMlLOCci1X/NLXX+oMG82Tl2v\nMX2DLDLnrWOiRuAQk2XhS56aR1LzYQvAeE+bgilQVdwFeTKyHHLTfqBtrutbk62v\ntA9nAW0AfYdaHupgbvdNcBqNx1c+AMiRAsecj8+YhhtyXZTg5rin5CSfrj9LDRcf\nVlTW8RbxLhuCuSxtBazFQFUCAwEAAaOCAhcwggITMIGTBgNVHSMEgYswgYiAFCWH\n3z4YHJLAbC6Wd9RKAJVZB3ZJoW2kazBpMQswCQYDVQQGEwJLUjENMAsGA1UECgwE\nS0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2Vu\ndHJhbDEbMBkGA1UEAwwSS0lTQSBUZXN0IFJvb3RDQSA0ggEQMB0GA1UdDgQWBBRR\naC2Bbi40gAFUjVhOwZArKH0SgzAOBgNVHQ8BAf8EBAMCAQYwfAYDVR0gAQH/BHIw\ncDBuBgRVHSAAMGYwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9yLmty\nL3JjYS9jcHMuaHRtbDAyBggrBgEFBQcCAjAmHiTHdAAgx3jJncEcspQAIMLc1djG\nqQAgx3jJncEcx4WyyLLkAC4wMwYDVR0RBCwwKqAoBgkqgxqMmkQKAQGgGzAZDBft\nlZzqta3soITsnpDsnbjspp0o7KO8KTASBgNVHRMBAf8ECDAGAQH/AgEAMA8GA1Ud\nJAEB/wQFMAOAAQAwdAYDVR0fBG0wazBpoGegZYZjbGRhcDovL3Rlc3RkaXIuY3Jv\nc3NjZXJ0LmNvbTozODkvQ049VEVTVC1ST09ULVJTQS1DUkwsT1U9Uk9PVENBLE89\nS0lTQSxDPUtSP2F1dGhvcml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3DQEBBQUA\nA4IBAQBiFTaANTqkRJmGcg/wFFmrEUyw5Gfl4BrVugWUbWGd8ducXkkzwoh7Yti4\nrngaTETPUKOWAC58NyTUJg2vgq+XXnVSNGMrHYiyACGNT+CzJQG9W9+5ThKhWKS5\n/LMApWyS1+L3K9lgz6tGGTESa0OdHHLgC8cMiMfyhuqyBFzJnU0kMTzZjR9/yLKC\nlSF0Zuh6W7dtXcfPuxOWGKFivhEU4EpL7L/WutvYV04JIG6yigCGNiuE8/U77Fjk\n5jGETcwG+CDptK/d8pff5BTzHftz0sW7BMhze5XzqYzJggSlkMXWsNV29Ch6FFcf\neHAtk504fa4n7arhFhlvkut2SZFE\n-----END CERTIFICATE-----\n";
var testSignGate_3280 = "-----BEGIN CERTIFICATE-----\nMIIFQDCCBCigAwIBAgICJ6IwDQYJKoZIhvcNAQEFBQAwaTELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktJU0EgVGVzdCBSb290Q0EgNDAeFw0w\nNTA4MjQwMjA4MjlaFw0xMDA4MjQwMjA4MjlaME0xCzAJBgNVBAYTAktSMQ0wCwYD\nVQQKDARLSUNBMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExGDAWBgNVBAMMD3NpZ25H\nQVRFIEZUQ0EwMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMCrjsbR\nJ7iv2GpyS/gmIAnIIiDYKD4R9eSJuyRg6cSZBOk3agZH9C6G90iZooYNJatmVQrQ\n88IwuMoAuVm/X0n0fJLGjS+1IflmmXeJ4myh6NRb/MUgvZLZCKkO4JFBM9x2PtyF\n49SRBanx+5NZ/RrBTcyvUX+0zd05ZyEgjdtKrTdruo/DdFGUO0o5/CgmUFuev/KV\naXze3VTJMV3y4D6+Hk+oIjo5a7zO4gtbNKxlcQR7wt0nDRqCQDjEycHgvIP+q9tU\nT2b8xS32+T5S4oCffMzCWqB8sAxEbHL/rpGJBLWXp1KRoDOfDH97SlQlvSs8I74R\nscmB10OubCieimsCAwEAAaOCAgwwggIIMIGTBgNVHSMEgYswgYiAFCWH3z4YHJLA\nbC6Wd9RKAJVZB3ZJoW2kazBpMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEu\nMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEb\nMBkGA1UEAwwSS0lTQSBUZXN0IFJvb3RDQSA0ggEQMB0GA1UdDgQWBBRjLMfuvvez\ntTr5nwU3L0RA6qcvYTAOBgNVHQ8BAf8EBAMCAQYwfAYDVR0gAQH/BHIwcDBuBgRV\nHSAAMGYwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9yLmtyL3JjYS9j\ncHMuaHRtbDAyBggrBgEFBQcCAjAmHiTHdAAgx3jJncEcspQAIMLc1djGqQAgx3jJ\nncEcx4WyyLLkAC4wLgYDVR0RBCcwJaAjBgkqgxqMmkQKAQGgFjAUDBLtlZzqta3s\noJXrs7Tsnbjspp0wEgYDVR0TAQH/BAgwBgEB/wIBADAPBgNVHSQBAf8EBTADgAEA\nMG4GA1UdHwRnMGUwY6BhoF+GXWxkYXA6Ly9mdGNhLnNpZ25nYXRlLmNvbTozODkv\nY249S0lTQVRlc3RSb290Q0E0LE9VPVJPT1RDQSxPPUtJU0EsQz1LUj9hdXRob3Jp\ndHlSZXZvY2F0aW9uTGlzdDANBgkqhkiG9w0BAQUFAAOCAQEAjclOKUwPauhbpC/n\niq5VFBYBz9LLrv6dAtmYcnh6+s7I3swQYpqCNThAmvofaLPLj/lcHtDrmaT1jikt\nrSx0EuZ1QC+Bfyomvxzi8Px7VYpyz3cPMzNVX7UVinv76Ean4HLpN1XQ2fKxlcLs\nBWMPXZlUKMf3lJ6pnq5elSQkbfc4gO9l2aeFhj643mhO2opJ6shKYtqUEs5W4PUR\nAIZY5F65PHssSLOQjnakKf05r2tsUMxnx3RlxE2YAVc1EOnUGxP0WFazY2A9vwpt\nAPTNyVsViUrWODhs/dWZymImw1O5eru+4SjzCmhbh/6yax694h6hHG/79p8N6kxO\nj+9sJg==\n-----END CERTIFICATE-----\n";
var testSignKorea_3280 = "-----BEGIN CERTIFICATE-----\nMIIFQzCCBCugAwIBAgICJ6gwDQYJKoZIhvcNAQEFBQAwaTELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktJU0EgVGVzdCBSb290Q0EgNDAeFw0w\nNTA5MTUwOTA5NDRaFw0xMDA5MTUwOTA5NDRaMFQxCzAJBgNVBAYTAktSMRIwEAYD\nVQQKDAlTaWduS29yZWExFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEaMBgGA1UEAwwR\nU2lnbktvcmVhIFRlc3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB\nAQCvU26tn++7HrTCH8aBuNPLpJ0tD+9SWeM1AYTsQ1FQUrv9Po+2jIaO+0a9dVLs\ninMBpScHWKf2wDgSNBswrvAmY6sgGKD6vp+Fm24j0iWZ+ZxOTlMplvrXYd0ooZu1\nVXcEDJV+jqe6NNMUX61LVdSaSlTIOsd5ReisTkYtCdd0LswlOPAa+QaMPu+OGDbN\n8EIL/u0XqQLNC475Q1Cl9oJ3MHH0Uq1HUiwtEXy8vuEUW84ZfiqDFcApDH+K4F/F\nLc06ybJagS3ltM0flhGDM9lyz9axSdv6H7b5v7SMEw7SNFQWfGi9IexvbHQsFdP/\n/ocv5dPMNacVRDI11Jtbq3MfAgMBAAGjggIIMIICBDCBkwYDVR0jBIGLMIGIgBQl\nh98+GBySwGwulnfUSgCVWQd2SaFtpGswaTELMAkGA1UEBhMCS1IxDTALBgNVBAoM\nBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENl\nbnRyYWwxGzAZBgNVBAMMEktJU0EgVGVzdCBSb290Q0EgNIIBEDAdBgNVHQ4EFgQU\nSUJok//3UPYCznpFad1EG/nSe0YwDgYDVR0PAQH/BAQDAgEGMHwGA1UdIAEB/wRy\nMHAwbgYEVR0gADBmMDAGCCsGAQUFBwIBFiRodHRwOi8vd3d3LnJvb3RjYS5vci5r\nci9yY2EvY3BzLmh0bWwwMgYIKwYBBQUHAgIwJh4kx3QAIMd4yZ3BHLKUACDC3NXY\nxqkAIMd4yZ3BHMeFssiy5AAuMCoGA1UdEQQjMCGgHwYJKoMajJpECgEBoBIwEAwO\nKOyjvCnsvZTsiqTsvaQwEgYDVR0TAQH/BAgwBgEB/wIBADAPBgNVHSQBAf8EBTAD\ngAEAMG4GA1UdHwRnMGUwY6BhoF+GXWxkYXA6Ly8yMTEuMTc1LjgxLjEwMjo2ODkv\nY249VEVTVC1ST09ULVJTQS1DUkwxLG91PVJPT1RDQSxvPUtJU0EsYz1LUj9hdXRo\nb3JpdHlSZXZvY2F0aW9uTGlzdDANBgkqhkiG9w0BAQUFAAOCAQEAGZxC3wQEovtR\naa5L/crlHwWhPbJQRuzspBed2IuyYnMsKy/cZsqiQtZfk1KdtIs+D5024l33FPbT\natECiHPx9uHe5K0+Cgf3DhPh+pg67QB1n6gptObMygUHwUZPP4vuDe6lE+IeKRDh\nj8R/DfTFd7yK0t6FNDiZdxEJ8Wb+4No0Hl/gPf78aCDx1Rk1eTR8tNvPepo1rkc2\ntWDnyeSY23RGCCteAKF2JoSeNI7PE2qhNB+KdKHo7HrcYEfo6OBRejMhanitJW0D\nOar3Utgo4vBe1T5UboNskphrlj0/r3mX7I6tJjYJMOZgdQ4hlV4QZla7Ghz3uHwx\nXoyQxb5M4Q==\n-----END CERTIFICATE-----\n";
var testTradeSign_3280 = "-----BEGIN CERTIFICATE-----\nMIIFcjCCBFqgAwIBAgICJ6kwDQYJKoZIhvcNAQEFBQAwaTELMAkGA1UEBhMCS1Ix\nDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0\naG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktJU0EgVGVzdCBSb290Q0EgNDAeFw0w\nNTA5MTUwOTEwMTdaFw0xMDA5MTUwOTEwMTdaMFIxCzAJBgNVBAYTAktSMRIwEAYD\nVQQKDAlUcmFkZVNpZ24xFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEYMBYGA1UEAwwP\nVGVzdFRyYWRlU2lnbkNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA\n2B/bK+ShXu7kBrcC6BjkltMNfPnJot+Tz3NCVxhU0YfY4cI9aTx/xUW+1y1ZX+Nv\nElmBZlEAdacCuDpnzLjP+GKlXQPw6cpAnomQ6nEUUigBTxlcrRaIXL0XyAaLLAtg\nmucAdtsOJJqvyzYQQw1l0KhseJ5gey2DoASd7GF9aiB7o5idikaf/ZtiWmErK7PZ\n2dyluKZZWABiP75ivnT5k/IecO4yCMyT7Rvbc0o7+NqoxNAfZ172id6yQSJ7B0X9\n2ZxGqTfKpXB1Cf3dHjPXPElBrZu2GZ33TAyKJkxeFid754GYwvhJORWfMEMGHF41\nC2T7/reor8MyEfqR/Jhj8wIDAQABo4ICOTCCAjUwgZMGA1UdIwSBizCBiIAUJYff\nPhgcksBsLpZ31EoAlVkHdkmhbaRrMGkxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARL\nSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50\ncmFsMRswGQYDVQQDDBJLSVNBIFRlc3QgUm9vdENBIDSCARAwHQYDVR0OBBYEFLI7\nJm2WMVMZn3pS6f5DkxbcrG21MA4GA1UdDwEB/wQEAwIBBjB8BgNVHSABAf8EcjBw\nMG4GBFUdIAAwZjAwBggrBgEFBQcCARYkaHR0cDovL3d3dy5yb290Y2Eub3Iua3Iv\ncmNhL2Nwcy5odG1sMDIGCCsGAQUFBwICMCYeJMd0ACDHeMmdwRyylAAgwtzV2Map\nACDHeMmdwRzHhbLIsuQALjA5BgNVHREEMjAwoC4GCSqDGoyaRAoBAaAhMB8MHSjs\no7wp7ZWc6rWt66y07Jet7KCV67O07Ya17IugMBIGA1UdEwEB/wQIMAYBAf8CAQAw\nDwYDVR0kAQH/BAUwA4ABADCBjwYDVR0fBIGHMIGEMIGBoH+gfYZ7bGRhcDovLzIx\nMC4xMDIuNzcuMTg3OjM4OS9DTj1URVNULVJPT1QtUlNBLUNSTCxPVT1Lb3JlYSBD\nZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsLE89S0lTQSxDPUtSP2F1dGhv\ncml0eVJldm9jYXRpb25MaXN0MA0GCSqGSIb3DQEBBQUAA4IBAQAoVuoDMMgnzOMl\n225j7xGna665MmzPH/2gsrwzp2bddA8I6z5Rus2GUmVdG2DPVTzCEWAS6KkVVES1\n+JiGRd/O7Bai+AFMoo8ufelipVTxgF+S0qv/OSzWaTLNR/D+9MrzLeZZ1wiFxfL4\nQg1DuThEszBAXb861gCqCKMBAypMoEaIjj/XSufp2KFJdihkwLbi1Rrl7zGppq1S\nWA2LSYR3jZL4J18mfyi4ZyFWFPnXA4EhA5OxSHHQ0eMcl6F5eEVOevwLrwEcdXKo\nqyga4f2fRT/TaTgTFa6M0MZ9FeVH+0jsBWZOOSLb5SewSNohVa3LIoUSAarR5C+G\nGslCtPSh\n-----END CERTIFICATE-----\n";
var testYessign_08 = "-----BEGIN CERTIFICATE-----\nMIIFSTCCBDGgAwIBAgIBCDANBgkqhkiG9w0BAQsFADBpMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA2MB4XDTE1MTIyMjA1MTMyNFoXDTI1MTIyMjA1MTMyNFowVzELMAkGA1UEBhMCa3IxEDAOBgNVBAoMB3llc3NpZ24xFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEfMB0GA1UEAwwWeWVzc2lnbkNBLVRlc3QgQ2xhc3MgMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMLQGMF8YsirEXeGkoOh+r/90pmYt0oc4gkgK/5vFyW6f9F0W9evJ9yqzUrEiZ7gBkENKuv/xoOx70AALT9qYXnaWsIDYbrgfEFC5TyexKR3alWyuUQmsm/QDNgjNCMZ/3Xj4qc5DkOp86oj71x9g9sBg8tes4sH77Dm3qGNH0T83FnWjcNb+itqpliQ4UCRRp5aniAs1vmwhvxDmAobpnT0jgqnk5jvzo7McwF8BLFNTnhZXrejZx1orIREaIxHAAvlft5+1dW+66kkhlMNf3Uu1VLRs/o7s0OK+gIP39n7872Dm2bBm697l3tO+mGyMN8ari0aYMGTkfLuIzF/wwECAwEAAaOCAgwwggIIMIGTBgNVHSMEgYswgYiAFJwGJECLicN7T9wfd7B3OnvqGnKooW2kazBpMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA2ggEBMB0GA1UdDgQWBBRw+n2Dw0UfFJrv8Cg+E4xduwULlDAOBgNVHQ8BAf8EBAMCAQYwfAYDVR0gAQH/BHIwcDBuBgRVHSAAMGYwMAYIKwYBBQUHAgEWJGh0dHA6Ly93d3cucm9vdGNhLm9yLmtyL3JjYS9jcHMuaHRtbDAyBggrBgEFBQcCAjAmHiTHdAAgx3jJncEcspQAIMLc1djGqQAgx3jJncEcx4WyyLLkAC4wKwYDVR0RBCQwIqAgBgkqgxqMmkQKAQGgEzARDA/quIjsnLXqsrDsoJzsm5AwEgYDVR0TAQH/BAgwBgEB/wIBADAPBgNVHSQBAf8EBTADgAEAMHEGA1UdHwRqMGgwZqBkoGKGYGxkYXA6Ly9zbm9vcHkueWVzc2lnbi5vci5rcjo2MDIwL2NuPUtJU0EtVEVTVC1BUkw1LG91PVJPT1RDQSxvPUtJU0EsYz1LUj9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdDANBgkqhkiG9w0BAQsFAAOCAQEABFwXbGsEtqvSIKk+pJEAlW3YhwGdkucnzbTRH/Q4GH/cb8NXYSGN4UuS0aMaYBuxwaTt3SOsFmvf3dMO97v61SEUYqayvab8FvKoLrm34LdIjYgqeDxikJD7TzblVnDvlT4PVxxUPdoh0zN7YLbgn63m2op5QjM0es9grlF2wP8efAnQuql1sS5sBB+hEwmDhNvlfhFFU+9k87yezoomxwjp/4FnpIaoxeOLto3/O2g2uvlrOzr+d7TEv2qbCINNjE35wZg+6o2jU+mb+SKFGbIlpvde6bYqkqSm4UiH1oJG3vpiuKMYi3k6LFX9/URfd+k0w44fgzf04brWwP49XA==\n-----END CERTIFICATE-----\n";

/************************************************************
 * @brief		CA 인증서 목록 (REAL NPKI)
 ************************************************************/
var realNpkiCACert = "";
realNpkiCACert += realSignKorea_2048 + realSignKorea_2048_1020;
realNpkiCACert += realYessign_2048 + realYessign_2048_101C;
realNpkiCACert += realCrossCert_2048 + realCrossCert_2048_101E;
realNpkiCACert += realTradeSign_2048 + realTradeSign_2048_101F;
realNpkiCACert += realSignGate_2048 + realSignGate_2048_101D;
realNpkiCACert += realSignKorea_CA3 + realSignGate_CA5;
realNpkiCACert += realCrossCertCA3 + realTradeSignCA3;

/************************************************************
 * @brief		CA 인증서 목록 (REAL GPKI)
 ************************************************************/
var realGpkiCACert = "";
realGpkiCACert += realGpki_01 + realGpki_2712;
realGpkiCACert += realGpki_2713 + realGpki_2714;
realGpkiCACert += realGpki_2715 + realGpki_2716;
realGpkiCACert += realGpki_2717 + realGpki_2719;

/************************************************************
 * @brief		CA 인증서 목록 (TEST NPKI)
 ************************************************************/
var testNpkiCACert = "";
testNpkiCACert += testCrossCert_2048 + testCrossCert_3280;
testNpkiCACert += testSignGate_2048 + testSignGate_3280;
testNpkiCACert += testSignKorea_2048 + testSignKorea_3280;
testNpkiCACert += testTradeSign_2048 + testTradeSign_3280;
testNpkiCACert += testYessign_2048 + testYessign_3280 + testYessign_08;

/************************************************************
 * @brief		CA 인증서 목록
 ************************************************************/
var CACert;

// CA 인증서 목록: 신한은행 개발 서버 (Real + Test)
if (window.location.host == CW_DEV_HOST) {
	CACert = realNpkiCACert + testNpkiCACert + realGpkiCACert;

	// CA 인증서 목록: 신한은행 테스트 서버 (Real + Test)
} else if (window.location.host == CW_TEST_HOST) {
	CACert = realNpkiCACert + testNpkiCACert + realGpkiCACert;

	// CA 인증서 목록: 신한은행 운영 서버 (Real)
} else if (window.location.host == CW_REAL_HOST) {
	CACert = realNpkiCACert + realGpkiCACert;

	// CA 인증서 목록: 기타 (Real + Test)
} else {
	CACert = realNpkiCACert + testNpkiCACert + realGpkiCACert;
}

/************************************************************
 * @brief		HTML5 지원여부
 * @param[in]	isHtml5			HTML5 지원여부
 * @retval		true			HTML5 지원
 * @retval		false			HTML5 지원 안함
 ************************************************************/
function isSupportHtml5(isHtml5) {
	if (isHtml5 && GINI_supportHtml5()) {
		return true;
	} else {
		return false;
	}
}

/************************************************************
 * @brief		초기화 및 모듈 설치
 * @param[in]	url				VCS URL
 * @param[in]	callback		콜백 함수
 ************************************************************/
function InstallModule(url, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.InstallModule(url, callback);
		});
	}
}

/************************************************************
 * @brief		인증서 캐쉬 초기화
 * @param[in]	callback		콜백 함수
 ************************************************************/
function InitCache(callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.InitCache(callback);
		});
	}
}

/************************************************************
 * @brief		세션 재설정
 * @param[in]	callback		콜백 함수
 ************************************************************/
function ReSession(callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.ReSession(callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	time1			
 * @param[in]	time2			
 * @param[in]	callback		콜백 함수
 ************************************************************/
function SetVerifyNegoTime(time1, time2, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.SetVerifyNegoTime(time1, time2, callback);
		});
	}
}

/************************************************************
 * @brief		CA 인증서 로드
 * @param[in]	cert			CA 인증서
 * @param[in]	callback		콜백 함수
 ************************************************************/
function LoadCACert(cert, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.LoadCACert(cert, callback);
		});
	}
}

/************************************************************
 * @brief		로고 이미지 설정
 * @param[in]	logoUrl			로고 이미지 URL
 * @param[in]	callback		콜백 함수
 ************************************************************/
function SetLogoPath(logoUrl, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.SetLogoPath(logoUrl, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	gap				
 * @param[in]	callback		콜백 함수
 ************************************************************/
function SetCacheTime(gap, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.SetCacheTime(gap, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	check			
 * @param[in]	callback		콜백 함수
 ************************************************************/
function EnableCheckCRL(check, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EnableCheckCRL(check, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	check			
 * @param[in]	callback		콜백 함수
 ************************************************************/
function DisableInvalidCert(check, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.DisableInvalidCert(check, callback);
		});
	}
}

/************************************************************
 * @brief		정책 설정
 * @param[in]	name			이름
 * @param[in]	value			값
 * @param[in]	callback		콜백함수
 ************************************************************/
function SetProperty(name, value, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.SetProperty(name, value, callback);
		});
	}
}

/************************************************************
 * @brief		정책 추가
 * @param[in]	name			이름
 * @param[in]	value			값
 ************************************************************/
function SetPropertyAdd(name, value, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.SetPropertyAdd(name, value);
		});
	}
}

/************************************************************
 * @brief		정책 실행
 * @param[in]	callback		콜백 함수
 ************************************************************/
function SetPropertyEX(callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.SetPropertyEX(callback);
		});
	}
}

/************************************************************
 * @brief		정책 실행
 * @param[in]	params			파라미터
 * @param[in]	callback		콜백 함수
 ************************************************************/
function SetPropertyArr(params, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.SetPropertyArr(params, callback);
		});
	}
}

/************************************************************
 * @brief		정책 취득
 * @param[in]	name			이름
 * @param[in]	callback		콜백함수
 ************************************************************/
function GetProperty(name, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.GetProperty(name, callback);
		});
	}
}

/************************************************************
 * @brief		URL 인코드
 * @param[in]	data			데이터
 ************************************************************/
function URLEncode(data) {
	if (!data) return "";
	return encodeURIComponent(data);
}

/************************************************************
 * @brief		URL 디코드
 * @param[in]	data			데이터
 * @param[in]	callback		콜백함수
 ************************************************************/
function URLDecode(data, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.URLDecode(data, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	name			이름
 * @param[in]	value			값
 * @param[in]	callback		콜백 함수
 ************************************************************/
function ICCSetOption(name, value, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.ICCSetOption(name, value, callback);
		});
	}
}

/************************************************************
 * @brief		인증서 내보내기
 * @param[in]	url				인증서 내보내기 URL
 * @param[in]	callback		콜백 함수
 ************************************************************/
function ICCSendCert(url, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.ICCSendCert(url, callback);
		});
	}
}

/************************************************************
 * @brief		인증서 가져오기
 * @param[in]	url				인증서 가져오기 URL
 * @param[in]	callback		콜백 함수
 ************************************************************/
function ICCRecvCert(url, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.ICCRecvCert(url, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	form
 * @param[in]	start
 * @param[in]	bErase
 ************************************************************/
function GatherValue(form, start, bErase, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.GatherValue(form, start, bErase);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	form
 * @param[in]	start
 * @param[in]	bErase
 ************************************************************/
function GatherFileValue(form, start, bErase, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.GatherFileValue(form, start, bErase);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	data
 * @param[in]	delimiter
 ************************************************************/
function SplitValue(data, delimiter, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.SplitValue(data, delimiter);
		});
	}
}

/************************************************************
 * @brief		UTF-8 decoding params -> euc-kr encoding params
 * @param[in]	str
 * @param[in]	exceptStr
 ************************************************************/
function iniConvert(str, exceptStr, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.iniConvert(str, exceptStr);
		});
	}
}

/************************************************************
 * @brief		euc-kr parameter split encoding
 * @param[in]	data
 ************************************************************/
function iniSplitEncode(data, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.iniSplitEncode(data);
		});
	}
}

/************************************************************
 * @brief		utf-8 encoding params -> euc-kr encoding params convert
 * @param[in]	signData
 * @param[in]	signParamName
 ************************************************************/
function convertEncode7(signData, signParamName, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.convertEncode7(signData, signParamName);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	cert
 * @param[in]	callback		콜백 함수
 ************************************************************/
function ViewCert(cert, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.ViewCert(cert, callback);
		});
	}
}

/************************************************************
 * @brief		서버 인증서 로드
 * @param[in]	cert			서버 인증서
 * @param[in]	callback		콜백 함수
 ************************************************************/
function LoadCert(cert, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.LoadCert(cert, callback);
		});
	}
}

/************************************************************
 * @brief		데이터 복호화
 * @param[in]	data			데이터
 * @param[in]	callback		콜백 함수
 ************************************************************/
function Idecrypt(data, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.Idecrypt(data, callback);
		});
	}
}

/************************************************************
 * @brief		암호화된 SPAN 요소 취득
 * @retval		object			암호화된 SPAN 요소
 ************************************************************/
function getSpanEncElement(isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.getSpanEncElement();
		});
	}
}

/************************************************************
 * @brief		블록 복호화
 * @param[in]	callback		콜백 함수
 ************************************************************/
function IdecryptBlock(callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.IdecryptBlock(callback);
		});
	}
}

/************************************************************
 * @brief		프로세스 공유 속성 설정
 * @param[in]	name			이름
 * @param[in]	value			값
 * @param[in]	callback		콜백 함수
 ************************************************************/
function setSharedAttribute(name, value, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.setSharedAttribute(name, value, callback);
		});
	}
}

/************************************************************
 * @brief		프로세스 공유 속성 취득
 * @param[in]	name			이름
 * @param[in]	callback		콜백 함수
 ************************************************************/
function getSharedAttribute(name, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.getSharedAttribute(name, callback);
		});
	}
}

/************************************************************
 * @brief		확장 함수
 * @param[in]	name			이름
 * @param[in]	value			값
 * @param[in]	callback		콜백 함수
 ************************************************************/
function ExtendMethod(name, value, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.ExtendMethod(name, value, callback);
		});
	}
}

/************************************************************
 * @brief		인증서 필터
 * @param[in]	storage			인증서 저장소
 * @param[in]	issuerAndSerial	인증서 발급자 및 시리얼 번호
 * @param[in]	callback		콜백 함수
 ************************************************************/
function FilterCert(storage, issuerAndSerial, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.FilterCert(storage, issuerAndSerial, callback);
		});
	}
}

/************************************************************
 * @brief		사용자 인증서 필터
 * @param[in]	storage			인증서 저장소
 * @param[in]	issuerAndSerial	인증서 발급자 및 시리얼 번호
 * @param[in]	callback		콜백 함수
 ************************************************************/
function FilterUserCert(storage, issuerAndSerial, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.FilterUserCert(storage, issuerAndSerial, callback);
		});
	}
}

/************************************************************
 * @brief		인증서 캐쉬 여부 취득
 * @param[in]	callback		콜백 함수
 ************************************************************/
function IsCachedCert(callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.IsCachedCert(callback);
		});
	}
}

/************************************************************
 * @brief		캐쉬 인증서 취득
 * @param[in]	name			이름
 * @param[in]	callback		콜백 함수
 ************************************************************/
function GetCachedCert(name, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.GetCachedCert(name, callback);
		});
	}
}

/************************************************************
 * @brief		구간 암호화
 * @param[in]	vf				
 * @param[in]	data			
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 ************************************************************/
function MakeINIpluginData(vf, data, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.MakeINIpluginData(vf, data, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	data			
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 ************************************************************/
function EncParams(data, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncParams(data, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	form			
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 ************************************************************/
function EncForm(form, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncForm(form, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	readForm		
 * @param[in]	sendForm		
 * @param[in]	callback		
 * @param[in]	postdata		
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function EncForm2(readForm, sendForm, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.EncForm2(readForm, sendForm, callback, postdata);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncForm2(readForm, sendForm, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	url				
 * @param[in]	data			
 * @param[in]	target			
 * @param[in]	style			
 ************************************************************/
function EncLink(url, data, target, style, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncLink(url, data, target, style);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	indata			
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 ************************************************************/
function EncLocation(indata, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncLocation(indata, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	form			
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 ************************************************************/
function EncFormVerify(form, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncFormVerify(form, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	readForm		
 * @param[in]	sendForm		
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 ************************************************************/
function EncFormVerify2(readForm, sendForm, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.EncFormVerify2(readForm, sendForm, callback, postdata);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncFormVerify2(readForm, sendForm, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	form			
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 ************************************************************/
function NoCertVerify(form, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.NoCertVerify(form, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	readForm		
 * @param[in]	sendForm		
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function NoCertVerify2(readForm, sendForm, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.NoCertVerify2(readForm, sendForm, callback, postdata);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.NoCertVerify2(readForm, sendForm, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		전자서명
 * @param[in]	readForm		전자서명 폼
 * @param[in]	data			전자서명 원문
 * @param[in]	callback		전자서명 콜백함수
 * @param[in]	postdata		
 * @param[in]	isHtml5			HTML5 지원여부
 * @param[in]	isInnerView		INNER 지원여부
 ************************************************************/
function PKCS7SignedData(data, callback, postdata, isHtml5, isInnerView) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.PKCS7SignedDataSign(data, callback, postdata, isInnerView);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignedData(data, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		전자서명
 * @param[in]	form			
 * @param[in]	data			원문
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 * @param[in]	isHtml5			HTML5 지원여부
 * @param[in]	isInnerView		INNER 지원여부
 ************************************************************/
function PKCS7SignedDataForm(form, data, callback, postdata, isHtml5, isInnerView) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.PKCS7SignedDataForm(form, data, callback, postdata, isInnerView);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignedDataForm(form, data, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		전자서명 (VID)
 * @param[in]	data			전자서명 원문
 * @param[in]	callback		전자서명 콜백함수
 * @param[in]	postdata		
 * @param[in]	isHtml5			HTML5 지원여부
 * @param[in]	isHtml5			CMP 지원여부
 ************************************************************/
function PKCS7SignVIDData(data, callback, postdata, isHtml5, isCmp) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.PKCS7SignedLogin(data, callback, postdata, isCmp);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignVID(data, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		전자서명 (VID)
 * @param[in]	data			
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 ************************************************************/
function PKCS7SignVID(data, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignVID(data, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		전자서명 (VID)
 * @param[in]	readForm		전자서명 폼
 * @param[in]	data			전자서명 원문
 * @param[in]	callback		전자서명 콜백함수
 * @param[in]	postdata		
 * @param[in]	isHtml5			HTML5 지원여부
 * @param[in]	isHtml5			CMP 지원여부
 ************************************************************/
function PKCS7SignVIDForm(form, data, callback, postdata, isHtml5, isCmp) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.PKCS7SignVIDFormLogin(form, data, callback, postdata, isCmp);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignVIDForm(form, data, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		전자서명 (PDF)
 * @param[in]	data			전자서명 원문
 * @param[in]	callback		전자서명 콜백함수
 * @param[in]	postdata		
 * @param[in]	isHtml5			HTML5 지원여부
 * @param[in]	isInnerView		INNER 지원여부
 ************************************************************/
function PKCS7SignedDataWithMD(data, callback, postdata, isHtml5, isInnerView) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.PKCS7PDFSignData(data, callback, postdata);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignedDataWithMD(data, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		전자서명 (PDF)
 * @param[in]	form			전자서명 폼
 * @param[in]	data			전자서명 원문
 * @param[in]	callback		전자서명 콜백함수
 * @param[in]	postdata		
 * @param[in]	isHtml5			HTML5 지원여부
 * @param[in]	isInnerView		INNER 지원여부
 ************************************************************/
function PKCS7SignedDataWithMDForm(form, data, callback, postdata, isHtml5, isInnerView) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignedDataWithMDForm(data, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		전자서명 (금결원 형식)
 * @param[in]	data			전자서명 원문
 * @param[in]	callback		전자서명 콜백함수
 * @param[in]	postdata		
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function PKCS7YesSignData(data, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.PKCS7YesSignData(data, callback, postdata);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignedData(data, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		다건 전자서명
 * @param[in]	form			다건 전자서명 폼
 * @param[in]	dataArr			다건 전자서명 원문 리스트
 * @param[in]	callback		다건 전사서명 콜백 함수
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function PKCS7SignedDataMultiForm(form, dataArr, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignedDataMultiForm(form, dataArr, callback);
		});
	}
}

/************************************************************
 * @brief		다건 전자서명 (VID)
 * @param[in]	form			다건 전자서명 폼
 * @param[in]	dataArr			다건 전자서명 원문 리스트
 * @param[in]	callback		다건 전사서명 콜백 함수
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function PKCS7SignVIDMultiForm(form, dataArr, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 지원 안함
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignedDataWithVIDMultiForm(form, dataArr, callback);
		});
	}
}

/************************************************************
 * @brief		다건 전자서명 (VID)
 * @param[in]	form			다건 전자서명 폼
 * @param[in]	dataArr			다건 전자서명 원문 리스트
 * @param[in]	callback		다건 전사서명 콜백 함수
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function PKCS7SignedDataWithVIDMultiForm(form, dataArr, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 지원 안함
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignedDataWithVIDMultiForm(form, dataArr, callback);
		});
	}
}

/************************************************************
 * @brief		다건 전자서명 (PDF)
 * @param[in]	form			다건 전자서명 폼
 * @param[in]	dataArr			다건 전자서명 원문 리스트
 * @param[in]	callback		다건 전사서명 콜백 함수
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function PKCS7SignedDataWithMDMultiForm(form, dataArr, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.PKCS7SignedDataWithMDMultiForm(form, dataArr, callback);
		});
	}
}

/************************************************************
 * @brief		파일 선택
 * @param[in]	field			선택 파일 경로
 ************************************************************/
function SelFile(field, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.SelFile(field);
		});
	}
}

/************************************************************
 * @brief		암호화 파일 업로드
 * @param[in]	url				업로드 URL
 * @param[in]	form			
 * @param[in]	callback		콜백 함수
 ************************************************************/
function EncFile(url, form, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncFile(url, form, callback);
		});
	}
}

/************************************************************
 * @brief		암호화 파일 다운로드
 * @param[in]	url				다운로드 URL
 * @param[in]	args			
 * @param[in]	callback		콜백 함수
 ************************************************************/
function EncDown(url, args, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncDown(url, args, callback);
		});
	}
}

/************************************************************
 * @brief		인증서 발급
 * @param[in]	caName			발급기관
 * @param[in]	szRef			참조코드
 * @param[in]	szCode			인가코드
 * @param[in]	callback		인증서 발급 콜백함수
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function IssueCertificate(caName, szRef, szCode, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.IssueCertificate(caName, szRef, szCode, callback);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.IssueCertificate(caName, szRef, szCode, callback);
		});
	}
}

/************************************************************
 * @brief		인증서 재발급
 * @param[in]	caName			발급기관
 * @param[in]	szRef			참조코드
 * @param[in]	szCode			인가코드
 * @param[in]	callback		인증서 재발급 콜백함수
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function ReIssueCertificate(caName, szRef, szCode, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.ReIssueCertificate(caName, szRef, szCode, callback);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.ReIssueCertificate(caName, szRef, szCode, callback);
		});
	}
}

/************************************************************
 * @brief		인증서 갱신
 * @param[in]	caName			발급기관
 * @param[in]	callback		인증서 갱신 콜백함수
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function UpdateCertificate(caName, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.UpdateCertificate(caName, callback);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.UpdateCertificate(caName, callback);
		});
	}
}

/************************************************************
 * @brief		인증서 폐기
 * @param[in]	caName			발급기관
 * @param[in]	serial			인증서 시리얼 번호
 * @param[in]	callback		인증서 폐기 콜백함수
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function RevokeCertificate(caName, serial, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.RevokeCertificate(caName, serial, callback);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.RevokeCertificate(caName, serial, callback);
		});
	}
}

/************************************************************
 * @brief		인증서 발급 (INITECH)
 * @param[in]	szRef			참조 코드
 * @param[in]	szCode			인가 코드
 * @param[in]	callback		콜백 함수
 ************************************************************/
function INITECHCA_IssueCertificate(szRef, szCode, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.INITECHCA_IssueCertificate(szRef, szCode, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	frm				
 * @param[in]	callback		콜백 함수
 ************************************************************/
function CertRequest(frm, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.CertRequest(frm, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	cert			
 * @param[in]	callback		콜백 함수
 ************************************************************/
function InsertUserCert(cert, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.InsertUserCert(cert, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	cert			
 * @param[in]	callback		콜백 함수
 ************************************************************/
function DeleteUserCert(cert, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.DeleteUserCert(cert, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	callback		콜백 함수
 ************************************************************/
function InsertCerttoMS(callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.InsertCerttoMS(callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	cert			인증서
 * @param[in]	callback		콜백 함수
 ************************************************************/
function InsertCACertToSystem(cert, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.InsertCACertToSystem(cert, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	BSCert			
 * @param[in]	form			
 * @param[in]	callback		콜백 함수
 ************************************************************/
function makeSK(BSCert, form, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.makeSK(BSCert, form, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	name			
 * @param[in]	form			
 * @param[in]	callback		콜백 함수
 ************************************************************/
function EncryptToSK(name, form, callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncryptToSK(name, form, callback);
		});
	}
}

/************************************************************
 * @brief		
 * @param[in]	BSCert			
 * @param[in]	nameArr			
 * @param[in]	form			
 * @param[in]	callback		콜백 함수
 * @param[in]	postdata		
 ************************************************************/
function EncryptAfterMakeSK(BSCert, nameArr, form, callback, postdata, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.EncryptAfterMakeSK(BSCert, nameArr, form, callback, postdata);
		});
	}
}

/************************************************************
 * @brief		인증서 가져오기 (v1.1)
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function CertImportV11WithForm(isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.CertImportV11WithForm();
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.CertImportV11WithForm();
		});
	}
}

/************************************************************
 * @brief		인증서 내보내기 (v1.1)
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function CertExportV11WithForm(isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.CertExportV11WithForm();
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.CertExportV11WithForm();
		});
	}
}

/************************************************************
 * @brief		인증서 가져오기 (v1.2)
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function CertImportV12WithForm(isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.CertImportV12WithForm();
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.CertImportV12WithForm();
		});
	}
}

/************************************************************
 * @brief		인증서 내보내기 (v1.2)
 * @param[in]	isHtml5			HTML5 지원여부
 ************************************************************/
function CertExportV12WithForm(isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.CertExportV12WithForm();
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.CertExportV12WithForm();
		});
	}
}

/************************************************************
 * @brief		인증서 관리
 * @param[in]	isHtml5			HTML5 지원여부
 * @param[in]	taskNm			
 ************************************************************/
function CertManagerWithForm(isHtml5, taskNm, callback) {
	if (isSupportHtml5(isHtml5)) {
		Html5Adaptor.CertManagerWithForm(taskNm);
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.ManageCert(callback);
		});
	}
}

/************************************************************
 * @brief		인증서 관리
 * @param[in]	callback		콜백 함수
 ************************************************************/
function ManageCert(callback, isHtml5) {
	if (isSupportHtml5(isHtml5)) {
		// 없음
	} else {
		// 설치 체크 대기
		cwModuleInstallWait(function () {
			CrossWebExWeb6.ManageCert(callback);
		});
	}
}

/************************************************************
 * @brief		HTML5 인터페이스 호출
 * @param[in]	param			HTML5 인터페이스 파라미터
 * @param[in]	callback		HTML5 인터페이스 콜백함수
 ************************************************************/
function CWEXRequestCmd(params, callback) {
	// 설치 체크 대기
	cwModuleInstallWait(function () {
		CrossWebExWeb6.CWEXRequestCmd(params, callback);
	});
}