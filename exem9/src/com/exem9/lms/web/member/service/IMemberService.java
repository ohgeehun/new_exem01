package com.exem9.lms.web.member.service;

import java.util.List;

import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.member.bean.MemberBean;

public interface IMemberService {

	public  List<DeptBean> getdept() throws Throwable ;	
	
/*	public List getteam() throws Throwable;	*/
	
	/*사용자 검색 조건에 해당하는 사용자 리스트 정보 가져오기*/
	public List<MemberBean> getmeminfo(String selectBtnVal, String selectTextVal, int pageNo)throws Throwable;
	
	/*사용자(직원) 리스트 Row 갯수 가져오기(페이지 처리)*/
	public LineBoardBean getNCount(String selectBtnVal, String selectTextVal, int nowPage) throws Throwable;
}
