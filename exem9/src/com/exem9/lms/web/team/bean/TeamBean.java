package com.exem9.lms.web.team.bean;

import org.directwebremoting.annotations.DataTransferObject;

@DataTransferObject
public class TeamBean {
	private String teamId;
	private String teamNm;
	private String deptId;
	
	public String getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = teamId;
	}
	public String getTeamNm() {
		return teamNm;
	}
	public void setTeamNm(String teamNm) {
		this.teamNm = teamNm;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
}
