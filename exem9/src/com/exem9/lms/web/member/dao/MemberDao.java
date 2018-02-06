package com.exem9.lms.web.member.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.team.bean.TeamBean;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="IMemberDao")
public class MemberDao implements IMemberDao{
	@Autowired
	public SqlMapClient sqlMapClient;

	public List<MemberBean> getUsermember(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("member.getUsermember",params);
	}

	public List<MemberBean> getSalsemember() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("member.getSalsemember");
	}

	public List<MemberBean> getteamuser(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("member.getteamuser",params);
	}
	
	public List<MemberBean> getteamuser1(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("member.getteamuser1",params);
	}

	public List<MemberBean> getTeammember(HashMap params) throws Throwable {
		// TODO Auto-generated method stub		
		return sqlMapClient.queryForList("member.getTeammember",params);
	}
	
	public List<MemberBean> getmeminfo(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("member.getmeminfo", params);
	}
	
	public int getNCount(HashMap params) throws Throwable {
		
		int count = (Integer) sqlMapClient.queryForObject("member.getNCount", params);
		// TODO Auto-generated method stub
		return count;
	}
	
	/*신규 사용자 등록시*/
	public String insertMeminfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("member.insertMeminfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}
}
