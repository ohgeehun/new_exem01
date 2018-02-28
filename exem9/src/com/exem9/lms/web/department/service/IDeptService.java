package com.exem9.lms.web.department.service;

import java.util.List;

import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.mypage.bean.MypageBean;


public interface IDeptService {	

	public List<DeptBean> getdept() throws Throwable;	
	
}
