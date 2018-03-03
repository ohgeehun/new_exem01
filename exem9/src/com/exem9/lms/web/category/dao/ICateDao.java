package com.exem9.lms.web.category.dao;

import java.util.HashMap;
import java.util.List;

import com.exem9.lms.web.category.bean.CateBean;
import com.exem9.lms.web.mypage.bean.MypageBean;

public interface ICateDao {

	public List<CateBean> getcate() throws Throwable;

}
