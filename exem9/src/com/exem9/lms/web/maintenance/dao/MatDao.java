package com.exem9.lms.web.maintenance.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exem9.lms.web.maintenance.bean.MatBean;
import com.exem9.lms.web.member.bean.MemberBean;
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

	public List<MatBean> getmatinfo(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("maintenance.getmatinfo", params);
	}
	
	public int getNCount(HashMap params) throws Throwable {
		
		int count = (Integer) sqlMapClient.queryForObject("maintenance.getNCount", params);
		// TODO Auto-generated method stub
		return count;
	}
	
	/*유지보수 정보 삭제 처리*/
	public String deleteMatinfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("maintenance.deleteMatinfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}
	
	/*유지보수 정보 삭제 처리*/
	public String updateMatinfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("maintenance.updateMatinfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}
	
}
