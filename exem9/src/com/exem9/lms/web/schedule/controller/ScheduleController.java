package com.exem9.lms.web.schedule.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.exem9.lms.exception.UserNotFoundException;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.position.bean.PosiBean;
import com.exem9.lms.web.schedule.service.IScheduleService;
import com.exem9.lms.web.team.bean.TeamBean;


@Controller
public class ScheduleController {
	@Autowired
	public IScheduleService iScheduleService;
	
	@RequestMapping(value = "/schedule")
	public ModelAndView mypage(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			modelAndView.setViewName("schedule/schedule");
		}
				
		return modelAndView;
	}
	
	
	@RequestMapping(value = "/schedule_insert")
	public ModelAndView schedule_insert(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			modelAndView.setViewName("schedule/schedule_insert");
		}
				
		return modelAndView;
	}
	
	@RequestMapping(value = "/my_schedule")
	public ModelAndView my_schedule(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			modelAndView.setViewName("schedule/my_schedule");
		}
				
		return modelAndView;
	}
	
	@RequestMapping(value = "/team_schedule")
	public ModelAndView team_schedule(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			modelAndView.setViewName("schedule/team_schedule");
		}
				
		return modelAndView;
	}
	
}