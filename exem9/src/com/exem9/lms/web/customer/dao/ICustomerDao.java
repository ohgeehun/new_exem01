package com.exem9.lms.web.customer.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.customer.bean.CustomerNmBean;
import com.exem9.lms.web.customer.bean.CustomerPjtNmBean;
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
	
	public String deleteCusinfo(HashMap params) throws Throwable;
	
	// 테스트 중. 사용안함
	public String insertCusProj(HashMap params) throws Throwable;

	public void insertCus(HashMap params) throws Throwable;
	public Integer getInsertedCusId(HashMap params) throws Throwable;
	public void insertProj(HashMap params)  throws Throwable;
	public Integer getInsertedPjtId(HashMap params) throws Throwable;

		
}
