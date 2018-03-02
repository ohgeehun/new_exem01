package com.exem9.lms.web.schedule.dao;

import java.util.HashMap;
import java.util.List;

import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.schedule.bean.SchBean;

public interface ISchDao {

	public List<SchBean> getsch(HashMap params) throws Throwable;

	public String insertSchinfo(HashMap params) throws Throwable;

	public int getNCount(HashMap params) throws Throwable;
}
