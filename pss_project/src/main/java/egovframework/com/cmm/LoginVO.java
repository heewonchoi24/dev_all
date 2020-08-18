package egovframework.com.cmm;

import java.io.Serializable;

public class LoginVO implements Serializable{
	
	private static final long serialVersionUID = -8274004534207618049L;
	
	/** 사용자 id */
	private String userId;
	/** 사용자 명 */
	private String userNm;
	/** 비밀번호 */
	private String password;
	/** 기관코드 */
	private String insttCd;
	/** 기관명 */
	private String insttNm;
	/** 부서 */
	private String dept;
	/** 직급 */
	private String clsf;
	/** 직책 */
	private String rspofc;
	/** 담당업무 코드 */
	private String chrgDutyCd;
	/** 휴대폰 번호 */
	private String moblphonNo;
	/** 전화번호 */
	private String telNo;
	/** 내선번호 */
	private String lxtnNo;
	/** 이메일 */
	private String email;
	/** 공인인증서 */
	private String ogcr;
	/** 승인여부 */
	private String confmYn;
	/** 상태코드 */
	private String statusCd;
	/** 반려사유 */
	private String returnResn;
	/** 점검원시작일자 */
	private String insctrBgnde;
	/** 점검원종료일자 */
	private String insctrEndde;
	/** 점검기간여부(점검원인 경우에만 체크) */
	private String insctrPdYn;
	/** 점검원 접속 승인IP(점검원인 경우에만 체크) */
	private String permIp;
	/** 기관별 접속 승인IP(점검원 이외 사용자 체크) */
	private String insttPermIp;
	/** 비밀번호변경일시 */
	private String passwordChangeDt;
	/** 권한 id */
	private String authorId;
	/** 약관동의여부 */
	private String stplatAgreYn;
	/** 최종로그인일시 */
	private String lastLoginDt;
	/** 비밀번호오류횟수 */
	private int passwordErrCnt;
	/** 최종 비밀번호오류후 경과시간(초) */
	private int passwordErrTerm;
	/** 기관구분 */
	private String insttClCd;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getInsttCd() {
		return insttCd;
	}
	public void setInsttCd(String insttCd) {
		this.insttCd = insttCd;
	}
	public String getInsttNm() {
		return insttNm;
	}
	public void setInsttNm(String insttNm) {
		this.insttNm = insttNm;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getClsf() {
		return clsf;
	}
	public void setClsf(String clsf) {
		this.clsf = clsf;
	}
	public String getRspofc() {
		return rspofc;
	}
	public void setRspofc(String rspofc) {
		this.rspofc = rspofc;
	}
	public String getChrgDutyCd() {
		return chrgDutyCd;
	}
	public void setChrgDutyCd(String chrgDutyCd) {
		this.chrgDutyCd = chrgDutyCd;
	}
	public String getMoblphonNo() {
		return moblphonNo;
	}
	public void setMoblphonNo(String moblphonNo) {
		this.moblphonNo = moblphonNo;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getLxtnNo() {
		return lxtnNo;
	}
	public void setLxtnNo(String lxtnNo) {
		this.lxtnNo = lxtnNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getOgcr() {
		return ogcr;
	}
	public void setOgcr(String ogcr) {
		this.ogcr = ogcr;
	}
	public String getConfmYn() {
		return confmYn;
	}
	public void setConfmYn(String confmYn) {
		this.confmYn = confmYn;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getReturnResn() {
		return returnResn;
	}
	public void setReturnResn(String returnResn) {
		this.returnResn = returnResn;
	}
	public String getInsctrBgnde() {
		return insctrBgnde;
	}
	public void setInsctrBgnde(String insctrBgnde) {
		this.insctrBgnde = insctrBgnde;
	}
	public String getInsctrEndde() {
		return insctrEndde;
	}
	public void setInsctrEndde(String insctrEndde) {
		this.insctrEndde = insctrEndde;
	}
	public String getInsctrPdYn() {
		return insctrPdYn;
	}
	public void setInsctrPdYn(String insctrPdYn) {
		this.insctrPdYn = insctrPdYn;
	}
	public String getPermIp() {
		return permIp;
	}
	public void setPermIp(String permIp) {
		this.permIp = permIp;
	}
	public String getInsttPermIp() {
		return insttPermIp;
	}
	public void setInsttPermIp(String insttPermIp) {
		this.insttPermIp = insttPermIp;
	}
	public String getPasswordChangeDt() {
		return passwordChangeDt;
	}
	public void setPasswordChangeDt(String passwordChangeDt) {
		this.passwordChangeDt = passwordChangeDt;
	}
	public String getAuthorId() {
		return authorId;
	}
	public void setAuthorId(String authorId) {
		this.authorId = authorId;
	}
	public String getStplatAgreYn() {
		return stplatAgreYn;
	}
	public void setStplatAgreYn(String stplatAgreYn) {
		this.stplatAgreYn = stplatAgreYn;
	}
	public String getLastLoginDt() {
		return lastLoginDt;
	}
	public void setLastLoginDt(String lastLoginDt) {
		this.lastLoginDt = lastLoginDt;
	}
	public int getPasswordErrCnt() {
		return passwordErrCnt;
	}
	public void setPasswordErrCnt(int passwordErrCnt) {
		this.passwordErrCnt = passwordErrCnt;
	}
	public int getPasswordErrTerm() {
		return passwordErrTerm;
	}
	public void setPasswordErrTerm(int passwordErrTerm) {
		this.passwordErrTerm = passwordErrTerm;
	}
	public String getInsttClCd() {
		return insttClCd;
	}
	public void setInsttClCd(String insttClCd) {
		this.insttClCd = insttClCd;
	}

}
