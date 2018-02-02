package com.exem9.lms.web.schedule.service;

import java.util.List;

public interface IScheduleService {

	public List getsch() throws Throwable;
	
	/*내 일정 등록 insertSchInfo 이벤트*/
	public String insertSchinfo(String user_id,String customer_id, String project_id,
								String dbms_id,String category_id,
								String start_time, String end_time,
								String contents) throws Throwable ;
}
