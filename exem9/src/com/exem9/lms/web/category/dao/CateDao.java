package com.exem9.lms.web.category.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exem9.lms.web.category.bean.CateBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="ICateDao")
public class CateDao implements ICateDao{
	@Autowired
	public SqlMapClient sqlMapClient;

	public List<CateBean> getcate() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("cate.getcate");
	}
}
