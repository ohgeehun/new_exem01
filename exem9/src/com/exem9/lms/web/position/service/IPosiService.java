package com.exem9.lms.web.position.service;

import java.util.List;

import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.position.bean.PosiBean;


public interface IPosiService {	
	
	public List<PosiBean> getposi() throws Throwable;	
	
}
