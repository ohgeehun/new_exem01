package com.exem9.lms.web.main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.exem9.lms.web.login.bean.LoginBean;
import com.exem9.lms.web.login.service.ILoginService;
import com.exem9.lms.web.main.service.IMainService;


@Controller
public class MainController {
	
	@Autowired
	public IMainService imainService;

	@RequestMapping(value = "/main")
	public ModelAndView main(
			HttpServletRequest request, HttpServletResponse response,
			ModelAndView modelAndView) throws Throwable {
		
		modelAndView.setViewName("main");
		
		return modelAndView;
	}	
	
	@RequestMapping(value="/main_upview")
	public ModelAndView cus_mianupview(HttpServletRequest request, 
			 				           HttpServletResponse response,
			 				    	   ModelAndView modelAndView) throws Throwable{
		modelAndView.setViewName("common/common_upmain");
		return modelAndView;
	}
	@RequestMapping(value="/main_botview")
	public ModelAndView cus_mianbotview(HttpServletRequest request, 
			 				     	    HttpServletResponse response,
			 					        ModelAndView modelAndView) throws Throwable{
		modelAndView.setViewName("common/common_botmain");
		return modelAndView;
	}
	
}






