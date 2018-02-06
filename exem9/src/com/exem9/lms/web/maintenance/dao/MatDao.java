package com.exem9.lms.web.maintenance.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="IMatDao")
public class MatDao implements IMatDao{
	
	@Autowired
	public SqlMapClient sqlMapClient;

	public String insertMatinfo(HashMap params)throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("maintenance.insertMatinfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}

	
}
