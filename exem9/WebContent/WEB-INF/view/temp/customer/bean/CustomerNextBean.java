package com.exem9.lms.web.customer.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class CustomerNextBean {
	private String userId;
	private String supoState;
	private String userDept;
	private String userDbms;
	private String selectBtnVal;
	private String selectTextVal;
	private int pageNo;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSupoState() {
		return supoState;
	}
	public void setSupoState(String supoState) {
		this.supoState = supoState;
	}
	public String getUserDept() {
		return userDept;
	}
	public void setUserDept(String userDept) {
		this.userDept = userDept;
	}
	public String getUserDbms() {
		return userDbms;
	}
	public void setUserDbms(String userDbms) {
		this.userDbms = userDbms;
	}
	public String getSelectBtnVal() {
		return selectBtnVal;
	}
	public void setSelectBtnVal(String selectBtnVal) {
		this.selectBtnVal = selectBtnVal;
	}
	public String getSelectTextVal() {
		return selectTextVal;
	}
	public void setSelectTextVal(String selectTextVal) {
		this.selectTextVal = selectTextVal;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
	
}

