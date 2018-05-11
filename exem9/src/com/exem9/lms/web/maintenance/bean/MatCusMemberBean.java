package com.exem9.lms.web.maintenance.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class MatCusMemberBean {
	private String matId;
	private String cususerId;
	private String cususerNm;
	private String cususerPhone;
	private String cususerMail;
	
	public String getMatId() {
		return matId;
	}
	public void setMatId(String matId) {
		this.matId = matId;
	}
	public String getCususerId() {
		return cususerId;
	}
	public void setCususerId(String cususerId) {
		this.cususerId = cususerId;
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

