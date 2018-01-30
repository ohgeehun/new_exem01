package com.exem9.lms.web.maintenance.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="IMatDao")
public class MatDao implements IMatDao{
	@Autowired
	public SqlMapClient sqlMapClient;

	
}
