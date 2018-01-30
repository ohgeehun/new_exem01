package com.exem9.lms.web.department.service;

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
import com.exem9.lms.web.department.dao.IDeptDao;
import com.exem9.lms.web.mypage.bean.MypageBean;
import com.exem9.lms.web.mypage.dao.IMypageDao;


@RemoteProxy(name="IDeptService")
@Service(value="IDeptService")
public class DeptService implements IDeptService{
	
	@Autowired
	public IDeptDao iDeptDao;
	

/*	public List getdept() throws Throwable {
		
		// TODO Auto-generated method stub
		return iDeptDao.getdept();
	}
*/
}
