package com.exem9.lms.web.member.service;

import java.util.List;

import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.mypage.bean.MypageBean;


public interface IMemberService {

	public  List<DeptBean> getdept() throws Throwable ;	
	
/*	public List getteam() throws Throwable;	*/
	
}
