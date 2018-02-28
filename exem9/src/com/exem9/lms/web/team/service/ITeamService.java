package com.exem9.lms.web.team.service;

import java.util.HashMap;
import java.util.List;

import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.team.bean.TeamBean;


public interface ITeamService {	
	public List getdeptteam2(HashMap params) throws Throwable;	
	
	public List<TeamBean> getteam() throws Throwable;
}
