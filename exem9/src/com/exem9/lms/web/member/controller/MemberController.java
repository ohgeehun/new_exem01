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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.exem9.lms.exception.UserNotFoundException;
import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.customer.bean.CustomerNextBean;
import com.exem9.lms.web.member.bean.MemberNextBean;

import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.dbms.service.IDbmsService;
import com.exem9.lms.web.department.service.IDeptService;
import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.member.bean.MemberBean2;
import com.exem9.lms.web.member.service.IMemberService;
import com.exem9.lms.web.position.bean.PosiBean;
import com.exem9.lms.web.position.service.IPosiService;
import com.exem9.lms.web.team.bean.TeamBean;
import com.exem9.lms.web.team.service.ITeamService;

import com.exem9.lms.web.customer.service.ICustomerService;


@Controller
public class MemberController {
	@Autowired
	public IMemberService iMemberService;
	@Autowired
	public IDeptService iDeptService;
	@Autowired
	public ITeamService iTeamService;
	@Autowired
	public IPosiService iPosiService;
	@Autowired
	public IDbmsService iDbmsService;
	
	@Autowired
	public ICustomerService iCustomerService;
	
	@RequestMapping(value = "/member_edit")
	public ModelAndView member(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {						
			List<MemberBean> mem_list_info = iMemberService.getmeminfo("0","",1);
			List<DeptBean> dept_list = iDeptService.getdept();
			List<TeamBean> team_list = iTeamService.getteam();
			List<PosiBean> posi_list = iPosiService.getposi();
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			
			List<CustomerBean> cus_list_info = iCustomerService.getcusinfo("0","",1);
			List<MemberBean2> edit_salseman_list = iCustomerService.getSalsemember(); 
			List<CustomerMemberBean> cus_member_list_info = iCustomerService.getcusUserinfo("", "0", "0");
			
			LineBoardBean lbb = iMemberService.getNCount("0","",1);
		
			modelAndView.addObject("mem_list_info", mem_list_info);
			modelAndView.addObject("dept_list", dept_list);
			modelAndView.addObject("team_list", team_list);
			modelAndView.addObject("posi_list", posi_list);
			modelAndView.addObject("dbms_list", dbms_list);
			
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sUserId", session.getAttribute("sUserId"));
			modelAndView.addObject("cus_list_info", cus_list_info);
			modelAndView.addObject("edit_salseman_list", edit_salseman_list);
			modelAndView.addObject("cus_member_list_info", cus_member_list_info);
			
			modelAndView.setViewName("member/member_edit");
		}
				
		return modelAndView;
	}
	
	@RequestMapping(value = "/member_insert")
	public ModelAndView member_insert(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			List<DeptBean> dept_list = iDeptService.getdept();
			List<TeamBean> team_list = iTeamService.getteam();
			List<PosiBean> posi_list = iPosiService.getposi();
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			
			modelAndView.addObject("dept_list", dept_list);
			modelAndView.addObject("team_list", team_list);
			modelAndView.addObject("posi_list", posi_list);
			modelAndView.addObject("dbms_list", dbms_list);
			
			modelAndView.setViewName("member/member_insert");
		}
				
		return modelAndView;
	}
	
	@RequestMapping(value = "/member_edit_next")
	public ModelAndView member_edit_next(@ModelAttribute(value="MemberNextBean") MemberNextBean cnb,
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
			List<MemberBean> mem_list_info = iMemberService.getmeminfo(selectBtnVal,cusNm,pageNo);
			
			List<DeptBean> dept_list = iDeptService.getdept();
			List<TeamBean> team_list = iTeamService.getteam();
			List<PosiBean> posi_list = iPosiService.getposi();
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			
			LineBoardBean lbb = iMemberService.getNCount(selectBtnVal,cusNm,pageNo);
		
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sUserId", session.getAttribute("sUserId"));
			modelAndView.addObject("mem_list_info", mem_list_info);
			modelAndView.addObject("dept_list", dept_list);
			modelAndView.addObject("team_list", team_list);
			modelAndView.addObject("posi_list", posi_list);
			modelAndView.addObject("dbms_list", dbms_list);
		
			modelAndView.setViewName("member/member_edit");
		}
				
		return modelAndView;
	}
}
