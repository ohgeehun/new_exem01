package com.exem9.lms.web.dbms.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="IDbmsDao")
public class DbmsDao implements IDbmsDao{
	@Autowired
	public SqlMapClient sqlMapClient;


	public List getdbms() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("dbms.getdbmsinfo");
	}


	public List<DbmsBean> getdbms(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("dbms.getUserinfo",params);
	}


	public List<DbmsBean> getdeptdbms(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("dbms.getdeptdbms",params);
	}
}
