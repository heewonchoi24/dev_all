package com.park.ch.cmn;

import java.io.Serializable;

import com.park.ch.cmn.encrypt.AES256Util;

public class LoginVO implements Serializable{
	
	private static final long serialVersionUID = -8274004534207618049L;
	
	/** 사용자 고유 번호 */
	private String userNo;
	/** 사용자 id */
	private String userId;
	/** 사용자 pw */
	private String userPw;
	/** 사용자 salt */
	private String salt;
	/** 사용자 명 */
	private String userNm;
	/** 휴대전화 */
	private String userTelno;	
	/** 이메일 주소 */
	private String userEmail;		
	/** 배송 주소 */
	private String userAddr;	
	/** 개인정보 동의 여부 */
	private String agreeYn;
	/** 대기회원 정회원 구분 */
	private String memYn;	
	/** 관리자 권한 */
	private String authYn;
	/** 추천 아이디 */
	private String recUid;	
	/** 사용자 IP */
	private String userIp;
	/** 가입 일자 */
	private String registDt;
	
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getUserTelno() {
		return userTelno;
	}
	public void setUserTelno(String userTelno) {
		this.userTelno = userTelno;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserAddr() {
		return userAddr;
	}
	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}
	public String getAgreeYn() {
		return agreeYn;
	}
	public void setAgreeYn(String agreeYn) {
		this.agreeYn = agreeYn;
	}
	public String getMemYn() {
		return memYn;
	}
	public void setMemYn(String memYn) {
		this.memYn = memYn;
	}
	public String getAuthYn() {
		return authYn;
	}
	public void setAuthYn(String authYn) {
		this.authYn = authYn;
	}
	public String getRecUid() {
		return recUid;
	}
	public void setRecUid(String recUid) {
		this.recUid = recUid;
	}
	public String getUserIp() {
		return userIp;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	public String getRegistDt() {
		return registDt;
	}
	public void setRegistDt(String registDt) {
		this.registDt = registDt;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
}
