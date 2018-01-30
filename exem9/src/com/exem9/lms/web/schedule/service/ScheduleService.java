package com.exem9.lms.web.schedule.service;

import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.exem9.lms.web.mypage.dao.IMypageDao;


@RemoteProxy(name="IScheduleService")
@Service(value="IScheduleService")
public class ScheduleService implements IScheduleService{
	
	@Autowired
	public IMypageDao iMypageDao;
	
	
}
