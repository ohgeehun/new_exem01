package com.exem9.lms.web.customer.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class CustomerBean {
	private String cusId;
	private String cusNm;
	private String proId;
	private String proNm;
	private String cususerId;
	private String cususerNm;
	private String cususerPhone;
	private String cususerMail;
	private String cusLoca;
	private String salseId;
	private String etc;
	private String createUserId;
	private String createDate;
	private String lastUpUserId;
	private String lastUpDate;
	
	

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
	public void setCususerMail(String cususer1Mail) {
		this.cususerMail = cususer1Mail;
	}
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
	public String getProId() {
		return proId;
	}
	public void setProId(String proId) {
		this.proId = proId;
	}
	public String getProNm() {
		return proNm;
	}
	public void setProNm(String proNm) {
		this.proNm = proNm;
	}
	public String getCusLoca() {
		return cusLoca;
	}
	public void setCusLoca(String cusLoca) {
		this.cusLoca = cusLoca;
	}
	public String getSalseId() {
		return salseId;
	}
	public void setSalseId(String salseId) {
		this.salseId = salseId;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(String createUserId) {
		this.createUserId = createUserId;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getLastUpUserId() {
		return lastUpUserId;
	}
	public void setLastUpUserId(String lastUpUserId) {
		this.lastUpUserId = lastUpUserId;
	}
	public String getLastUpDate() {
		return lastUpDate;
	}
	public void setLastUpDate(String lastUpDate) {
		this.lastUpDate = lastUpDate;
	}
}

