package com.exem9.lms.web.mypage.service;

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

import com.exem9.lms.util.BCrypt;
import com.exem9.lms.web.dbms.bean.DbmsBean;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.mypage.dao.IMypageDao;
import com.exem9.lms.web.position.bean.PosiBean;


@RemoteProxy(name="IMypageService")
@Service(value="IMypageService")
public class MypageService implements IMypageService{
	
	@Autowired
	public IMypageDao iMypageDao;
	
	public List<MypageBean> getUserinfo(String userId) throws Throwable {
		
		return iMypageDao.getUserinfo(userId);
	}

	public List<DbmsBean> getdbms() throws Throwable {
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();
		
		String userId = (String) session.getAttribute("sUserId");
		// TODO Auto-generated method stub
		return iMypageDao.getdbms(userId);
	}

	public List<PosiBean> getposi() throws Throwable {
		
		// TODO Auto-generated method stub
		return iMypageDao.getposi();
	}

	public String updateUserInfo(int userDbms, int userPosi,
			String userPhone, String userMail) throws Throwable {
		
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();
		
		HashMap params = new HashMap();
		
		params.put("userId", (String)session.getAttribute("sUserId"));
		params.put("userDbms", userDbms);
		params.put("userPosi", userPosi);
		params.put("userPhone", userPhone);
		params.put("userMail", userMail);
		
		String result = iMypageDao.updateUserInfo(params);
	
		if (result == "SUCCESS"){
			session.removeAttribute("sUserDbms");
			session.removeAttribute("sUserPosi");
			
			session.setAttribute("sUserDbms", userDbms);
			session.setAttribute("sUserPosi", userPosi);		
		}
		return result;
	}

	public String updateUserPw(String userOldPw, String userNewPw) throws Throwable {
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();				
		
		HashMap params = new HashMap();
		params.put("userId", (String)session.getAttribute("sUserId"));
		
		String userPw_BC = iMypageDao.updateUserPwInfo(params);
			
		if(BCrypt.checkpw(userOldPw, userPw_BC) == true){
			String userNewPw_BC = BCrypt.hashpw(userNewPw, BCrypt.gensalt(12));		
			params.put("userNewPw", userNewPw_BC);
			
			return iMypageDao.updateUserPw(params);
		}else{
			return "PW_FAILED";
		}		
	}
}
