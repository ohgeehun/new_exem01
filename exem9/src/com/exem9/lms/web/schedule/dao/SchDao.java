package com.exem9.lms.web.schedule.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exem9.lms.web.mypage.bean.MypageBean;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="ISchDao")
public class SchDao implements ISchDao{
	@Autowired
	public SqlMapClient sqlMapClient;

	public List getsch() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("sch.getsch");
	}
}
