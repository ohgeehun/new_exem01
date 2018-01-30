package com.exem9.lms.web.team.controller;

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
import com.exem9.lms.web.team.service.ITeamService;



@Controller
public class TeamController {
	@Autowired
	public ITeamService iTeamService;
	
	@RequestMapping(value = "/Team")
	public ModelAndView team(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			modelAndView.setViewName("Team/Team");
		}
				
		return modelAndView;
	}
	
}