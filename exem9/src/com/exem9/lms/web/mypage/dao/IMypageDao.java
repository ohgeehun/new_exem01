package com.exem9.lms.web.mypage.dao;

import java.util.HashMap;
import java.util.List;

import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.position.bean.PosiBean;

public interface IMypageDao {

	public List<MypageBean> getUserinfo(String userId) throws Throwable;

	public List<DbmsBean> getdbms(String userId) throws Throwable;

	public List<PosiBean> getposi() throws Throwable;

	public String updateUserInfo(HashMap params) throws Throwable;

	public String updateUserPw(HashMap params) throws Throwable;

	public String updateUserPwInfo(HashMap params) throws Throwable;;

}
