package com.exem9.lms.web.login.dao;

import java.util.HashMap;
import java.util.List;

import com.exem9.lms.web.login.bean.LoginBean;

public interface ILoginDao {

	/*public LoginBean getUserInfo(LoginBean lb) throws Throwable;*/
	public List<LoginBean> getUserInfo(HashMap params) throws Throwable;

}
