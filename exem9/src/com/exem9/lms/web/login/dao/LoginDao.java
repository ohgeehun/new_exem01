package com.exem9.lms.web.login.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.exem9.lms.web.login.bean.LoginBean;

@Repository(value="ILoginDao")
public class LoginDao implements ILoginDao {
	
	@Autowired
	public SqlMapClient sqlMapClient;
	
/*	public LoginBean getUserInfo(LoginBean lb) throws Throwable {

		return (LoginBean) sqlMapClient.queryForObject("login.getUserInfo", lb);
	}*/

	public List<LoginBean> getUserInfo(HashMap params) throws Throwable {
		return sqlMapClient.queryForList("login.getUserInfo", params);
	}
}
