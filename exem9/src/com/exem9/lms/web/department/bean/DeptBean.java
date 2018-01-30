package com.exem9.lms.web.department.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class DeptBean {
	private String deptId;
	private String deptNm;
	
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	
}
