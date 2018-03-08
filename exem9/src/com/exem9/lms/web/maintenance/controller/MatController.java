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
import com.exem9.lms.web.category.service.ICateService;
import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.common.bean.SupoBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.customer.bean.CustomerNmBean;
import com.exem9.lms.web.customer.bean.CustomerPjtNmBean;
import com.exem9.lms.web.customer.service.ICustomerService;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.dbms.service.IDbmsService;
import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.department.service.IDeptService;
import com.exem9.lms.web.maintenance.bean.MatBean;
import com.exem9.lms.web.maintenance.service.IMatService;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.member.bean.MemberBean2;
import com.exem9.lms.web.member.service.IMemberService;
import com.exem9.lms.web.position.bean.PosiBean;
import com.exem9.lms.web.team.bean.TeamBean;
import com.exem9.lms.web.team.service.ITeamService;

@Controller
public class  MatController {
	@Autowired
	public IMatService iMatService;
	@Autowired
	public ICustomerService iCustomerService;
	@Autowired
	public IDeptService iDeptService;
	@Autowired
	public IMemberService iMemberService;
	@Autowired
	public IDbmsService iDbmsService;
	@Autowired
	public ITeamService iTeamService;
	
	@RequestMapping(value = "/maintenance")
	public ModelAndView maintenance(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			List<MatBean> mat_list = iMatService.getmatinfo("0","",1);
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			List<CustomerNmBean> cus_list = iCustomerService.getcusNminfo2();
			List<CustomerPjtNmBean> pjt_list = iCustomerService.getcusPjtNminfo();
			List<DeptBean> dept_list = iDeptService.getdept();
			List<TeamBean> team_list = iTeamService.getteam();
			List<MemberBean> mem_list = iMemberService.getallmem();
			List<CustomerMemberBean> cususer_list = iCustomerService.getprodbmsManagedinfo("BGF리테일");
			List<MemberBean2> salesman_list = iCustomerService.getSalsemember();
			List<SupoBean> supo_level_list = iMatService.getSupolevel();
			List<SupoBean> supo_visit_list = iMatService.getSupovisit("");
			
			LineBoardBean lbb = iMatService.getNCount("0","",1);
			
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("mat_list", mat_list);
			modelAndView.addObject("dbms_list", dbms_list);
			modelAndView.addObject("cus_list", cus_list);
			modelAndView.addObject("pjt_list", pjt_list);
			modelAndView.addObject("dept_list", dept_list);
			modelAndView.addObject("team_list", team_list);
			modelAndView.addObject("mem_list", mem_list);
			modelAndView.addObject("cususer_list", cususer_list);
			modelAndView.addObject("salesman_list", salesman_list);
			modelAndView.addObject("supo_level_list", supo_level_list);
			modelAndView.addObject("supo_visit_list", supo_visit_list);
			
			System.out.println( "+++++++++++++++++++++++++++++++++++++++++++++: salesman : "  + salesman_list.get(0).getUserId()  );
			
			modelAndView.setViewName("maintenance/maintenance");
		}
				
		return modelAndView;
	}
	

	@RequestMapping(value = "/maintenance_insert")
	public ModelAndView maintenance_insert(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		
		List<MemberBean2> salseman_list = iCustomerService.getSalsemember(); 
		System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++ : salesman : " + salseman_list.size() );
		System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++ : salesman : " + salseman_list.get(0).getUserNm() );
		
		List<SupoBean> supo_level_list = iMatService.getSupolevel();
		List<SupoBean> supo_visit_list = iMatService.getSupovisit("");
		List<DbmsBean> dbms_list = iMatService.getdbms();
		List<DeptBean> dept_list = iDeptService.getdept();
		List<MemberBean> mem_list = iMemberService.getallmem();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			modelAndView.addObject("supo_level_list", supo_level_list);
			modelAndView.addObject("supo_visit_list", supo_visit_list);
			modelAndView.addObject("salseman_list", salseman_list);
			modelAndView.addObject("dbms_list", dbms_list);
			modelAndView.addObject("dept_list", dept_list);
			modelAndView.addObject("mem_list", mem_list);
			
			modelAndView.setViewName("maintenance/maintenance_insert");
		}
				
		return modelAndView;
	}
	
	@RequestMapping(value = "/maintenance_next")
	public ModelAndView maintenance_next(HttpServletRequest request, 
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
			//List<MatBean> mat_list = iMatService.getmatinfo("0","",1);
			List<MatBean> mat_list = iMatService.getmatinfo(selectBtnVal,cusNm,pageNo);
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			List<CustomerNmBean> cus_list = iCustomerService.getcusNminfo2();
			List<CustomerPjtNmBean> pjt_list = iCustomerService.getcusPjtNminfo();
			List<DeptBean> dept_list = iDeptService.getdept();
			List<TeamBean> team_list = iTeamService.getteam();
			List<MemberBean> mem_list = iMemberService.getallmem();
			List<CustomerMemberBean> cususer_list = iCustomerService.getprodbmsManagedinfo("BGF리테일");
			List<MemberBean2> salesman_list = iCustomerService.getSalsemember();
			List<SupoBean> supo_level_list = iMatService.getSupolevel();
			List<SupoBean> supo_visit_list = iMatService.getSupovisit("");
			
			//LineBoardBean lbb = iMatService.getNCount("0","",1);
			LineBoardBean lbb = iMatService.getNCount(selectBtnVal,cusNm,pageNo);
			
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("mat_list", mat_list);
			modelAndView.addObject("dbms_list", dbms_list);
			modelAndView.addObject("cus_list", cus_list);
			modelAndView.addObject("pjt_list", pjt_list);
			modelAndView.addObject("dept_list", dept_list);
			modelAndView.addObject("team_list", team_list);
			modelAndView.addObject("mem_list", mem_list);
			modelAndView.addObject("cususer_list", cususer_list);
			modelAndView.addObject("salesman_list", salesman_list);
			modelAndView.addObject("supo_level_list", supo_level_list);
			modelAndView.addObject("supo_visit_list", supo_visit_list);
			
			System.out.println( "+++++++++++++++++++++++++++++++++++++++++++++: salesman : "  + salesman_list.get(0).getUserId()  );
			
			modelAndView.setViewName("maintenance/maintenance");
		}
				
		return modelAndView;
	}
	
}