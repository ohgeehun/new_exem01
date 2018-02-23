package com.exem9.lms.web.customer.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.customer.bean.CustomerNmBean;
import com.exem9.lms.web.customer.bean.CustomerPjtNmBean;
import com.ibatis.sqlmap.client.SqlMapClient;

@Transactional
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
	
	public List<CustomerNmBean> getcusNminfo2() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getcusNminfo2");
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
	
	// 고객사 프로젝트명 콤보박스 조회 용
	public List<CustomerPjtNmBean> getcusPjtNminfo() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getcusPjtNminfo");
	}

	/*신규고객사 / 신규 프로젝트 / 신규 업무 / 신규 담당자*/
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String insertCusinfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		
		sqlMapClient.startTransaction();
		sqlMapClient.getCurrentConnection().setAutoCommit(false);		
        
        
		try{
			if(sqlMapClient.update("customer.insertCusinfo1000", params) > 0){		/* xm_customer 인서트*/
				
				if(sqlMapClient.update("customer.insertCusinfo0100", params) > 0){	/* xm_project 인서트*/	 
					
					if(sqlMapClient.update("customer.insertCusinfo0010", params) > 0){ /* xm_project_dbms_managed 인서트*/
						
						if(sqlMapClient.update("customer.insertCusinfo0001", params) > 0){ /* xm_customer_member */
							
							if(sqlMapClient.update("customer.insertCusinfo0001-1", params) > 0){ /* xm_project_dbms_member_managed 인서트*/
								result = "SUCCESS";								
								sqlMapClient.commitTransaction();
								sqlMapClient .getCurrentConnection().commit();
							}					
						}
					}			
				}		
			}
		}catch(Exception e){
			result = "FAILED";
			System.out.println(e);
			
		}finally{			
			sqlMapClient.endTransaction();			
		}
		
		return result;
	}

	/*기존 고객사 / 신규 프로젝트 / 신규 업무 / 기존 담당자*/
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String insertCusinfo1(HashMap params) throws Throwable {
		String result = "FAILED";
		
		sqlMapClient.startTransaction();
		sqlMapClient.getCurrentConnection().setAutoCommit(false);		
        
		try{			
			if(sqlMapClient.update("customer.insertCusinfo0100", params) > 0){
				result = "SUCCESS";					
				
				if(sqlMapClient.update("customer.insertCusinfo0010", params) > 0){
					result = "SUCCESS";

					if(sqlMapClient.update("customer.insertCusinfo0001-1", params) > 0){
						result = "SUCCESS";								
						sqlMapClient.commitTransaction();
						sqlMapClient .getCurrentConnection().commit();
					}					
				}
			}			
				
		}catch(Exception e){
			result = "FAILED";
			System.out.println(e);
			
		}finally{			
			sqlMapClient.endTransaction();			
		}
		
		return result;
	}
	
	/*기존 고객사 / 신규 프로젝트 / 신규 업무 / 신규 담당자*/
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String insertCusinfo2(HashMap params) throws Throwable {
		String result = "FAILED";
		
		sqlMapClient.startTransaction();
		sqlMapClient.getCurrentConnection().setAutoCommit(false);		
        
		try{
			if(sqlMapClient.update("customer.insertCusinfo0100", params) > 0){		
				
				if(sqlMapClient.update("customer.insertCusinfo0010", params) > 0){
					
					if(sqlMapClient.update("customer.insertCusinfo0001", params) > 0){
						
						if(sqlMapClient.update("customer.insertCusinfo0001-1", params) > 0){
							result = "SUCCESS";								
							sqlMapClient.commitTransaction();
							sqlMapClient .getCurrentConnection().commit();
						}					
					}
				}			
			}					
		}catch(Exception e){
			result = "FAILED";
			System.out.println(e);
			
		}finally{			
			sqlMapClient.endTransaction();			
		}
		
		return result;
	}

	/*기존 고객사 / 기존 프로젝트 / 신규 업무 / 기존 담당자*/
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String insertCusinfo3(HashMap params) throws Throwable {
		String result = "FAILED";
		
		sqlMapClient.startTransaction();
		sqlMapClient.getCurrentConnection().setAutoCommit(false);		
        
		try{
			if(sqlMapClient.update("customer.insertCusinfo0010", params) > 0){
				if(sqlMapClient.update("customer.insertCusinfo0001-1", params) > 0){
					result = "SUCCESS";								
					sqlMapClient.commitTransaction();
					sqlMapClient .getCurrentConnection().commit();
				}					
				
			}		
		}catch(Exception e){
			result = "FAILED";
			System.out.println(e);
			
		}finally{			
			sqlMapClient.endTransaction();			
		}
		
		return result;
	}
	
	/*기존 고객사 / 기존 프로젝트 / 신규 업무 / 신규 담당자*/
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String insertCusinfo4(HashMap params) throws Throwable {
		String result = "FAILED";
		
		sqlMapClient.startTransaction();
		sqlMapClient.getCurrentConnection().setAutoCommit(false);		

		try{		
			if(sqlMapClient.update("customer.insertCusinfo0010", params) > 0){
				
				if(sqlMapClient.update("customer.insertCusinfo0001", params) > 0){
					
					if(sqlMapClient.update("customer.insertCusinfo0001-1", params) > 0){
						result = "SUCCESS";								
						sqlMapClient.commitTransaction();
						sqlMapClient .getCurrentConnection().commit();
					}					
				}
			}			
		}catch(Exception e){
			result = "FAILED";
			System.out.println(e);
			
		}finally{			
			sqlMapClient.endTransaction();			
		}
		
		return result;
	}
	
	/*기존 고객사 / 기존 프로젝트 / 기존 업무 / 신규 담당자*/
	@Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
	public String insertCusinfo5(HashMap params) throws Throwable {
		String result = "FAILED";
		
		sqlMapClient.startTransaction();
		sqlMapClient.getCurrentConnection().setAutoCommit(false);		

		try{	
			if(sqlMapClient.update("customer.insertCusinfo0001", params) > 0){
				
				if(sqlMapClient.update("customer.insertCusinfo0001-1", params) > 0){
					result = "SUCCESS";								
					sqlMapClient.commitTransaction();
					sqlMapClient .getCurrentConnection().commit();
				}					
			}						
		}catch(Exception e){
			result = "FAILED";
			System.out.println(e);
			
		}finally{			
			sqlMapClient.endTransaction();			
		}
		
		return result;
	}

	public List<CustomerMemberBean> getprodbmsManagedinfo(HashMap params)
			throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getprodbmsManagedinfo");
	}
}
