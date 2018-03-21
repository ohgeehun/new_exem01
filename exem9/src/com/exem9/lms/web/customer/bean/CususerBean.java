package com.exem9.lms.web.customer.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class CususerBean {
	private int gencususerId;
	private String cususerNm;
	private String cususerPhone;
	private String cususerMail;
	
	public int getGencususerId() {
		return gencususerId;
	}
	public void setGencususerId(int gencususerId) {
		this.gencususerId = gencususerId;
	}
	public String getCususerNm() {
		return cususerNm;
	}
	public void setCususerNm(String cususerNm) {
		this.cususerNm = cususerNm;		
	}
	public String getCususerPhone() {
		return cususerPhone;
	}
	public void setCususerPhone(String cususerPhone) {
		this.cususerPhone = cususerPhone;
	}
	public String getCususerMail() {
		return cususerMail;
	}
	public void setCususerMail(String cususerMail) {
		this.cususerMail = cususerMail;
	}
}

