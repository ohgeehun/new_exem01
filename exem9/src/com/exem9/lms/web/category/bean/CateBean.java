package com.exem9.lms.web.category.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class CateBean {
	private String catId;
	private String catNm;
	private String big_group;
	private String small_group;
	private String dept_group;
	
	public String getBig_group() {
		return big_group;
	}
	public void setBig_group(String big_group) {
		this.big_group = big_group;
	}
	public String getDept_group() {
		return dept_group;
	}
	public void setDept_group(String dept_group) {
		this.dept_group = dept_group;
	}
	
	public String getCatId() {
		return catId;
	}
	public void setCatId(String catId) {
		this.catId = catId;
	}
	public String getCatNm() {
		return catNm;
	}
	public void setCatNm(String catNm) {
		this.catNm = catNm;
	}
	public String getSmall_group() {
		return small_group;
	}
	public void setSmall_group(String small_group) {
		this.small_group = small_group;
	}
}
