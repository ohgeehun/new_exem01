package com.exem9.lms.web.maintenance.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
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

		System.out.println(user1Id);
		
		HashMap params = new HashMap();
		params.put("teamId",Integer.parseInt(teamId));
		params.put("user1Id",user1Id);
		
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

	public String insertMatinfo(String cusNm, String proNm, String dbmsId,
			String dbmsVersion, String cusUserNm, String salesmanId,
			String user1Id, String user2Id, String supoLeverId,
			String supoVisitId, String supoinstallData, String supostateDate,
			String supoendDatae, String etc) throws Throwable {
		
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();	
		
		HashMap params = new HashMap();
		params.put("cusNm",cusNm);
		params.put("proNm",proNm);
		params.put("dbmsId",Integer.parseInt(dbmsId));
		params.put("dbmsVersion",dbmsVersion);
		params.put("cusUserNm",cusUserNm);
		params.put("salesmanId",salesmanId);
		params.put("user1Id",user1Id);
		params.put("user2Id",user2Id);
		params.put("supoLeverId",Integer.parseInt(supoLeverId));
		params.put("supoVisitId",Integer.parseInt(supoVisitId));
		params.put("supoinstallData",supoinstallData);
		params.put("supostateDate",supostateDate);
		params.put("supoendDatae",supoendDatae);
		params.put("etc",etc);
		params.put("userId", (String)session.getAttribute("sUserId"));
		
		return iMatDao.insertMatinfo(params);
	}


}
