package com.exem9.lms.web.login.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class LoginBean {

	private String userId;
	private String userNm;
	private String userPw;
	private String userTeam;
	private String userFlag;
	private String userDbms;
	private String userLevel;
	private String userDept;
	private String userPosi;

	
	/*public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}*/
	public String getUserId() {
		return userId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
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
	public String getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
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
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/*public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}*/
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
}
