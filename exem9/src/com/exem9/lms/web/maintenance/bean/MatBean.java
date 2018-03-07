package com.exem9.lms.web.maintenance.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class MatBean {
	private String matId;
	private String custId;
	private String projId;
	private String dbmsId;
	private String dbmsVersion;
	private String cususerId;
	private String mem1Id;
	private String mem2Id;
	private String salesmanId;
	private String installDay;
	private String contractId;
	private String visitId;
	private String startDay;
	private String endDay;
	private String etc;
	
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getProjId() {
		return projId;
	}
	public void setProjId(String projId) {
		this.projId = projId;
	}
	public String getDbmsId() {
		return dbmsId;
	}
	public void setDbmsId(String dbmsId) {
		this.dbmsId = dbmsId;
	}
	public String getMem1Id() {
		return mem1Id;
	}
	public void setMem1Id(String mem1Id) {
		this.mem1Id = mem1Id;
	}
	public String getMem2Id() {
		return mem2Id;
	}
	public void setMem2Id(String mem2Id) {
		this.mem2Id = mem2Id;
	}
	public String getSalesmanId() {
		return salesmanId;
	}
	public void setSalesmanId(String salesmanId) {
		this.salesmanId = salesmanId;
	}
	public String getInstallDay() {
		return installDay;
	}
	public void setInstallDay(String installDay) {
		this.installDay = installDay;
	}
	public String getContractId() {
		return contractId;
	}
	public void setContractId(String contractId) {
		this.contractId = contractId;
	}
	public String getVisitId() {
		return visitId;
	}
	public void setVisitId(String visitId) {
		this.visitId = visitId;
	}
	public String getStartDay() {
		return startDay;
	}
	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}
	public String getEndDay() {
		return endDay;
	}
	public void setEndDay(String endDay) {
		this.endDay = endDay;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getMatId() {
		return matId;
	}
	public void setMatId(String matId) {
		this.matId = matId;
	}
	public String getDbmsVersion() {
		return dbmsVersion;
	}
	public void setDbmsVersion(String dbmsVersion) {
		this.dbmsVersion = dbmsVersion;
	}
	public String getCususerId() {
		return cususerId;
	}
	public void setCususerId(String cususerId) {
		this.cususerId = cususerId;
	}
	
}
