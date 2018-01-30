package com.exem9.lms.common.service;

import java.util.ArrayList;

import com.exem9.lms.common.bean.CodeBean;

public interface ICommonService {
	
/*	public ArrayList<CodeBean> getCode(String lCd) throws Throwable;
	
	public int getCodeCount(String lCd) throws Throwable;*/
	
	//테이블 시작row
	public int getStartCount(int page);
	
	//페이징 최대 크기
	public int getMaxPcount(int maxCount);
	
	//현재페이지 기준 시작페이지
	public int getStartPcount(int page);
	
	//현재페이지 기준 종료페이지
	public int getEndPcount(int page, int maxCount);
}
