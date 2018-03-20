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
import com.exem9.lms.web.customer.bean.CususerBean;
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
		//return sqlMapClient.queryForList("customer.getcusinfo", params);
		return sqlMapClient.queryForList("customer.getcusinfo3", params);
	}

	public int getNCount(HashMap params) throws Throwable {
		
		int count = (Integer) sqlMapClient.queryForObject("customer.getNCount3", params);
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
	
	// 프로젝트, 고객사위치, 비고 정보 수정
	public String updatePjtInfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.updatePjtInfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}
	
	// 제품, 영업대표 수정
	public String updateDbmsInfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.updateDbmsInfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}
	
	// 고객담당자, 전화, email 수정
	public String updateCusmemberInfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.updateCusmemberInfo", params) > 0){
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
	
	public List<CustomerMemberBean> getcusUserinfo2() throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getcusUserinfo2");
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

	public List<CustomerMemberBean> getprodbmsManagedinfo(HashMap params)throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getprodbmsManagedinfo", params);
	}

	public List<CustomerPjtNmBean> getCusProCheck(HashMap params)
			throws Throwable {
		// TODO Auto-generated method stub
		return  sqlMapClient.queryForList("customer.getCusProCheck", params);
	}

	public List<CustomerMemberBean> getprodbmsManagedcheck(HashMap params)
			throws Throwable {
		// TODO Auto-generated method stub
		return  sqlMapClient.queryForList("customer.getprodbmsManagedcheck", params);
	}

	public List<CustomerMemberBean> getprodbmsmemberinfo(HashMap params)
			throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getprodbmsmemberinfo", params);
	}
	

	public List<CustomerMemberBean> getcusmemberinfo(HashMap params)
			throws Throwable {
		// TODO Auto-generated method stub
		return sqlMapClient.queryForList("customer.getcusmemberinfo", params);
	}

	/*고객사 정보 삭제 처리*/
	public String deleteCusinfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.deleteCusinfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}

	/*xm_projtect_dbms_cusmember테이블의 정보 삭제 처리*/
	public String deletePjtDbmsCusmemberinfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.deletePjtDbmsCusmemberinfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}
	
	/*고객사담당자 정보 삭제 처리*/
	public String deleteCusmemberinfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.deleteCusmemberinfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}
	
	/*고객사담당자 여러건 정보 삭제 처리*/
	public String deleteCusmembersinfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.deleteCusmembersinfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}
	
	/*고객사프로젝트의 업무 삭제 처리*/
	public String deleteCusPjtDbmsinfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.deleteCusPjtDbmsinfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}
	
	/*고객사의 프로젝트 삭제 처리*/
	public String deleteCusPjtinfo(HashMap params) throws Throwable {
		String result = "FAILED";
		
		if(sqlMapClient.update("customer.deleteCusPjtinfo", params) > 0){
			result = "SUCCESS";
		}
		return result;
	}
	
	// 사용안함
	// 고객사 및 프로젝트 신규 등록
	public String insertCusProj(HashMap params) throws Throwable {
		String result = "FAILED";
		
		try{
			// 고객사 신규등록
			sqlMapClient.update("customer.insertCus", params);
			// 등록된 고객사 정보 조회
			//int cusId = (Integer) sqlMapClient.queryForObject("customer.getCusId", params);
			//params.put("cusId", cusId);
			// 프로젝트 신규등록
			//sqlMapClient.update("customer.insertProj", params);
			
		} catch(Exception e) {
			 e.printStackTrace();
             //TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
             return result;
		}
		result = "SUCCESS";
		return result;     
	}
	
	// 고객사 신규 등록
	public void insertCus(HashMap params) throws Throwable {
		//String result = "FAILED";

		//if(sqlMapClient.update("customer.insertCus", params) > 0){
			//result = "SUCCESS";
		//}
		//return result;
		if( sqlMapClient.update("customer.insertCus", params) <= 0 ) {
			throw new Exception("transction: customer insert Error");
		}
	}
	
	// 고객사 id조회
	public Integer getInsertedCusId(HashMap params)	throws Throwable {
		// TODO Auto-generated method stub
		Integer cusId = (Integer) sqlMapClient.queryForObject("customer.getInsertedCusId", params);
		return  cusId;
	}
	
	// 프로젝트 신규 등록
	public void insertProj(HashMap params) throws Throwable {
		//String result = "FAILED";

		//if(sqlMapClient.update("customer.insertProj", params) > 0){
//			result = "SUCCESS";
//		}
//		return result;    
		if ( sqlMapClient.update("customer.insertProj", params) <= 0){
			throw new Exception("transction: project insert Error");
		}
	}
	
	// 프로젝트id 조회
	public Integer getInsertedPjtId(HashMap params)	throws Throwable {
		// TODO Auto-generated method stub
		Integer pjtId = (Integer) sqlMapClient.queryForObject("customer.getInsertedPjtId", params);
		return  pjtId;
	}

	// (고객사/프로젝트/업무) 담당영업 등록
	public void insertSalesman(HashMap params) throws Throwable {
		if ( sqlMapClient.update("customer.insertSalesman", params) <= 0){
			throw new Exception("transction: Salesman insert Error");
		}
	}
		
	// (고객사/프로젝트/업무) 고객사담당자 등록, 여러명 등록 가능
	public void insertCusmember(HashMap params) throws Throwable {
		if ( sqlMapClient.update("customer.insertCusmember", params) <= 0){
			throw new Exception("transction: Customer member insert Error");
		}
//		System.out.println("-----------------------------------------------------------------");
//		System.out.println( params.get("gencususerId") );
//		return 1;
	}
	
	public int insertCusmember2(CususerBean cususerBean) throws Throwable {
		int id = sqlMapClient.update("customer.insertCusmember2", cususerBean);
		if (  id <= 0){
			throw new Exception("transction: Customer member insert Error");
		}
		System.out.println("-----------------------------------------------------------------");
		System.out.println( "getGencususerId() : " + cususerBean.getGencususerId() );
//		System.out.println( "id : " + id );
		return cususerBean.getGencususerId();
	}
	
	// (고객사/프로젝트/업무) 고객사담당자 등록, 여러명 등록 가능
	public void insertPjtDbmsCusmember(HashMap params) throws Throwable {
		if ( sqlMapClient.update("customer.insertPjtDbmsCusmember", params) <= 0){
			throw new Exception("transction: xm_project_dbms_cusmember table insert Error");
		}
	}
	
	// 특정이름의 고객사담당자id 조회
	public Integer getInsertedCusmemberId(HashMap params) throws Throwable {
		Integer cusmemberId = (Integer) sqlMapClient.queryForObject("customer.getInsertedCusmemberId", params);
		return  cusmemberId;
	}
	
	// 담당영업이 등록되어 있는지 확인
	public String getSalesmanId(HashMap params) throws Throwable {
		String salesmanId = (String) sqlMapClient.queryForObject("customer.getSalesmanId", params);
		return  salesmanId;
	}
}
	

