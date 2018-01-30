package com.exem9.lms.web.position.service;

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
import com.exem9.lms.web.position.dao.IPosiDao;


@RemoteProxy(name="IPosiService")
@Service(value="IPosiService")
public class PosiService implements IPosiService{
	
	@Autowired
	public IPosiDao iPosiDao;
	

/*	public List getdept() throws Throwable {
		
		// TODO Auto-generated method stub
		return iPosiDao.getposi();
	}*/

}
