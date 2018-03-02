package com.exem9.lms.web.schedule.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.schedule.bean.SchBean;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="ISchDao")
public class SchDao implements ISchDao{
	@Autowired
	public SqlMapClient sqlMapClient;

	public List<SchBean> getsch(HashMap params) throws Throwable {
		return sqlMapClient.queryForList("sch.getsch",params);
	}

	@Override
	public String insertSchinfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("sch.insertSchinfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}

	@Override
	public int getNCount(HashMap params) throws Throwable {
		
		int count = (Integer) sqlMapClient.queryForObject("sch.getNCount", params);
		return count;
	}
	
}
