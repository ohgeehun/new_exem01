package com.exem9.lms.web.maintenance.service;

import java.util.List;

import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.team.bean.TeamBean;



public interface IMatService {	
	/*고객사 수정 이벤트 계약상태 리스트 데이터 가져오기 (SupoDao 연계) */
	public List<SupoBean> getSupolevel() throws Throwable;

	/*고객사 수정 이벤트 방문주기 리스트 데이터 가져오기 (SupoDao 연계) */
	public List<SupoBean> getSupovisit(String supoId)throws Throwable;

	/*  */
	public List<MemberBean> getTeammember(String teamId, String user1Id) throws Throwable ;
	
	/*고객사 수정 이벤트 담당부서(팀) 리스트 데이터 가져오기 (TeamDao 연계) */
/*	public List<TeamBean> getuserteam(String userDept)throws Throwable;*/
	
	/*고객사 정보 등록시 담당팀 리스트 가져오기*/
	public List<TeamBean> getdeptteam(String dbmsId) throws Throwable;
	
	/*고객사 관리 검색 조건 중 업무 리스트 정보 가져오기 (DbmsDao 연계)*/
	public List<DbmsBean> getdbms() throws Throwable;
}
