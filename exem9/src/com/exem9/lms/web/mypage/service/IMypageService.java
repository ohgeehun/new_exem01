package com.exem9.lms.web.mypage.service;

import java.util.List;

import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.position.bean.PosiBean;


public interface IMypageService {

	public List<MypageBean> getUserinfo(String userId)throws Throwable;

	public List<DbmsBean> getdbms() throws Throwable;
	
	public List<PosiBean> getposi() throws Throwable;
	
	public String updateUserInfo(int userDbms,int userPosi,String userPhone,String userMail)throws Throwable;
	
	public String updateUserPw(String userOldPw,String userNewPw)throws Throwable;
	
}
