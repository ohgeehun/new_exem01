package com.exem9.lms.web.schedule.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exem9.lms.common.CommonProperties;
import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.schedule.bean.SchBean;
import com.exem9.lms.web.schedule.dao.ISchDao;


@RemoteProxy(name="IScheduleService")
@Service(value="IScheduleService")
public class ScheduleService implements IScheduleService{
	
	@Autowired
	public ISchDao iSchDao;
	
	public List<SchBean> getsch(String strfromYYYYMMDD, String strtoYYYYMMDD, int pageNo) throws Throwable {
		
		HashMap params = new HashMap();
		
		java.sql.Timestamp fromYYYYMMDD=null;
		java.sql.Timestamp toYYYYMMDD=null;
		
		System.out.println( "---------------------------------------------------   : strFromYYYYMMDD : " +  strfromYYYYMMDD);
		System.out.println( "---------------------------------------------------   : strtoYYYYMMDD : " +  strtoYYYYMMDD);
		
		try {
			  // String 타입을 java.util.Date 로 변환한다.
			  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
			  java.util.Date datefromYYYYMMDD = formatter.parse(strfromYYYYMMDD);
			  java.util.Date datetoYYYYMMDD = formatter.parse(strtoYYYYMMDD);

			  // java.util.Date 를 java.sql.Timestamp 로 변환한다.
			  fromYYYYMMDD = new java.sql.Timestamp( datefromYYYYMMDD.getTime() ) ;
			  toYYYYMMDD = new java.sql.Timestamp( datetoYYYYMMDD.getTime() ) ;

			} catch (Exception ex) {
			  // Exception 에 대한 오류처리를 한다.
				System.out.println( "---------------------------------------------------   : datetime convert Error" );
			}
		
		params.put("fromYYYYMMDD", fromYYYYMMDD);
		params.put("toYYYYMMDD",toYYYYMMDD);
		
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
		
		return iSchDao.getsch(params);
	}

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
	
	public LineBoardBean getNCount(String strfromYYYYMMDD, String strtoYYYYMMDD, int nowPage) throws Throwable {
		
		HashMap params = new HashMap();
		
		java.sql.Timestamp fromYYYYMMDD=null;
		java.sql.Timestamp toYYYYMMDD=null;
		
		try {
			  // String 타입을 java.util.Date 로 변환한다.
			  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
			  java.util.Date datefromYYYYMMDD = formatter.parse(strfromYYYYMMDD);
			  java.util.Date datetoYYYYMMDD = formatter.parse(strtoYYYYMMDD);

			  // java.util.Date 를 java.sql.Timestamp 로 변환한다.
			  fromYYYYMMDD = new java.sql.Timestamp( datefromYYYYMMDD.getTime() ) ;
			  toYYYYMMDD = new java.sql.Timestamp( datetoYYYYMMDD.getTime() ) ;

			} catch (Exception ex) {
			  // Exception 에 대한 오류처리를 한다.
				System.out.println( "---------------------------------------------------   : datetime convert Error" );
			}
		
		params.put("fromYYYYMMDD", fromYYYYMMDD);
		params.put("toYYYYMMDD", toYYYYMMDD);
		
		int nCount = iSchDao.getNCount(params);
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
	
	public String updateSchinfo(String user_id, String customer_id, String project_id, String dbms_id,
			String category_id, String start_time, String end_time, String contents, String chkId) throws Throwable {
		
		WebContext wctx = WebContextFactory.get();
		HttpServletRequest request = wctx.getHttpServletRequest();
		HttpSession session = request.getSession();	
		
		HashMap params = new HashMap();

		params.put("user_id",user_id );
		params.put("customer_id",Integer.parseInt(customer_id));
		params.put("project_id",Integer.parseInt(project_id));		
		params.put("dbms_id",Integer.parseInt(dbms_id));
		params.put("category_id",Integer.parseInt(category_id));
		params.put("start_time",start_time);
		params.put("end_time",end_time);
		params.put("contents",contents);
		params.put("chkId", Integer.parseInt(chkId) );
		
		//System.out.println("############################################ ");
		//System.out.println("start_time : " + start_time);
		
		return iSchDao.updateSchinfo(params);
	}
	
	public String getThisWeek(){

		// 월요일
		SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
 		Calendar c = Calendar.getInstance();
 		c.set(Calendar.DAY_OF_WEEK,Calendar.MONDAY);
 		String strFromYYYYMMDD = formatter.format(c.getTime());
// 		System.out.println("=========================================================== : MONDAY : " + strFromYYYYMMDD);
 		
 		c.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
 		c.add(Calendar.DATE,7);
 		String strToYYYYMMDD = formatter.format(c.getTime());
// 		System.out.println("=========================================================== : SUNDAY : " + strToYYYYMMDD);
		
		return strFromYYYYMMDD + strToYYYYMMDD;  // "yyyy-MM-ddyyyy-MM-dd"
	}
	
	public List<SchBean> getTeamsch(String strfromYYYYMMDD, String strtoYYYYMMDD, int pageNo, int teamFilter) throws Throwable {
		
		HashMap params = new HashMap();
		
		java.sql.Timestamp fromYYYYMMDD=null;
		java.sql.Timestamp toYYYYMMDD=null;
		
		System.out.println( "---------------------------------------------------   : strFromYYYYMMDD : " +  strfromYYYYMMDD);
		System.out.println( "---------------------------------------------------   : strtoYYYYMMDD : " +  strtoYYYYMMDD);
		
		try {
			  // String 타입을 java.util.Date 로 변환한다.
			  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
			  java.util.Date datefromYYYYMMDD = formatter.parse(strfromYYYYMMDD);
			  java.util.Date datetoYYYYMMDD = formatter.parse(strtoYYYYMMDD);

			  // java.util.Date 를 java.sql.Timestamp 로 변환한다.
			  fromYYYYMMDD = new java.sql.Timestamp( datefromYYYYMMDD.getTime() ) ;
			  toYYYYMMDD = new java.sql.Timestamp( datetoYYYYMMDD.getTime() ) ;

			} catch (Exception ex) {
			  // Exception 에 대한 오류처리를 한다.
				System.out.println( "---------------------------------------------------   : datetime convert Error" );
			}
		
		params.put("fromYYYYMMDD", fromYYYYMMDD);
		params.put("toYYYYMMDD",toYYYYMMDD);
		
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
		params.put("teamFilter", teamFilter);
		
		return iSchDao.getsch(params);
	}
	
	public LineBoardBean getTeamNCount(String strfromYYYYMMDD, String strtoYYYYMMDD, int nowPage, int teamFilter) throws Throwable {
		
		HashMap params = new HashMap();
		
		java.sql.Timestamp fromYYYYMMDD=null;
		java.sql.Timestamp toYYYYMMDD=null;
		
		try {
			  // String 타입을 java.util.Date 로 변환한다.
			  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
			  java.util.Date datefromYYYYMMDD = formatter.parse(strfromYYYYMMDD);
			  java.util.Date datetoYYYYMMDD = formatter.parse(strtoYYYYMMDD);

			  // java.util.Date 를 java.sql.Timestamp 로 변환한다.
			  fromYYYYMMDD = new java.sql.Timestamp( datefromYYYYMMDD.getTime() ) ;
			  toYYYYMMDD = new java.sql.Timestamp( datetoYYYYMMDD.getTime() ) ;

			} catch (Exception ex) {
			  // Exception 에 대한 오류처리를 한다.
				System.out.println( "---------------------------------------------------   : datetime convert Error" );
			}
		
		params.put("fromYYYYMMDD", fromYYYYMMDD);
		params.put("toYYYYMMDD", toYYYYMMDD);
		params.put("teamFilter", teamFilter);
		
		int nCount = iSchDao.getNCount(params);
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
	
	public String deleteSchinfo(String chkId) throws Throwable {

		HashMap params = new HashMap();

		params.put("chkId", Integer.parseInt(chkId) );
		
		//System.out.println("############################################ ");
		//System.out.println("start_time : " + start_time);
		
		return iSchDao.deleteSchinfo(params);
	}
	
}
