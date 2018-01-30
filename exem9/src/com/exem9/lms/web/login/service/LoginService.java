package com.exem9.lms.web.login.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.exem9.lms.util.BCrypt;
import com.exem9.lms.web.login.bean.LoginBean;
import com.exem9.lms.web.login.dao.ILoginDao;

@RemoteProxy(name ="ILoginService")
@Service(value="ILoginService")
public class LoginService implements ILoginService {
	
	
	@Autowired
	public ILoginDao iLoginDao;

	/*@RemoteMethod
	public LoginBean getUserInfo(LoginBean lb) throws Throwable {
		return iLoginDao.getUserInfo(lb);
	}*/
	
	@RemoteMethod
	public String getUserInfo(String Id, String Pw) throws Throwable{
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();		
		
		HashMap params = new HashMap();
		params.put("userId", Id);				
		
		List<LoginBean> ulist = iLoginDao.getUserInfo(params);
		String userId ="";
		
		if (ulist.isEmpty() == false){
			userId = ulist.get(0).getUserId();					
			
			String userPw_BC = ulist.get(0).getUserPw();			
			
			if(BCrypt.checkpw(Pw, userPw_BC) == true){
				
				session.setAttribute("sUserId", ulist.get(0).getUserId());
				session.setAttribute("sUserDept", ulist.get(0).getUserDept());
				session.setAttribute("sUserTeam", ulist.get(0).getUserTeam());
				session.setAttribute("sUserPosi", ulist.get(0).getUserPosi());
				session.setAttribute("sUserName", ulist.get(0).getUserNm());
				session.setAttribute("sUserDbms", ulist.get(0).getUserDbms());
				session.setAttribute("sUserFlag", ulist.get(0).getUserFlag());
				
				
				userId = ulist.get(0).getUserId();
			}else{

				userId = "PW_FAILED";
			}			
			return userId;
			
		}else{
			userId = "ID_FAILED";			
			return userId;
		}			
	}
}
