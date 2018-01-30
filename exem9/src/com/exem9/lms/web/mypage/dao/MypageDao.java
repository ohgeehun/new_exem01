package com.exem9.lms.web.mypage.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.position.bean.PosiBean;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="IMypageDao")
public class MypageDao implements IMypageDao{
	@Autowired
	public SqlMapClient sqlMapClient;

	public List<MypageBean> getUserinfo(String userId) throws Throwable {
		return sqlMapClient.queryForList("mypage.getUserinfo", userId);
	}

	public List<DbmsBean> getdbms(String userId) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("mypage.getdbmsinfo", userId);
	}

	public List<PosiBean> getposi() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("mypage.getposiinfo");
	}

	public String updateUserInfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("mypage.updateUserInfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}

	public String updateUserPw(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("mypage.updateUserPw", params) > 0){
			result = "PW_SUCCESS";
		}
		return result;
	}

	public String updateUserPwInfo(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return (String) sqlMapClient.queryForObject("mypage.getUserPw", params);
	}

	
}
