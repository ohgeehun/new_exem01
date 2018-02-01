package com.exem9.lms.web.customer.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class CustomerPjtNmBean {
	private String cusId;
	private String pjtId;
	private String pjtNm;
	
	public String getCusId() {
		return cusId;
	}
	public void setCusId(String cusId) {
		this.cusId = cusId;
	}
	public String getPjtId() {
		return pjtId;
	}
	public void setPjtId(String pjtId) {
		this.pjtId = pjtId;
	}
	public String getPjtNm() {
		return pjtNm;
	}
	public void setPjtNm(String pjtNm) {
		this.pjtNm = pjtNm;
	}
}

