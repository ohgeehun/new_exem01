package com.exem9.lms.web.position.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class PosiBean {
	private String posiId;
	private String posiNm;
	
	public String getPosiId() {
		return posiId;
	}
	public void setPosiId(String posiId) {
		this.posiId = posiId;
	}
	public String getPosiNm() {
		return posiNm;
	}
	public void setPosiNm(String posiNm) {
		this.posiNm = posiNm;
	}
	

	
}
