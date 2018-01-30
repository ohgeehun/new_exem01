package com.exem9.lms.web.dbms.dao;

import java.util.HashMap;
import java.util.List;

import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.mypage.bean.MypageBean;

public interface IDbmsDao {

	public List getdbms() throws Throwable;

	public List<DbmsBean> getdbms(HashMap params)throws Throwable;

	public List<DbmsBean> getdeptdbms(HashMap params) throws Throwable ;

}
