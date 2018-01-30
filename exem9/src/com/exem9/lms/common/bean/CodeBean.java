package com.exem9.lms.common.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class CodeBean {
	//코드 대분류
	private String lCd;
	
	//코드 소분류
	private String sCd;
	
	//코드명
	private String cdNm;

	//Getter & Setter
	public String getlCd() {
		return lCd;
	}

	public void setlCd(String lCd) {
		this.lCd = lCd;
	}

	public String getsCd() {
		return sCd;
	}

	public void setsCd(String sCd) {
		this.sCd = sCd;
	}

	public String getCdNm() {
		return cdNm;
	}

	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}
}
