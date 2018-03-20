package com.exem9.lms.web.customer.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.customer.bean.CustomerNmBean;
import com.exem9.lms.web.customer.bean.CustomerPjtNmBean;
import com.exem9.lms.web.customer.bean.CususerBean;
import com.exem9.lms.web.mypage.bean.MypageBean;


public interface ICustomerDao {

	public List<SupoBean> getsupo() throws Throwable;

	public List<CustomerBean> getcusinfo(HashMap params)throws Throwable ;

	public int getNCount(HashMap params) throws Throwable;

	public String updateCusInfo(HashMap params) throws Throwable;

	public List<CustomerBean> getcusNminfo() throws Throwable ;
	
	public List<CustomerNmBean> getcusNminfo2() throws Throwable ;

	public List<CustomerBean> getcusNmProinfo(HashMap params) throws Throwable ;

	public List<CustomerBean> getcusNmUserinfo(HashMap params) throws Throwable ;

	public List<CustomerMemberBean> getcusUserinfo(HashMap params) throws Throwable;

	// 전체 고객사담당자 정보 가져오기
	public List<CustomerMemberBean> getcusUserinfo2() throws Throwable;

	public String insertCusinfo1(HashMap params)throws Throwable ;

	public String insertCusinfo2(HashMap params)throws Throwable ;
	
	public String insertCusinfo3(HashMap params)throws Throwable ;
	
	public String insertCusinfo4(HashMap params)throws Throwable ;
	
	public String insertCusinfo5(HashMap params)throws Throwable ;
	
	public List<CustomerPjtNmBean> getcusPjtNminfo() throws Throwable ;

	public String insertCusinfo(HashMap params) throws Throwable;

	public List<CustomerMemberBean> getprodbmsManagedinfo(HashMap params) throws Throwable;

	public List<CustomerPjtNmBean> getCusProCheck(HashMap params) throws Throwable;

	public List<CustomerMemberBean> getprodbmsManagedcheck(HashMap params)throws Throwable;

	public List<CustomerMemberBean> getprodbmsmemberinfo(HashMap params)throws Throwable;

	public List<CustomerMemberBean> getcusmemberinfo(HashMap params)throws Throwable;
	
	
	// 테스트 중. 사용안함
	public String insertCusProj(HashMap params) throws Throwable;

	public void insertCus(HashMap params) throws Throwable;
	public Integer getInsertedCusId(HashMap params) throws Throwable;
	public void insertProj(HashMap params)  throws Throwable;
	public Integer getInsertedPjtId(HashMap params) throws Throwable;
	public void insertSalesman(HashMap params)  throws Throwable;
	public void insertCusmember(HashMap params)  throws Throwable;
	public Integer getInsertedCusmemberId(HashMap params) throws Throwable;
	public void insertPjtDbmsCusmember(HashMap params)  throws Throwable;

	public String getSalesmanId(HashMap params) throws Throwable;

	// 고객사담당자 삭제
	public String deleteCusmemberinfo(HashMap params) throws Throwable;
	public String deletePjtDbmsCusmemberinfo(HashMap params) throws Throwable;

	// 고객사프로젝트업무의 담당자 여러건 삭제
	public String deleteCusmembersinfo(HashMap params) throws Throwable;
	// 고객사프로젝트의 해당 업무 삭제
	public String deleteCusPjtDbmsinfo(HashMap params) throws Throwable;
	// 프로젝트 정보 삭제
	public String deleteCusPjtinfo(HashMap params) throws Throwable;
	// 고객사 정보 삭제
	public String deleteCusinfo(HashMap params) throws Throwable;

	// 프로젝트, 비고, 고객사위치 정보 수정
	public String updatePjtInfo(HashMap params) throws Throwable;
	// 제품(업무)정보, 영업대표 수정
	public String updateDbmsInfo(HashMap params) throws Throwable;
	// 고객담당자, 전화, email 수정
	public String updateCusmemberInfo(HashMap params)  throws Throwable;

	public int insertCusmember2(CususerBean cususerBean) throws Throwable;
}
