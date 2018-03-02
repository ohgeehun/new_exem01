package com.exem9.lms.web.member.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.servlet.ServletUtilities;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exem9.lms.common.CommonProperties;
import com.exem9.lms.util.BCrypt;
import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.dbms.dao.IDbmsDao;
import com.exem9.lms.web.department.bean.DeptBean;
import com.exem9.lms.web.department.dao.IDeptDao;
import com.exem9.lms.web.member.bean.MemberBean;
import com.exem9.lms.web.member.dao.IMemberDao;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.mypage.dao.IMypageDao;
import com.exem9.lms.web.team.dao.ITeamDao;


@RemoteProxy(name="IMemberService")
@Service(value="IMemberService")
public class MemberService implements IMemberService{
	
	@Autowired
	public IMemberDao iMemberDao;
	
	@Autowired
	public IDeptDao iDeptrDao;

	public List<DeptBean> getdept() throws Throwable {
	
		return iDeptrDao.getdept();
	}

	public List<MemberBean> getmeminfo(String selectBtnVal, String selectTextVal, int pageNo) throws Throwable {
		
		HashMap params = new HashMap();
		
		params.put("selectBtnVal", Integer.parseInt(selectBtnVal));
		params.put("selectTextVal",selectTextVal);
		params.put("viewCount", CommonProperties.VIEWCOUNT);
		
		int startNo = 1+(CommonProperties.VIEWCOUNT * (pageNo-1));
		int endNo = CommonProperties.VIEWCOUNT * pageNo;
		
		if(pageNo == 1){
			params.put("pageNo", ""); 
		}else{
			params.put("pageNo", pageNo);
		}
		
		params.put("startNo", startNo);
		params.put("endNo", endNo);
		
		return iMemberDao.getmeminfo(params);
	}
	

	public LineBoardBean getNCount(String selectBtnVal, String selectTextVal, int nowPage) throws Throwable {
		
		HashMap params = new HashMap();
			
		params.put("selectBtnVal", Integer.parseInt(selectBtnVal));
		params.put("selectTextVal",selectTextVal);
		
		int nCount = iMemberDao.getNCount(params);
		int maxPage=0;
		int startPage=0;
		int endPage=0;
		int nowpage=0;
		
		if(nowPage == 0){
			nowpage = 1;
		}else if(nowPage != 0){
			nowpage = nowPage;
		}		
		
		if(nCount % CommonProperties.VIEWCOUNT == 0){
			maxPage = nCount / CommonProperties.VIEWCOUNT;
		}else{
			maxPage = (nCount / CommonProperties.VIEWCOUNT) + 1;
		}
		
		startPage = nowpage / CommonProperties.PAGECOUNT + 1;
		endPage = startPage + CommonProperties.PAGECOUNT -1;
		
		if(endPage > maxPage){
			endPage = maxPage;
		}		
		
		LineBoardBean lbb = new LineBoardBean();
		lbb.setStartPage(startPage);
		lbb.setEndPage(endPage);
		lbb.setMaxPage(maxPage);
		lbb.setNowPage(nowpage);
		return lbb;
	}
	
	
	public String insertMeminfo(String user_id, String user_name, String user_password,
			String user_team_id,String user_dbms_id,
			String user_department_id, String user_phone,String user_mail, String user_position_id,
			String user_point) throws Throwable {
		
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();	
		
		HashMap params = new HashMap();

		params.put("user_id",user_id.toUpperCase());
		params.put("user_name",user_name);
		params.put("user_password",user_password);
		params.put("user_team_id",Integer.parseInt(user_team_id));
		params.put("user_dbms_id",Integer.parseInt(user_dbms_id));		
		params.put("user_department_id",Integer.parseInt(user_department_id));
		params.put("user_phone",user_phone);
		params.put("user_mail",user_mail);
		params.put("user_position_id",Integer.parseInt(user_position_id));
		params.put("usr_point",0);
		

		return iMemberDao.insertMeminfo(params);
	}
	
	public String updateMeminfo(String user_id, String user_name, String user_password,
			String user_team_id,String user_dbms_id,
			String user_department_id, String user_phone,String user_mail, String user_position_id,
			String user_point) throws Throwable {
		
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();	
		
		HashMap params = new HashMap();

		params.put("user_id",user_id.toUpperCase());
		params.put("user_name",user_name);
		params.put("user_password",user_password);
		params.put("user_team_id",Integer.parseInt(user_team_id));
		params.put("user_dbms_id",Integer.parseInt(user_dbms_id));		
		params.put("user_department_id",Integer.parseInt(user_department_id));
		params.put("user_phone",user_phone);
		params.put("user_mail",user_mail);
		params.put("user_position_id",Integer.parseInt(user_position_id));
		params.put("usr_point",0);
		

		return iMemberDao.updateMeminfo(params);
	}
}
