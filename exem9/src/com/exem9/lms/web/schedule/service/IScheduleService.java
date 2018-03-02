package com.exem9.lms.web.schedule.service;

import java.util.List;

import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.schedule.bean.SchBean;

public interface IScheduleService {
	/*내 일정정보 조회*/
	List<SchBean> getsch(String fromYYYYMMDD, String toYYYYMMDD, int pageNo) throws Throwable;
	
	/*내 일정 등록 insertSchInfo 이벤트*/
	public String insertSchinfo(String user_id,String customer_id, String project_id,
								String dbms_id,String category_id,
								String start_time, String end_time,
								String contents) throws Throwable ;

	/*내일정 리스트 Row 갯수 가져오기(페이지 처리)*/
	public LineBoardBean getNCount(String fromYYYYMMDD, String toYYYYMMDD, int nowPage) throws Throwable;

	/*내 일정 수정 */
	public String updateSchinfo(String user_id,String customer_id, String project_id,
								String dbms_id,String category_id,
								String start_time, String end_time,
								String contents, String chkId) throws Throwable ;
}
