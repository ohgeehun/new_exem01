package com.exem9.lms.web.member.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.exem9.lms.exception.UserNotFoundException;
import com.exem9.lms.web.dbms.service.IDbmsService;
import com.exem9.lms.web.department.service.IDeptService;
import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.member.service.IMemberService;
import com.exem9.lms.web.team.service.ITeamService;



@Controller
public class MemberController {
	@Autowired
	public IMemberService iMemberService;
	
	
	@RequestMapping(value = "/member")
	public ModelAndView member(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		List<DeptBean> dept_list = iMemberService.getdept();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			
			modelAndView.addObject("dept_list", dept_list);
			modelAndView.setViewName("member/member");
		}
				
		return modelAndView;
	}
}