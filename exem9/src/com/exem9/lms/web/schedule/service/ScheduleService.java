package com.exem9.lms.web.schedule.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.exem9.lms.common.CommonProperties;
import com.exem9.lms.web.common.bean.LineBoardBean;
import com.exem9.lms.web.schedule.bean.SchBean;
import com.exem9.lms.web.schedule.dao.ISchDao;


@RemoteProxy(name="IScheduleService")
@Service(value="IScheduleService")
public class ScheduleService implements IScheduleService{
	
	@Autowired
	public ISchDao iSchDao;
	@Autowired
	private PlatformTransactionManager transactionManager;
	
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

	// 내일정 정보 조회
	public List<SchBean> getmysch(String strfromYYYYMMDD, String strtoYYYYMMDD, String userId, int pageNo) throws Throwable {
		
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
		params.put("userId",userId);
		
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
		
		//System.out.println("############################################ ");
		//System.out.println("start_time : " + start_time);
		
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition() );
		String result = "FAILED";
		
		//System.out.println("======================================================================");
		long diffDays = getDiffDate(start_time, end_time);
		//System.out.println("=====================================================================날짜차이=" + diffDays);
		
		try {
			if( diffDays >= 1 ){ //시작일과 종료일이 다르면, 날짜별로 쪼개서 insert
				String calStartDate = start_time;
				String calEndDate = end_time;
				for(long i = 0 ; i <= diffDays ; i++) {
					if(i !=0 ) calStartDate = getDate(calStartDate, true);  // 시작날짜 시작시각값 계산, 9:00고정, 단, 종료일종료시간이 9:00보다작으면, 종료일종료시간으로
					else {
						calStartDate = start_time+":00";  // 첫날은 시작시간
					}
					if ( i != diffDays ) calEndDate =  getDate(calStartDate, false); // 종료날짜시각값 계산, 18:00 고정, 단, 시작일시작시간이 18:00시보다크면, 시작일시작시간으로
					else {
						calEndDate = end_time+":00";   // 마지막날은 끝나는 시간,
						String tempStrEndtime = end_time.substring(11, 13);
						String replaceEndtime = end_time.substring(11, 16);
						int tempEndtime = Integer.parseInt( tempStrEndtime );
						if( tempEndtime < 9 ) calStartDate = calStartDate.replace(" 09:00:00", " "+replaceEndtime+":00")  ;  // 종료일종료시간이 9:00보다작으면, start_time을 종료일종료시간으로 수정
					}
					if (i == 0 ) {
						String tempStrStarttime = start_time.substring(11, 13);
						String replaceStarttime = start_time.substring(11, 16);
						int tempStarttime = Integer.parseInt( tempStrStarttime );
						if( tempStarttime > 18 ) calEndDate = calEndDate.replace(" 18:00:00", " "+replaceStarttime+":00")  ;  // 시작일시작시간이 18:00시보다크면, end_time을 시작일시작시간으로 수정
					}
					
//					System.out.println("------------------------------------------------------ start_time: " + calStartDate);
//					System.out.println("------------------------------------------------------ end_time: " + calEndDate);
					
					params.put("start_time",calStartDate);
					params.put("end_time",calEndDate);
					
					iSchDao.insertSchinfo(params);  // 해달날짜를 넣는다.
					calStartDate = doDateAdd(calStartDate);  // 하루하루씩 증가시키면서 입력 필요
				}
			} else {
				iSchDao.insertSchinfo(params);  // 시작일자, 종료일자가 같은 날이면 그냥 insert
			}
						
			this.transactionManager.commit(status);
		} catch (Exception e){
			this.transactionManager.rollback(status);
			e.printStackTrace();
            return result;
		}
		result = "SUCCESS";
		return result;
	}
	
	private long getDiffDate(String start, String end) throws ParseException{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date beginDate = formatter.parse(start);
        Date endDate = formatter.parse(end);
        // 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
        long diff = endDate.getTime() - beginDate.getTime();
        long diffDays = diff / (24 * 60 * 60 * 1000);
        return diffDays;
	}
	
	private String doDateAdd(String date) throws ParseException{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date tempDate = formatter.parse(date);
        
        GregorianCalendar cal = new GregorianCalendar(Locale.KOREA);
	    cal.setTime(tempDate);
	    cal.add(Calendar.DAY_OF_YEAR, 1); // 하루를 더한다.
	     
	    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String strDate = fm.format(cal.getTime());
	    return strDate;
	}
	
	private String getDate(String date, boolean isStart) {
		String convertedDate;
		if(isStart) convertedDate = date.substring(0,10) + " 09:00:00";
		else convertedDate = date.substring(0,10) + " 18:00:00";
        return convertedDate;
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
	
	public LineBoardBean getmyNCount(String strfromYYYYMMDD, String strtoYYYYMMDD, String userId, int nowPage) throws Throwable {
		
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
		params.put("userId", userId);
		
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
