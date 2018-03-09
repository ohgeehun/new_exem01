package com.exem9.lms.web.customer.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class CustomerNmBean {
	private String cusId;
	private String cusNm;
	
	public String getCusId() {
		return cusId;
	}
	public void setCusId(String cusId) {
		this.cusId = cusId;
	}
	public String getCusNm() {
		return cusNm;
	}
	public void setCusNm(String cusNm) {
		this.cusNm = cusNm;
	}

	
}

