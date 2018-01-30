package com.exem9.lms.common.service;

import java.util.ArrayList;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exem9.lms.common.CommonProperties;
import com.exem9.lms.common.bean.CodeBean;
import com.exem9.lms.common.dao.ICommonDAO;

@Service("ICommonService")
@RemoteProxy(name = "ICommonService")
public class CommonService implements ICommonService {

	@Autowired
	private ICommonDAO iCommonDAO;

	@RemoteMethod
/*	public ArrayList<CodeBean> getCode(String lCd) throws Throwable {
		return iCommonDAO.getCode(lCd);
	}

	public int getCodeCount(String lCd) throws Throwable {
		return iCommonDAO.getCodeCount(lCd);
	}*/

	/*
	 * Paging
	 */
	// 테이블 시작row
	public int getStartCount(int page) {
		int startCount = 0;
		int viewCount = CommonProperties.VIEWCOUNT;
		startCount = (page - 1) * viewCount;
		return startCount;
	}

	// 페이징 최대 크기
	public int getMaxPcount(int maxCount) {
		int maxPcount = 0;

		if (maxCount % CommonProperties.VIEWCOUNT > 0) {
			maxPcount = (maxCount / CommonProperties.VIEWCOUNT) + 1;
		} else {
			maxPcount = (maxCount / CommonProperties.VIEWCOUNT);
		}

		if (maxCount == 0) {
			maxPcount = 1;
		}

		return maxPcount;
	}

	// 현재페이지 기준 시작페이지
	public int getStartPcount(int page) {
		int startPcount = 0;

		if (page % CommonProperties.PAGECOUNT > 0) {
			startPcount = ((page / CommonProperties.PAGECOUNT) 
						  * CommonProperties.PAGECOUNT) + 1;
		} else {
			startPcount = (((page / CommonProperties.PAGECOUNT) - 1) 
						* CommonProperties.PAGECOUNT) + 1;
		}

		return startPcount;
	}

	// 현재페이지 기준 종료페이지
	public int getEndPcount(int page, int maxCount) {
		int endPcount = 0;
		int maxPcount = getMaxPcount(maxCount);

		if (page % CommonProperties.PAGECOUNT == 0) {
			endPcount = page;
		} else {
			endPcount = ((page / CommonProperties.PAGECOUNT) 
						* CommonProperties.PAGECOUNT)
						+ CommonProperties.PAGECOUNT;
		}

		if (endPcount >= maxPcount) {
			endPcount = maxPcount;
		}

		return endPcount;
	}

}
