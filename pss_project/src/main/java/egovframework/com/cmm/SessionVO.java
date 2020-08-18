package egovframework.com.cmm;

import java.io.Serializable;

@SuppressWarnings("serial")
public class SessionVO implements Serializable {
	/** 사용자 id */
	private String userId;
	/** 사용자 명 */
	private String userNm;
	/** 기관코드 */
	private String insttCd;
	/** 기관명 */
	private String insttNm;
	/** 담당업무 코드 */
	private String chrgDutyCd;
	/** 승인여부 */
	private String confmYn;
	/** 점검원시작일자 */
	private String insctrBgnde;
	/** 점검원종료일자 */
	private String insctrEndde;
	/** 권한 id */
	private String authorId;
	/** 기관구분 */
	private String insttClCd;
	
	private String authRead;
	
	private String authWrite;
	
	private String authDwn;	
	/** 마이라이브러리 */
	private String myLibryYN;
	
	public String getAuthRead() {
		return authRead;
	}
	public void setAuthRead(String authRead) {
		this.authRead = authRead;
	}
	public String getAuthWrite() {
		return authWrite;
	}
	public void setAuthWrite(String authWrite) {
		this.authWrite = authWrite;
	}
	public String getAuthDwn() {
		return authDwn;
	}
	public void setAuthDwn(String authDwn) {
		this.authDwn = authDwn;
	}

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
	public String getChrgDutyCd() {
		return chrgDutyCd;
	}
	public void setChrgDutyCd(String chrgDutyCd) {
		this.chrgDutyCd = chrgDutyCd;
	}
	public String getConfmYn() {
		return confmYn;
	}
	public void setConfmYn(String confmYn) {
		this.confmYn = confmYn;
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
	public String getAuthorId() {
		return authorId;
	}
	public void setAuthorId(String authorId) {
		this.authorId = authorId;
	}
	public String getInsttClCd() {
		return insttClCd;
	}
	public void setInsttClCd(String insttClCd) {
		this.insttClCd = insttClCd;
	}
	public String getMyLibryYN() {
		return myLibryYN;
	}
	public void setMyLibryYN(String myLibryYN) {
		this.myLibryYN = myLibryYN;
	}

}
