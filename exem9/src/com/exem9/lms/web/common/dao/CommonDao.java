package com.exem9.lms.web.common.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.team.bean.TeamBean;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="ICommonDao")
public class CommonDao implements ICommonDao{
	@Autowired
	public SqlMapClient sqlMapClient;
	
	public List<SupoBean> getSupolevel() throws Throwable {
		
		return sqlMapClient.queryForList("common.getSupoLevel");
	}

	public List<SupoBean> getSupovisit(HashMap params) throws Throwable {
		
		return sqlMapClient.queryForList("common.getSupoVisit",params);
	}
}
