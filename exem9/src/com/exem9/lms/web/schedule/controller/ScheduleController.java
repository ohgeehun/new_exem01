package com.exem9.lms.web.schedule.controller;

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
import com.exem9.lms.web.category.bean.CateBean;
import com.exem9.lms.web.category.service.ICateService;
import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerNmBean;
import com.exem9.lms.web.customer.bean.CustomerPjtNmBean;
import com.exem9.lms.web.customer.service.ICustomerService;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.dbms.service.IDbmsService;
import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.member.bean.MemberNextBean;
import com.exem9.lms.web.position.bean.PosiBean;
import com.exem9.lms.web.schedule.bean.SchBean;
import com.exem9.lms.web.schedule.bean.SchNextBean;
import com.exem9.lms.web.schedule.service.IScheduleService;
import com.exem9.lms.web.team.bean.TeamBean;


@Controller
public class ScheduleController {
	@Autowired
	public IScheduleService iScheduleService;
	@Autowired
	public IDbmsService iDbmsService;
	@Autowired
	public ICustomerService iCustomerService;
	@Autowired
	public ICateService iCateService;
	
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
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			List<CustomerNmBean> cusNm_list = iCustomerService.getcusNminfo2();
			List<CustomerPjtNmBean> cusPjtNm_list = iCustomerService.getcusPjtNminfo();
			List<CateBean> cate_list = iCateService.getcate();
			
			modelAndView.addObject("dbms_list", dbms_list);
			modelAndView.addObject("cusNm_list", cusNm_list);
			modelAndView.addObject("cusPjtNm_list", cusPjtNm_list);
			modelAndView.addObject("cate_list", cate_list);
			
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
			
			String year = request.getParameter("week-label-year"); // 2018
			String fromMM_YY = request.getParameter("week-label-from-day"); // 01-01
			String toMM_YY = request.getParameter("week-label-to-day");   //  01-08
			if ( fromMM_YY == null || fromMM_YY.isEmpty() ) fromMM_YY = "02-23";
			if ( toMM_YY == null || toMM_YY.isEmpty() ) toMM_YY = "02-24";
			
			System.out.println( "---------------------------------------------------  my_schedule : MM-YY(received) :" + fromMM_YY );
			String strfromYYYYMMDD = year + "-"+ fromMM_YY.substring(0, 2) + "-" + fromMM_YY.substring(3, 5);
			String strtoYYYYMMDD = year + "-"+ toMM_YY.substring(0, 2) + "-" +  toMM_YY.substring(3, 5);
			
			List<SchBean> sch_list = iScheduleService.getsch(strfromYYYYMMDD,strtoYYYYMMDD,1);
			List<CateBean> cat_list = iCateService.getcate();
			
			LineBoardBean lbb = iScheduleService.getNCount(strfromYYYYMMDD,strtoYYYYMMDD,1);
			
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sch_list", sch_list);
			modelAndView.addObject("cat_list", cat_list);
			
			//modelAndView.addObject("year", "2018");
			//modelAndView.addObject("from_day", "02-23");
			//modelAndView.addObject("to_day", "02-24");
			
			//System.out.println( "---------------------------------------------------   : " + cat_list.get(0).getCatId() );
			
			modelAndView.setViewName("schedule/my_schedule");
		}
				
		return modelAndView;
	}
	
	@RequestMapping(value = "/my_schedule_next")
	public ModelAndView my_schedule_next(@ModelAttribute(value="SchNextBean") SchNextBean cnb,
								HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		request.setCharacterEncoding("UTF-8");
		
		//String cusNm = request.getParameter("selectTextVal");
		//String selectBtnVal = request.getParameter("selectBtnVal");
		String year = request.getParameter("week-label-year"); // 2018
		String fromMM_YY = request.getParameter("week-label-from-day"); // 01-01
		String toMM_YY = request.getParameter("week-label-to-day");   //  01-08
		int pageNo = Integer.parseInt(request.getParameter("pageNo"));
		
		System.out.println( "---------------------------------------------------  my_schedule_next : MM-YY(received) :" + fromMM_YY );
		System.out.println( "---------------------------------------------------  my_schedule_next : pageNo :" + pageNo );
		
		String strfromYYYYMMDD = year + "-"+ fromMM_YY.substring(0, 2) + "-" + fromMM_YY.substring(3, 5);
		String strtoYYYYMMDD = year + "-"+ toMM_YY.substring(0, 2) + "-" +  toMM_YY.substring(3, 5);

		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			
			//List<SchBean> sch_list = iScheduleService.getsch(selectBtnVal,cusNm,pageNo);
			List<SchBean> sch_list = iScheduleService.getsch(strfromYYYYMMDD, strtoYYYYMMDD, pageNo);
			List<CateBean> cat_list = iCateService.getcate();
			
			//LineBoardBean lbb = iScheduleService.getNCount(selectBtnVal,cusNm,pageNo);
			LineBoardBean lbb = iScheduleService.getNCount(strfromYYYYMMDD, strtoYYYYMMDD, pageNo);
			
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sch_list", sch_list);
			modelAndView.addObject("cat_list", cat_list);
			
			//System.out.println( "---------------------------------------------------   : " + cat_list.get(0).getCatId() );
			modelAndView.addObject("year", year);
			modelAndView.addObject("from_day", fromMM_YY);
			modelAndView.addObject("to_day", toMM_YY);
			
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