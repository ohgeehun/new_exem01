package com.exem9.lms.web.dbms.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class DbmsBean {
	private String dbmsId;
	private String dbmsNm;
	private String deptId;
	
	public String getDbmsId() {
		return dbmsId;
	}
	public void setDbmsId(String dbmsId) {
		this.dbmsId = dbmsId;
	}
	public String getDbmsNm() {
		return dbmsNm;
	}
	public void setDbmsNm(String dbmsNm) {
		this.dbmsNm = dbmsNm;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	

	
}
