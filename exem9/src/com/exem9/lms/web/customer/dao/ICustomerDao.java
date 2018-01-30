package com.exem9.lms.web.customer.dao;

import java.util.HashMap;
import java.util.List;

import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.mypage.bean.MypageBean;

public interface ICustomerDao {

	public List<SupoBean> getsupo() throws Throwable;

	public List<CustomerBean> getcusinfo(HashMap params)throws Throwable ;

	public int getNCount(HashMap params) throws Throwable;

	public String updateCusInfo(HashMap params) throws Throwable;

	public List<CustomerBean> getcusNminfo() throws Throwable ;

	public List<CustomerBean> getcusNmProinfo(HashMap params) throws Throwable ;

	public List<CustomerBean> getcusNmUserinfo(HashMap params) throws Throwable ;

	public List<CustomerMemberBean> getcusUserinfo(HashMap params) throws Throwable;

	public String insertCusinfo1(HashMap params)throws Throwable ;

	public String insertCusinfo2(HashMap params)throws Throwable ;
	
	public String insertCusinfo3(HashMap params)throws Throwable ;
}
