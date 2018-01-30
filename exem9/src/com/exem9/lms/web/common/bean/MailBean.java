package com.exem9.lms.web.common.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class MailBean {
	private String from;
	private String strUserAdd;
	private String subject;
	private String content;
	
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getStrUserAdd() {
		return strUserAdd;
	}
	public void setStrUserAdd(String strUserAdd) {
		this.strUserAdd = strUserAdd;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	
	
}
