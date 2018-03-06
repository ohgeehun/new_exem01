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
	
	// 개인정보 수정
	public String updateUserInfo2(String user_id, String user_name, String user_password, 
			int user_department_id, int user_team_id, int user_dbms_id, int user_position_id, 
			String user_phone, String user_mail, int user_point) throws Throwable;
}
