package com.exem9.lms.web.member.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class MemberBean {
	
	private String userId;
	private String userNm;
	private String userPw;
	private String userTeam;
	private String userFlag;
	private String userDbms;
	private String userDept;
	private String userPosi;
	private String userPhone;
	private String userMail;
	private String userPoint;
	private String userHint;
	
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
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserTeam() {
		return userTeam;
	}
	public void setUserTeam(String userTeam) {
		this.userTeam = userTeam;
	}
	public String getUserFlag() {
		return userFlag;
	}
	public void setUserFlag(String userFlag) {
		this.userFlag = userFlag;
	}
	public String getUserDbms() {
		return userDbms;
	}
	public void setUserDbms(String userDbms) {
		this.userDbms = userDbms;
	}
	public String getUserDept() {
		return userDept;
	}
	public void setUserDept(String userDept) {
		this.userDept = userDept;
	}
	public String getUserPosi() {
		return userPosi;
	}
	public void setUserPosi(String userPosi) {
		this.userPosi = userPosi;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserMail() {
		return userMail;
	}
	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}
	public String getUserPoint() {
		return userPoint;
	}
	public void setUserPoint(String userPoint) {
		this.userPoint = userPoint;
	}
	public String getUserHint() {
		return userHint;
	}
	public void setUserHint(String userHint) {
		this.userHint = userHint;
	}
	
	
}
