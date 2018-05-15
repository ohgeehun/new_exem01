package com.exem9.lms.web.customer.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.exem9.lms.exception.UserNotFoundException;
import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.customer.bean.CustomerNextBean;
import com.exem9.lms.web.customer.service.ICustomerService;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.dbms.service.IDbmsService;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.member.bean.MemberBean2;


@Controller
public class CustomerController {
	@Autowired
	public ICustomerService iCustomerService;
	@Autowired
	public IDbmsService iDbmsService;
	
	@RequestMapping(value = "/customer_insert")
	public ModelAndView customer_insert(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {			
			
			List<MemberBean2> salseman_list = iCustomerService.getSalsemember(); 
			List<DbmsBean> dbms_list = iCustomerService.getdbms();

			modelAndView.addObject("salseman_list", salseman_list);
			modelAndView.addObject("dbms_list", dbms_list);			
			
			modelAndView.setViewName("customer/customer_insert");
		}
				
		return modelAndView;
	}
	
	@RequestMapping(value = "/customer_edit")
	public ModelAndView customer_edit(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {						
			List<CustomerBean> cus_list_info = iCustomerService.getcusinfo("0","",1);
			List<MemberBean2> edit_salseman_list = iCustomerService.getSalsemember(); 
			//List<CustomerMemberBean> cus_member_list_info = iCustomerService.getcusUserinfo("", "0", "0");
			List<CustomerMemberBean> cus_member_list_info = iCustomerService.getcusUserinfo2();
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			
			LineBoardBean lbb = iCustomerService.getNCount("0","",1);
		
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sUserId", session.getAttribute("sUserId"));
			modelAndView.addObject("cus_list_info", cus_list_info);
			modelAndView.addObject("edit_salseman_list", edit_salseman_list);
			modelAndView.addObject("cus_member_list_info", cus_member_list_info);
			modelAndView.addObject("dbms_list", dbms_list);
		
			modelAndView.setViewName("customer/customer_edit");
		}
				
		return modelAndView;
	}	
	
	@RequestMapping(value = "/customer_edit_next")
	public ModelAndView customer_edit_next(@ModelAttribute(value="CustomerNextBean") CustomerNextBean cnb,
							   HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		request.setCharacterEncoding("UTF-8");
		
		String selectTextVal = request.getParameter("selectTextVal");
		String selectBtnVal = request.getParameter("selectBtnVal");
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if(strPageNo != null && strPageNo.equals("")){
			pageNo = Integer.parseInt(strPageNo);
		}
		HttpSession session=request.getSession();		
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {						
			List<CustomerBean> cus_list_info = iCustomerService.getcusinfo(selectBtnVal,selectTextVal,pageNo);
			
			List<MemberBean2> edit_salseman_list = iCustomerService.getSalsemember(); 
			//List<CustomerMemberBean> cus_member_list_info = iCustomerService.getcusUserinfo("", "0", "0");
			List<CustomerMemberBean> cus_member_list_info = iCustomerService.getcusUserinfo2();
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			
			LineBoardBean lbb = iCustomerService.getNCount(selectBtnVal,selectTextVal,pageNo);
		
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sUserId", session.getAttribute("sUserId"));
			modelAndView.addObject("cus_list_info", cus_list_info);
			modelAndView.addObject("edit_salseman_list", edit_salseman_list);
			modelAndView.addObject("cus_member_list_info", cus_member_list_info);
			modelAndView.addObject("dbms_list", dbms_list);
			
			modelAndView.addObject("selectTextVal", selectTextVal);
			modelAndView.addObject("selectBtnVal", selectBtnVal);
			modelAndView.addObject("pageNo", pageNo);
		
			modelAndView.setViewName("customer/customer_edit");
		}
				
		return modelAndView;
	}
	
	
}



