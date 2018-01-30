package com.exem9.lms.web.login.service;

import java.util.List;

import com.exem9.lms.web.login.bean.LoginBean;

public interface ILoginService {

	/*public LoginBean getUserInfo(LoginBean lb) throws Throwable;*/
	public String getUserInfo(String Id, String Pw) throws Throwable;

}
