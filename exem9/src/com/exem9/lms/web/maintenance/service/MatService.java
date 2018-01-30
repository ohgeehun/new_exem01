package com.exem9.lms.web.maintenance.service;

import java.util.HashMap;
import java.util.List;

import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.common.dao.ICommonDao;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.dbms.dao.IDbmsDao;
import com.exem9.lms.web.maintenance.dao.IMatDao;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.member.dao.IMemberDao;
import com.exem9.lms.web.team.bean.TeamBean;
import com.exem9.lms.web.team.dao.ITeamDao;



@RemoteProxy(name="IMatService")
@Service(value="IMatService")
public class MatService implements IMatService{
	
	@Autowired
	public IMatDao iMatDao;
	
	@Autowired
	public ICommonDao iCommonDao;
	
	@Autowired
	public IMemberDao iMemberDao;
	
	@Autowired
	public ITeamDao iTeamDao;
	
	@Autowired
	public IDbmsDao iDbmsDao;
	
	public List<SupoBean> getSupolevel() throws Throwable {
		// TODO Auto-generated method stub
		return iCommonDao.getSupolevel();
	}

	public List<SupoBean> getSupovisit(String supoId) throws Throwable {
		
		HashMap params = new HashMap();
		
		if(supoId == ""){
			params.put("supoId",supoId);
		}else{
			params.put("supoId",Integer.parseInt(supoId));
		}
		
		return iCommonDao.getSupovisit(params);
	}
/*	public List getdbms() throws Throwable {
		
		// TODO Auto-generated method stub
		return iDbmsDao.getdbms();
	}*/

	public List<MemberBean> getTeammember(String teamId, String user1Id)
			throws Throwable {

		HashMap params = new HashMap();
		params.put("teamId",Integer.parseInt(teamId));
		params.put("user1Id",Integer.parseInt(user1Id));
		
		return iMemberDao.getTeammember(params);
	}
/*	public List<TeamBean> getuserteam(String userDept) throws Throwable {
		// TODO Auto-generated method stub
		HashMap params = new HashMap();
		params.put("userDept",userDept);
		
		
		return iTeamDao.getuserteam(params);
	}*/
	
	//고객사 정보 등록시 담당부서에 해당 하는 팀정보 가져오기
	public List<TeamBean> getdeptteam(String dbmsId) throws Throwable {
		// TODO Auto-generated method stub
		HashMap params = new HashMap();
		params.put("dbmsId",Integer.parseInt(dbmsId));
		
		
		return iTeamDao.getdeptteam(params);
	}
	
	public List<DbmsBean> getdbms() throws Throwable {
		// TODO Auto-generated method stub
		return iDbmsDao.getdbms();
	}


}
