package com.exem9.lms.web.member.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class MemberBean2 {
	
	private String userId;
	private String userNm;
	private String userPhone;
	private String userMail;
	
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
	
}
