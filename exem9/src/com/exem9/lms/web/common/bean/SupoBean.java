package com.exem9.lms.web.common.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class SupoBean {
	private String supoId;
	private String supoNm;
	private String supoVisitId;
	private String supoVisitNm;
	private String supoLevelVisitId;
	
	public String getSupoId() {
		return supoId;
	}
	public void setSupoId(String supoId) {
		this.supoId = supoId;
	}
	public String getSupoNm() {
		return supoNm;
	}
	public void setSupoNm(String supoNm) {
		this.supoNm = supoNm;
	}
	public String getSupoVisitId() {
		return supoVisitId;
	}
	public void setSupoVisitId(String supoVisitId) {
		this.supoVisitId = supoVisitId;
	}
	public String getSupoVisitNm() {
		return supoVisitNm;
	}
	public void setSupoVisitNm(String supoVisitNm) {
		this.supoVisitNm = supoVisitNm;
	}
	public String getSupoLevelVisitId() {
		return supoLevelVisitId;
	}
	public void setSupoLevelVisitId(String supoLevelVisitId) {
		this.supoLevelVisitId = supoLevelVisitId;
	}
	
}
