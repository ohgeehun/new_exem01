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
	
	public String updateUserInfo2(String user_id, String user_name, String user_password, 
			int user_department_id, int user_team_id, int user_dbms_id, int user_position_id, 
			String user_phone, String user_mail, int user_point) throws Throwable{
				
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();
		
		String user_id2 = (String)session.getAttribute("sUserId");
		
		HashMap params = new HashMap();
		
		params.put("user_id", user_id2 );
		params.put("user_name", user_name );
		params.put("user_password", user_password);
		params.put("user_department_id", user_department_id );
		params.put("user_team_id", user_team_id );
		params.put("user_dbms_id", user_dbms_id);
		params.put("user_position_id", user_position_id);
		params.put("user_phone", user_phone);
		params.put("user_mail", user_mail);
		params.put("user_point", user_point);
		
		System.out.println( user_id2 + user_name+ 
				user_department_id + user_department_id);
		
		String result = iMypageDao.updateUserInfo2(params);
	
		if (result == "SUCCESS"){
			session.removeAttribute("sUserDbms");
			session.removeAttribute("sUserPosi");
			session.removeAttribute("sUserDept");
			
			try {
				session.setAttribute("sUserDbms", String.valueOf(user_dbms_id) );
				session.setAttribute("sUserPosi", String.valueOf(user_position_id) );
				session.setAttribute("sUserDept", String.valueOf(user_department_id) );
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("부서id, 직급id, 업무id String 변환 실패");
			}
			
//			System.out.println(  (String)session.getAttribute("sUserId")    );
//			System.out.println(  (String)session.getAttribute("sUserPosi")  );
//			System.out.println(  (String)session.getAttribute("sUserDept")  );
//			System.out.println(  (String)session.getAttribute("sUserDbms")  );
//			
//			System.out.println(  user_position_id  );
//			System.out.println(  user_department_id  );
//			System.out.println(  user_dbms_id  );
			
		}
		return result;
		
	}
}
