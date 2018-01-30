package com.exem9.lms.web.maintenance.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.exem9.lms.exception.UserNotFoundException;
import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.service.ICustomerService;
import com.exem9.lms.web.maintenance.service.IMatService;
import com.exem9.lms.web.member.bean.MemberBean;



@Controller
public class  MatController {
	@Autowired
	public IMatService iMatService;
	@Autowired
	public ICustomerService iCustomerService;
	
	@RequestMapping(value = "/maintenance")
	public ModelAndView maintenance(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			modelAndView.setViewName("maintenance/maintenance");
		}
				
		return modelAndView;
	}
	

	@RequestMapping(value = "/maintenance_insert")
	public ModelAndView maintenance_insert(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		List<MemberBean> salseman_list = iCustomerService.getSalsemember(); 
		List<SupoBean> supo_level_list = iMatService.getSupolevel();
		List<SupoBean> supo_visit_list = iMatService.getSupovisit("");
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			modelAndView.addObject("supo_level_list", supo_level_list);
			modelAndView.addObject("supo_visit_list", supo_visit_list);
			modelAndView.addObject("salseman_list", salseman_list);
			
			
			modelAndView.setViewName("maintenance/maintenance_insert");
		}
				
		return modelAndView;
	}
	
}