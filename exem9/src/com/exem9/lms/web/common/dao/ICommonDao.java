package com.exem9.lms.web.common.dao;

import java.util.HashMap;
import java.util.List;

import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.team.bean.TeamBean;

public interface ICommonDao {


	public List<SupoBean> getSupolevel() throws Throwable;

	public List<SupoBean> getSupovisit(HashMap params) throws Throwable;	
}
