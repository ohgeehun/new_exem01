package com.exem9.lms.web.maintenance.service;

import java.util.List;

import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.maintenance.bean.MatBean;
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
	public List<TeamBean> getdeptteam(String deptId) throws Throwable;
	
	/*고객사 관리 검색 조건 중 업무 리스트 정보 가져오기 (DbmsDao 연계)*/
	public List<DbmsBean> getdbms() throws Throwable;
	
	/*유지보수 등록  이벤트*/
	public String insertMatinfo(String cusNm, String proNm, String dbmsId,
								String dbmsVersion, String cusUserId, String salesmanId,
								String user1Id, String user2Id, String supoLeverId,
								String supoVisitId, String supoinstallData, String supostateDate,
								String supoendDatae, String etc) throws Throwable ;

	public List<MatBean> getmatinfo(String selectBtnVal, String selectTextVal, int nowPage) throws Throwable; 

	public LineBoardBean getNCount(String selectBtnVal, String selectTextVal, int nowPage) throws Throwable;
	
	
	/* 유지보수 항목 삭제*/
	public String deleteMatinfo(String chkId) throws Throwable;
	
	/*유지보수 수정*/
	public String updateMatinfo(String custId, String pjtId, String cususerId, String dbmsId, 
								String user1Id, String user2Id,  String salesmanId, String installDay, String contractId, 
								String visitId, String startDay, String endDay, String etc, String chkId) throws Throwable ;
	
	public List<CustomerMemberBean> getcusmemberinfo(int cusId)throws Throwable ;
	
	public List<CustomerMemberBean> getprodbmsmemberinfo(int cusId, int proId,int dbmsId)throws Throwable ; 
	
}
