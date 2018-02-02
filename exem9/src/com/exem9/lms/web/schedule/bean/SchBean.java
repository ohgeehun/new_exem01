package com.exem9.lms.web.schedule.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class SchBean {
	private String schId;
	private String schCusId;
	private String schCusNm;
	private String schPjtId;
	private String schPjtNm;
	private String user_id; 
	private String user_name;
	private String team_id; 
	private String team_name;
	private String dbms_id; 
	private String dbms_name;
	private String category_id; 
	private String category_name;
	private String start_time; 
	private String end_time; 
	private String contents;
	
	public String getSchCusId() {
		return schCusId;
	}
	public void setSchCusId(String schCusId) {
		this.schCusId = schCusId;
	}
	public String getSchPjtId() {
		return schPjtId;
	}
	public void setSchPjtId(String schPjtId) {
		this.schPjtId = schPjtId;
	}
	public String getSchCusNm() {
		return schCusNm;
	}
	public void setSchCusNm(String schCusNm) {
		this.schCusNm = schCusNm;
	}
	public String getSchPjtNm() {
		return schPjtNm;
	}
	public void setSchPjtNm(String schPjtNm) {
		this.schPjtNm = schPjtNm;
	}
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getDbms_id() {
		return dbms_id;
	}
	public void setDbms_id(String dbms_id) {
		this.dbms_id = dbms_id;
	}
	public String getDbms_name() {
		return dbms_name;
	}
	public void setDbms_name(String dbms_name) {
		this.dbms_name = dbms_name;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getSchId() {
		return schId;
	}
	public void setSchId(String schId) {
		this.schId = schId;
	}
	
}
