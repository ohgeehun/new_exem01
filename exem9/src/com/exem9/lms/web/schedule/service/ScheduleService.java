package com.exem9.lms.web.schedule.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exem9.lms.web.schedule.dao.ISchDao;


@RemoteProxy(name="IScheduleService")
@Service(value="IScheduleService")
public class ScheduleService implements IScheduleService{
	
	@Autowired
	public ISchDao iSchDao;
	
	public List getsch() throws Throwable {
		
		// TODO Auto-generated method stub
		return iSchDao.getsch();
	}

	@Override
	public String insertSchinfo(String user_id, String customer_id, String project_id, String dbms_id,
			String category_id, String start_time, String end_time, String contents) throws Throwable {
		
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();	
		
		HashMap params = new HashMap();

		params.put("user_id",user_id.toUpperCase());
		params.put("customer_id",Integer.parseInt(customer_id));
		params.put("project_id",Integer.parseInt(project_id));		
		params.put("dbms_id",Integer.parseInt(dbms_id));
		params.put("category_id",Integer.parseInt(category_id));
		params.put("start_time",start_time);
		params.put("end_time",end_time);
		params.put("contents",contents);
		
		System.out.println("############################################ ");
		System.out.println("start_time : " + start_time);
		
		return iSchDao.insertSchinfo(params);
	}
	
}
