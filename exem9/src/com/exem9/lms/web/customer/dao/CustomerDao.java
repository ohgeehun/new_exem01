package com.exem9.lms.web.customer.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.ibatis.sqlmap.client.SqlMapClient;

@Repository(value="ICustomerDao")
public class CustomerDao implements ICustomerDao{
	@Autowired
	public SqlMapClient sqlMapClient;

	public List<SupoBean> getsupo() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getsupoinfo");
	}

	public List<CustomerBean> getcusinfo(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getcusinfo", params);
	}

	public int getNCount(HashMap params) throws Throwable {
		
		int count = (Integer) sqlMapClient.queryForObject("customer.getNCount", params);
		// TODO Auto-generated method stub
		return count;
	}

	public String updateCusInfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.updateCusInfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}

	public List<CustomerBean> getcusNminfo() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getcusNminfo");
	}

	public List<CustomerBean> getcusNmProinfo(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getcusNmProinfo", params);
	}

	public List<CustomerBean> getcusNmUserinfo(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return  sqlMapClient.queryForList("customer.getcusNmUserinfo", params);
	}

	public List<CustomerMemberBean> getcusUserinfo(HashMap params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getcusUserinfo", params);
	}

	/*기존고객사에 기존 담당자 등록시*/
	public String insertCusinfo1(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.insertCusinfo1", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}

	/*기존고객사에 신규 담당자 등록시*/
	public String insertCusinfo2(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.insertCusinfo2", params) > 0){
			result = "SUCCESS";
					
		}
		if(sqlMapClient.update("customer.insertCusinfo1", params) > 0){
			result = "SUCCESS";
		}	
		return result;		
		
	}

	/*신규고객사 신규 담당자 등록시*/
	public String insertCusinfo3(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.insertCusinfo3", params) > 0){
			result = "SUCCESS";
			
			if(sqlMapClient.update("customer.insertCusinfo4", params) > 0){
				result = "SUCCESS";
			}			
		}
		return result;
	}

}
