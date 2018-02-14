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
import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.customer.bean.CustomerNextBean;
import com.exem9.lms.web.customer.service.ICustomerService;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.team.bean.TeamBean;

@Controller
public class CustomerController {
	@Autowired
	public ICustomerService iCustomerService;

	/*@RequestMapping(value = "/customer")
	public ModelAndView customer(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		String userId = (String) session.getAttribute("sUserId");
		String userDept = (String) session.getAttribute("sUserDept");
		String userDbms = (String) session.getAttribute("sUserDbms");
		String userFlag = (String) session.getAttribute("sUserFlag");
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {			
			List<MypageBean> cus_list = iCustomerService.getUserinfo(userId);
			List<SupoBean> supo_list = iCustomerService.getsupo();
			List<DeptBean> dept_list = iCustomerService.getdept();
			List<DbmsBean> dbms_list = iCustomerService.getdbms();
			
			List<CustomerBean> cus_list_info = iCustomerService.getcusinfo("0","",1);
			LineBoardBean lbb = iCustomerService.getNCount("0","",1);
			
			//List<MypageBean> cus_list = iCustomerService.getUserinfo(userId);
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			modelAndView.addObject("sUserId", session.getAttribute("sUserId"));
			
			modelAndView.addObject("cus_list", cus_list);
			modelAndView.addObject("supo_list", supo_list);
			modelAndView.addObject("dept_list", dept_list);			
			modelAndView.addObject("dbms_list", dbms_list);
			modelAndView.addObject("cus_list_info", cus_list_info);
			
			modelAndView.setViewName("customer/customer");
		}
				
		return modelAndView;
	}*/
	
	@RequestMapping(value = "/customer_insert")
	public ModelAndView customer_insert(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {			
			
			List<MemberBean> salseman_list = iCustomerService.getSalsemember(); 
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
			
			List<MemberBean> edit_salseman_list = iCustomerService.getSalsemember(); 
			List<CustomerMemberBean> cus_member_list_info = iCustomerService.getcusUserinfo("", "0", "0");
			LineBoardBean lbb = iCustomerService.getNCount("0","",1);
		
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sUserId", session.getAttribute("sUserId"));
			modelAndView.addObject("cus_list_info", cus_list_info);
			modelAndView.addObject("edit_salseman_list", edit_salseman_list);
			modelAndView.addObject("cus_member_list_info", cus_member_list_info);
		
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
		
		String cusNm = request.getParameter("selectTextVal");
		String selectBtnVal = request.getParameter("selectBtnVal");
		int pageNo = Integer.parseInt(request.getParameter("pageNo"));

		HttpSession session=request.getSession();		
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {						
			List<CustomerBean> cus_list_info = iCustomerService.getcusinfo(selectBtnVal,cusNm,pageNo);
			
			List<MemberBean> edit_salseman_list = iCustomerService.getSalsemember(); 
			List<CustomerMemberBean> cus_member_list_info = iCustomerService.getcusUserinfo("", "0", "0");
			LineBoardBean lbb = iCustomerService.getNCount(selectBtnVal,cusNm,pageNo);
		
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sUserId", session.getAttribute("sUserId"));
			modelAndView.addObject("cus_list_info", cus_list_info);
			modelAndView.addObject("edit_salseman_list", edit_salseman_list);
			modelAndView.addObject("cus_member_list_info", cus_member_list_info);
		
			modelAndView.setViewName("customer/customer_edit");
		}
				
		return modelAndView;
	}
	
	/*@RequestMapping(value = "/customer_edit1")
	public ModelAndView customer_edit1(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		String userId = (String) session.getAttribute("sUserId");
		String userDept = (String) session.getAttribute("sUserDept");
		String userDbms = (String) session.getAttribute("sUserDbms");
		String userTeam = (String) session.getAttribute("sUserTeam");
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {			
			List<MypageBean> cus_list = iCustomerService.getUserinfo(userId);
			List<SupoBean> supo_list = iCustomerService.getsupo();
			List<DeptBean> dept_list = iCustomerService.getdept();
			List<DbmsBean> dbms_list = iCustomerService.getdbms();
			
			List<CustomerBean> cus_list_info = iCustomerService.getcusinfo("0","",1);
			List<CustomerMemberBean> cus_member_list_info = iCustomerService.getcusUserinfo("", cusId);
			LineBoardBean lbb = iCustomerService.getNCount("0","",1);
			
			List<DbmsBean> edit_dbms_list = iCustomerService.getdbms(userDept);
			List<MemberBean> edit_member_list = iCustomerService.getUsermember(userTeam);
			List<MemberBean> edit_salseman_list = iCustomerService.getSalsemember(); 
			List<SupoBean> edit_supo_list = iCustomerService.getSupolevel();
			List<SupoBean> edit_supo_visit_list = iCustomerService.getSupovisit("");
			
			
			//List<MypageBean> cus_list = iCustomerService.getUserinfo(userId);
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			modelAndView.addObject("sUserId", session.getAttribute("sUserId"));
			
			modelAndView.addObject("cus_list", cus_list);
			modelAndView.addObject("supo_list", supo_list);
			modelAndView.addObject("dept_list", dept_list);			
			modelAndView.addObject("dbms_list", dbms_list);
			modelAndView.addObject("cus_list_info", cus_list_info);
			
			modelAndView.addObject("edit_team_list", edit_team_list);
			modelAndView.addObject("edit_dbms_list", edit_dbms_list);
			modelAndView.addObject("edit_member_list", edit_member_list);
			modelAndView.addObject("edit_salseman_list", edit_salseman_list);
			modelAndView.addObject("edit_supo_list", edit_supo_list);
			modelAndView.addObject("edit_supo_visit_list", edit_supo_visit_list);
			modelAndView.setViewName("customer/customer_edit");
		}
				
		return modelAndView;
	}*/
}



