package com.exem9.lms.web.customer.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.customer.bean.CustomerNmBean;
import com.exem9.lms.web.customer.bean.CustomerPjtNmBean;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.member.bean.MemberBean2;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.team.bean.TeamBean;

@Transactional
public interface ICustomerService {

	/*현재 접속 중인 유저 정보 가져오기(MypageDao 연계)*/
	public List<MypageBean> getUserinfo(String userId) throws Throwable;

	/*고객사 관리 검색 조건 중 부서 리스트 정보 가져오기 (DeptDao 연계)*/
	public List<DeptBean> getdept() throws Throwable;
	
	/*고객사 관리 검색 조건 중 계약상태 리스트 정보 가져오기 (supoBean(common) 연계)*/
	public List<SupoBean> getsupo()throws Throwable;
	
	/*고객사 관리 검색 조건에 해당하는 고객사 리스트 정보 가져오기*/
	public List<CustomerBean> getcusinfo(String selectBtnVal, String selectTextVal, int pageNo)throws Throwable;

	/*고객사 관리 리스트 Row 횟수 가져오기(페이지 처리)*/
	public LineBoardBean getNCount(String selectBtnVal, String selectTextVal, int nowPage) throws Throwable;

	/*고객사 수정 이벤트 업무(담당부서에 속한) 리스트 데이터 가져오기 (DbmsDao 연계) */
	public List<DbmsBean> getdbms(String userDept)throws Throwable;
	
	/*고객사 등록 시 업무리스트 가져오기*/
	public List<DbmsBean> getdbms()throws Throwable;

	/*고객사 수정 이벤트 담당엔지니어정보(담당팀에 속한) 리스트 데이터 가져오기 (MemberDao 연계) */
	public List<MemberBean> getUsermember(String userTeam) throws Throwable;
	
	/*고객사 수정 이벤트 영업대표 리스트 데이터 가져오기 (MemberDao 연계) */
	public List<MemberBean2> getSalsemember()throws Throwable;

	/*고객사 정보 업데이트 */
	public String updateCusInfo(String userId, int cusproId, int cususer, String cusloca,   String salseman, String etc)throws Throwable;
	
	/*고객사 정보 등록시 업무 리스트 가져오기*/
	public List<DbmsBean> getdeptdbms(String deptId) throws Throwable;
	
	/*고객사 정보 등록시 담당엔지니어 리스트 가져오기*/
	public List<MemberBean> getteamuser(String teamId) throws Throwable;
	
	/*고객사 정보 등록시 담당엔지니어 정 선택시 부  리스트 가져오기*/
	public List<MemberBean> getteamuser1(String teamId, String userId) throws Throwable;
	
	/*기존고객사명 가져오기 이벤트*/
	public List<CustomerBean> getcusNminfo()throws Throwable ;
	
	/*기존고객사명 가져오기 콤포박스에서 사용*/
	public List<CustomerNmBean> getcusNminfo2()throws Throwable ;
	
	/*선택된고객사에 등록된 프로젝트명 가져오기 이벤트*/
	public List<CustomerBean> getcusNmProinfo(String cusNm, String cusProNm)throws Throwable ;
	
	/*선택된고객사에 등록된 담당자명 가져오기 이벤트*/
	public List<CustomerBean> getcusNmUserinfo(String cusNm)throws Throwable ;
	
	/*선택된담당자에 등록된 연락처 메일 정보 가져오기 이벤트*/
	public List<CustomerMemberBean> getcusUserinfo(String cusUser,String cusId, String cusUserId) throws Throwable ;
	
	/*고객사 등록 updateCusInfo 이벤트*/
	public String insertCusinfo(String cusNm_hidden, String cusPro_hidden, String cusDbms_hidden, String cusUser_hidden,
								String cusNm, String cusproNm, String dbmsId,
								String cususerNm, String cususerPhone,String cususerMail, String cuslocation,
								String salesmanId, String etc) throws Throwable ;
	
	/*고객사 등록 updateCusInfo2 */
	//public String insertCusinfo2(String cusNm, String cusproNm) throws Throwable ;
	public String insertCusinfo2(String cusNm, String cusproNm, String dbmsId, String cuslocation, 
			String cususerNm, String cususerPhone, String cususerMail, String salesmanId, String etc) throws Throwable;
	
	/*고객사 프로젝트명 가져오기 콤포박스에서 사용*/
	public List<CustomerPjtNmBean> getcusPjtNminfo()throws Throwable ;
	
	public List<CustomerMemberBean> getprodbmsManagedinfo(String cusNm)throws Throwable ;
	
	public List<CustomerPjtNmBean> getCusProCheck(String cusNm, String proNm)throws Throwable ;
	
	public List<CustomerMemberBean> getprodbmsManagedcheck(String cusNm, String proNm, String dbmsId)throws Throwable ;
	
	public List<CustomerMemberBean> getprodbmsmemberinfo(String cusNm, String proNm, String dbmsId, String cususerNm)throws Throwable ;
	
	public String deleteCusinfo(String chkId) throws Throwable ;
	
}
