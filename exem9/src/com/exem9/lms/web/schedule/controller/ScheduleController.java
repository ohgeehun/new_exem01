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
import com.exem9.lms.web.department.service.IDeptService;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.member.bean.MemberNextBean;
import com.exem9.lms.web.member.service.IMemberService;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.position.bean.PosiBean;
import com.exem9.lms.web.schedule.bean.SchBean;
import com.exem9.lms.web.schedule.bean.SchNextBean;
import com.exem9.lms.web.schedule.service.IScheduleService;
import com.exem9.lms.web.team.bean.TeamBean;
import com.exem9.lms.web.team.service.ITeamService;
import com.exem9.lms.web.mypage.service.IMypageService;

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
	@Autowired
	public IDeptService iDeptService;
	@Autowired
	public ITeamService iTeamService;
	@Autowired
	public IMemberService iMemberService;
	@Autowired
	public IMypageService iMypageService;
	
	// 사용하지 않음
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
			
			String YYYYMMDDYYYYMMDD = iScheduleService.getThisWeek();
			String strfromYYYYMMDD = YYYYMMDDYYYYMMDD.substring(0, 10);
			String strtoYYYYMMDD = YYYYMMDDYYYYMMDD.substring(10, 20);
			//System.out.println( "---------------------------------------------------  strfromYYYYMMDD :" + strfromYYYYMMDD );
			//System.out.println( "---------------------------------------------------  strtoYYYYMMDD :" + strtoYYYYMMDD );
			String currentUserId = (String) session.getAttribute("sUserId");
			modelAndView.addObject("year", strfromYYYYMMDD.substring(0,4) );
			modelAndView.addObject("from_day", strfromYYYYMMDD.substring(5) );
			modelAndView.addObject("to_day", strtoYYYYMMDD.substring(5) );  
			
			//List<SchBean> sch_list = iScheduleService.getsch(strfromYYYYMMDD,strtoYYYYMMDD,1);
			// getmysch호출 전에 strtoYYYYMMDD를 2018-04-01 23:59:59 로 변환 필요
			//String strtoYYYYMMDD = strtoYYYYMMDD + " 23:59:59";
			List<SchBean> sch_list = iScheduleService.getmysch(strfromYYYYMMDD,strtoYYYYMMDD,currentUserId,1);
			List<CateBean> cat_list = iCateService.getcate();
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			List<CustomerNmBean> cus_list = iCustomerService.getcusNminfo2();
			List<CustomerPjtNmBean> pjt_list = iCustomerService.getcusPjtNminfo();
			
			LineBoardBean lbb = iScheduleService.getmyNCount(strfromYYYYMMDD,strtoYYYYMMDD,currentUserId,1);
			
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sch_list", sch_list);
			modelAndView.addObject("cat_list", cat_list);
			modelAndView.addObject("dbms_list", dbms_list);
			modelAndView.addObject("cus_list", cus_list);
			modelAndView.addObject("pjt_list", pjt_list);
			
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
		
		String year = request.getParameter("week-label-year"); // 2018
		String fromMM_YY = request.getParameter("week-label-from-day"); // 01-01
		String toMM_YY = request.getParameter("week-label-to-day");   //  01-08
		int pageNo = Integer.parseInt(request.getParameter("pageNo"));
		
		//System.out.println( "---------------------------------------------------  my_schedule_next : MM-YY(received) :" + fromMM_YY );
		//System.out.println( "---------------------------------------------------  my_schedule_next : pageNo :" + pageNo );
		
		String strfromYYYYMMDD = year + "-"+ fromMM_YY.substring(0, 2) + "-" + fromMM_YY.substring(3, 5);
		String strtoYYYYMMDD = year + "-"+ toMM_YY.substring(0, 2) + "-" +  toMM_YY.substring(3, 5);

		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			
			//List<SchBean> sch_list = iScheduleService.getsch(selectBtnVal,cusNm,pageNo);
			String currentUserId = (String) session.getAttribute("sUserId");
			
			// getmysch호출 전에 strtoYYYYMMDD를 2018-04-01 23:59:59 로 변환 필요
			//String strtoYYYYMMDD = strtoYYYYMMDD + " 23:59:59";
			List<SchBean> sch_list = iScheduleService.getmysch(strfromYYYYMMDD, strtoYYYYMMDD,currentUserId, pageNo);
			List<CateBean> cat_list = iCateService.getcate();
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			List<CustomerNmBean> cus_list = iCustomerService.getcusNminfo2();
			List<CustomerPjtNmBean> pjt_list = iCustomerService.getcusPjtNminfo();
			
			//LineBoardBean lbb = iScheduleService.getNCount(selectBtnVal,cusNm,pageNo);
			LineBoardBean lbb = iScheduleService.getmyNCount(strfromYYYYMMDD, strtoYYYYMMDD,currentUserId, pageNo);
			
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sch_list", sch_list);
			modelAndView.addObject("cat_list", cat_list);
			modelAndView.addObject("dbms_list", dbms_list);
			modelAndView.addObject("cus_list", cus_list);
			modelAndView.addObject("pjt_list", pjt_list);
			
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
			// 로그인한 유저의 본부를 확인 후 해당본부로 선택하여 조회되도록 한다.
			String myId = (String) session.getAttribute("sUserId");
			List<MypageBean> mypage_info = iMypageService.getUserinfo(myId);
			int deptId = Integer.parseInt( mypage_info.get(0).getUserDeptId() ) ;
			
			String YYYYMMDDYYYYMMDD = iScheduleService.getThisWeek();
			String strfromYYYYMMDD = YYYYMMDDYYYYMMDD.substring(0, 10);
			String strtoYYYYMMDD = YYYYMMDDYYYYMMDD.substring(10, 20);
//			System.out.println( "---------------------------------------------------  strfromYYYYMMDD :" + strfromYYYYMMDD );
//			System.out.println( "---------------------------------------------------  strtoYYYYMMDD :" + strtoYYYYMMDD );
			modelAndView.addObject("year", strfromYYYYMMDD.substring(0,4) );
			modelAndView.addObject("from_day", strfromYYYYMMDD.substring(5) );
			modelAndView.addObject("to_day", strtoYYYYMMDD.substring(5) );
			
			// getsch호출 전에 strtoYYYYMMDD를 2018-04-01 23:59:59 로 변환 필요
			//String strtoYYYYMMDD = strtoYYYYMMDD + " 23:59:59";
			List<SchBean> sch_list = iScheduleService.getTeamsch(strfromYYYYMMDD, strtoYYYYMMDD,1, 0, deptId);
			List<CateBean> cat_list = iCateService.getcate();
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			List<CustomerNmBean> cus_list = iCustomerService.getcusNminfo2();
			List<CustomerPjtNmBean> pjt_list = iCustomerService.getcusPjtNminfo();
			List<DeptBean> dept_list = iDeptService.getdept();
			List<TeamBean> team_list = iTeamService.getteam();
			List<MemberBean> mem_list = iMemberService.getallmem();
			
			LineBoardBean lbb = iScheduleService.getTeamNCount(strfromYYYYMMDD,strtoYYYYMMDD,1, 0, deptId);
			
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sch_list", sch_list);
			modelAndView.addObject("cat_list", cat_list);
			modelAndView.addObject("dbms_list", dbms_list);
			modelAndView.addObject("cus_list", cus_list);
			modelAndView.addObject("pjt_list", pjt_list);
			modelAndView.addObject("dept_list", dept_list);
			modelAndView.addObject("team_list", team_list);
			modelAndView.addObject("mem_list", mem_list);
			modelAndView.addObject("deptFilter", deptId);
			
			modelAndView.setViewName("schedule/team_schedule");
		}
				
		return modelAndView;
	}
	
	
	@RequestMapping(value = "/team_schedule_next")
	public ModelAndView team_schedule_next(@ModelAttribute(value="SchNextBean") SchNextBean cnb,
								HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		request.setCharacterEncoding("UTF-8");
		
		String year = request.getParameter("week-label-year"); // 2018
		String fromMM_YY = request.getParameter("week-label-from-day"); // 01-01
		String toMM_YY = request.getParameter("week-label-to-day");   //  01-08
		int pageNo = Integer.parseInt(request.getParameter("pageNo"));
		int teamFilter = -1; // 팀이 선택되지 않았을 때
		int deptFilter = -1; // 본부(부서)가 선택되지 않았을 때
		
		String strTeamFilter = request.getParameter("teamFilter");
		if ( strTeamFilter != null && !strTeamFilter.isEmpty() ) {
			teamFilter = Integer.parseInt(strTeamFilter);
		} 
		String strDeptFilter = request.getParameter("deptFilter");
		if ( strDeptFilter != null && !strDeptFilter.isEmpty() ) {
			deptFilter = Integer.parseInt(strDeptFilter);
		}
		
		//System.out.println( "---------------------------------------------------  my_schedule_next : MM-YY(received) :" + fromMM_YY );
		//System.out.println( "---------------------------------------------------  my_schedule_next : pageNo :" + pageNo );
		
		String strfromYYYYMMDD = year + "-"+ fromMM_YY.substring(0, 2) + "-" + fromMM_YY.substring(3, 5);
		String strtoYYYYMMDD = year + "-"+ toMM_YY.substring(0, 2) + "-" +  toMM_YY.substring(3, 5);

		HttpSession session=request.getSession();
		
		if(session.getAttribute("sUserId")==null) {
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			
			//List<SchBean> sch_list = iScheduleService.getsch(selectBtnVal,cusNm,pageNo);
			//List<SchBean> sch_list = iScheduleService.getsch(strfromYYYYMMDD, strtoYYYYMMDD, pageNo);
			
			// getTeamsch호출 전에 strtoYYYYMMDD를 2018-04-01 23:59:59 로 변환 필요
			////String strtoYYYYMMDD = strtoYYYYMMDD + " 23:59:59";
			List<SchBean> sch_list;
			if(teamFilter != -1) { // team이 선택된 경우
				sch_list = iScheduleService.getTeamsch(strfromYYYYMMDD, strtoYYYYMMDD, pageNo, teamFilter, 0);
			} else { //본부만 선택한 경우
				sch_list = iScheduleService.getTeamsch(strfromYYYYMMDD, strtoYYYYMMDD, pageNo, 0, deptFilter);
			}
				
			List<CateBean> cat_list = iCateService.getcate();
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			List<CustomerNmBean> cus_list = iCustomerService.getcusNminfo2();
			List<CustomerPjtNmBean> pjt_list = iCustomerService.getcusPjtNminfo();
			List<DeptBean> dept_list = iDeptService.getdept();
			List<TeamBean> team_list = iTeamService.getteam();
			List<MemberBean> mem_list = iMemberService.getallmem();
			
			//LineBoardBean lbb = iScheduleService.getNCount(selectBtnVal,cusNm,pageNo);
			//LineBoardBean lbb = iScheduleService.getNCount(strfromYYYYMMDD, strtoYYYYMMDD, pageNo);
			LineBoardBean lbb;
			if(teamFilter != -1) { // team이 선택된 경우
				lbb = iScheduleService.getTeamNCount(strfromYYYYMMDD, strtoYYYYMMDD, pageNo, teamFilter, 0);
			} else { //본부만 선택한 경우
				lbb = iScheduleService.getTeamNCount(strfromYYYYMMDD, strtoYYYYMMDD, pageNo, 0, deptFilter);
			}
			
			modelAndView.addObject("startPage", lbb.getStartPage());
			modelAndView.addObject("endPage", lbb.getEndPage());
			modelAndView.addObject("maxPage", lbb.getMaxPage());
			modelAndView.addObject("nowPage", lbb.getNowPage());
			
			modelAndView.addObject("sch_list", sch_list);
			modelAndView.addObject("cat_list", cat_list);
			modelAndView.addObject("dbms_list", dbms_list);
			modelAndView.addObject("cus_list", cus_list);
			modelAndView.addObject("pjt_list", pjt_list);
			modelAndView.addObject("dept_list", dept_list);
			modelAndView.addObject("team_list", team_list);
			modelAndView.addObject("mem_list", mem_list);
			
			//System.out.println( "---------------------------------------------------   : " + cat_list.get(0).getCatId() );
			modelAndView.addObject("year", year);
			modelAndView.addObject("from_day", fromMM_YY);
			modelAndView.addObject("to_day", toMM_YY);
			
			modelAndView.addObject("teamFilter", teamFilter);
			modelAndView.addObject("deptFilter", strDeptFilter);
			
			modelAndView.setViewName("schedule/team_schedule");
		}
				
		return modelAndView;
	}
	
}