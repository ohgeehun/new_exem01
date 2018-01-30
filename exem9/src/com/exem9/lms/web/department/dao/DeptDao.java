package com.exem9.lms.web.department.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exem9.lms.web.mypage.bean.MypageBean;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="IDeptDao")
public class DeptDao implements IDeptDao{
	@Autowired
	public SqlMapClient sqlMapClient;


	public List getdept() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("dept.getdeptinfo");
	}
	
}
