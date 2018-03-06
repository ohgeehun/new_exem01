package com.exem9.lms.web.mypage.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.exem9.lms.exception.UserNotFoundException;
import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.customer.bean.CustomerBean;
import com.exem9.lms.web.customer.bean.CustomerMemberBean;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.dbms.service.IDbmsService;
import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.department.service.IDeptService;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.member.service.IMemberService;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.mypage.service.IMypageService;
import com.exem9.lms.web.position.bean.PosiBean;
import com.exem9.lms.web.position.service.IPosiService;
import com.exem9.lms.web.team.bean.TeamBean;
import com.exem9.lms.web.team.service.ITeamService;



@Controller
public class MypageController {
	@Autowired
	public IMypageService iMypageService;
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
	
	@RequestMapping(value = "/mypage")
	public ModelAndView mypage(HttpServletRequest request, 
							   HttpServletResponse response,
							   ModelAndView modelAndView) throws Throwable{
		
		HttpSession session=request.getSession();
		request.setCharacterEncoding("UTF-8");
		String myId = (String) session.getAttribute("sUserId");
		
		if(session.getAttribute("sUserId")==null) {
			/*modelAndView.setViewName("redirect:Login");*/
			throw new UserNotFoundException("자동 로그아웃 됐습니다.");
		} else {
			
			List<MypageBean> mypage_info = iMypageService.getUserinfo(myId);
			List<DeptBean> dept_list = iDeptService.getdept();
			List<TeamBean> team_list = iTeamService.getteam();
			List<PosiBean> posi_list = iPosiService.getposi();
			List<DbmsBean> dbms_list = iDbmsService.getdbms();
			
			//System.out.println("================================================= MypageBean : " + mypage_info.get(0) );
			
			modelAndView.addObject("mypage_info", mypage_info.get(0) );
			modelAndView.addObject("dept_list", dept_list);
			modelAndView.addObject("team_list", team_list);
			modelAndView.addObject("posi_list", posi_list);
			modelAndView.addObject("dbms_list", dbms_list);
			
			modelAndView.addObject("sUserId", session.getAttribute("sUserId"));
			
			modelAndView.setViewName("mypage/mypage");
		}
				
		return modelAndView;
	}
	
}