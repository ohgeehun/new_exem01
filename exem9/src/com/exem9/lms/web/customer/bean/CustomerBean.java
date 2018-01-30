package com.exem9.lms.web.customer.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class CustomerBean {
	private String cusId;
	private String cusNm;
	private String proId;
	private String proNm;
	private String cus1Nm;
	private String cus1Phone;
	private String cus1Mail;
	private String cus2Nm;
	private String cusLoca;
	private String salseId;
	private String etc;
	private String createUserId;
	private String createDate;
	private String lastUpUserId;
	private String lastUpDate;
	
	
	public String getCus1Nm() {
		return cus1Nm;
	}
	public void setCus1Nm(String cus1Nm) {
		this.cus1Nm = cus1Nm;
	}
	public String getCus2Nm() {
		return cus2Nm;
	}
	public void setCus2Nm(String cus2Nm) {
		this.cus2Nm = cus2Nm;
	}
	public String getCus1Phone() {
		return cus1Phone;
	}
	public void setCus1Phone(String cus1Phone) {
		this.cus1Phone = cus1Phone;
	}
	public String getCus1Mail() {
		return cus1Mail;
	}
	public void setCus1Mail(String cus1Mail) {
		this.cus1Mail = cus1Mail;
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

