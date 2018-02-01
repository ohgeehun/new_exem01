package com.exem9.lms.web.category.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class CateBean {
	private String catId;
	private String catNm;
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
}
